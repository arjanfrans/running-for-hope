package game.objects.sensors
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Player;
	
	import model.Model;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.windows.*;
	
	public class ItemSensor extends Sensor
	{
		public var itemName:String;
		
		public function ItemSensor(name:String, params:Object=null)
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
				Main.getModel().items++;
				var state:GameState = (Main.getState() as GameState);
				
				//If Player has all the items, the final dialog which finishes the level will become visible
				if(Main.getModel().items >= Main.getModel().getCurrentLevel().maxItems) {
					var sensor:DialogSensor = state.getObjectByName("FinalDialog") as DialogSensor;
					sensor.visible = true;
				}
					
				switch(itemName) {
					case "CondomsInfo":
						state.openPopup(new ItemInfo("To prevent HIV always use a condom during sexual intercourse."));
						break;
					case "Newspaper":
						state.openPopup(new ItemInfo("A newspaper from last week: \n\n" +
							"HIGH HIV/AIDS DEATH RATE IN KENYA: \n" +
							"Thousands of people die from HIV each year."));
						break;
					case "MedicineInfo":
						state.openPopup(new ItemInfo("There is no cure HIV at this moment. A lot of research on HIV and AIDS is being done, \n" +
							" but a cure has not been found. \n\n" +
							"You can live a normal life with HIV if you take medicine every day."));
						break;
				}
			}
		}
	}
}