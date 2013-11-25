package model
{
	import citrus.core.CitrusObject;
	import citrus.utils.objectmakers.ObjectMakerStarling;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import game.objects.Token;
	
	import model.dialog.DialogLibrary;
	
	public class Level
	{
		private var _name:String;
		private var _file:String;
		private var _maxPoints:int = -1;
		private var _highscores:Highscores;
		
		private var _width:int;
		private var _height:int;
		private var _objects:Vector.<String>;
		private var _dialog:DialogLibrary;
		private var _dialogInit:Function = null;
		
		public function Level(name:String, file:String, dialogInit:Function = null)
		{
			_name = name;
			_file = file;
			_dialog = new DialogLibrary();
			_dialogInit = dialogInit;
			_highscores = new Highscores(this);
			initMetadata();
		}
		
		private function initMetadata():void
		{
			// We need to load our level once to get some metadata of our level
			_objects = new Vector.<String>(); 
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				var _flashLevel:MovieClip = e.target.loader.content;
				_width = _flashLevel.loaderInfo.width;
				_height = _flashLevel.loaderInfo.height;
				_maxPoints = 0;
				for(var i:int = 0; i < _flashLevel.numChildren; i++) {
					var obj:Object = _flashLevel.getChildAt(i);
					if(obj != null && obj["className"] == "game.objects.Token") _maxPoints++;
				}
				
				loader.unloadAndStop(true);
			});
			loader.load(new URLRequest("levels/" + _file + ".swf"));
		}
		
		public function initDialog():void
		{
			if(_dialogInit != null) _dialogInit();
		}
		
		public function load(callback:Function = null, reload:Boolean = false):void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				var _flashLevel:MovieClip = e.target.loader.content;
				if(callback != null){
					callback(_flashLevel);
				}
				loader.unloadAndStop(true);
			});
			loader.load(new URLRequest("levels/" + _file + ".swf"));
		}
		
		public function get width():int
		{
			return _width;
		}
		
		public function get height():int
		{
			return _height;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(name:String):void
		{
			_name = name;
		}
		
		public function get dialog():DialogLibrary
		{
			return _dialog;
		}
		
		public function set dialog(dialog:DialogLibrary):void
		{
			_dialog = dialog;
		}
		
		public function highscores():Highscores
		{
			return _highscores;
		}
		
		public function maxPoints():int
		{
			return _maxPoints;
		}
	}
}