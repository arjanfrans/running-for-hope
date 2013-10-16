package objects
{
	import citrus.CustomHero;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.NapeUtils;
	import citrus.view.starlingview.AnimationSequence;
	
	import nape.callbacks.InteractionCallback;
	import nape.callbacks.PreCallback;
	import nape.callbacks.PreFlag;
	import nape.dynamics.CollisionArbiter;
	import nape.dynamics.Contact;
	import nape.geom.GeomPoly;
	import nape.geom.GeomPolyList;
	import nape.geom.Vec2;
	import nape.geom.Vec2List;
	import nape.phys.Body;
	import nape.phys.BodyType;
	import nape.shape.Circle;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	import nape.shape.ValidationResult;
	import flash.ui.Keyboard;
	
	import starling.textures.TextureAtlas;
	
	public class Luigi extends CustomHero
	{
		private static var seq:AnimationSequence;
		private var texture_height:Number;
		private var texture_height_duck:Number;
		private var duckShape:Polygon;
		private var normalShape:Polygon;
		private var isDuckShape:Boolean = false;

		private const angular_dampening:Number = 20;
		private const linear_dampening:Number = 20;
		private var wall:NapePhysicsObject;
		private var _toutchingWall:Boolean = false;
		
		public function Luigi(name:String, params:Object=null)
		{
			super(name, params);
			var ta:TextureAtlas = Assets.getAtlas("LuigiAnimation");
			seq = new AnimationSequence(ta, ["walk", "idle", "duck", "hurt", "jump"], "idle", 60);
			this.texture_height = this.height;
			this.texture_height_duck = seq.mcSequences["duck"].height;
			this.view = seq;
			normalShape = new Polygon(Polygon.box(this.width, this.height), _material);
			this._shape = normalShape;
			//this.acceleration = 3;
		}		
				
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
			// we get a reference to the actual velocity vector
			var velocity:Vec2 = _body.velocity;
			
			if (controlsEnabled)
			{
				var moveKeyPressed:Boolean = false;
				
				_ducking = (_ce.input.isDoing("duck", inputChannel) && _onGround && canDuck);
				
				if (_ce.input.isDoing("right", inputChannel)  && !_ducking)
				{
					//velocity.addeq(getSlopeBasedMoveAngle());
					velocity.x += acceleration;
					moveKeyPressed = true;
				}
				
				if (_ce.input.isDoing("left", inputChannel) && !_ducking)
				{
					//velocity.subeq(getSlopeBasedMoveAngle());
					velocity.x -= acceleration;
					moveKeyPressed = true;
				}
				
				//If player just started moving the hero this tick.
				if (moveKeyPressed && !_playerMovingHero)
				{
					_playerMovingHero = true;
					_material.dynamicFriction = 0; //Take away friction so he can accelerate.
					_material.staticFriction = 0;
				}
					//Player just stopped moving the hero this tick.
				else if (!moveKeyPressed && _playerMovingHero)
				{
					_playerMovingHero = false;
					_material.dynamicFriction = _dynamicFriction; //Add friction so that he stops running
					_material.staticFriction = _staticFriction;
				}
				
				if (_onGround && _ce.input.justDid("jump", inputChannel) && !_ducking)
				{
					velocity.y = -jumpHeight;
					onJump.dispatch();
				}
				
				if (_ce.input.isDoing("jump", inputChannel) && !_onGround && velocity.y < 0)
				{
					//WALL JUMPING
					trace(_toutchingWall);
					if(_toutchingWall) {
						if(_ce.input.isDown(Keyboard.SPACE)) {
							//???????
						}
					}
					else {
						velocity.y -= jumpAcceleration;
					}
				}
			
				
				if (_springOffEnemy != -1)
				{
					if (_ce.input.isDoing("jump", inputChannel))
						velocity.y = -enemySpringJumpHeight;
					else
						velocity.y = -enemySpringHeight;
					_springOffEnemy = -1;
				}
				
				//Cap velocities
				if (velocity.x > (maxVelocity))
					velocity.x = maxVelocity;
				else if (velocity.x < (-maxVelocity))
					velocity.x = -maxVelocity;
			}
			damping();
			updateAnimation();
			
		}
		
		override public function handleBeginContact(callback:InteractionCallback):void {
			
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, callback);
			
			if (_enemyClass && collider is _enemyClass)
			{
				if ((_body.velocity.y == 0 || _body.velocity.y < killVelocity) && !_hurt)
				{
					hurt();
					
					//fling the hero
					var hurtVelocity:Vec2 = _body.velocity;
					hurtVelocity.y = -hurtVelocityY;
					hurtVelocity.x = hurtVelocityX;
					if (collider.x > x)
						hurtVelocity.x = -hurtVelocityX;
					_body.velocity = hurtVelocity;
				}
				else
				{
					_springOffEnemy = collider.y - height;
					onGiveDamage.dispatch();
				}
			}
			

			if (callback.arbiters.length > 0 && callback.arbiters.at(0).collisionArbiter) {
				
				var collisionAngle:Number = callback.arbiters.at(0).collisionArbiter.normal.angle * 180 / Math.PI;
				
				if ((collisionAngle > 45 && collisionAngle < 135) || (collisionAngle > -30 && collisionAngle < 10) || collisionAngle == -90)
				{
					_toutchingWall = false;
					if (collisionAngle > 1 || collisionAngle < -1) {
						//we don't want the Hero to be set up as onGround if it touches a cloud.
						if (collider is Platform && (collider as Platform).oneWay && collisionAngle == -90)
							return;
						
						_groundContacts.push(collider.body);
						_onGround = true;
						//updateCombinedGroundAngle();
					}
				}
				else {
					//If not, the collision is a wall
					_toutchingWall = true;
				}
			}
		}
		
		private function damping():void {
			_body.velocity.muleq(Math.pow(linear_dampening, 1/this._ce.stage.frameRate));
			_body.angularVel *= Math.pow(angular_dampening, 1/this._ce.stage.frameRate);
		}
		
		
		override protected function createShape():void
		{
			// Used by the Tiled Map Editor software, if we defined a polygon/polyline
			if (points && points.length > 1) {
				
				var verts:Vec2List = new Vec2List();
				
				for each (var point:Object in points)
				verts.push(new Vec2(point.x as Number, point.y as Number));
				
				var polygon:Polygon = new Polygon(verts, _material);
				var validation:ValidationResult = polygon.validity();
				
				if (validation == ValidationResult.VALID)
					_shape = polygon;
					
				else if (validation == ValidationResult.CONCAVE) {
					
					var concave:GeomPoly = new GeomPoly(verts);
					var convex:GeomPolyList = concave.convexDecomposition();
					convex.foreach(function(p:GeomPoly):void {
						_body.shapes.add(new Polygon(p));
					});
					return;
					
				} else
					throw new Error("Invalid polygon/polyline");
				
			} else {
				
				if (_radius != 0)
					_shape = new Circle(_radius, null, _material);
				else
					_shape = new Polygon(Polygon.box(_width, _height), _material);
			}
			//var bottomShape:Shape = new Polygon(Polygon.box(_width, texture_height_duck), _material);
			//_shape.bounds.y = texture_height_duck;
			_body.shapes.add(_shape);
			//_body.shapes.add(bottomShape);
		}
