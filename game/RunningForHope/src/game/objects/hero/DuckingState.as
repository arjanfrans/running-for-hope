package game.objects.hero
{
	import citrus.input.Input;
	
	import nape.geom.Vec2;
	import game.objects.Luigi;
	import citrus.input.Input;
	
	import game.objects.Luigi;
	import nape.geom.Vec2;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import nape.phys.Body;
	
	public class DuckingState implements LuigiState
	{
		private var _hero:Luigi;
		
		public function DuckingState(hero:Luigi)
		{
			_hero = hero;
		}
		
		public function init():void
		{
			_hero.body.shapes.remove(_hero.normal_shape);
			_hero.body.shapes.add(_hero.ducking_shape);
			_hero.view.y += _hero.texture_height_duck/2;
			_hero.view.pivotX = 0;
		}
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			var moveKeyPressed:Boolean = false;
			
			if (input.justDid("right", _hero.inputChannel) || input.justDid("left", _hero.inputChannel)) {
				_hero.body.shapes.remove(_hero.ducking_shape);
				_hero.body.shapes.add(_hero.normal_shape);
				_hero.state = _hero.walkState;
				_hero.view.y -= _hero.texture_height_duck/2; // Restore size
				moveKeyPressed = true;
			}
			else if(!input.isDoing("duck", _hero.inputChannel)) {
					_hero.body.shapes.remove(_hero.ducking_shape);
					_hero.body.shapes.add(_hero.normal_shape);
					
					_hero.state = _hero.idleState;
					_hero.view.y -= _hero.texture_height_duck/2; // Restore size
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
			_hero.animation = "duck";
		}
	}
}