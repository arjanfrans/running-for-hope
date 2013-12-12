package game.objects.hero
{
	import game.objects.Luigi;
	import citrus.input.Input;
	import nape.geom.Vec2;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import nape.phys.Body;
	
	public class WalkState implements LuigiState
	{
		private var _hero:Luigi;
		
		public function WalkState(hero:Luigi)
		{
			_hero = hero;
		}
		
		public function init():void
		{
			Main.audio.playSound("walk");
			_hero.view.pivotX = 25;
		}
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			var moveKeyPressed:Boolean = false;
			
			
			if (input.isDoing("right", _hero.inputChannel))
			{
				velocity.x += _hero.acceleration;
				moveKeyPressed = true;
			}
			
			if (input.isDoing("left", _hero.inputChannel))
			{
				velocity.x -= _hero.acceleration;
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
			
			if (input.justDid("jump", _hero.inputChannel) && !_hero.ducking)
			{
				velocity.y = -_hero.jumpHeight;
				Main.audio.stopSound("walk");
				_hero.state = _hero.jumpState;
			}
			
			if(!input.justDid("jump", _hero.inputChannel) && !input.isDoing("left", _hero.inputChannel) && 
				!input.isDoing("right", _hero.inputChannel)) {
				Main.audio.stopSound("walk");
				_hero.state = _hero.idleState;
			}
			
			//Cap velocities
			if (velocity.x > (_hero.maxVelocity))
				velocity.x = _hero.maxVelocity;
			else if (velocity.x < (-_hero.maxVelocity))
				velocity.x = -_hero.maxVelocity;
			
		}
		
		public function updateAnimation():void
		{
			_hero.animation = "walk";
			
		}
	}
}