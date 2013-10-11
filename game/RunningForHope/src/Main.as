package {
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	import debug.Stats;
	
	import starling.core.starling_internal;
	
	[SWF(backgroundColor="#00015F", frameRate="30")]
	
	/**
	 * @author Aymeric
	 */
	public class Main extends StarlingCitrusEngine {
		
	
		
		public function Main() {
			setUpStarling(true);
			//addChild(new Stats());
			state = new TiledMapGameState();	
		}
	}
}