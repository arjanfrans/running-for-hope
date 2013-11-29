package citrus
{
	import citrus.objects.platformer.nape.Sensor;
	import nape.callbacks.InteractionCallback;
	
	public class CustomSensor extends Sensor
	{
		private var parameters:Object;
		
		/**
		 * Creates a CustomSensor.
		 * @param String name The name of this CustomSensor.
		 * @param Object params Any parameters of this CustomSensor.
		 * @return A new CustomSensor instance.
		 */
		public function CustomSensor(name:String, params:Object=null)
		{
			super(name, params);
			if(params != null) {
				parameters = params;
			}
		}
		
		
		
		/**
		 * checks whether something should happen if something contacts a CustomSensor.
		 * @param InteractionCallback interactionCallback
		 */
		override public function handleBeginContact(interactionCallback:InteractionCallback):void
		{
			super.handleBeginContact(interactionCallback);
			if(parameters != null) {
				handleObjective();
			}
		}
		
		/**
		 * checks whether a Contact with this CustomCoin should trigger a new objective.
		 */
		private function handleObjective():void {
			if(parameters["newObjective"] != null) { 
				Main.getModel().getLevel().objective = parameters["newObjective"];
			}
		}
		
	}
}