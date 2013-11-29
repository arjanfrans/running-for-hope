package citrus
{
	import citrus.objects.platformer.nape.Coin;
	import nape.callbacks.InteractionCallback;
	
	public class CustomCoin extends Coin
	{
		private var parameters:Object = null;
		
		/**
		 * Creates a CustomCoin.
		 * @param String name The name of this CustomCoin.
		 * @param Object params Any parameters of this CustomCoin.
		 * @return A new CustomCoin instance.
		 */
		public function CustomCoin(name:String, params:Object=null)
		{
			super(name, params);
			if(params != null) {
				parameters = params;
			}
		}
		
		/**
		 * checks whether something should happen if something contacts a CustomCoin.
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