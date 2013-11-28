package ui.dialog
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class DialogArea extends Sprite
	{
		private const MAX_HEIGHT:Number = 360;
		private const MAX_WIDTH:Number = 460;
		
		public function DialogArea()
		{
			super();
			width = 460;
			x = 170;
			y = 10;
			height = MAX_HEIGHT;
		}
		
		public function addMessage(msg:DialogMessage):void
		{
			for(var i:int = 0; i < numChildren; i++) {
				var dm:DialogMessage = getChildAt(i) as DialogMessage;
				dm.target_y += msg.height + 10;
				slideMessageTo(dm);
				if((dm.target_y + dm.height) > MAX_HEIGHT) {
					removeMessage(dm);
				}
			}
			showMessage(msg);
		}
		
		private function showMessage(msg:DialogMessage):void
		{
			if(msg.side !== "left") msg.x = (MAX_WIDTH - msg.real_width);
			msg.alpha = 0;
			addChild(msg);
			Starling.juggler.tween(msg, 0.5, { alpha: 1 });
		}
		
		private function slideMessageTo(msg:DialogMessage):void
		{
			Starling.juggler.removeTweens(msg);
			Starling.juggler.tween(msg, 1, { y: msg.target_y });
		}
		
		private function removeMessage(msg:DialogMessage):void
		{
			Starling.juggler.tween(msg, 0.5, { alpha: 0 });
			Starling.juggler.delayCall(function():void {
				removeChild(msg);
			}, 0.5);
		}
	}
}