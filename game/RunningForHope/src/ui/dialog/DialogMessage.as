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
	
	public class DialogMessage extends Sprite
	{
		public var real_width:Number;
		public var target_y:Number = 0;
		public var side:String;
		
		public function DialogMessage(nameColor:uint, name:String, message:String, direction:String = "left")
		{
			super();
			this.side = direction;
			
			var size:Vec2 = getTextSize(message);
			real_width = size.x + 30;
			
			// Background, simply plain white
			var head:Quad = new Quad(size.x, 10);
			var body:Quad = new Quad(size.x + 20, size.y + 30);
			var foot:Quad = new Quad(size.x, 10);
			
			head.x = foot.x = 10;
			body.y = 10;
			foot.y = 40 + size.y;
			this.addChild(head);
			this.addChild(body);
			this.addChild(foot);
			
			// Title / Name
			var nameEle:starling.text.TextField = new starling.text.TextField(450, 40, name, "Arial", 24, nameColor, true);
			nameEle.hAlign = HAlign.LEFT;
			nameEle.x = 10;
			nameEle.y = 0;
			addChild(nameEle);
			
			// Message
			var textEle:starling.text.TextField = new starling.text.TextField(size.x + 15, size.y + 15, message, "Arial", 16);
			textEle.hAlign = HAlign.LEFT;
			textEle.x = 10;
			textEle.y = 30;
			addChild(textEle);
			
			// Corners
			var tl:Image = Assets.getImage("Interface", "DialogMessageCorner");
			var tr:Image = Assets.getImage("Interface", "DialogMessageCorner");
			var bl:Image = Assets.getImage("Interface", "DialogMessageCorner");
			var br:Image = Assets.getImage("Interface", "DialogMessageCorner");
			
			tl.x = 0; tr.y = 0;
			tr.x = size.x + 10; tr.y = 0;
			br.x = size.x + 10; br.y = size.y + 40;
			bl.x = 0; bl.y = size.y + 40;
			
			rotate(tl, 0);
			rotate(tr, 90);
			rotate(br, 180);
			rotate(bl, 270);
			
			addChild(tl);
			addChild(tr);
			addChild(bl);
			addChild(br);
			
			// Arrow to indicate source
			var arrow:Image = Assets.getImage("Interface", "DialogSideArrow");
			arrow.y = (height / 2) - (arrow.height / 2);
			if(direction === "left") {
				arrow.x = -arrow.width;
				rotate(arrow, 180);
			}
			else {
				arrow.x = size.x + 20;
			}
			addChild(arrow);
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
		
		private function getTextSize(text:String):Vec2 {
			var format:TextFormat = new TextFormat("Arial", 16);
			
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