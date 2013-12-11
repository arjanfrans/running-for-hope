package game.objects
{
	import avmplus.getQualifiedClassName;
	import avmplus.getQualifiedSuperclassName;
	
	import citrus.CustomHero;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Platform;
	import citrus.objects.platformer.simple.StaticObject;
	import citrus.physics.nape.NapeUtils;
	import citrus.view.starlingview.AnimationSequence;
	
	import flash.ui.Keyboard;
	import flash.utils.describeType;
	
	import game.GameState;
	import game.objects.hero.DuckingState;
	import game.objects.hero.IdleState;
	import game.objects.hero.JumpState;
	import game.objects.hero.LuigiState;
	import game.objects.hero.WalkState;
	
	import model.Model;
	
	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import starling.textures.TextureAtlas;
	
	import ui.hud.PlayerStatsUi;
	import ui.menus.MenuState;
	import ui.windows.GameOverWindow;
	
	public class Luigi extends CustomHero
	{
		public var air_acceleration:Number;
		private var _oldVelocity:Vec2 = new Vec2();
		
		private var _safe_respawn:Vec2;
		
		private var _touchingWall:Boolean = false;
		private var _dead:Boolean = false;		
		
		private var texture_height:Number;
		private var texture_height_duck:Number;
		private var duck_trigger:Boolean;
		
		private var _normal_shape:Shape;
		private var _ducking_shape:Shape;
		private var _state:LuigiState;
		
		public var idleState:IdleState;
		public var jumpState:JumpState;
		public var walkState:WalkState;
		public var duckingState:LuigiState;
		public var faceRight:Boolean = true;
		public var lastWallContact:NapePhysicsObject = null;
		
		public function Luigi(name:String, params:Object=null)
		{
			super(name, params);
			var ta:TextureAtlas = Assets.getAtlas("MaxAnimation");
			//var seq:AnimationSequence = new AnimationSequence(ta, ["walk", "idle", "duck", "hurt", "jump"], "idle", 30, false, Config.SMOOTHING);
			var seq:AnimationSequence = new AnimationSequence(ta, ["walk", "idle", "jump"], "idle", 60, false, Config.SMOOTHING);
			view = seq;
			
			idleState = new IdleState(this);
			jumpState = new JumpState(this);
			walkState = new WalkState(this);
			duckingState = new DuckingState(this);
			
			_state = idleState;
			
			air_acceleration = 7;
			maxVelocity = 150;
			acceleration = 30;
			jumpAcceleration = 10;
			jumpHeight = 450;
			
		}	
		
		/**
		 * Update function is overrided to add wall-jumping. Most of the code below is a copy of the super class.
		 */
		override public function update(timeDelta:Number):void
		{
			_state.update(timeDelta, _body.velocity, _ce.input);
			super.update(timeDelta);
			
			if(faceRight && _body.velocity.x < 0) {
				faceRight = false;
			}
			else if(!faceRight && _body.velocity.x > 0) {
				faceRight = true;
			}
			
			// If on a safe ground tile (static), save it for possible respawns
			var groundBody:Body =  groundContacts[0] as Body;
			if(onGround && groundBody != null && groundBody.isStatic()) {
				if(Math.abs(x - groundBody.bounds.x) > 30 && Math.abs(x - (groundBody.bounds.x + groundBody.bounds.width)) > 30) {
					Starling.juggler.add(new DelayedCall(function(x:Number, y:Number):void {
						_safe_respawn = new Vec2(x, y);
					}, 1, [x, y]));
				}
			}
			
			// Handle being dead			
			if(_dead) {
				var m:Model = Main.getModel();
				if(m.lifes-- < 1) {
					(Main.getState() as GameState).openPopup(new GameOverWindow());
					return;
				}
				velocity.x = 0;
				velocity.y = 0;
				x = safe_respawn.x;
				y = safe_respawn.y;
				dead = false;
			}
			
			updateAnimation();
		}
		
		/**
		 * This function is copied from the super class. It is modified to make wall jumping possible.
		 * A few changes are made to make this possible
		 */
		override public function handleBeginContact(callback:InteractionCallback):void 
		{
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, callback);
			_touchingWall = false;
			
			if (callback.arbiters.length > 0 && callback.arbiters.at(0).collisionArbiter) {
				var collisionAngle:Number = callback.arbiters.at(0).collisionArbiter.normal.angle * 180 / Math.PI;
		
				if ((collisionAngle > 45 && collisionAngle < 135) || collisionAngle == -90)
				{
					if (collisionAngle > 1 || collisionAngle < -1) {
						//we don't want the Hero to be set up as onGround if it touches a cloud.
						if (collider is Platform && (collider as Platform).oneWay && collisionAngle == -90) {
							return;
						}
						_groundContacts.push(collider.body);
						_onGround = true;
					}
				}
				else {
					//If not, the collision is a wall
					_touchingWall = true;
					lastWallContact = collider;
				}
			}
		}		
		
		/**
		 * Copied from super class. Nothing is modified, but it is just copied hero for possible
		 * changes in the future.
		 */
		override protected function updateAnimation():void 
		{
			var prevAnimation:String = _animation;
			var walkingSpeed:Number = _body.velocity.x;
			
			if (walkingSpeed < -acceleration)
				_inverted = true;
			else if (walkingSpeed > acceleration)
				_inverted = false;
			
			_state.updateAnimation();

			if (prevAnimation != _animation) {
				onAnimationChange.dispatch();
			}
		}
		
		public function set state(state:LuigiState):void
		{
			_state = state;
			_state.init();
		}
		
		override public function get animation():String
		{
			return _animation;
		}
		
		public function set animation(animation:String):void
		{
			_animation = animation;
		}
		
		/**
		 * Check if the hero is dead
		 */
		public function get dead():Boolean
		{
			return _dead;
		}
		
		public function set dead(dead:Boolean):void
		{
			_dead = dead;
		}
		
		public function get normal_shape():Shape
		{
			return _normal_shape;
		}
		
		public function set normal_shape(value:Shape):void
		{
			_normal_shape = value;
		}
		
		public function get ducking_shape():Shape
		{
			return _ducking_shape;
		}
		
		public function set ducking_shape(value:Shape):void
		{
			_ducking_shape = value;
		}
		
		
		public function get safe_respawn():Vec2
		{
			return _safe_respawn;
		}
		
		public function set safe_respawn(value:Vec2):void
		{
			_safe_respawn = value;
		}
		
		public function get oldVelocity():Vec2
		{
			return _oldVelocity;
		}
		
		public function set oldVelocity(value:Vec2):void
		{
			_oldVelocity = value;
		}
		
		public function get touchingWall():Boolean
		{
			return _touchingWall;
		}
		
		public function set touchingWall(value:Boolean):void
		{
			_touchingWall = value;
		}
		
	}
}