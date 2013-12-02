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
	
	import ui.buttons.DialogButton;
	
	/**
	 * ...
	 * @author Wim Barelds
	 */
	public class DialogView extends Sprite 
	{
		private var dialogArea:DialogArea;
		private var chat:Dialog;
		private var options:Sprite;
		private var dialog_progress:int = 0;
		private var endDialogCallback:Function;
		
		public function DialogView(dialogName:String, callback:Function):void
		{
			endDialogCallback = callback;
			chat = Main.getModel().getLevel().dialog.take(dialogName);
			
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
			
			addChild(Assets.getImage("Interface", "DialogBackground"));
			
			// Player and conversation partner
			var player:Image;
			if(Main.getModel().player().gender == "Male") {
				player = Assets.getImage("Characters", "Max_Male");
			}
			else {
				// TODO: Female
				player = Assets.getImage("Characters", "Max_Female");
			}
			var other:Image = new Image(chat.partner_asset);
			other.scaleX = -1;
			
			player.x = 10;
			player.y = 10;
			addChild(player);
			
			other.x = 790;
			other.y = 10;
			addChild(other);
			
			dialogArea = new DialogArea();
			addChild(dialogArea);
			
			if (chat.root != null) addMessage(chat.root, chat.partner_name);
			
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
			if (dialog_progress < chat.length) {
				var dialogEntry:Object = chat.load(dialog_progress);
				var choices:QuestionResponseSet = dialogEntry as QuestionResponseSet;
				if(choices !== null) {
					// It's a questionResponseSet
					showOptions(choices);
				}
				else {
					// It's a regular message
					var entry:DialogEntry = dialogEntry as DialogEntry;
					showContinue(entry);
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
			var choices:QuestionResponseSet = chat.load(dialog_progress) as QuestionResponseSet;
			var qr:QuestionResponse = choices.load(btn);
			addMessage(qr.question());
			
			dialog_progress++;
			showContinue(qr.answer());
		}
		
		private function showContinue(entry:DialogEntry):void
		{
			options.addChild(new DialogButton("Continue dialog", 1, function():void {
				addMessage(entry.message, entry.from, entry.side);
				continueDialog();
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
			message = message.replace(/\[playerName\]/gi, Main.getModel().player().name);
			if (from == null) {
				if(side === null) side = "left";
				dialogArea.addMessage(new DialogMessage(0xFF990000, "You", message, side));
			}
			else {
				if(side === null) side = "right";
				dialogArea.addMessage(new DialogMessage(0xFF336699, from, message, side));
			}
		}
	}

}