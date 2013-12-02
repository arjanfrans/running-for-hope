package ui.windows
{
	import starling.text.TextField;

	public class WalljumpInfo extends InfoWindow
	{
		public function WalljumpInfo()
		{
			super();
			
			addChild(Assets.getImage("Interface", "TipsAndTricks"));
			
			var infoText:TextField = new TextField(345, 75, "You can perform a walljump by jumping into a wall, and jumping again when you hit it", "Arial", 16, 0, true);
			appendChild(infoText, 10);
			
			appendChild(Assets.getImage("Interface", "Walljump"), 10);
			
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);
		}
	}
}