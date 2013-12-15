package game.objects.sensors
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Luigi;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.windows.*;
	
	public class InfoSensor extends Sensor
	{
		private var infoName:String;
		
		public function InfoSensor(name:String, params:Object=null)
		{
			super(name, params);
			
			if(name != null) infoName = name;
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
				var state:GameState = (Main.getState() as GameState);
				switch(infoName){
					case "ControlsInfo":
						state.openPopup(new ControlsInfo());
						break;
					case "WalljumpInfo":
						state.openPopup(new WalljumpInfo());
						break;
					case "CoinInfo":
						state.openPopup(new CoinInfo());
						break;
				}
			}
		}
	}
}