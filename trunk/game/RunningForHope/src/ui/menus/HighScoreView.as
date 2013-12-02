package ui.menus
{
	import model.Level;
	import model.Model;
	import model.Score;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import ui.buttons.NumberButton;
	
	public class HighScoreView extends Sprite
	{
		private var level:Level;
	
		public function HighScoreView(level:int)
		{
			this.level = Main.getModel().getLevel(level);
			MenuState.setTitle("Highscores for: " + this.level.name);
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			// Add medals
			var imageGold:Image = Assets.getImage("Interface", "MedalGold");
			var imageSilver:Image = Assets.getImage("Interface", "MedalSilver");
			var imageBronze:Image = Assets.getImage("Interface", "MedalBronze");
			imageGold.x = imageSilver.x = imageBronze.x = 40;
			imageGold.y = 175;
			imageSilver.y = 225;
			imageBronze.y = 275;
			addChild(imageGold);
			addChild(imageSilver);
			addChild(imageBronze);
			
			// Add scores
			var numLevels:int = Main.getModel().numLevels();
			for (var i:int = 0; i < numLevels; i++) {
				var score:Score = level.highscores().getHighScore(i); 
				var highscoreTextField:TextField = new TextField(700, 50, score.toString(), "Arial", 20);
				highscoreTextField.hAlign = HAlign.LEFT;
				highscoreTextField.x = 90;
				highscoreTextField.y = 168 + (i * 50);
				highscoreTextField.color = 0xFFFFFFFF;
				addChild(highscoreTextField);
			}
			
			var backButton:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnBack"), 0, "", back, 250, 0xFF440000);
			backButton.x = 540;
			backButton.y = 520;
			addChild(backButton);
		}
		
		private function mainmenu():void
		{
			MenuState.openMenu();
		}
		
		private function back():void
		{
			MenuState.openMenu(new LevelMenu(levelHighscores, mainmenu, "Choose level to view high-scores"));
		}
		
		private function levelHighscores(level:int):void
		{
			MenuState.openMenu(new HighScoreView(level));
		}		
	}
}