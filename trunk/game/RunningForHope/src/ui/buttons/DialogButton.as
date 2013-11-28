package ui.buttons
{
	import flash.geom.Rectangle;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class DialogButton extends Button 
	{
		private var btn:int;
		private var callback:Function;
		
		public function DialogButton(text:String, btn:int, callback:Function) 
		{
			this.btn = btn;
			this.callback = callback;
			
			var texture:Texture;
			if(btn == 1) {
				texture = Assets.getTexture("Interface", "DialogBtnRed");
			}
			else if(btn == 2) {
				texture = Assets.getTexture("Interface", "DialogBtnYellow");
			}
			else {
				texture = Assets.getTexture("Interface", "DialogBtnGreen");
			}
			
			super(texture, text, texture);
			
			textHAlign = HAlign.LEFT;
			textVAlign = VAlign.CENTER;
			textBounds = new Rectangle(10, 0, 700, 52);
			this.fontSize = 24;
			
			if(callback != null) {
				addEventListener(Event.REMOVED_FROM_STAGE, destroy);
				addEventListener(Event.ADDED_TO_STAGE, init);
				addEventListener(Event.TRIGGERED, function():void {
					if (callback.length > 0) callback(btn);
					else callback();
				});
			}
		}
		
		private function init():void
		{
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
		}
		
		private function destroy(e:Event):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
		}
		
		private function keyboardHandler(e:KeyboardEvent):void
		{
			if (e.keyCode == (48 + btn) || e.keyCode == (96 + btn)) {
				if (callback.length > 0) callback(btn);
				else callback();
			}
		}
	}
}