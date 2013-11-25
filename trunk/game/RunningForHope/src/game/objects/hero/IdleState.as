package game.objects.hero
{
	import citrus.input.Input;
	
	import game.objects.Luigi;
	import nape.geom.Vec2;
	import starling.animation.DelayedCall;
	import starling.core.Starling;
	import nape.phys.Body;
	
	public class IdleState implements LuigiState {
		private var _hero:Luigi;
		
		public function IdleState(hero:Luigi)
		{
			_hero = hero;
		}
		
		public function init():void
		{
			
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
			
			if (input.justDid("right", _hero.inputChannel) || input.justDid("left", _hero.inputChannel)) {
				_hero.state = _hero.walkState;
				moveKeyPressed = true;
			}
			
			if (input.justDid("duck", _hero.inputChannel))
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
			if((Math.round(_hero.body.velocity.x) > 1) || (Math.round(_hero.body.velocity.x) < -1)) {
				_hero.animation = "walk";
			}
			else {
				_hero.animation = "idle";
			}
		}
	}
}