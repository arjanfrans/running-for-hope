package actions
{
	import model.Level;
	import model.Model;
	import game.GameState;
	import model.dialog.Dialog;
	import audio.Audio;
	import ui.dialog.DialogView;
	import ui.windows.ScoreDisplay;

	public class Action
	{
		private var type:String;
		private var param:String;
		
		private static function get _state():GameState
		{
			var state:GameState = Main.getState() as GameState;
			return state;
		}
		private static function get _model():Model
		{
			return Main.getModel();
		}
		private static function get _level():Level
		{
			return _model.getLevel();
		}
		
		
		public function Action(type:String, param:String = null)
		{
			this.type = type;
			this.param = param;
		}
		
		public function trigger():void
		{
			switch (type) {
				case "Dialog":
					try {
						_level.initDialog(); //initialize dialog scene
						var dialog:Dialog = _level.dialog.take(param);
						
						if(dialog == null) return;
						Main.getModel().pause = true; //pause the game
						
						//Stop game fx sounds
						Audio.setState("dialog");
						
						var dialogView:DialogView = new DialogView(dialog, function():void {
							_state.closePopup();
							dialog.close();
						});
						_state.openPopup(dialogView, false, false);					}
					catch(e:Error) {
						trace(e);
					}
					break;
				case "EndLevel":
					_state.openPopup(new ScoreDisplay());
					break;
				case "NextObjective":
					_level.objective = param;
					break;
			}
		}
	}
}