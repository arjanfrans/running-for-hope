package model
{
	import citrus.utils.objectmakers.tmx.TmxMap;
	import citrus.utils.objectmakers.tmx.TmxObject;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	
	import game.objects.Token;
	
	public class Level
	{
		private var _name:String;
		private var _tmxName:String;
		private var _tmx:XML = null;
		private var _maxPoints:int = -1;
		private var _highscores:Highscores;
		
		private var _flashLevel:MovieClip;
		
		public function Level(name:String, tmx:String)
		{
			_name = name;
			_tmxName = tmx;
			_highscores = new Highscores(this);
		}
		
		public function get flashLevel():MovieClip
		{
			return _flashLevel;
		}
		
		public function set flashLevel(mc:MovieClip):void
		{
			_flashLevel = mc;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(name:String):void
		{
			_name = name;
		}
		
		public function map():XML
		{
			return _tmx;
		}

		public function tmx():TmxMap
		{
			if(_tmx == null) _tmx = Assets.getTmxMap(_tmxName);
			return new TmxMap(_tmx);
		}
		
		public function highscores():Highscores
		{
			return _highscores;
		}
		
		public function maxPoints():int
		{
			if(_maxPoints < 0) {
				_maxPoints = 0;
				var objects:Array = tmx().getObjectGroup("objects").objects;
				for(var i:int = 0; i < objects.length; i++) {
					var obj:TmxObject = objects[i] as TmxObject;
					if(obj != null && obj.type == "game.objects.Token") _maxPoints++;
				}
			}
			return _maxPoints;
		}
	}
}