/*		
		override public function handlePreContact(callback:PreCallback):PreFlag
		{
			var hit:PreFlag = PreFlag.ACCEPT;
			for each (var c:Contact in callback.arbiter.collisionArbiter.contacts) {
				if (texture_height_duck - this.y < c.position.y) {
					hit = PreFlag.IGNORE;;
				}
			}
			trace(hit);
			return hit;
		}*/
		

		
		
		
		override protected function updateAnimation():void 
		{
			var prevAnimation:String = _animation;
			
			//var walkingSpeed:Number = getWalkingSpeed();
			var walkingSpeed:Number = _body.velocity.x; // this won't work long term!
			
			if(_hurt) {
				_animation = "hurt";
			}
			else if (!_onGround) {
				
				_animation = "jump";
				
				if (walkingSpeed < -acceleration) {
					_inverted = true;
				}
				else if (walkingSpeed > acceleration) {
					_inverted = false;
				}
			} else if (_ducking) {
				//adjust hero to size of duck texture
				//this.y = y + (texture_height - texture_height_duck);
				_animation = "duck";
			}
			else {
				if (walkingSpeed < -acceleration) {
					_inverted = true;
					_animation = "walk";
				} else if (walkingSpeed > acceleration) {
					_inverted = false;
					_animation = "walk";
					
				}
				else {
					_animation = "idle";
				}
			}
			if (prevAnimation != _animation) {
				onAnimationChange.dispatch();
			}
			
		}
	}
}