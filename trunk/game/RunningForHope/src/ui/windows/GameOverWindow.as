package ui.windows
{
	import game.GameState;
	
	import starling.text.TextField;
	
	import ui.buttons.NumberButton;
	import ui.menus.MenuState;

	public class GameOverWindow extends InfoWindow
	{
		public function GameOverWindow()
		{
			super(-1);
			
			addChild(Assets.getImage("Interface", "GameOver"));
			
			appendChild(new TextField(345, 20, "You've lost all of your lifes", "Arial", 16), 10);
			appendChild(new NumberButton(Assets.getTexture("Interface", "btnRed"), 1, "Restart level", restart, 345, 0xFF660000), 10);
			appendChild(new NumberButton(Assets.getTexture("Interface", "btnBlue"), 2, "Main Menu", mainmenu, 345, 0xFF223344), 10);
		}
		
		private function restart():void
		{
			Main.setState(new GameState());
		}
		
		private function mainmenu():void
		{
			Main.setState(new MenuState());
		}
	}
}