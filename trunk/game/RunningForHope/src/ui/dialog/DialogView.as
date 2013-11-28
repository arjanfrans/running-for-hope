package ui.dialog 
{
	import citrus.core.starling.StarlingState;
	
	import flash.geom.Rectangle;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	
	import model.dialog.Dialog;
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
		private var chat:Dialog;
		private var textArea:TextField;
		private var text:String = "";
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
			
			var dm:DialogMessage = new DialogMessage(0xFF336699, "Bla bla!", "Bla bla bla");
			/*
			
			// Background
			addChild(Assets.getImage("Interface", "FadedBackground"));
			
			// Player and conversation partner
			var player:Image;
			if(Main.getModel().player().gender == "Male") {
				player = Assets.getImage("Characters", "Max_Male");
			}
			else {
				// TODO: Female
				player = Assets.getImage("Characters", "Max_Male");
			}
			var other:Image = new Image(chat.partner_asset);
			other.scaleX = -1;
			
			player.x = 10;
			player.y = 500 - player.height;
			addChild(player);

			other.x = 790;
			other.y = 500 - other.height;
			addChild(other);
			
			// Dialog
			var dialogBg:Image = Assets.getImage("Interface", "DialogBackground");
			dialogBg.x = 126;
			dialogBg.y = -5;
			addChild(dialogBg);
			
			textArea = new TextField();
			textArea.wordWrap = true;
			textArea.width = 460;
			textArea.height = 405;
			textArea.x = 170;
			textArea.y = 35;
			textArea.multiline = true;
			
			if (chat.root != null) addMessage(chat.root, chat.partner_name);
			Starling.current.nativeOverlay.addChild(textArea);
			
			// Dialog options
			options = new Sprite();
			options.width = 500;
			options.height = 135;
			options.x = 150;
			options.y = 460;
			addChild(options);
			showOptions();
			
			*/
			
			// Resize
			stage.addEventListener(Event.RESIZE, onResize);
			onResize(new ResizeEvent("init", Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight));
		}
		
		/**
		 * Resize the sprite to window
		 */
		private function onResize(event:ResizeEvent):void
		{
			//TODO almost the same as in GameState, MenuState. Double code!!!
			var newWidth:Number = event.width;
			var newHeight:Number = event.height;
			this.width = newWidth;
			this.height = newHeight;
			
			if(Config.KEEP_SCALING_RATIO) {
				var aspectRatio:Number = width / height;
				var scale:Number = 1;
				var crop:Vec2 = new Vec2(0, 0);
				if(aspectRatio > Config.ASPECT_RATIO)
				{
					scale = height / Config.VIRTUAL_HEIGHT;
					crop.x = (width - Config.VIRTUAL_WIDTH * scale) / 2;
				}
				else if(aspectRatio < Config.ASPECT_RATIO)
				{
					scale = width / Config.VIRTUAL_WIDTH;
					crop.y = (height - Config.VIRTUAL_HEIGHT*scale) / 2;
				}
				else
				{
					scale = width / Config.VIRTUAL_WIDTH;
				}
				newWidth = Config.VIRTUAL_WIDTH * scale;
				newHeight = Config.VIRTUAL_HEIGHT * scale;
			}
			
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = newWidth;
			viewPortRectangle.height = newHeight;
			if(!Config.DEBUG_MODE) viewPortRectangle.x = (width - newWidth) / 2;
			Starling.current.stage.stageWidth = newWidth + (width - newWidth);
			Starling.current.stage.stageHeight = newHeight;
			Starling.current.viewPort = viewPortRectangle;
		}
		
		private function showOptions():void
		{
			if (dialog_progress < chat.length) {
				var choices:QuestionResponseSet = chat.load(dialog_progress);
				for (var i:int = 0; i < choices.length; i++) {
					var qr:QuestionResponse = choices.load(i);
					var btn:DialogButton = new DialogButton(qr.question(), i + 1, dialogChoice );
					btn.y = i * 45;
					btn.x = 0;
					options.addChild(btn);
				}
			}
			else {
				// End of dialog
				options.addChild(new DialogButton("Continue", 1, endDialog ));
			}
		}
		
		private function dialogChoice(btn:int):void
		{
			while (options.numChildren > 0) options.removeChildAt(0);
			
			var choices:QuestionResponseSet = chat.load(dialog_progress++);
			var qr:QuestionResponse = choices.load(btn - 1);
			addMessage(qr.question());
			
			if (qr.answer() == null) {
				showOptions();
			}
			else {
				Starling.juggler.delayCall(function():void {
					addMessage(qr.answer(), chat.partner_name);
					showOptions();
				}, 0.5);
			}
		}
		
		private function endDialog(ignore:int):void
		{
			Starling.current.nativeOverlay.removeChild(textArea);
			endDialogCallback();
		}
		
		private function setText():void
		{
			textArea.htmlText = "<FONT FACE=\"Arial\" SIZE=\"20\">" + text + "</FONT>";
			textArea.scrollV = textArea.maxScrollV;
		}
		
		private function addMessage(message:String, from:String = null):void
		{
			if (from == null) {
				text += "<P ALIGN=\"LEFT\"><FONT SIZE=\"28\" COLOR=\"#990000\">You</FONT><br>";
			}
			else {
				text += "<P ALIGN=\"RIGHT\"><FONT SIZE=\"28\" COLOR=\"#336699\">" + from + "</FONT><br>";
			}
			text += message.replace(/\[playerName\]/gi, Main.getModel().player().name) + "</P><br>";
			setText();
		}
	}

}