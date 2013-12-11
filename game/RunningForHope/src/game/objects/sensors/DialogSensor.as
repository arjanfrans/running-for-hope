package game.objects.sensors
{
	import citrus.CustomCoin;
	import citrus.core.CitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Sensor;
	import citrus.physics.nape.NapeUtils;
	
	import game.GameState;
	import game.objects.Luigi;
	import audio.Audio;
	import nape.callbacks.InteractionCallback;
	
	import ui.dialog.DialogView;
	import ui.menus.MainMenu;
	import ui.menus.MenuState;
	import model.dialog.Dialog;
	import model.Level;
	
	public class DialogSensor extends Sensor
	{
		private var dialogName:String;
		
		public function DialogSensor(name:String, params:Object = null)
		{
			super(name, params);
			
			if(name != null) dialogName = name;
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
				
				Main.getModel().pause = true; //pause the game
				
				var level:Level = Main.getModel().getLevel(); 
				level.initDialog(); //initialize dialog scene
				var dialog:Dialog = level.dialog.take(dialogName);
				
				//Stop game fx sounds
				Audio.setState("dialog");
				
				var dialogView:DialogView = new DialogView(dialog, function():void {
					state.closePopup();
					if(dialog.endLevel) {
						// This ends the level
						// submit score to highscorelist
						level.highscores().submitScore();
						
						// check whether there are any levels left
						if(Main.getModel().level + 1 >= Main.getModel().numLevels()) {
							// go to main menu
							Main.setState(new MenuState());
						}
						else {
							// load next level.
							Main.getModel().level++;
							Main.setState(new GameState());
						}
					}
					else {
						// This isnt the end of the level
						level.objective = dialog.nextObjective;
					}
				});
				state.openPopup(dialogView, false, false);
			}
		}
		
		
	}
}