package ui.hud {
	
	import citrus.core.starling.StarlingState;
	
	import flash.display.StageDisplayState;
	
	import game.GameState;
	
	import model.Level;
	import model.Model;
	import model.Score;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.ResizeEvent;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import ui.buttons.NumberButton;
	import ui.menus.PauseMenu;
	/**
	 * A ingame interface that displays all information the player should know during gameplay.
	 */
	public class PlayerStatsUi extends StarlingState {


		private var heartsBar:HeartsBar;
		private var highscoreText:TextField;
		private var scoreText:TextField;
		private var itemsText:TextField;
		private var objectiveText:TextField;
		
		/**
		 * This creates a ingame interface that displays all information the player should know during gameplay.
		 * 
		 * @param Function menuCallback The function the menubutton calls to open a pauzemenu.
		 */
		public function PlayerStatsUi() {
			super();
			
			var level:Level = Main.getModel().getLevel();
			var highScore:Score = level.highscores().getHighScore(0);
			
			//background
			var img:Image = Assets.getImage("Interface", "HUDBackground");
			this.addChild(img);
			
			var footer:Image = Assets.getImage("Interface", "HUDFooter");
			footer.y = Config.VIRTUAL_HEIGHT - footer.height;
			addChild(footer);
			
			//menu button
			// Remove this
			//highscoreText
			scoreText = new TextField(300, 40, "", "Arial", 15, 0xFFFFFFFF);
			scoreText.hAlign = HAlign.LEFT;
			scoreText.x = 20;
			scoreText.y = 40;
			this.addChild(scoreText);
			

			//scoreText
			highscoreText = new TextField(300, 40, "Points: "+highScore.points.toString()+" | "+"Time: "+timeToClock(highScore.time), "Arial", 15, 0xFFFFFFFF);
			highscoreText.hAlign = HAlign.RIGHT;
			highscoreText.x = width - 320;
			highscoreText.y = 40;
			addChild(highscoreText);
						
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
			
			if(stage == null) addEventListener(Event.ADDED_TO_STAGE, addBinding);
			else addBinding();
			
			addEventListener(Event.REMOVED_FROM_STAGE, removeBinding);
		}
		
		public function addBinding():void
		{
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
		}
		
		public function removeBinding():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
		}
		
		private function keyboardHandler(e:KeyboardEvent):void
		{
			//TODO Game goes out of full screen when escape is pressed
			if (e.keyCode == 27) {
				var state:GameState = Main.getState() as GameState;
				state.openPopup(new PauseMenu());
			}
		}
		
		/**
		 * Update de HUD.
		 */
		public function updateUi():void {
			var m:Model = Main.getModel();
			scoreText.text = "Points: " + m.points + " | Time: " + timeToClock(m.time);
			objectiveText.text = Main.getModel().getLevel().objective;
			
			//if in level 2, update the item ui
			if(m.level == 1) {
				var itemsLeft:Number = m.getLevel().maxItems - m.items;
				if(itemsLeft != 0 && itemsLeft < m.getLevel().maxItems) {
					objectiveText.text = "Find " + itemsLeft + " more item" + (itemsLeft == 1 ? "" : "s") + " with information on HIV.";
				}
				else {
					objectiveText.text = Main.getModel().getLevel().objective;
				}
			}
			
			heartsBar.update();
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