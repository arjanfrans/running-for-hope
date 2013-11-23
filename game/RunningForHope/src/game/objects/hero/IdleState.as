package game.objects.hero
{
	import game.objects.Luigi;

	public class IdleState implements IState
		private var _hero:Luigi;
	{
		public function IdleState(hero:Luigi)
		{
			_hero = hero;
		}
		
		public function update(timeDelta:Number):void
		{
			
		}
		
		public function updateAnimation():void
		{
			_hero.animation = "idle";
		}
	}
}