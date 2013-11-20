package menus.buttons
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
		
		public function DialogOption(text:String, btn:int, callback:Function) 
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
			
			addEventListener(Event.TRIGGERED, function():void { callback(btn); } );
			addEventListener(KeyboardEvent.KEY_UP, function(e:KeyboardEvent):void {
				if (e.keyCode == (48 + btn)) callback(btn);
			} );
		}
	}
}