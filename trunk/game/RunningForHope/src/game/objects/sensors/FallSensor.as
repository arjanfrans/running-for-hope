package game.objects.sensors
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.objects.Luigi;
	
	import nape.callbacks.InteractionCallback;
	public class FallSensor extends Sensor
	{
		public function FallSensor(name:String, params:Object=null)
		{
			super(name, params);
		}
		
		/**
		 * Function when the Hero gets in contact with this a FallSensor, he is set to dead.
		 */
		override public function handleBeginContact(interactionCallback:InteractionCallback):void
		{
			super.handleBeginContact(interactionCallback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, interactionCallback);
			
			//check whether the contact is the player.
			if (collider is Luigi) {
				//set the player to dead.
				(collider as Luigi).dead = true;
			}
		}		
		
	}
}