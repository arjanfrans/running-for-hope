package game.objects.sensors
{
	import citrus.core.CitrusEngine;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Coin;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Luigi;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.dialog.DialogView;
	import ui.menus.MainMenu;
	import ui.menus.MenuState;
	import citrus.core.starling.StarlingState;
	
	public class DialogSensor extends Coin
	{
		private var dialogName:String; 
		public function DialogSensor(name:String, params:Object=null)
		{
			super(name, params);
			this.collectorClass = "game.objects.Luigi";
			if(params != null && params["dialogName"] != null) dialogName = params["dialogName"];
		}
		
		/**
		 * Function when the Hero gets in contact with this a FallSensor, he is set to dead.
		 */
		override public function handleBeginContact(interactionCallback:InteractionCallback):void
		{
			super.handleBeginContact(interactionCallback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
			
			if (collider is Luigi) {
				Main.getModel().pause = true;
				Main.getModel().getLevel().initDialog();
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