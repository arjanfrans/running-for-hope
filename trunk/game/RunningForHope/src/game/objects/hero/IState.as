package game.objects.hero
{
	public interface IState
	{
		public function update(timeDelta:Number):void;
		
		public function updateAnimation():void;
	}
}