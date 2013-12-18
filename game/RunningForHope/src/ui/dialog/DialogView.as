package ui.dialog 
{
	import citrus.core.starling.StarlingState;
	
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	import model.dialog.Dialog;
	import model.dialog.DialogEntry;
	import model.dialog.QuestionResponse;
	import model.dialog.QuestionResponseSet;
	
	import nape.geom.Vec2;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	import audio.Audio;
	import ui.buttons.DialogButton;
	
	/**
	 * ...
	 * @author Wim Barelds
	 */
	public class DialogView extends Sprite 
	{
		private var dialogArea:DialogArea;
		private var dialog:Dialog;
		private var options:Sprite;
		private var dialog_progress:int = 0;
		private var endDialogCallback:Function;
		
		public function DialogView(dialog:Dialog, callback:Function):void
		{
			endDialogCallback = callback;
			this.dialog = dialog; 
			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			/* Dialog consists of
			 * - background
			 * - image of player
			 * - mirrored image of char 2
			 * - message area
			 * - dialog options
			 */
			
			if(dialog.background != null) {
				addChild(new Image(dialog.background));
			}
			addChild(Assets.getImage("Interface", "DialogBackground"));
			
			// Player and conversation partner
			var char1:Image;
			if(dialog.char1_asset == null) {
				if(Main.getModel().player().gender == "Male") {
					char1 = Assets.getImage("Characters", "Max_Male");
				}
				else {
					char1 = Assets.getImage("Characters", "Max_Female");
				}
			}
			else {
				char1 = new Image(dialog.char1_asset);
			}
			var char2:Image = new Image(dialog.char2_asset);
			char2.scaleX = -1;
			
			char1.x = 10;
			char1.y = 10;
			addChild(char1);
			
			char2.x = 790;
			char2.y = 10;
			addChild(char2);
			
			dialogArea = new DialogArea();
			addChild(dialogArea);
			
			// Dialog options
			options = new Sprite();
			options.width = 770;
			options.height = 192;
			options.x = 15;
			options.y = 395;
			addChild(options);
			continueDialog();
			
			// Resize
			stage.addEventListener(Event.RESIZE, onResize);
			onResize(new ResizeEvent("init", Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight));
		}
		
		/**
		 * Resize the sprite to window
		 */
		private function onResize(event:ResizeEvent):void
		{
			var scale:Number = Math.min((event.width / Config.VIRTUAL_WIDTH), (event.height / Config.VIRTUAL_HEIGHT));
			this.scaleX = scale;
			this.scaleY = scale;
		}
		
		private function continueDialog():void
		{
			if (dialog_progress < dialog.length) {
				var dialogEntry:Object = dialog.load(dialog_progress);
				var choices:QuestionResponseSet = dialogEntry as QuestionResponseSet;
				if(choices !== null) {
					// It's a questionResponseSet
					showOptions(choices);
				}
				else {
					// It's a regular message
					var entry:DialogEntry = dialogEntry as DialogEntry;
					if(dialog_progress++ > 0) {
						showContinue(entry);
					}
					else {
						addMessage(entry.message, entry.from, entry.side);
						continueDialog();
					}
				}
			}
			else {
				// End of dialog
				options.addChild(new DialogButton("Continue game", 1, endDialogCallback ));
			}
		}
		
		private function dialogChoice(btn:int):void
		{
			// Buttons go from upwards, the index of the choices starts at 0. So, -1
			btn--;
			// Remove buttons from options panel
			while (options.numChildren > 0) options.removeChildAt(0);
			
			// Get the QuestionResponseSet linked to the chosen dialog option
			var choices:QuestionResponseSet = dialog.load(dialog_progress) as QuestionResponseSet;
			var qr:QuestionResponse = choices.load(btn);
			addMessage(qr.question());
			
			dialog_progress++;
			if(qr.answer() == null) {
				continueDialog();
			}
			else {
				showContinue(qr.answer());
			}
		}
		
		private function showContinue(entry:DialogEntry):void
		{
			options.addChild(new DialogButton("Continue dialog", 1, function():void {
				addMessage(entry.message, entry.from, entry.side);
				while (options.numChildren > 0) options.removeChildAt(0);
				Starling.juggler.delayCall(continueDialog, 1);
			}));
		}
		
		private function showOptions(choices:QuestionResponseSet):void
		{
			for (var i:int = 0; i < choices.length; i++) {
				var qr:QuestionResponse = choices.load(i);
				var btn:DialogButton = new DialogButton(qr.question(), i + 1, dialogChoice );
				btn.y = i * 70;
				options.addChild(btn);
			}
		}
		
		private function addMessage(message:String, from:String = null, side:String = null):void
		{
			var playerName:String = Main.getModel().player().name;
			message = message.replace(/\[playerName\]/gi, playerName);
			if (from == null) {
				if(side === null) side = "left";
				dialogArea.addMessage(new DialogMessage(playerName, message, side));
			}
			else {
				if(side === null) side = "right";
				dialogArea.addMessage(new DialogMessage(from, message, side));
			}
		}
	}

}