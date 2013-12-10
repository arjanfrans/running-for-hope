package game.objects.sensors
{
	import citrus.CustomSensor;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Luigi;
	
	import model.Score;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.menus.MainMenu;
	import ui.menus.MenuState;
	import ui.windows.ScoreDisplay;
	
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
				var state:GameState = Main.getState() as GameState;
				state.closePopup();
				state.openPopup(new ScoreDisplay());
			}
		}
	}
}