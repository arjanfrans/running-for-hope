package ui.windows
{
	import starling.text.TextField;
	import ui.menus.MenuState;
	import game.GameState;

	public class LevelSummary extends InfoWindow
	{
		public function LevelSummary()
		{
			super();
	/*		super.closeFunc = close;*/
			var text:String;
			
			var player:String = Main.getModel().player().name;
			switch(Main.getModel().level) {
				case 0:
					text = "- Hope wasn't feeling very well. " + player + " went with Hope to the local doctor. \n" +
						"- The local doctor told Hope to go to a clinic to get her blood tested.\n" +
						"- The bridge to the clinic was broken. " + player + " used boxes to get to the other side.\n" +
						"- Hope got tested at the clinic. The doctor came back with the result that Hope has HIV.\n" +
						"- Hope has to use medicine as prescribed every day in her life. With medicine she can live a normal life. \n";
					break;
				case 1:
					text = "";
					break;
				case 2:
					text = "";
					break;
			}
			
			var infoText:TextField = new TextField(345, 400, text, "Arial", 16, 0, true);		
			appendChild(infoText, 10);
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);

		}
		
		private function close():void
		{		
			
			// Change level
			//check whether there are any levels left after this one and increase level counter.
			if(Main.getModel().level + 1 >= Main.getModel().numLevels()) {
				//go to main menu
				Main.setState(new MenuState());
				return;
			}
			//load next level.
			Main.getModel().level++;
			Main.setState(new GameState());
		}
	}
}