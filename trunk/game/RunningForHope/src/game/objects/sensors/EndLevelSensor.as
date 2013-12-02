package game.objects.sensors
{
	import citrus.objects.NapePhysicsObject;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Luigi;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.menus.MainMenu;
	import ui.menus.MenuState;
	import citrus.CustomSensor;
	import citrus.objects.platformer.nape.Sensor;
	
	public class EndLevelSensor extends CustomSensor
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
				Main.getModel().getLevel().highscores().submitScore(); //submit score to highscorelist
				//check whether there are any levels left after this one and increase level counter.
				if(Main.getModel().level + 1 >= Main.getModel().numLevels()) {
					//go to main menu
					Main.setState(new MenuState());
					return;
				}
				//load next level.
				Main.getModel().level++;
				Main.setState(new GameState());
			}
		}
	}
}