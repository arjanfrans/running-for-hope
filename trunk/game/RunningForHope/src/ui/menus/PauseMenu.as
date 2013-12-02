package ui.menus
{
	import citrus.objects.NapePhysicsObject;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	
	import game.GameState;
	import game.objects.Resetable;
	
	import model.Model;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	
	import ui.buttons.NumberButton;

	public class PauseMenu extends Sprite
	{
		private var state:GameState;
		public function PauseMenu()
		{
			super();
			state = Main.getState() as GameState;
			addChild(Assets.getImage("Interface", "PauseMenu"));
			
			// Continue button
			var btnContinue:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPaleBlue"), 1, "Continue", state.closePopup, 283);
			btnContinue.x = 68;
			btnContinue.y = 96;
			addChild(btnContinue);
			
			// Reset items button
			var btnReset:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPaleBlue"), 2, "Reset items", reset, 283);
			btnReset.x = 68;
			btnReset.y = 176;
			addChild(btnReset);
			
			// Reset items button
			var btnRestart:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPaleBlue"), 3, "Restart level", restart, 283);
			btnRestart.x = 68;
			btnRestart.y = 256;
			addChild(btnRestart);
			
			// Reset items button
			var btnMainMenu:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPaleBlue"), 4, "Main menu", mainMenu, 283);
			btnMainMenu.x = 68;
			btnMainMenu.y = 336;
			addChild(btnMainMenu);
		}
		
		
		private function reset():void
		{
			// The movieclip is where our level is loaded from, it defines the blueprint from which our level was built
			for(var i:int = 0; i < state.objects.length; i++) {
				var obj:Resetable = state.objects[i] as Resetable;
				if(obj != null) obj.reset();
			}
			state.closePopup();
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