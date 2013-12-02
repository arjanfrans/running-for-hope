package ui.hud {
	
	import citrus.core.starling.StarlingState;
	
	import model.Level;
	import model.Score;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import ui.buttons.NumberButton;
	
	/**
	 * A ingame interface that displays all information the player should know during gameplay.
	 */
	public class PlayerStatsUi extends StarlingState {


		private var heartsBar:HeartsBar;
		private var menuCallback:Function;
		private var highscoreText:TextField;
		private var scoreText:TextField;
		private var objectiveText:TextField;
		
		/**
		 * This creates a ingame interface that displays all information the player should know during gameplay.
		 * 
		 * @param Function menuCallback The function the menubutton calls to open a pauzemenu.
		 */
		public function PlayerStatsUi(menuCallback:Function) {
			super();
			
			var level:Level = Main.getModel().getLevel();
			var highScore:Score = level.highscores().getHighScore(0);
			
			//background
			var img:Image = Assets.getImage("Spritesheet", "HUDBackground");
			this.addChild(img);
			
			//menu button
			// Remove this
			this.menuCallback = menuCallback;
			var menuButton:NumberButton = new NumberButton(
				Assets.getTexture("Interface", "btnGeneric")
				, 0
				, "Menu"
				, menuCallback
				, 135
				, 0xFF000000
			);
			menuButton.x = 400-(130/2);
			menuButton.y = 30;
			menuButton.alpha = 0;
			this.addChild(menuButton);
			
			//highscoreText
			highscoreText = new TextField(300, 40, "Points: "+highScore.points.toString()+" | "+"Time: "+timeToClock(highScore.time), "Arial", 15, 0xFFFFFFFF);
			highscoreText.hAlign = HAlign.LEFT;
			highscoreText.x = 20;
			highscoreText.y = 40;

			this.addChild(highscoreText);
			

			//scoreText
			scoreText = new TextField(300, 40, "", "Arial", 15, 0xFFFFFFFF);
			scoreText.hAlign = HAlign.RIGHT;
			scoreText.x = width - 320;
			scoreText.y = 40;
			addChild(scoreText);
			
			//objectiveText
			objectiveText = new TextField(300, 40, "Objective", "Arial", 15, 0xFF000000);
			objectiveText.hAlign = HAlign.CENTER;
			objectiveText.x = width/2 - 150;
			objectiveText.y = 0;
			addChild(objectiveText);
			
			//heartsBar
			heartsBar = new HeartsBar();
			heartsBar.update();
			heartsBar.x = (width / 2) - (heartsBar.width / 2);
			heartsBar.y = 50;
			this.addChild(heartsBar);
		}
		

		
		/**
		 * Update de HUD.
		 */
		public function updateUi():void {
			updateText();
			updateObjective();
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
			//pointsLabel.text = "Points: " + getPoints();
		}
		
		/**
		 * Update the timeLabel in the hud.
		 */
		private function updateTime():void {
			//timeLabel.text = "Time: " + timeToClock(getTime());
		}
		
		private function updateText():void {
			var points:String;
			if (getPoints()<100) {
				points = '  '+getPoints();
			} else if (getPoints()<10) {
				points = ' '+getPoints();
			} else {
				points = ''+getPoints();
			}
			scoreText.text = "Points: "+points+" | "+"Time: "+timeToClock(getTime());
		}
		
		private function updateObjective():void {
			objectiveText.text = Main.getModel().getLevel().objective;;
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
				minutesString = ' '+minutes.toString();
				
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