package model
{
	import citrus.core.CitrusEngine;
	
	public class Model
	{
		private var _level:int = 0;
		private var _points:int = 0;
		private var _time:Number = 0;
		private var _lifes:int = 4;
		private var _player:Player;
		
		private var _levels:Vector.<Level>;
		
		public function Model()
		{
			_player = new Player();
			_levels = new <Level>[
				new Level("Level 1", "Level0"),
				new Level("Level 2", "Level1"),
				new Level("Level 3", "Level2")
			]; 
		}
		
		public function set level(level:int):void
		{
			_level = level;
			_points = 0;
			_time = 0;
		}
		
		public function numLevels():int
		{
			return _levels.length;
		}
		
		public function getLevel(num:int = -1):Level
		{
			if(num < 0) num = _level;
			return _levels[num];
		}
		
		public function get level():int
		{
			return _level;
		}
		
		public function set pause(b:Boolean):void
		{
			CitrusEngine.getInstance().playing = !b;
		}
		
		public function get pause():Boolean
		{
			return !CitrusEngine.getInstance().playing;
		}
		
		public function set points(points:int):void
		{
			_points = points;
		}
		
		public function get points():int
		{
			return _points;
		}
		
		public function set time(time:Number):void
		{
			_time = time;
		}
		
		public function get time():Number
		{
			return _time;
		}
		
		public function inc_time():void
		{
			_time++;
		}
		
		public function set lifes(lifes:int):void
		{
			_lifes = lifes;
		}
		
		public function get lifes():int
		{
			return _lifes;
		}
		
		public function player():Player
		{
			return _player;
		}
		
	}
}