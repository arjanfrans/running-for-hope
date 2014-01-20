package ui.windows
{
	import game.GameState;
	
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import ui.menus.MenuState;

	public class LevelSummary extends InfoWindow
	{
		public function LevelSummary()
		{
			super();
			super.closeFunc = close;
			var text:String;
			
			var player:String = Main.getModel().player().name;
			switch(Main.getModel().level) {
				case 0:
					text = "- Hope wasn't feeling very well. " + player + " went with Hope to the local doctor. \n\n" +
						"- The local doctor told Hope to go to a clinic to get her blood tested.\n\n" +
						"- The bridge to the clinic was broken. " + player + " used boxes to get to the other side.\n\n" +
						"- Hope got tested at the clinic. The doctor came back with the result that Hope has HIV.\n\n" +
						"- Hope has to use medicine as prescribed every day in her life. With medicine she can live a normal life. \n";
					break;
				case 1:
					text = "- " + player + " was looking for the school teacher, Mr. Abasi.\n\n" +
						"- " + player + " wanted to give a presentation about HIV prevention. Mr. Abasi thought it was a good idea.\n\n" +
						"- " + player + " searched for information in books and newspapers.\n\n";
						"- When " + player + " found all the information " + (Main.getModel().player().gender == "Male" ? "he" : "she") + " went to the school " +
						"and gave the presentation. The class thanked " + player + " for the important information\n";
					break;
				case 2:
					text = "";
					break;
			}
			
			var infoText:TextField = new TextField(600, 400, text, "Arial", 16, 0, true);	
			infoText.hAlign = HAlign.LEFT;
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