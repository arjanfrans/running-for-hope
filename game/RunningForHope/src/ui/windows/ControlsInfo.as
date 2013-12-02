package ui.windows
{
	import starling.display.Sprite;
	import starling.text.TextField;

	public class ControlsInfo extends InfoWindow
	{
		public function ControlsInfo()
		{
			super();
			
			addChild(Assets.getImage("Interface", "TipsAndTricks"));
			
			var infoText:TextField = new TextField(345, 50, "Use the arrow buttons to move.\nUse the spacebar to jump!", "Arial", 16, 0, true);
			appendChild(infoText, 10);
			
			appendChild(Assets.getImage("Interface", "Keyboard"), 10);
			
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);
		}
	}
}