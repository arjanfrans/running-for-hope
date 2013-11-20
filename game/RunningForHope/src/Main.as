package {
	
	import citrus.core.citrus_internal;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	
	import game.GameState;
	
	import menus.screens.MenuState;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	import ui.PlayerStatsUi;

	[SWF(backgroundColor="#000000", wmode="direct", width="800", height="600", frameRate="30")]
	public class Main extends StarlingCitrusEngine {
		
		private static var _this:Main;
		private var _level:int = 0;
		
		public function Main() {
			_this = this;
			this.stage.frameRate = Config.INTERNAL_FPS;
			setUpStarling(Config.DEBUG_MODE);
			state = new MenuState(this);
		}
		
		public static function setState(state:StarlingState):void
		{
			_this.state = state;
		}
		
		public static function level(level:int = -1):int
		{
			if(level >= 0) _this._level = level;
			return _this._level;
		}
	}
}