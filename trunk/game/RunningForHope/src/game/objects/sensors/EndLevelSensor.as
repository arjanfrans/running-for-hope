package game.objects.sensors
{
	import citrus.objects.platformer.nape.Sensor;
	import citrus.objects.NapePhysicsObject;
	import citrus.physics.nape.NapeUtils;
	import game.objects.Luigi;
	import nape.callbacks.InteractionCallback;
	import game.GameState;
	
	public class EndLevelSensor extends Sensor
	{
		private var nextLevel:Number;
		
		public function EndLevelSensor(name:String, params:Object=null)
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
			
			if (collider is Luigi) {
				_ce.state = new GameState(nextLevel);
			}
		}
	}
}