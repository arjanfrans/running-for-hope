package ui.menus
{
	import citrus.objects.NapePhysicsObject;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import game.GameState;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	
	import ui.buttons.NumberButton;
	import model.Model;
	import game.objects.Resetable;

	public class PauseMenu extends Sprite
	{
		private var state:GameState;
		public function PauseMenu(gameState:GameState)
		{
			super();
			state = gameState;
			addChild(Assets.getImage("Interface", "PauseMenu"));
			
			// Continue button
			var btnContinue:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPaleBlue"), 1, "Continue", continueGame, 283);
			btnContinue.x = 256;
			btnContinue.y = 162;
			addChild(btnContinue);
			
			// Reset items button
			var btnReset:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPaleBlue"), 2, "Reset items", reset, 283);
			btnReset.x = 256;
			btnReset.y = 242;
			addChild(btnReset);
			
			// Reset items button
			var btnRestart:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPaleBlue"), 3, "Restart level", restart, 283);
			btnRestart.x = 256;
			btnRestart.y = 322;
			addChild(btnRestart);
			
			// Reset items button
			var btnMainMenu:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPaleBlue"), 4, "Main menu", mainMenu, 283);
			btnMainMenu.x = 256;
			btnMainMenu.y = 402;
			addChild(btnMainMenu);

		}
		
		
		private function continueGame():void
		{
			state.closePauseMenu();
		}
		
		private function reset():void
		{
			// The movieclip is where our level is loaded from, it defines the blueprint from which our level was built
			for(var i:int = 0; i < state.objects.length; i++) {
				var obj:Resetable = state.objects[i] as Resetable;
				if(obj != null) obj.reset();
			}
			state.closePauseMenu();
		}
		
		private function restart():void
		{
			Main.setState(new GameState());
		}
		
		private function mainMenu():void
		{
			Main.setState(new MenuState());
		}
	}
}