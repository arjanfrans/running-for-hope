package game.objects.hero
{
	import citrus.input.Input;
	import game.objects.Luigi;
	import nape.geom.Vec2;

	public class JumpState implements LuigiState
	{
		private var _hero:Luigi;
		
		public function JumpState(hero:Luigi)
		{
			_hero = hero;
		}
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			
			
			if (input.isDoing("right", _hero.inputChannel)) {
				velocity.x += _hero.air_acceleration;
			}
			
			if (input.isDoing("left", _hero.inputChannel))
			{
				velocity.x -= _hero.air_acceleration;
			}
			
			if (velocity.x > (_hero.maxVelocity))
			velocity.x = _hero.maxVelocity;
			else if (velocity.x < (-_hero.maxVelocity))
			velocity.x = -_hero.maxVelocity;
			
			
			if(_hero.onGround) {
				_hero.state = _hero.idleState;
			}
						
		}
		
		public function updateAnimation():void
		{
			_hero.inverted =  _hero.body.velocity.x < -_hero.acceleration ? true : false;
			_hero.animation = "jump";
		}
		
		
	}
}