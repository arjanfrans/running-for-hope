package ui.dialog
{
	import feathers.text.StageTextField;
	
	import flash.text.StageText;
	import flash.text.StageTextInitOptions;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import nape.geom.Vec2;
	
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.deg2rad;
	
	import ui.windows.InfoWindow;
	
	public class DialogMessage extends InfoWindow
	{
		public var real_width:Number;
		public var target_y:Number = 0;
		public var side:String;
		
		public function DialogMessage(name:String, message:String, direction:String = "left")
		{
			super(-1, direction === "left");
			this.side = direction;
			
			var nameColor:uint = (direction === "left") ? 0xFF990000 : 0xFF336699;
			
			var nameSize:Vec2 = getTextSize(name, 24);
			var size:Vec2 = getTextSize(message);
			real_width = Math.max(size.x, nameSize.x) + 30;
			
			// Title / Name
			var nameEle:starling.text.TextField = new starling.text.TextField(nameSize.x + 15, 40, name, "Arial", 24, nameColor, true);
			nameEle.hAlign = HAlign.LEFT;
			addChild(nameEle);
			nameEle.y = -2;
			
			// Message
			var textEle:starling.text.TextField = new starling.text.TextField(size.x + 15, size.y + 15, message, "Arial", 16);
			textEle.hAlign = HAlign.LEFT;
			textEle.y = 30;
			addChild(textEle);
			
			// Arrow to indicate source
			var arrow:Image;
			if(direction === "left") {
				arrow = Assets.getImage("Interface", "DialogSideArrow2");
			}
			else {
				arrow = Assets.getImage("Interface", "DialogSideArrow");
			}
			
			arrow.y = (height / 2) - (arrow.height / 2);
			addChild(arrow);
			if(direction === "left") {
				arrow.x = -arrow.width - 10;
				rotate(arrow, 180);
			}
			else {
				arrow.x = this.width - 10;
			}
		}
		
		private function rotate(img:Image, deg:Number):Image
		{
			img.pivotX = img.width / 2;
			img.pivotY = img.height / 2;
			img.rotation = starling.utils.deg2rad(deg);
			img.x += img.width / 2;
			img.y += img.height / 2;
			return img;
		}
		
		private function getTextSize(text:String, fontSize:int = 16):Vec2 {
			var format:TextFormat = new TextFormat("Arial", fontSize);
			
			var ele:flash.text.TextField = new flash.text.TextField();
			ele.multiline = true;
			ele.wordWrap = true;
			ele.width = 410;
			ele.defaultTextFormat = format;
			ele.text = text;
			
			return new Vec2(ele.textWidth, ele.textHeight);
		}
	}
}