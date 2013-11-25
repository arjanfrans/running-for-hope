package game.objects.hero
{
	import citrus.input.Input;
	
	import game.objects.Luigi;
	
	import model.Model;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	
	import ui.menus.MenuState;
	
	public class JumpState implements LuigiState
	{
		private var _hero:Luigi;
		private var jump_triggered:Boolean;
		
		public function JumpState(hero:Luigi)
		{
			_hero = hero;
		}
		
		public function init():void
		{
			_hero.onJump.dispatch();
			jump_triggered = true;
		}
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			var groundBody:Body =  _hero.groundContacts[0] as Body;
			if(_hero.onGround && groundBody != null && groundBody.isStatic()) {
				Starling.juggler.add(new DelayedCall(function(x:Number, y:Number):void {
					_hero.safe_respawn = new Vec2(x, y);
				}, 1, [_hero.x, _hero.y]));
			}
			
			var moveKeyPressed:Boolean = false;
			
			if(input.justDid("jump", _hero.inputChannel)) jump_triggered = false;
			
			if (input.isDoing("right", _hero.inputChannel))
			{
				velocity.x += _hero.acceleration;
				moveKeyPressed = true;
			}
			
			if (input.isDoing("left", _hero.inputChannel))
			{
				velocity.x -= _hero.air_acceleration;
				moveKeyPressed = true;
			}
			
			//If player just started moving the hero this tick.
			if (moveKeyPressed && !_hero.playerMovingHero)
			{
				_hero.playerMovingHero = true;
				_hero.material.dynamicFriction = 0; //Take away friction so he can accelerate.
				_hero.material.staticFriction = 0;
			}
				//Player just stopped moving the hero this tick.
			else if (!moveKeyPressed && _hero.playerMovingHero)
			{
				_hero.playerMovingHero = false;
				_hero.material.dynamicFriction = _hero.dynamicFriction; //Add friction so that he stops running
				_hero.material.staticFriction = _hero.staticFriction;
			}
			
			//Wall jumping
			if (_hero.touchingWall && input.isDoing("jump", _hero.inputChannel) && !_hero.onGround && velocity.y < 50 && Math.abs(_hero.oldVelocity.x) > 50 && !jump_triggered)
			{
				velocity.y = Math.max(velocity.y - 200, -_hero.jumpHeight);
				velocity.x = (_hero.oldVelocity.x > 0) ? -150 : 150;
				_hero.touchingWall = false;
				jump_triggered = true;
			}
			
			if(_hero.onGround && !input.isDoing("jump", _hero.inputChannel)) {
				_hero.state = _hero.idleState;
			}
			
			
			//Cap velocities
			if (velocity.x > (_hero.maxVelocity))
				velocity.x = _hero.maxVelocity;
			else if (velocity.x < (-_hero.maxVelocity))
				velocity.x = -_hero.maxVelocity;
			
			//Track previous velocity, necessary for wall jumping.
			Starling.juggler.add(new DelayedCall(function(x:Number, y:Number):void {
				_hero.oldVelocity.x = x;
				_hero.oldVelocity.y = y;
			}, 0.3, [_hero.body.velocity.x, _hero.body.velocity.y]));
		}
		
		public function updateAnimation():void
		{
			trace(_hero.animation);
			_hero.animation = "jump";
		}
		
		
	}
}