package game.objects.sensors
{
	import actions.Action;
	
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Platform;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Player;
	
	import model.Model;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.windows.*;
	
	public class SwitchSensor extends Sensor
	{
		public function SwitchSensor(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		/**
		 * Function for when the Hero gets in contact with this item.
		 */
		override public function handleBeginContact(interactionCallback:InteractionCallback):void
		{
			super.handleBeginContact(interactionCallback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
			
			if (collider is Player) {
				kill = true;
				var state:GameState = (Main.getState() as GameState);
				
				var sprite:CitrusSprite = state.getObjectByName("LogSprite") as CitrusSprite;
				var platform:Platform = state.getObjectByName("LogPlatform") as Platform;
				trace(platform);
				sprite.visible = false;
				sprite.kill = true;
				platform.kill = true;
				state.openPopup(new SwitchInfo());
				new Action("NextObjective", "The cave is now open. Find your way in.").trigger();
			}
		}
	}
}