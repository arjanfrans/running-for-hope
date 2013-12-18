package ui.windows
{
	import starling.text.TextField;

	public class LoadingWindow extends InfoWindow
	{
		public function LoadingWindow()
		{
			super(-1);
			
			var loadingText:TextField = new TextField(345, 80, "Loading...", "Arial", 64);
			appendChild(loadingText);
			
			var infoText:TextField = new TextField(345, 20, "Please wait while the level is loading", "Arial", 12);
			appendChild(infoText, 10);
		}
	}
}