package game.objects.sensors
{
	import audio.Audio;
	
	import citrus.CustomCoin;
	import citrus.core.CitrusEngine;
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Luigi;
	
	import model.Level;
	import model.dialog.Dialog;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.dialog.DialogView;
	import ui.menus.MainMenu;
	import ui.menus.MenuState;
	import actions.Action;
	
	public class DialogSensor extends Sensor
	{
		public var dialogName:String;
		
		public function DialogSensor(name:String, params:Object = null)
		{
			super(name, params);
		}
		
		/**
		 * Function for when the Hero gets in contact with this DialogSensor.
		 */
		override public function handleBeginContact(interactionCallback:InteractionCallback):void
		{
			
			super.handleBeginContact(interactionCallback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
			
			if (collider is Luigi) {
				kill = true;
				(new Action("Dialog", dialogName)).trigger();
			}
			
		}
		
		
	}
}