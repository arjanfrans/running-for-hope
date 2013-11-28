package ui.menus
{
	import starling.display.Button;
	import starling.display.Sprite;
	
	import ui.buttons.NumberButton;
	import ui.dialog.DialogMessage;
	
	public class MainMenu extends Sprite
	{
		public function MainMenu()
		{
			super();
			var btnNewGame:Button = new NumberButton(Assets.getTexture("Interface", "btnNewGame"), 1, "", newGameFromStart, 0, 0x00000000);
			var btnContinueGame:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnContinueGame"), 2, "", continueGame, 0, 0x00000000);
			var btnViewHighscores:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnViewHighscores"), 3, "", viewHighScores, 0, 0x00000000);
			
			btnNewGame.x = 141; btnNewGame.y = 120;
			btnContinueGame.x = 141; btnContinueGame.y = 270;
			btnViewHighscores.x = 141; btnViewHighscores.y = 420;
			
			addChild(btnNewGame);
			addChild(btnContinueGame);
			addChild(btnViewHighscores);
			
			/*
			var dm:DialogMessage = new DialogMessage(0xFF336699, "Hope", "Hey Max, how are yf we ewgwetewg wwetwe tewbtweqrv Hey Max, how are yf we ewgwetewg wwetwe tewbtweqrv Hey Max, how are yf we ewgwetewg wwetwe tewbtweqrv Hey Max, how are yf we ewgwetewg wwetwe tewbtweqrv Hey Max, how are yf we ewgwetewg wwetwe tewbtweqrv Hey Max, how are yf we ewgwetewg wwetwe tewbtweqrv qvqwrcqvqvqou doing?", "right");
			dm.x = 100;
			dm.y = 100;
			addChild(dm);
			*/
		}
		
		private function show():void
		{
			MenuState.openMenu();
		}
		
		private function newGameFromStart():void
		{
			newGame(0);
		}
		
		private function continueGame():void
		{
			MenuState.openMenu(new LevelMenu(newGame, show, "Choose level to play"));
		}
		
		private function viewHighScores():void
		{
			MenuState.openMenu(new LevelMenu(levelHighscores, show, "Choose level to view high-scores"));
		}
		
		/**
		 * Used in LevelMenu
		 */
		private function newGame(level:int):void
		{
			Main.getModel().level = level;
			MenuState.openMenu(new ChooseGender());
		}
		
		private function levelHighscores(level:int):void
		{
			MenuState.openMenu(new HighScoreView(level));
		}
		
	}
}