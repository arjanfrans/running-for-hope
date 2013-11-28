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
		private var _onGround:Boolean = false;
		
		public function JumpState(hero:Luigi)
		{
			_hero = hero;
		}
		
		public function init():void
		{
			_hero.onJump.dispatch();
			jump_triggered = true;
			_onGround = false;
		}
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
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
			
			if(_onGround && _hero.onGround) {
				if(input.isDoing("right", _hero.inputChannel) || input.isDoing("left", _hero.inputChannel)) {
					_hero.state = _hero.walkState;
					moveKeyPressed = true;
				}
				else {
					_hero.state = _hero.idleState;
				}
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
			if (_hero.touchingWall && input.isDoing("jump", _hero.inputChannel) && !_hero.onGround && velocity.y < 100 && Math.abs(_hero.oldVelocity.x) > 100 && !jump_triggered)
			{
				velocity.y = -_hero.jumpHeight;//Math.max(velocity.y - 200, -_hero.jumpHeight);
				velocity.x = (_hero.oldVelocity.x > 0) ? -250 : 250;
				_hero.touchingWall = false;
				jump_triggered = true;
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
			
			_onGround = _hero.onGround;
		}
		
		public function updateAnimation():void
		{
			_hero.animation = "jump";
		}
		
		
	}
}