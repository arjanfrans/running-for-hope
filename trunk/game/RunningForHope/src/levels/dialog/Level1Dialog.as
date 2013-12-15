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
			
			
			/*
			DUTCH TRANSLATION
			*/
			var intro:Dialog = new Dialog(
				null,
				Assets.getTexture("Characters", "Hope"),
				"Bereik het einde van het level"
			);
			
			intro.add(response("Hey [playerName], hoe is het?"));
			
			var qrs1:QuestionResponseSet = new QuestionResponseSet();
			qrs1.add(new QuestionResponse("Goed! Met jou?", response("Ik voel me niet zo lekker.")));
			qrs1.add(new QuestionResponse("Prima. Met jou?", response("Ik voel me niet zo goed.")));
			qrs1.add(new QuestionResponse("Ik heb mijn teen gestoten! Hoe is het met jou?", response("Haha! Ik voel me niet zo goed...")));
			intro.add(qrs1);
			
			var qrs2:QuestionResponseSet = new QuestionResponseSet();
			qrs2.add(new QuestionResponse("Oh? Wat is er mis?", response("Ik heb al een paar weken koorts en ben vaak moe.")));
			qrs2.add(new QuestionResponse("Ah kom op, wat is er mis?", response("... Ik heb al een paar week koorts en heb weinig energie.")));
			qrs2.add(new QuestionResponse("Ah, het zal vast niks voorstellen?", response("Nee echt. Ik heb al een paar week koorts en kom bijna niet uit bed")));
			intro.add(qrs2);
			
			var qrs3:QuestionResponseSet = new QuestionResponseSet();
			qrs3.add(new QuestionResponse("Misscihen moeten we naar de dokter...", response("Denk het ook. ga je met me mee?")));
			qrs3.add(new QuestionResponse("Dat is erg! Zal ik mee gaan naar de dokter?", response("Bedankt [playerName], ja laten we dat doen.")));
			qrs3.add(new QuestionResponse("Dat is balen! Kom op, ik breng je naar de dokter.", response("Goed idee. Bedankt.")));
			intro.add(qrs3);
			
			var qrs4:QuestionResponseSet = new QuestionResponseSet();
			qrs4.add(new QuestionResponse("Ok, laten we gaan!", null));
			qrs4.add(new QuestionResponse("Zullen we gaan?", response("Ja!")));
			qrs4.add(new QuestionResponse("Wedstrijde doen wie er als eerste is?.", response("Haha. Laten we gaan.")));
			intro.add(qrs4);
			library.put("Intro", intro);
			
			var doctor:Dialog = new Dialog(
				Assets.getTexture("Characters", "Hope"),
				Assets.getTexture("Characters", "PlaceHolderDoctor"),
				"Ga naar de dokter"
			);
			
			doctor.add(new DialogEntry("Dokter", "Hallo Hope, hoe is het?", "right"));
			doctor.add(new DialogEntry("Hope", "Ik heb me de afgelopen weken niet zo lekker gevoeld. Ik ben vaak moe en heb een hoge temperatuur.", "left"));
			doctor.add(new DialogEntry("Doctor", "Hope, Ik denk dat het goed is om naar de kliniek te gaan in het ziekenhuis voor een bloed test.", "right"));
			doctor.add(new DialogEntry("Hope", "Ok, dan ga ik nu", "left"));
			
			var qrs5:QuestionResponseSet = new QuestionResponseSet();
			qrs5.add(new QuestionResponse("Ik ga met je mee", response("Bedankt!")));
			qrs5.add(new QuestionResponse("Wil je dat ik mee ga?", response("Ja graag.")));
			qrs5.add(new QuestionResponse("Laten we naar de kliniek gaan,", null));
			doctor.add(qrs5);
			library.put("Doctor", doctor);
			
			// Puzzle
			var puzzle:Dialog = new Dialog(
				null,
				Assets.getTexture("Characters", "Hope"),
				"Ga naar de overkant van de rivier"
			);
			
			puzzle.add(response("Oh nee, de brug is kapot! Wat nu?"));
			var qrs6:QuestionResponseSet = new QuestionResponseSet();
			qrs6.add(new QuestionResponse("Laten de die dozen in de rivier gooien en er dan over heen springen", response("Goed idee!")));
			qrs6.add(new QuestionResponse("Ik weet het niet, heb jij een idee?", response("We zouden die dozen kunnen gebruiken en er op springen naar de overkant.")));
			qrs6.add(new QuestionResponse("Laten we kijken of we iets kunnen vinden wat we kunnen gebruiken", response("Laten we dat doen!")));
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
			
			hospital.add(new DialogEntry("Doctor", "Hallo, kan ik helpen?", "right"));
			hospital.add(new DialogEntry("Hope", "Ik heb me de afgelopen weken niet zo goed gevoeld. Mijn dokter zou dat ik hier heen moest gaan voor een bloed test.", "left"));
			hospital.add(new DialogEntry("Doctor", "Oh. Dat is niet best. Kun je mij vertellen wat je voelt?", "right"));
			hospital.add(new DialogEntry("Hope", "Ik ben altijd moe en heb geen energy om met vrienden de spelen.", "left"));
			hospital.add(new DialogEntry("Doctor", "Ok. Je kunt in deze kamer gaan voor een test zodat we het probleem kunnen uitzoeken.", "right"));
			library.put("Hospital", hospital);
			
			loaded = true;
			
			
			
			/*var intro:Dialog = new Dialog(
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
			
			loaded = true;*/
		}
	}
}