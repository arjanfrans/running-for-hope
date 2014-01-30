package ui.windows
{
	import game.GameState;
	
	import starling.text.TextField;
	import starling.utils.HAlign;
	
	import ui.menus.MenuState;
	import nape.geom.Vec2;

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
						   "- Hope has to use medicine as prescribed every day, she can live a normal life if she uses the medicine. \n";
					break;
				case 1:
				
					text = "- " + player + " was looking for the school teacher, Mr. Abasi.\n\n" +
						   "- " + player + " wanted to give a presentation about HIV prevention. Mr. Abasi thought it was a good idea.\n\n" +
						   "- " + player + " searched for information in books and newspapers.\n\n" +
						   "- Information that " + player + " found: \n" +
						   "   - HIV is a sexually transmitted disease. You can get HIV from having unprotected sex. \n" +
						   "   - To prevent HIV it is important to always use a condom if you have sex.\n" +
						   "   - You can live a normal life with HIV if you take medicine every day.\n\n" +
						   "- When " + player + " found all the information " + (Main.getModel().player().gender == "Male" ? "he" : "she") + " went to the school " +
						   "and gave the presentation. The class thanked " + player + " for the important information\n";
					break;
				case 2:
					text = "- " + player + " and Hope had gone out to town. Hope was feeling better. \n\n" +
						"- A man, named Adin told " + player + " and Hope about a meeting about HIV. \n\n" +
						"- The road was blocked so " + player + " found another way by pressing a switch which opened the cave underground. \n\n" +
						"- " + player + " and Hope arrived at the meeting. Adin told them about how he got HIV through blood transmission. \n\n" +
						"- HIV through blood transmission can happen if you use a razor from someone who has HIV. It can contain a tiny bit of blood. \n\n"
						"- It can happen with other sharp objects too, like needles. Always be careful!"
					break;
			}
			
			var textsize:Vec2 = TextHelper.getTextSize(text, 470);
			var infoText:TextField = new TextField(500, textsize.y + 30, text, "Arial", 16, 0, true);	
			infoText.hAlign = HAlign.LEFT;
			appendChild(infoText, 10);
			var closeText:TextField = new TextField(500, 20, "Press Enter to continue", "Arial", 12);
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