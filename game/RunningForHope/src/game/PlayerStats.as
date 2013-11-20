package game
{
	import ui.PlayerStatsUi;

	/**
	 * This class has some static variables, which keep the lives and score of the player.
	 */
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