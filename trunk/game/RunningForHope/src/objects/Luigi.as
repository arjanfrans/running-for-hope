package objects
{
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
	
	import starling.textures.TextureAtlas;
	
	public class Luigi extends Hero
	{
		private static var seq:AnimationSequence;
		private var texture_height:Number;
		private var texture_height_duck:Number;
		private var duckShape:Polygon;
		private var normalShape:Polygon;
		private var isDuckShape:Boolean = false;

		private const angular_dampening:Number = 20;
		private const linear_dampening:Number = 20;
		
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
			/**
			 * where linear/angular dampening would
			 *  be in [0,1] 1 being no dampening, 0 total dampening, 0.5 for instance meaning that in 1 second the velocity becomes half 
			 * so that it corresponds to what fraction of the velocity is removed each second.
			 * */
			
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