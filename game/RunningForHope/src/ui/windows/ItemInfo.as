package ui.windows
{
	import starling.text.TextField;
	import nape.geom.Vec2;

	public class ItemInfo extends InfoWindow
	{
		public function ItemInfo(text:String)
		{
			super();
			var size:Vec2 = TextHelper.getTextSize(text, 315, 16);
			
			addChild(Assets.getImage("Interface", "Information"));
			
			var infoText:TextField = new TextField(345, size.y + 30, text, "Arial", 16, 0, true);		
			appendChild(infoText, 10);
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);
		}
		
		
	}
}