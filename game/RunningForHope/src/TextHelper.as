package
{
	import flash.text.TextFormat;
	import nape.geom.Vec2;

	public class TextHelper
	{
		public function TextHelper()
		{
		}
		
		public static function getTextSize(text:String, width:Number = 410, fontSize:int = 16):Vec2 {
			var format:TextFormat = new TextFormat("Arial", fontSize);
			
			var ele:flash.text.TextField = new flash.text.TextField();
			ele.multiline = true;
			ele.wordWrap = true;
			ele.width = width;
			ele.defaultTextFormat = format;
			ele.text = text;
			
			return new Vec2(ele.textWidth, ele.textHeight);
		}
		
	}
}