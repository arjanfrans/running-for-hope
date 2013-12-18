package ui.dialog
{
	import model.dialog.Dialog;
	
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
		}
		
		public function addMessage(msg:DialogMessage):void
		{
			if(numChildren > 0) {
				var lastChild:DialogMessage = getChildAt(numChildren - 1) as DialogMessage;
				while(lastChild.target_y + lastChild.height + 10 + msg.height > MAX_HEIGHT) {
					var removed:Boolean = false;
					for(var i:int = 0; i < numChildren; i++) {
						var dm:DialogMessage = getChildAt(i) as DialogMessage;
						if(dm.removed) continue;
						if(!removed) {
							removeMessage(getChildAt(0) as DialogMessage);
							removed = true;
							continue;
						}
						if(i === 1) {
							dm.target_y = 0;
						}
						else {
							var lastDm:DialogMessage = getChildAt(i - 1) as DialogMessage;
							dm.target_y = lastDm.target_y + lastDm.height + 10;
						}
						slideMessageTo(dm);
					}
				}
			}
			showMessage(msg);
		}
		
		private function showMessage(msg:DialogMessage):void
		{
			if(numChildren > 0) {
				var lastChild:DialogMessage = getChildAt(numChildren - 1) as DialogMessage;
				msg.y = lastChild.y + lastChild.height + 10;
				msg.target_y = lastChild.target_y + lastChild.height + 10;
				slideMessageTo(msg);
			}
			else {
				msg.y = msg.target_y = 0;
			}
			if(msg.side !== "left") msg.x = (MAX_WIDTH - msg.real_width);
			msg.alpha = 0;
			addChild(msg);
			Starling.juggler.tween(msg, 0.5, { alpha: 1 });
		}
		
		private function slideMessageTo(msg:DialogMessage):void
		{
			Starling.juggler.tween(msg, 1, { y: msg.target_y });
		}
		
		private function removeMessage(msg:DialogMessage):void
		{
			msg.removed = true;
			Starling.juggler.tween(msg, 0.5, { alpha: 0 });
			Starling.juggler.delayCall(function():void {
				removeChild(msg);
			}, 0.5);
		}
	}
}