package ui.windows
{
	import starling.text.TextField;

	public class ItemInfo extends InfoWindow
	{
		public function ItemInfo(text:String)
		{
			super();
			
			
			var infoText:TextField = new TextField(345, 400, text, "Arial", 16, 0, true);		
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);
		}
		
		
	}
}