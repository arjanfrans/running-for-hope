package ui
{
	import citrus.core.starling.StarlingState;
	import starling.text.TextField;
	
	public class PlayerStatsUi extends StarlingState
	{

		private var scoreLabel:TextField;
		private var healthLabel:TextField;
		
		public function PlayerStatsUi()
		{
			super();
			scoreLabel = new TextField(80, 20, "Score:");
			healthLabel = new TextField(80, 20, "Health:");
			scoreLabel.x = 40;
			scoreLabel.y = 50;
			healthLabel.x = 130;
			healthLabel.y = 50;
			this.addChild(scoreLabel);
			this.addChild(healthLabel);
		}
	}
}