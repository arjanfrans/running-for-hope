package game.objects.sensors
{
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Luigi;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.dialog.DialogView;
	import ui.menus.MainMenu;
	import ui.menus.MenuState;
	import citrus.CustomCoin;
	
	public class DialogSensor extends CustomCoin
	{
		private var dialogName:String;
		private var parameters:Object = null;
		
		public function DialogSensor(name:String, params:Object = null)
		{
			super(name, params);
			this.collectorClass = "game.objects.Luigi";
			
			if(params != null) {
				parameters = params;
				if(params["dialogName"] != null) dialogName = params["dialogName"];
			}
		}
		
		/**
		 * Function for when the Hero gets in contact with this DialogSensor.
		 */
		override public function handleBeginContact(interactionCallback:InteractionCallback):void
		{
			super.handleBeginContact(interactionCallback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
			
			
			if (collider is Luigi) {
				Main.getModel().pause = true; //pause the game
				Main.getModel().getLevel().initDialog(); //initialize dialog scene
				var state:StarlingState = (Main.getState() as GameState);
				
				var dialogView:DialogView = new DialogView(dialogName, function():void {
					state.removeChild(dialogView);
					Main.getModel().pause = false;
				});
				state.addChild(dialogView);
				
			}
		}
	}
}