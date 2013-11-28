package ui.menus
{
	import flash.text.*;
	
	import game.GameState;
	
	import model.Model;
	import model.Player;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.ResizeEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
	public class ChooseName extends Sprite
	{
		private var name_input:flash.text.TextField;
		
		public function ChooseName() 
		{
			MenuState.setTitle("What is your name?", 10, 180, HAlign.CENTER);
			
			// Background for name input
			var image:Image = new Image(Assets.getTexture("Interface", "nameInput"));
			image.x = 124;
			image.y = 236;
			addChild(image);
			
			// Message saying to use the enter button
			var info:starling.text.TextField = new starling.text.TextField(700, 100, "Press the enter key when you've finished typing your name", "Arial", 12, 0xFFFFFF);
			info.x = 50;
			info.y = 270;
			addChild(info);
			
			// Name input
			name_input = new flash.text.TextField();
			var textFormat:TextFormat = new TextFormat("Arial", 25, 0x000000);
			textFormat.align = TextFormatAlign.LEFT;
			name_input.defaultTextFormat = textFormat;
			name_input.type = TextFieldType.INPUT;
			name_input.width = 508;
			name_input.height = 34;
			name_input.x = 147;
			name_input.y = 253;
			Starling.current.nativeOverlay.addChild(name_input);
			
			// Focus on the name input
			Starling.current.nativeStage.focus = name_input;
			name_input.text = "test ";
			name_input.setSelection(1, 1);
			name_input.text = "test";
			
			
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardListener);
			stage.addEventListener(Event.REMOVED, destroy);
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(event:ResizeEvent):void
		{
			name_input.x = 147 * (event.width / Config.VIRTUAL_WIDTH);
			name_input.y = 253 * (event.height / Config.VIRTUAL_HEIGHT);
			name_input.defaultTextFormat = new TextFormat("Arial", Math.round(25 *(event.height / Config.VIRTUAL_HEIGHT)), 0x000000);
			name_input.height = 34 * (event.height / Config.VIRTUAL_HEIGHT);
			name_input.height = 508 * (event.width / Config.VIRTUAL_WIDTH);
			name_input.text = name_input.text;
			name_input.setSelection(name_input.length, name_input.length);
		}
		
		private function destroy():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyboardListener);
			stage.removeEventListener(Event.REMOVED, destroy);
		}
		
		
		private function keyboardListener(e:KeyboardEvent):void
		{
			if (e.keyCode == 13 && name_input.text.replace(/\s+/gi, "").length > 0 ) {
				Starling.current.nativeOverlay.removeChild(name_input);
				Main.getModel().player().name = name_input.text;
				Main.setState(new GameState());
			}
		}
	}
}