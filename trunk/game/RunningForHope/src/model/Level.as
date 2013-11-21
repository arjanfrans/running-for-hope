package model
{
	import citrus.utils.objectmakers.tmx.TmxMap;

	public class Level
	{
		private var _name:String;
		private var _tmxName:String;
		private var _tmx:XML = null;
		
		public function Level(name:String, tmx:String)
		{
			_name = name;
			_tmxName = tmx;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function set name(name:String):void
		{
			_name = name;
		}
		
		public function tmx():TmxMap
		{
			if(_tmx == null) _tmx = Assets.getTmxMap(_tmxName);
			return new TmxMap(_tmx);
		}
	}
}