package ui.buttons
{
	import citrus.core.CitrusEngine;
	import citrus.input.Input;
	import citrus.input.controllers.Keyboard;
	
	import flash.geom.Rectangle;
	
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	
	/**
	 * Class to make it easier to add buttons
	 * @author Wim Barelds
	 */
	public class NumberButton extends Button 
	{
		private var btn:int;
		private var action:Function;
		
		public function NumberButton(background:Texture, btn:int = -1, text:String = "", action:Function = null, width:int = 0, textColor:uint = 0xFF000000):void
		{
			if (textColor == 0x00000000) text = "";
			super(background, text, background);
			
			this.btn = btn;
			this.action = action;
			this.textBounds = new Rectangle(69, 53, 300, 46);
			this.textHAlign = HAlign.LEFT;
			this.fontSize = 30;
			this.fontColor = textColor;
			
			if (width > 0) {
				this.scaleY = this.scaleX = width / background.nativeWidth;
			}
			
			// Mouse handler
			if (action != null) {
				addEventListener(Event.TRIGGERED, function():void {
					if (action.length > 0) action(btn);
					else action();
				});
			}
			
			// Keyboard handling
			if (btn >= 0 && btn <= 9) {
				// Add button textfield
				if (textColor != 0x00000000){
					var buttonTextField:TextField = new TextField(30, 50, "" + btn, "Arial", 30);
					buttonTextField.x = 426;
					buttonTextField.y = 51;
					buttonTextField.color = textColor;
					addChild(buttonTextField);
				}
				// Add keyboard listener
				if(action != null) {
					addEventListener(Event.ADDED_TO_STAGE, init);
				}
			}
		}
		
		private function init():void
		{
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
			stage.addEventListener(Event.REMOVED, destroy);
		}
		
		private function destroy(e:Event):void
		{
			if(e.target != this) return;
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
			stage.removeEventListener(Event.REMOVED, destroy);
		}
		
		private function keyboardHandler(e:KeyboardEvent):void
		{
			if (e.keyCode == (48 + btn) || e.keyCode == (96 + btn)) {
				if (action.length > 0) action(btn);
				else action();
			}
		}
		
	}
}