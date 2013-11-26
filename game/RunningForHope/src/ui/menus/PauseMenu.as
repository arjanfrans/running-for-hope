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
			
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			stage.addEventListener(Event.RESIZE, onResize);
			onResize(new ResizeEvent("init", Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight));
		}
		
		/**
		 * Resize the sprite to window
		 */
		private function onResize(event:ResizeEvent):void
		{
			this.width = event.width;
			this.height =  event.height;
		}
		
		
		private function continueGame():void
		{
			state.closePauseMenu();
		}
		
		private function reset():void
		{
			// The movieclip is where our level is loaded from, it defines the blueprint from which our level was built
			var level:MovieClip = Main.getModel().getLevel().flashLevel;
			for(var i:int = 0; i < level.numChildren; i++) {
				var item:DisplayObject = level.getChildAt(i);
				if(item["className"] == "game.objects.Box") {
					// The objects in state are direct references to the objects actually in our level
					// We can cross reference these to the same objects from our blueprint, and place them back in their original position
					var obj:NapePhysicsObject = state.objects[i + 1] as NapePhysicsObject;
					obj.x = item.x;
					obj.y = item.y;
					obj.rotation = item.rotation;
				}
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