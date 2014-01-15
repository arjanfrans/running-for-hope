package ui.windows
{
	import starling.text.TextField;

	public class LocationInfo extends InfoWindow
	{
		public function LocationInfo()
		{
			super();
			
			addChild(Assets.getImage("Interface", "TipsAndTricks"));
			
			var infoText:TextField = new TextField(345, 50, "Try taking a different route and explore the level, you might find something valuable!", "Arial", 16, 0, true);
			appendChild(infoText, 10);

			appendChild(Assets.getImage("Interface", "Explore"), 10);
			
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);
		}
	}
}