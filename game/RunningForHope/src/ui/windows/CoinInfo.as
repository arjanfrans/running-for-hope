package ui.windows
{
	import starling.text.TextField;

	public class CoinInfo extends InfoWindow
	{
		public function CoinInfo()
		{
			super();
			
			addChild(Assets.getImage("Interface", "TipsAndTricks"));
			
			var infoText:TextField = new TextField(345, 50, "CDs contain valuable information. Pick up more CDs for a higher score", "Arial", 16, 0, true);
			appendChild(infoText, 10);
			
			appendChild(Assets.getImage("Interface", "CoinsInfo"), 10);
			
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);
		}
	}
}