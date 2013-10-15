package {
	
	import citrus.core.starling.StarlingCitrusEngine;
	
	import debug.Stats;
	
	import flash.geom.Rectangle;
	
	import starling.core.starling_internal;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	
	[SWF(backgroundColor="#00015F", frameRate="30")]
	
	/**
	 * @author Aymeric
	 */
	public class Main extends StarlingCitrusEngine {
		
		public function Main() {
			this.stage.frameRate = Config.INTERNAL_FPS;
			setUpStarling(true);
			//addChild(new Stats());
			state = new TiledMapGameState();
			trace(this.width);
			
		}		
		
	}
}