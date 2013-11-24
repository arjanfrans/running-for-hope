package 
{
	import citrus.core.starling.StarlingState;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	
	import game.GameState;

	public class LevelLoaderState extends StarlingState
	{
		private var loader:Loader;
		
		public function LevelLoaderState()
		{
			this.loader = new Loader();
			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoad);
			this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderIOErrorHandler);
			this.loader.load(new URLRequest("levels/map" + Main.getModel().level + ".swf"));
		}
		
		protected function onLoad(event:Event):void {
			Main.getModel().getLevel().flashLevel = event.target.loader.content;
			Main.setState(new GameState());
			loader.removeEventListener(Event.COMPLETE, onLoad);
			loader.unloadAndStop(true);
		}
		
		protected function loaderIOErrorHandler(errorEvent:IOErrorEvent):void{
			trace("ioErrorHandler: " + errorEvent);
			
			Main.setState(new GameState());
			
			loader.removeEventListener(Event.COMPLETE, onLoad);
			loader.unloadAndStop(true);
		}
	}
}