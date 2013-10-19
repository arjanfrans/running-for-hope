package
{
	import ui.PlayerStatsUi;

	public class PlayerStats
	{
		public static var tokens:Number = 0;
		public static var health:Number = 10;
		
		public function PlayerStats()
		{
			
		}
		
		public static function addToken():void {
			tokens++;
			PlayerStatsUi.updateUi();
		}
		
		public static function decreaseHealth():void {
			health--;
			PlayerStatsUi.updateUi();
		}
		
	}
}