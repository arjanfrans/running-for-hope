package menus.screens
{
	import menus.buttons.NumberButton;
	
	import starling.display.Button;
	import starling.display.Sprite;
	
	public class MainMenu extends Sprite
	{
		public function MainMenu()
		{
			super();
			var btnNewGame:Button = new NumberButton(Assets.getTexture("Interface", "btnNewGame"), 1, "", newGame, 0, 0x00000000);
			var btnContinueGame:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnContinueGame"), 2, "", continueGame, 0, 0x00000000);
			var btnViewHighscores:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnViewHighscores"), 3, "", viewHighScores, 0, 0x00000000);
			
			btnNewGame.x = 141; btnNewGame.y = 120;
			btnContinueGame.x = 141; btnContinueGame.y = 270;
			btnViewHighscores.x = 141; btnViewHighscores.y = 420;
			
			addChild(btnNewGame);
			addChild(btnContinueGame);
			addChild(btnViewHighscores);
		}
		
		private function newGame():void
		{
			MenuState.openMenu(new ChooseGender());
		}
		
		private function continueGame():void
		{
			
		}
		
		private function viewHighScores():void
		{
			
		}
	}
}