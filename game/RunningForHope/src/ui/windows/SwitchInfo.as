package ui.windows
{
	import starling.text.TextField;

	public class SwitchInfo extends InfoWindow
	{
		public function SwitchInfo()
		{
			super();
			
			addChild(Assets.getImage("Interface", "TipsAndTricks"));
			
			var infoText:TextField = new TextField(300, 75, "You just pressed a switch. Look around and check for a new opening.", "Arial", 16, 0, true);
			appendChild(infoText, 10);
			
			appendChild(Assets.getImage("Spritesheet", "switchInfo"), 10);
			
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);
		}
	}
}