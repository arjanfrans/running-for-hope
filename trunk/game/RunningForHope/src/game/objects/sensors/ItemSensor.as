package game.objects.sensors
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Player;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.windows.*;
	
	public class ItemSensor extends Sensor
	{
		private var infoName:String;
		
		public function ItemSensor(name:String, params:Object=null)
		{
			super(name, params);
			
			if(name != null) infoName = name;
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
				Main.getModel().items++;
				trace(Main.getModel().items);
			}
		}
	}
}