package {
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	import debug.Stats;
	
	import starling.core.starling_internal;
	
	[SWF(backgroundColor="#00015F", frameRate="60")]
	
	/**
	 * @author Aymeric
	 */
	public class Platformer extends StarlingCitrusEngine {
		
	
		
		public function Platformer() {
			setUpStarling(true);
			//addChild(new Stats());
			state = new TiledMapGameState();	
		}
	}
}