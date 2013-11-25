package game.objects.hero
{
	import game.objects.Luigi;
	import citrus.input.Input;
	import nape.geom.Vec2;

	public class WalkState implements LuigiState
	{
		private var _hero:Luigi;
		{
			public function WalkState(hero:Luigi)
			{
				_hero = hero;
			}
		}
			
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			if(_hero.dynamicFriction != 0) _hero.dynamicFriction = 0; //Take away friction so he can accelerate.
			if(_hero.staticFriction != 0)_hero.staticFriction = 0;
			
			if (input.isDoing("right", _hero.inputChannel)) {
				velocity.x += _hero.acceleration;
			}
				
			if (input.isDoing("left", _hero.inputChannel)) {
				velocity.x -= _hero.acceleration;
			}
				
			if (_hero.onGround && input.justDid("jump", _hero.inputChannel)){
				velocity.y = -_hero.jumpHeight;
				_hero.onJump.dispatch();
				_hero.state = _hero.jumpState;
			}
			
			if(!input.isDoing("right", _hero.inputChannel) && !input.isDoing("left", _hero.inputChannel)) {
				_hero.state = _hero.idleState;				
			}
			
			if (velocity.x > (_hero.maxVelocity))
				velocity.x = _hero.maxVelocity;
			else if (velocity.x < (-_hero.maxVelocity))
				velocity.x = -_hero.maxVelocity;
		}
		
		public function updateAnimation():void
		{
			_hero.inverted =  _hero.body.velocity.x < -_hero.acceleration ? true : false;
			_hero.animation = "walk";
		}
	}
}