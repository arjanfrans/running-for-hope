package levels.dialog
{
	import model.dialog.Dialog;
	import model.dialog.DialogEntry;
	import model.dialog.DialogLibrary;
	import model.dialog.QuestionResponse;
	import model.dialog.QuestionResponseSet;
	import actions.Action;

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
			
			var intro:Dialog = new Dialog(
				Assets.getTexture("Characters", "Max"),
				Assets.getTexture("Characters", "Hope")
			);
			intro.addClosingAction(new Action("NextObjective", "Head to the town in the east."));
			
			
			intro.add(new DialogEntry("Hope", "Hey [playerName], I’m feeling a lot better today and I’d like to go out for the day. Would you like to come too?", "right"));
			
			var qrs1:QuestionResponseSet = new QuestionResponseSet();
			qrs1.add(new QuestionResponse("That’s great, yes I would love to come with you!", response("Alright, Let's go!", "Hope")));
			qrs1.add(new QuestionResponse("Why not, what are we waiting for!", response("Let's head out into town.", "Hope")));
			qrs1.add(new QuestionResponse("Of course! Let’s go out!", response("The town is to the east, let's go there.", "Hope")));
			intro.add(qrs1);
			
			library.put("Intro", intro);
			
			
			var adin:Dialog = new Dialog(
				Assets.getTexture("Characters", "Max"),
				Assets.getTexture("Characters", "Adin")
			);
			adin.addClosingAction(new Action("NextObjective", "The road to the town hall is blocked. Find another way."));
			
			adin.add(new DialogEntry("Adin", "Hello, would you be interested in a meeting in the Town Hall this afternoon?", "right"));
			adin.addClosingAction((new Action("Dialog", "Hope")));
			var qrs2:QuestionResponseSet = new QuestionResponseSet();
			qrs2.add(new QuestionResponse("What is this meeting about?", response("It is about HIV prevention.", "Adin")));
			qrs2.add(new QuestionResponse("What are they going to talk about?", response("They will talk about HIV prevention.", "Adin")));
			qrs2.add(new QuestionResponse("What is the topic?", response("The topic is HIV prevention.", "Adin")));
			adin.add(qrs2);
			library.put("Adin", adin);
			
			var hope:Dialog = new Dialog(
				Assets.getTexture("Characters", "Max"),
				Assets.getTexture("Characters", "Hope")
			);
			
			var qrs3:QuestionResponseSet = new QuestionResponseSet();
			qrs3.add(new QuestionResponse("That sounds interesting. Hope would you like to go?", response("Yes I would. We will go to it.", "Hope")));
			qrs3.add(new QuestionResponse("Oh it’ll be useful information! Hope would you like to go?", response("Sure! It will be interesting let's go!", "Hope")));
			qrs3.add(new QuestionResponse("Perfect! Hope will you come with me?", response("Yes, I will! It will be useful!", "Hope")));
			hope.add(qrs3);
			
			hope.add(new DialogEntry("Hope", "The town is to the east, but the road is blocked. What do we do?", "right"));
			
			var qrs4:QuestionResponseSet = new QuestionResponseSet();
			qrs4.add(new QuestionResponse("Let's find another way.", response("Let's try that.", "Mr. Abasi")));
			qrs4.add(new QuestionResponse("I will look around for another way.", response("Ok, let's go.", "Mr. Abasi")));
			qrs4.add(new QuestionResponse("I have no idea, any suggestions?", response("I see a switch over there, maybe try that.", "Mr. Abasi")));
			hope.add(qrs4);
			library.put("Hope", hope);
			
			var meeting:Dialog = new Dialog(
				Assets.getTexture("Characters", "Max"),
				Assets.getTexture("Characters", "Adin")
			);
			meeting.addClosingAction((new Action("Dialog", "Meeting2")));
			meeting.add(new DialogEntry("Adin", "Hey, you are just in time. We are about to start. Let's go inside.", "left"));
			library.put("Meeting", meeting);
			
			
			var meeting2:Dialog = new Dialog(
				Assets.getTexture("Characters", "Adin"),
				null
			);
			meeting2.addClosingAction(new Action("EndLevel"));
			meeting2.addClosingAction(new Action("LevelSummary"));
			meeting2.add(new DialogEntry("Adin", "Hello everyone, I will start with a short story.", "left"));
			meeting2.add(new DialogEntry("Adin", "I got HIV because I was using my friends razor and accidentally cut myself. My friend was HIV positive and had used the razor already.", "left"));
			meeting2.add(new DialogEntry("Adin", "The HIV transferred to me through the blood.", "left"));
			meeting2.add(new DialogEntry("Adin", "HIV through blood transmission.", "left"));
			meeting2.add(new DialogEntry("Adin", "When I developed HIV I had sores all over my body and my muscles were painful.", "left"));
			meeting2.add(new DialogEntry("Adin", "This was my story. Thanks for attending this meeting!", "left"));
			library.put("Meeting2", meeting2);

			loaded = true;
		}
	}
}