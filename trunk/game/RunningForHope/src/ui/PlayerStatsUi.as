package ui
{
	import citrus.core.starling.StarlingState;
	import starling.text.TextField;
	
	public class PlayerStatsUi extends StarlingState
	{
		public function PlayerStatsUi()
		{
			super();
			var scoreLabel:TextField = new TextField(80, 20, "Score:");
			var healthLabel:TextField = new TextField(80, 20, "Health:");
			scoreLabel.x = 40;
			scoreLabel.y = 50;
			healthLabel.x = 130;
			healthLabel.y = 50;
			this.addChild(scoreLabel);
			this.addChild(healthLabel);
		}
	}
}