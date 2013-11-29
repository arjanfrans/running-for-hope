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
		private var _objective:String;
		
		private var _width:int;
		private var _height:int;
		private var _objects:Vector.<String>;
		private var _dialog:DialogLibrary;
		private var _dialogInit:Function = null;
		private var _flashLevel:MovieClip;
		
		/**
		 * The datamodel of a level.
		 * 
		 * @param String name The name of the level.
		 * @param String file The .swf file of the level.
		 * @param String defaultObjective The default objective of the level.
		 * @param Function dialogInit
		 */
		public function Level(name:String, file:String, defaultObjective:String, dialogInit:Function = null)
		{
			_name = name;
			_file = file;
			_dialog = new DialogLibrary();
			_dialogInit = dialogInit;
			_highscores = new Highscores(this);
			_objective = defaultObjective;
			initMetadata();
		}
		
		/**
		 * initial loading of the metadata of the level.
		 */
		private function initMetadata():void
		{
			// We need to load our level once to get some metadata of our level
			_objects = new Vector.<String>(); 
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e:Event):void {
				_flashLevel = e.target.loader.content;
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
		
		/**
		 * getter for the flash level object.
		 * @return MovieClip The flash level object.
		 */
		public function get flashLevel():MovieClip
		{
			return _flashLevel;
		}
		
		/**
		 * The initialization of a dialog scene.
		 */
		public function initDialog():void
		{
			if(_dialogInit != null) _dialogInit();
		}
		
		/**
		 * Loads the level.
		 * 
		 * @param Function callback
		 * @param Boolean reload
		 */
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
		
		/**
		 * The getter for the width of the level.
		 * @return int The width of the level.
		 */
		public function get width():int
		{
			return _width;
		}
		
		/**
		 * The getter for the height of the level.
		 * @return int The height of the level.
		 */
		public function get height():int
		{
			return _height;
		}
		
		/**
		 * The getter for the name of the level.
		 * @return String The name of the level.
		 */
		public function get name():String
		{
			return _name;
		}
		
		/**
		 * The setter of the name of the level.
		 * @param String name The name of the level.
		 */
		public function set name(name:String):void
		{
			_name = name;
		}
		
		/**
		 * The getter for the dialog library of the level.
		 * @return DialogLibrary The dialog library of the level.
		 */
		public function get dialog():DialogLibrary
		{
			return _dialog;
		}
		
		/**
		 * The setter of the dialog library of the level.
		 * @param DialogLibrary dialog The dialog library of the level.
		 */
		public function set dialog(dialog:DialogLibrary):void
		{
			_dialog = dialog;
		}
		
		/**
		 * The getter for the currently set objective.
		 * @return int The currently set objective.
		 */
		public function get objective():String
		{
			return _objective;
		}
		
		/**
		 * The setter of the currently set objective.
		 * @param String value The currently set objective.
		 */
		public function set objective(objective:String):void
		{
			_objective = objective;
		}
		
		/**
		 * returns the highscores of this level.
		 * @return The highscores of this level.
		 */
		public function highscores():Highscores
		{
			return _highscores;
		}
		
		/**
		 * returns the maximum amount of points you can get in this level.
		 * @return The maximum amount of points you can get in this level.
		 */
		public function maxPoints():int
		{
			return _maxPoints;
		}
	}
}