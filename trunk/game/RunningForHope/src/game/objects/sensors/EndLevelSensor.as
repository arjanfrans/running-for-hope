package game.objects.sensors
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Luigi;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.menus.MainMenu;
	import ui.menus.MenuState;
	
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
				Main.getModel().getLevel().highscores().submitScore();
				
				if(++Main.getModel().level >= Main.getModel().numLevels()) {
					Main.setState(new MenuState());
					return;
				}
				
				Main.setState(new GameState());
			}
		}
	}
}