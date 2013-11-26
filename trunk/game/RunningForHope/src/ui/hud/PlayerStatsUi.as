package ui.hud {
	
	import citrus.core.starling.StarlingState;
	
	import game.PlayerStats;
	
	import starling.display.Quad;
	import starling.text.TextField;
	
	import ui.buttons.NumberButton;
	import ui.menus.MenuState;
	import model.Level;
	import model.Score;
	
	public class PlayerStatsUi extends StarlingState {

		private var scoreLabel:TextField;
		private var healthLabel:TextField;
		private var timeLabel:TextField;
		private var heartsBar:HeartsBar;
		private var menuCallback:Function;
		private var level:Level;
		private var highScore:Score;
		private var recordScoreLabel:TextField;
		private var RecordTimeLabel:TextField;
		
		public function PlayerStatsUi(menuCallback:Function) {
			super();
			
			level = Main.getModel().getLevel();
			highScore = level.highscores().getHighScore(0);
			
			//background
			this.addChild(new Quad(800, 100));
			
			//menu button
			this.menuCallback = menuCallback;
			var menuButton:NumberButton = new NumberButton(
				Assets.getTexture("Interface", "btnGeneric")
				, 0
				, "Menu"
				, menuCallback
				, 190
				, 0x000000
			);
			menuButton.x = 550;
			menuButton.y = 0;
			this.addChild(menuButton);
			
			//scoreLabel
			scoreLabel = new TextField(160, 40, "Score: " + Main.getModel().points, "Verdana", 20, 0x000000, true);
			scoreLabel.x = 30;
			scoreLabel.y = 10;
			this.addChild(scoreLabel);
			
			//bestScoreLabel
			recordScoreLabel = new TextField(250, 40, "Record Score: " + highScore.score.toString(), "Verdana", 20, 0x000000, true);
			recordScoreLabel.x = 200;
			recordScoreLabel.y = 10;
			this.addChild(recordScoreLabel);
			
			//healthLabel
			/*healthLabel = new TextField(80, 20, "Health: " + Main.getModel().lifes);
			healthLabel.x = 130;
			healthLabel.y = 50;
			this.addChild(healthLabel);*/
			
			//timeLabel
			timeLabel = new TextField(160, 40, "Time: " + timeToClock(Main.getModel().time), "Verdana", 20, 0x000000, true);
			timeLabel.x = 30;
			timeLabel.y = 60;
			this.addChild(timeLabel);
			
			//bestTimeLabel
			RecordTimeLabel = new TextField(250, 40, "Record Time:  " + timeToClock(highScore.time), "Verdana", 20, 0x000000, true);
			RecordTimeLabel.x = 200;
			RecordTimeLabel.y = 60;
			this.addChild(RecordTimeLabel);
			
			//heartsBar
			heartsBar = new HeartsBar();
			heartsBar.x = 550;
			heartsBar.y = 60;
			heartsBar.update();
			this.addChild(heartsBar);
		}
		
		/**
		 * Update de HUD.
		 */
		public function updateUi():void {
			scoreLabel.text = "Score: " + Main.getModel().points;
			timeLabel.text = "Time: " + timeToClock(Main.getModel().time);
			//healthLabel.text = "Health: " + Main.getModel().lifes;
			heartsBar.update();
		}
		
		
		private function timeToClock(time:Number):String{
			var minutes:Number = Math.floor(time/60);
			var seconds:Number = Math.floor(time%60);
			var minutesString:String;
			var secondsString:String;
			if (minutes<10) {
				minutesString = '0'+minutes.toString();
			} else {
				minutesString = minutes.toString();
			}
			if (seconds<10) {
				secondsString = '0'+seconds.toString();
			} else {
				secondsString = seconds.toString();
			}
			
			return minutesString+":"+secondsString;
		}
	}
}