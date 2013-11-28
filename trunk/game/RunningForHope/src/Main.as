package {
	
	import citrus.core.IState;
	import citrus.core.citrus_internal;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	
	import game.GameState;
	
	import model.Model;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	import ui.dialog.DialogMessage;
	import ui.hud.PlayerStatsUi;
	import ui.menus.MenuState;
	
	[SWF(backgroundColor="#000000", width="800", height="600", frameRate="60")]
	public class Main extends StarlingCitrusEngine {
		
		private static var _this:Main;
		private var _level:int = 0;
		private var _model:Model;
		
		public function Main() {
			_this = this;
			_model = new Model();
			this.stage.frameRate = Config.INTERNAL_FPS;
			setUpStarling(true);
			state = new MenuState();
		}
		
		public static function getModel():Model
		{
			return _this._model;
		}
		
		public static function setState(state:StarlingState):void
		{
			_this.state = state;
		}
		
		public static function getState():IState
		{
			return _this.state;
		}
		
		public static function level(level:int = -1):int
		{
			if(level >= 0) _this._level = level;
			return _this._level;
		}
	}
}