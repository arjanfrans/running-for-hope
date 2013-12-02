package levels.dialog
{
	import model.dialog.Dialog;
	import model.dialog.DialogEntry;
	import model.dialog.DialogLibrary;
	import model.dialog.QuestionResponse;
	import model.dialog.QuestionResponseSet;

	public class Level3Dialog
	{
		private static var loaded:Boolean = false;
		
		public function Level3Dialog()
		{
		}
		
		private static function response(message:String, from:String = "Hope"):DialogEntry
		{
			return new DialogEntry(from, message, "right"); 
		}
		
		public static function load():void
		{
			var library:DialogLibrary = Main.getModel().getLevel(2).dialog;
			if (loaded) return;
			
			var chat:Dialog = new Dialog(
				Assets.getTexture("Characters", "Hope"),
				"Reach the end of the level",
				false
			);
			
			var qrs1:QuestionResponseSet = new QuestionResponseSet();
			qrs1.add(new QuestionResponse("I'm doing great! How about you?", response("I'm actually not feeling too well.")));
			qrs1.add(new QuestionResponse("I'm fine. You?", response("I'm actually not feeling too well.")));
			qrs1.add(new QuestionResponse("Stubbed my toe! How about you?", response("Haha! I'm actually not feeling too well...")));
			chat.add(qrs1);
			
			var qrs2:QuestionResponseSet = new QuestionResponseSet();
			qrs2.add(new QuestionResponse("Oh? What's wrong with you?", response("For a few weeks now I've had a fever, and I'm constantly tired.")));
			qrs2.add(new QuestionResponse("Oh come on, what's the matter?", response("... I've been having a fever for weeks now, and I never have any energy.")));
			qrs2.add(new QuestionResponse("Don't be weak, it's nothing right?", response("No, really. I've had a bad fever for weeks now, and I can hardly get out of bed. I'm so tired.")));
			chat.add(qrs2);
			
			var qrs3:QuestionResponseSet = new QuestionResponseSet();
			qrs3.add(new QuestionResponse("Maybe you should go to the doctor...", response("I guess. Would you come with me?")));
			qrs3.add(new QuestionResponse("That's terrible! Want me to take you to the doctor?", response("Thanks [playerName], yeah lets do that.")));
			qrs3.add(new QuestionResponse("Wow that sucks! Come on, we need to get you to a doctor.", response("That's probably a good idea. Thanks.")));
			chat.add(qrs3);
			
			var qrs4:QuestionResponseSet = new QuestionResponseSet();
			qrs4.add(new QuestionResponse("Alright, lets go!", null));
			qrs4.add(new QuestionResponse("Shall we go now?", response("Yep! Lets go.")));
			qrs4.add(new QuestionResponse("I'll race you there.", response("Too funny. Lets go.")));
			chat.add(qrs4);
			
			
			var chat2:Dialog = new Dialog(
				Assets.getTexture("Characters", "Hope"),
				"",
				true
			);
			
			chat2.add(new DialogEntry("Hope", "You're done", "right"));
			
			var qrs5:QuestionResponseSet = new QuestionResponseSet();
			qrs5.add(new QuestionResponse("I know", response("Really?")));
			qrs5.add(new QuestionResponse("Really?", response("Yep")));
			qrs5.add(new QuestionResponse("Awesome", response("I know, right?")));
			chat2.add(qrs5);
			
			chat2.add(new DialogEntry("Hope", "Awesome", "right"));
			chat2.add(new DialogEntry("Hope", "Test", "left"));
			
			library.put("Level1Start", chat);
			library.put("Level1End", chat2);
			
			loaded = true;
		}
	}
}