package ui.windows
{
	import game.GameState;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.ResizeEvent;
	import starling.utils.deg2rad;
	
	public class InfoWindow extends Sprite
	{
		private var content:Sprite;

		private var foot:Quad;
		private var body:Quad;
		private var head:Quad;

		private var topLeft:Image;
		private var topRight:Image;
		private var bottomLeft:Image;
		private var bottomRight:Image;
		
		private var closeKey:int;
		protected var closeFunc:Function = null;
		
		public function InfoWindow(closeKey:int = 13)
		{
			super();
			// Background
			head = new Quad(10, 10);
			body = new Quad(10, 10);
			foot = new Quad(10, 10);
			body.y = head.x = foot.x = 10;
			super.addChild(head);
			super.addChild(body);
			super.addChild(foot);
			
			// Corners
			topLeft = Assets.getImage("Interface", "DialogMessageCorner");
			topRight = Assets.getImage("Interface", "DialogMessageCorner");
			bottomLeft = Assets.getImage("Interface", "DialogMessageCorner");
			bottomRight = Assets.getImage("Interface", "DialogMessageCorner");
			rotate(topLeft, 0);
			rotate(topRight, 90);
			rotate(bottomRight, 180);
			rotate(bottomLeft, 270);
			super.addChild(topLeft);
			super.addChild(topRight);
			super.addChild(bottomLeft);
			super.addChild(bottomRight);
			
			// Content
			content = new Sprite();
			content.x = content.y = 10;
			super.addChild(content);
			
			// Move and resize
			adjustBorders();
			
			if(closeKey > 0) {
				this.closeKey = closeKey;
				if(stage != null) init();
				else addEventListener(Event.ADDED_TO_STAGE, init);
				
				addEventListener(Event.REMOVED_FROM_STAGE, destroy);
			}
		}
		
		private function init():void
		{
			stage.addEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
			// Resize
			stage.addEventListener(Event.RESIZE, onResize);
			onResize(new ResizeEvent("init", Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight));
		}
		
		/**
		 * Resize the sprite to window
		 */
		private function onResize(event:ResizeEvent):void
		{
			var scale:Number = Math.min((event.width / Config.VIRTUAL_WIDTH), (event.height / Config.VIRTUAL_HEIGHT));
			this.scaleX = scale;
			this.scaleY = scale;
		}
		
		private function destroy():void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyboardHandler);
		}
		
		private function keyboardHandler(e:KeyboardEvent):void {
			if(e.keyCode == closeKey) {
				if(closeFunc !== null) closeFunc();
				else (Main.getState() as GameState).closePopup();
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			content.addChild(child);
			adjustBorders();
			return this;
		}
		
		public function appendChild(child:DisplayObject, spacing:Number = 0):DisplayObject
		{
			child.y = content.height + spacing;
			content.addChild(child);
			adjustBorders();
			return this;
		}
		
		private function adjustBorders():void
		{
			head.width = content.width;
			body.width = content.width + 20;
			body.height = content.height;
			foot.width = content.width;
			foot.y = content.height + 10;
			
			topRight.x = bottomRight.x = content.width + 20;
			bottomLeft.y = bottomRight.y = content.height + 20;
		}
		
		private function rotate(img:Image, deg:Number):Image
		{
			img.pivotX = img.width / 2;
			img.pivotY = img.height / 2;
			img.rotation = deg2rad(deg);
			img.pivotX = 0;
			img.pivotY = 0;
			return img;
		}
	}
}