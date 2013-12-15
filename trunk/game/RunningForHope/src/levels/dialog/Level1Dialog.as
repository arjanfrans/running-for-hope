package levels.dialog
{
	import model.dialog.Dialog;
	import model.dialog.DialogEntry;
	import model.dialog.DialogLibrary;
	import model.dialog.QuestionResponse;
	import model.dialog.QuestionResponseSet;
	
	public class Level1Dialog
	{
		private static var loaded:Boolean = false;
		
		public function Level1Dialog()
		{
		}
		
		private static function response(message:String, from:String = "Hope"):DialogEntry
		{
			return new DialogEntry(from, message, "right"); 
		}
		
		public static function load():void
		{
			var library:DialogLibrary = Main.getModel().getLevel(0).dialog;
			if (loaded) return;
			
			var intro:Dialog = new Dialog(
				null,
				Assets.getTexture("Characters", "Hope"),
				"Reach the end of the level"
			);
			
			intro.add(response("Hey [playerName], how are you doing?"));
			
			var qrs1:QuestionResponseSet = new QuestionResponseSet();
			qrs1.add(new QuestionResponse("I'm doing great! How about you?", response("I'm actually not feeling too well.")));
			qrs1.add(new QuestionResponse("I'm fine. You?", response("I'm actually not feeling too well.")));
			qrs1.add(new QuestionResponse("Stubbed my toe! How about you?", response("Haha! I'm actually not feeling too well...")));
			intro.add(qrs1);
			
			var qrs2:QuestionResponseSet = new QuestionResponseSet();
			qrs2.add(new QuestionResponse("Oh? What's wrong with you?", response("For a few weeks now I've had a fever, and I'm constantly tired.")));
			qrs2.add(new QuestionResponse("Oh come on, what's the matter?", response("... I've been having a fever for weeks now, and I never have any energy.")));
			qrs2.add(new QuestionResponse("Don't be weak, it's nothing right?", response("No, really. I've had a bad fever for weeks now, and I can hardly get out of bed. I'm so tired.")));
			intro.add(qrs2);
			
			var qrs3:QuestionResponseSet = new QuestionResponseSet();
			qrs3.add(new QuestionResponse("Maybe you should go to the doctor...", response("I guess. Would you come with me?")));
			qrs3.add(new QuestionResponse("That's terrible! Want me to take you to the doctor?", response("Thanks [playerName], yeah lets do that.")));
			qrs3.add(new QuestionResponse("Wow that sucks! Come on, we need to get you to a doctor.", response("That's probably a good idea. Thanks.")));
			intro.add(qrs3);
			
			var qrs4:QuestionResponseSet = new QuestionResponseSet();
			qrs4.add(new QuestionResponse("Alright, lets go!", null));
			qrs4.add(new QuestionResponse("Shall we go now?", response("Yep! Lets go.")));
			qrs4.add(new QuestionResponse("I'll race you there.", response("Too funny. Lets go.")));
			intro.add(qrs4);
			library.put("Intro", intro);
			
			var doctor:Dialog = new Dialog(
				Assets.getTexture("Characters", "Hope"),
				Assets.getTexture("Characters", "PlaceHolderDoctor"),
				"Go to the hospital"
			);
			
			doctor.add(new DialogEntry("Doctor", "Hello Hope, how are you doing?", "right"));
			doctor.add(new DialogEntry("Hope", "I have been feeling very unwell the past few weeks. I’ve been tired all the time and have had a high temperature.", "left"));
			doctor.add(new DialogEntry("Doctor", "Hope, I think it is best if you go to the Clinic to do some blood tests.", "right"));
			doctor.add(new DialogEntry("Hope", "Okay, I will go now", "left"));
			
			var qrs5:QuestionResponseSet = new QuestionResponseSet();
			qrs5.add(new QuestionResponse("I'll come too", response("Thanks!")));
			qrs5.add(new QuestionResponse("Want me to come with you?", response("Please do.")));
			qrs5.add(new QuestionResponse("Lets get you to the clinic", null));
			doctor.add(qrs5);
			library.put("Doctor", doctor);
			
			// Puzzle
			var puzzle:Dialog = new Dialog(
				null,
				Assets.getTexture("Characters", "Hope"),
				"Throw boxes into the river to cross it"
				);
			
			puzzle.add(response("Oh no, there is no bridge! What do we do?"));
			var qrs6:QuestionResponseSet = new QuestionResponseSet();
			qrs6.add(new QuestionResponse("Lets throw boxes into the river, and jump on them", response("Great idea!")));
			qrs6.add(new QuestionResponse("I don't know, do you have any idea?", response("We should throw those boxes in, we can jump on them.")));
			qrs6.add(new QuestionResponse("Lets see if we can find some things to help us", response("Lets do that")));
			puzzle.add(qrs6);
			library.put("Puzzle", puzzle);
			
			// Hospital
			var hospital:Dialog = new Dialog(
				Assets.getTexture("Characters", "Hope"),
				Assets.getTexture("Characters", "PlaceHolderDoctor"),
				"",
				true,
				Assets.getTexture("DialogBackgrounds", "hospital")
				);
			
			hospital.add(new DialogEntry("Doctor", "Hello, how can I help you?", "right"));
			hospital.add(new DialogEntry("Hope", "I haven't been feeling very well over the past few weeks. My doctor told me to come here to see you for blood tests.", "left"));
			hospital.add(new DialogEntry("Doctor", "Oh. That's not good. Can you tell me how you've been feeling?", "right"));
			hospital.add(new DialogEntry("Hope", "I'm tired all of the time. I have no energy to play with my friends.", "left"));
			hospital.add(new DialogEntry("Doctor", "Ok. You can step into the next room and we will do some tests on you. We need to find out what the problem is.", "right"));
			library.put("Hospital", hospital);
			
			loaded = true;
		}
	}
}