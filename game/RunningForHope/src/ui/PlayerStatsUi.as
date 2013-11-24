package ui
{
	import citrus.core.starling.StarlingState;
	
	import starling.text.TextField;
	import game.PlayerStats;
	
	public class PlayerStatsUi extends StarlingState
	{

		private static var scoreLabel:TextField;
		private static var healthLabel:TextField;
		
		public function PlayerStatsUi()
		{
			super();
			scoreLabel = new TextField(80, 20, "Score: " + Main.getModel().points);
			healthLabel = new TextField(80, 20, "Health: " + Main.getModel().lifes);
			scoreLabel.x = 40;
			scoreLabel.y = 50;
			healthLabel.x = 130;
			healthLabel.y = 50;
			this.addChild(scoreLabel);
			this.addChild(healthLabel);
		}
		
		/**
		 * Update de HUD.
		 */
		public static function updateUi():void {
			scoreLabel.text = "Score: " + Main.getModel().points;
			healthLabel.text = "Health: " + Main.getModel().lifes;
		}
	}
}