package levels.dialog
{
	import actions.Action;
	
	import model.dialog.Dialog;
	import model.dialog.DialogEntry;
	import model.dialog.DialogLibrary;
	import model.dialog.QuestionResponse;
	import model.dialog.QuestionResponseSet;
	
	public class Level2Dialog
	{
		private static var loaded:Boolean = false;
		
		public function Level2Dialog()
		{
		}
		
		private static function response(message:String, from:String = "Mr. Abasi"):DialogEntry
		{
			return new DialogEntry(from, message, "right"); 
		}
		
		public static function load():void
		{
			var library:DialogLibrary = Main.getModel().getLevel(1).dialog;
			if (loaded) return;
			
			var intro:Dialog = new Dialog(
				null,
				Assets.getTexture("Characters", "Basha")
			);
			intro.addClosingAction(new Action("NextObjective", "Find Mr. Abasi, your teacher"));
			
			intro.add(response("Hello [playerName]!", "Mom"));
			
			var qrs1:QuestionResponseSet = new QuestionResponseSet();
			qrs1.add(new QuestionResponse("Hello mom, do you know where I can find Mr. Abasi, my teacher?", response("I saw him go to the grocery store earlier. Maybe you can find him there.", "Mom")));
			qrs1.add(new QuestionResponse("Mom, do you know where Mr. Abasi is?", response("He was in the grocery store earlier. Maybe he is still there.", "Mom")));
			qrs1.add(new QuestionResponse("Hey mom, where can I find my teacher?", response("In the grocery store, I saw him there earlier.", "Mom")));
			intro.add(qrs1);
			
			var qrs2:QuestionResponseSet = new QuestionResponseSet();
			qrs2.add(new QuestionResponse("Ok, I'll go now. I need to see him.", response("Good luck! ...and be home before it gets dark.", "Mom")));
			qrs2.add(new QuestionResponse("Thanks mom, I will go see him. It is important.", response("If it is important, you better hurry. Good luck!", "Mom")));
			qrs2.add(new QuestionResponse("I need to go to the grocery store now. I have to go see him!", response("Ok, good luck!", "Mom")));
			intro.add(qrs2);
			
			library.put("Intro", intro);
			
			
			var mrabasi:Dialog = new Dialog(
				Assets.getTexture("Characters", "Max"),
				Assets.getTexture("Characters", "MrAbasi")
			);
			mrabasi.addClosingAction(new Action("NextObjective", "Find books and newspapers to get information on HIV."));
			
			mrabasi.add(new DialogEntry("Mr. Abasi", "Hello [playerName]", "right"));
			
			var qrs3:QuestionResponseSet = new QuestionResponseSet();
			qrs3.add(new QuestionResponse("I am good, thanks you. The sad news is that my friend Hope is HIV positive.", response("Oh no, that's terrible!", "Mr. Abasi")));
			qrs3.add(new QuestionResponse("I'm feeling perfect. But my friend Hope is HIV positive.", response("Oh my! Is she okay?", "Mr. Abasi")));
			qrs3.add(new QuestionResponse("I am fine, thank you.", response("Oh no, that is so awful!", "Mr. Abasi")));
			mrabasi.add(qrs3);
			
			var qrs4:QuestionResponseSet = new QuestionResponseSet();
			qrs4.add(new QuestionResponse("She can have a normal life with the medicine.", response("That is good, it's good that there are medicine.", "Mr. Abasi")));
			qrs4.add(new QuestionResponse("Hopefully with the medicine she can have normal life!", response("Yes, medicine are important.", "Mr. Abasi")));
			qrs4.add(new QuestionResponse("I am really worried about her.", response("Don't worry, as long as she takes her medicine she can have a normal life.", "Mr. Abasi")));
			mrabasi.add(qrs4);
			
			
			mrabasi.add(new DialogEntry(Main.getModel().player().name, "I want to spread information about HIV prevention. I want everyone to know about it. Can I give a presentation to the class about it?", "left"));
			mrabasi.add(new DialogEntry("Mr. Abasi", "Yes, of course you can. That is very good of you!", "right"));
			mrabasi.add(new DialogEntry("Mr. Abasi", "I have a tip for you: You try to find books and newspapers to get information.", "right"));
			
			var qrs5:QuestionResponseSet = new QuestionResponseSet();
			qrs5.add(new QuestionResponse("Ok, I will start searching!", response("Meet me at the school when you have found all the information!", "Mr. Abasi")));
			qrs5.add(new QuestionResponse("Thanks for the tip!", response("You're welcome, meet me at the school when you have found all the information!", "Mr. Abasi")));
			qrs5.add(new QuestionResponse("Where can I find books and newspapers?", response("Try exploring! You can find them in the area. Meet me at the school when you have found all the information!", "Mr. Abasi")));
			mrabasi.add(qrs5);
			
			library.put("MrAbasi", mrabasi);
			
			
			var mrabasi2:Dialog = new Dialog(
				Assets.getTexture("Characters", "Max"),
				Assets.getTexture("Characters", "MrAbasi")
			);
			mrabasi2.addClosingAction(new Action("Dialog", "Presentation"));
			
			mrabasi2.add(new DialogEntry("Mr. Abasi", "Hey [playerName], did you find enough information about HIV? Let's start with the presentation, are you ready?.", "right"));
			
			var qrs6:QuestionResponseSet = new QuestionResponseSet();
			qrs6.add(new QuestionResponse("I am ready for my presentation.", response("Alright, good luck!", "Mr. Abasi")));
			qrs6.add(new QuestionResponse("I am a little nervous, but I will be fine.", response("I am proud of you for doing this.", "Mr. Abasi")));
			qrs6.add(new QuestionResponse("Let's do this!", response("Good luck [playerName]!", "Mr. Abasi")));
			mrabasi2.add(qrs6)
			library.put("MrAbasi2", mrabasi2);
			
			var presentation:Dialog = new Dialog(
				Assets.getTexture("Characters", "MrAbasi"),
				null
			);
			presentation.addClosingAction(new Action("Dialog", "Presentation2"));
			presentation.add(new DialogEntry("Mr. Abasi", "Ok class, Max will be having a presentation about prevention of HIV. Max you can start now.", "left"));
			library.put("Presentation", presentation);
			
			var presentation2:Dialog = new Dialog(
				Assets.getTexture("Characters", "Max"),
				null
			);
			presentation2.addClosingAction((new Action("Dialog", "Presentation3")));
			presentation2.add(new DialogEntry(Main.getModel().player().name, "Hello everybody! My friend Hope has just found out that she is HIV positive.", "left"));
			presentation2.add(new DialogEntry(Main.getModel().player().name, "I would like to give a presentation about HIV prevention.", "left"));
			presentation2.add(new DialogEntry(Main.getModel().player().name, "HIV is a sexually transmitted discease. You can get HIV from having uprotected sex.", "left"));
			presentation2.add(new DialogEntry(Main.getModel().player().name, "To prevent HIV it is important to always use a condom if you have sex.", "left"));
			presentation2.add(new DialogEntry(Main.getModel().player().name, "There is no cure for HIV yet, a lot of research is being done to find it.", "left"));
			presentation2.add(new DialogEntry(Main.getModel().player().name, "Many people die because they take no medicine. If you get HIV you have to use medicine. If you take them every day you can live a normal life.", "left"));
			presentation2.add(new DialogEntry(Main.getModel().player().name, "This was my presentation, thank you!", "left"));
			library.put("Presentation2", presentation2);
			
			var presentation3:Dialog = new Dialog(
				Assets.getTexture("Characters", "Max"),
				Assets.getTexture("Characters", "MrAbasi")
			);
			presentation3.addClosingAction(new Action("EndLevel"));
			presentation3.addClosingAction(new Action("LevelSummary"));
			presentation3.add(new DialogEntry("Mr. Abasi", "Thank you very much [playerName]! This information can save many lives.", "right"));
			
			library.put("Presentation3", presentation3);
			loaded = true;
		}
	}
}