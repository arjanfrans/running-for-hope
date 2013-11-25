package ui.hud {
	
	import citrus.core.starling.StarlingState;
	
	import game.PlayerStats;
	
	import starling.display.Quad;
	import starling.text.TextField;
	
	import ui.buttons.NumberButton;
	import ui.menus.MenuState;
	
	public class PlayerStatsUi extends StarlingState {

		private var scoreLabel:TextField;
		private var healthLabel:TextField;
		private var heartsBar:HeartsBar;
		
		public function PlayerStatsUi() {
			super();
			scoreLabel = new TextField(80, 20, "Score: " + Main.getModel().points);
			healthLabel = new TextField(80, 20, "Health: " + Main.getModel().lifes);
			scoreLabel.x = 40;
			scoreLabel.y = 50;
			healthLabel.x = 130;
			healthLabel.y = 50;
			this.addChild(new Quad(800, 100));
			
			
			this.addChild(scoreLabel);
			this.addChild(healthLabel);
			this.addChild(
				new NumberButton(
					Assets.getTexture("Interface", "btnGeneric")
					, 1
					, "Main Menu"
					, menuButtonCallBack
					, 100
					, 0x000000
				)
			);
			heartsBar = new HeartsBar();
			this.addChild(heartsBar);
			heartsBar.update();
			
		}
		
		/**
		 * Update de HUD.
		 */
		public function updateUi():void {
			scoreLabel.text = "Score: " + Main.getModel().points;
			healthLabel.text = "Health: " + Main.getModel().lifes;
			heartsBar.update();
		}
		
		private function menuButtonCallBack():void {
			
			Main.setState(new MenuState());
		}
	}
}