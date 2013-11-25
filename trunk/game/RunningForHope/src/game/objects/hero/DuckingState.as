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
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			var groundBody:Body =  _hero.groundContacts[0] as Body;
			_hero.body.shapes.remove(_hero.normal_shape);
			_hero.body.shapes.add(_hero.ducking_shape);
			if(_hero.onGround && groundBody != null && groundBody.isStatic()) {
				Starling.juggler.add(new DelayedCall(function(x:Number, y:Number):void {
					_hero.safe_respawn = new Vec2(x, y);
				}, 1, [_hero.x, _hero.y]));
			}
			
			if (_hero.controlsEnabled) {
				var moveKeyPressed:Boolean = false;
				
				_hero.ducking = (input.isDoing("duck", _hero.inputChannel) && _hero.onGround && _hero.canDuck);
				
				
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
							
					if(!input.isDoing("duck", _hero.inputChannel)) {
						_hero.body.shapes.remove(_hero.ducking_shape);
						_hero.body.shapes.add(_hero.normal_shape);
						_hero.state = _hero.idleState;
					}
				//Cap velocities
				if (velocity.x > (_hero.maxVelocity))
					velocity.x = _hero.maxVelocity;
				else if (velocity.x < (-_hero.maxVelocity))
					velocity.x = -_hero.maxVelocity;
			}
		}
		
		public function updateAnimation():void
		{
			_hero.inverted =  _hero.body.velocity.x < -_hero.acceleration ? true : false;
			_hero.animation = "duck";
		}
	}
}