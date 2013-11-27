package ui.hud {
	
	import citrus.core.starling.StarlingState;
	
	import model.Level;
	import model.Score;
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.text.TextField;
	
	import ui.buttons.NumberButton;
	import starling.display.Image;
	

	/**
	 * A ingame interface that displays all information the player should know during gameplay.
	 */
	public class PlayerStatsUi extends StarlingState {


		private var pointsLabel:TextField;
		private var healthLabel:TextField;
		private var timeLabel:TextField;
		private var heartsBar:HeartsBar;
		private var menuCallback:Function;
		private var level:Level;
		private var highScore:Score;
		private var recordPointsLabel:TextField;
		private var RecordTimeLabel:TextField;
		public var originalHeight:Number = 100;
		public var originalWidth:Number = 800;
		private var highscoreText:TextField;
		
		/**
		 * This creates a ingame interface that displays all information the player should know during gameplay.
		 * 
		 * @param Function menuCallback The function the menubutton calls to open a pauzemenu.
		 */
		public function PlayerStatsUi(menuCallback:Function) {
			super();
			
			level = Main.getModel().getLevel();
			highScore = level.highscores().getHighScore(0);
			
			//background
			this.addChild(new Quad(originalWidth, originalHeight));
			var img:Image = new Image(Assets.getTexture("Spritesheet", "HUDBackground"));
			img.x = 0;
			img.y = 0;
			img.width = originalWidth;
			this.addChild(img);
			trace(this.height);
			
			//menu button
			this.menuCallback = menuCallback;
			var menuButton:NumberButton = new NumberButton(
				Assets.getTexture("Interface", "btnGeneric")
				, 0
				, "Menu"
				, menuCallback
				, 190
				, 0xFF000000
			);
			menuButton.x = 550;
			menuButton.y = 0;
			this.addChild(menuButton);
			
			//highscoreText
			
			highscoreText = new TextField(300, 40, "Points: "+highScore.points.toString()+" | "+"Time: "+timeToClock(highScore.time), "Arial", 15, 0x000000, true);
			//updatePoints();
			highscoreText.x = -40;
			highscoreText.y = 40;
			this.addChild(highscoreText);
			
			//pointsLabel
			pointsLabel = new TextField(160, 40, " ", "Arial", 20, 0x000000, true);
			updatePoints();
			pointsLabel.x = 30;
			pointsLabel.y = 10;
			//this.addChild(pointsLabel);
			
			//recordPointsLabel
			recordPointsLabel = new TextField(250, 40, "Points: " + highScore.points.toString(), "Arial", 20, 0x000000, true);
			recordPointsLabel.x = 20;
			recordPointsLabel.y = 10;
			//this.addChild(recordPointsLabel);
			
			//healthLabel
			/*healthLabel = new TextField(80, 20, "Health: " + Main.getModel().lifes);
			healthLabel.x = 130;
			healthLabel.y = 50;
			this.addChild(healthLabel);*/
			
			//timeLabel
			timeLabel = new TextField(160, 40, " ", "Arial", 20, 0x000000, true);
			updateTime();
			timeLabel.x = 30;
			timeLabel.y = 60;
			//this.addChild(timeLabel);
			
			//bestTimeLabel
			RecordTimeLabel = new TextField(250, 40, "Time:  " + timeToClock(highScore.time), "Arial", 20, 0x000000, true);
			RecordTimeLabel.x = 200;
			RecordTimeLabel.y = 60;
			//this.addChild(RecordTimeLabel);
			
			//heartsBar
			heartsBar = new HeartsBar();
			heartsBar.update();
			heartsBar.x = 550;
			heartsBar.y = 60;
			this.addChild(heartsBar);
		}
		

		
		/**
		 * Update de HUD.
		 */
		public function updateUi():void {
			updatePoints();
			updateTime();
			heartsBar.update();
		}
		
		/**
		 * Get the current elapsed playtime.
		 * @return Number The current elapsed playtime.
		 */
		private function getTime():Number {
			return Main.getModel().time;
			
		}
		
		/**
		 * Get the current score.
		 * @return int The current score.
		 */
		private function getScore():int {
			return Score.calculate(getTime(), getPoints());
		}
		
		/**
		 * Get the current amount of points.
		 * @return int The current amount of points.
		 */
		private function getPoints():int {
			return Main.getModel().points;
		}
		
		/**
		 * Update the scoreLabel in the hud.
		 */
		private function updateScore():void {
			//scoreLabel.text = "Score: " + getScore();
		}
		
		/**
		 * Update the pointsLabel in the hud.
		 */
		private function updatePoints():void {
			pointsLabel.text = "Points: " + getPoints();
		}
		
		/**
		 * Update the timeLabel in the hud.
		 */
		private function updateTime():void {
			timeLabel.text = "Time: " + timeToClock(getTime());
		}
		
		private function updateHighscore():void {
			
		}
		
		/**
		 * Generate a clock from an amount of seconds.
		 * @param Number time An amount of seconds.
		 * @return String A clock with minutes and seconds(mm:ss)
		 */
		private function timeToClock(time:Number):String {
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