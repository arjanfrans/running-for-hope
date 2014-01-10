package game.objects.player
{
	import citrus.input.Input;
	
	import game.objects.Player;
	import nape.geom.Vec2;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import nape.phys.Body;
	
	public class IdleState implements PlayerState {
		private var _hero:Player;
		
		public function IdleState(hero:Player)
		{
			_hero = hero;
		}
		
		public function init():void
		{
			_hero.view.pivotX = 0;
		}
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			var moveKeyPressed:Boolean = false;
			
			if (input.justDid("right", _hero.inputChannel) || input.justDid("left", _hero.inputChannel)) {
				_hero.state = _hero.walkState;
				moveKeyPressed = true;
			}
			
			if (input.isDoing("duck", _hero.inputChannel))
			{
				_hero.state = _hero.duckingState;
				moveKeyPressed = true;
			}
			
			if (_hero.onGround && input.justDid("jump", _hero.inputChannel))
			{
				velocity.y = -_hero.jumpHeight;
				_hero.state = _hero.jumpState;
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
			
			//Cap velocities
			if (velocity.x > (_hero.maxVelocity))
				velocity.x = _hero.maxVelocity;
			else if (velocity.x < (-_hero.maxVelocity))
				velocity.x = -_hero.maxVelocity;
		}
		
		public function updateAnimation():void
		{
			if(_hero.respawn) {
				_hero.animation = "respawn";
			} else {
				_hero.animation = "idle";
			}
		}
	}
}