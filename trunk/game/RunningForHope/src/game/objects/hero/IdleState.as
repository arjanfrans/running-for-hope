package game.objects.hero
{
	import citrus.input.Input;
	
	import game.objects.Luigi;
	import nape.geom.Vec2;

	public class IdleState implements LuigiState {
		private var _hero:Luigi;
	
		public function IdleState(hero:Luigi)
		{
			_hero = hero;
		}
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			if(_hero.dynamicFriction != 0.77) _hero.dynamicFriction = 0.77; //Take away friction so he can accelerate.
			if(_hero.staticFriction != 1.2)_hero.staticFriction = 1.2;

			var moveKeyPressed:Boolean = false;
			if (input.justDid("right", _hero.inputChannel)) {
				_hero.state = _hero.walkState;
			}
			
			if (input.justDid("left", _hero.inputChannel)) {
				_hero.state = _hero.walkState;
			}
	
			if (_hero.onGround && input.justDid("jump", _hero.inputChannel)){
				velocity.y = -_hero.jumpHeight;
				_hero.onJump.dispatch();
				_hero.state = _hero.jumpState;
			}
		}
		
		public function updateAnimation():void
		{
			if(Math.round(_hero.body.velocity.x) == 0) {
				_hero.animation = "idle";
			}
			else {
				_hero.animation = "walk";
			}
		}
	}
}