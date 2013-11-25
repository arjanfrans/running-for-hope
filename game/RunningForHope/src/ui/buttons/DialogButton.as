package ui.buttons
{
	import flash.geom.Rectangle;
	import starling.display.Button;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.HAlign;

	public class DialogButton extends Button 
	{
		private var btn:int;
		private var callback:Function;
		
		public function DialogButton(text:String, btn:int, callback:Function) 
		{
			this.btn = btn;
			this.callback = callback;
			
			var texture:Texture = Assets.getTexture("Interface", "DialogOption");
			super(texture, text, texture);
			
			textHAlign = HAlign.LEFT;
			textBounds = new Rectangle(20, 0, 400, 45);
			
			var actionText:TextField = new TextField(45, 45, "" + btn, "Arial");
			actionText.color = 0xFFFFFFFF;
			actionText.bold = true;
			actionText.width = 45;
			actionText.height = 45;
			actionText.x = 452;
			actionText.y = 0;
			addChild(actionText);
			
			if(callback != null) {
				addEventListener(Event.ADDED_TO_STAGE, init);
				addEventListener(Event.TRIGGERED, function():void { callback(btn); } );
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
				if (callback.length > 0) callback(btn);
				else callback();
			}
		}
	}
}