package {
	
	import citrus.core.citrus_internal;
	import citrus.core.starling.StarlingCitrusEngine;
	
	import game.GameState;
	
	import ui.PlayerStatsUi;

	[SWF(backgroundColor="#000000", wmode="direct", width="512", height="448", frameRate="30")]
	public class Main extends StarlingCitrusEngine {
		
		public function Main() {
			this.stage.frameRate = Config.INTERNAL_FPS;
			setUpStarling(Config.DEBUG_MODE);
			state = new GameState();
		}	
	}
}