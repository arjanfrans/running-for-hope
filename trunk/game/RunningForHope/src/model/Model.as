package model
{
	import citrus.core.CitrusEngine;
	import levels.dialog.*;
	
	/**
	 * The general datamodel.
	 */
	public class Model
	{
		private var _level:int = 0;
		private var _points:int = 0;
		private var _time:Number = 0;
		private var _lifes:int = 4;
		private var _player:Player;
		
		private var _levels:Vector.<Level>;
		
		/**
		 * Creates a general datamodel.
		 * @return Model a new instance of the datamodel.
		 */
		public function Model()
		{
			_player = new Player();
			
			var level1:Level = new Level("Level 1", "map0", "Go to the right.", Level1Dialog.load);
			var level2:Level = new Level("Level 2", "map1", "Get to the right, now.");
			var level3:Level = new Level("Level 3", "map2", "Meet Hope.", Level3Dialog.load);
			
			_levels = new <Level>[ level1, level2, level3 ];
		}
		
		/**
		 * Sets the current level.
		 * @param int level The current level.
		 */
		public function set level(level:int):void
		{
			_level = level;
		}
		
		/**
		 * Returns the amount of levels there are.
		 * @return int The amount of levels there are.
		 */
		public function numLevels():int
		{
			return _levels.length;
		}
		
		/**
		 * Returns the object of the given level.
		 * If no level is given the current level is returned.
		 * 
		 * @param int num The number of the a level.
		 * @return Level The object of the given level.
		 */
		public function getLevel(num:int = -1):Level
		{
			if(num < 0) num = _level;
			return _levels[num];
		}
		
		/**
		 * Returns the number of the current level.
		 * @return int The number of the current level.
		 */
		public function get level():int
		{
			return _level;
		}
		
		/**
		 * pauzes or unpauzes the game.
		 * @param Boolean b Whether the game should be pauzed.
		 */
		public function set pause(b:Boolean):void
		{
			CitrusEngine.getInstance().playing = !b;
		}
		
		/**
		 * returns whether the game is pauzed.
		 * @return Boolean Whether the game is pauzed.
		 */
		public function get pause():Boolean
		{
			return !CitrusEngine.getInstance().playing;
		}
		
		/**
		 * sets the current amount of points.
		 * @param int points The current amount of points.
		 */
		public function set points(points:int):void
		{
			_points = points;
		}
		
		/**
		 * Returns the current amount of points.
		 * @return int The current amount of points.
		 */
		public function get points():int
		{
			return _points;
		}
		
		/**
		 * Sets the current elapsed time.
		 * @param Number time The current elapsed time.
		 */
		public function set time(time:Number):void
		{
			_time = time;
		}
		
		/**
		 * Returnes the current elapsed time.
		 * @return Number The current elapsed time.
		 */
		public function get time():Number
		{
			return _time;
		}
		
		/**
		 * increases the current elapsed time.
		 */
		public function inc_time():void
		{
			_time++;
		}
		
		/**
		 * Sets the current amount of lives.
		 * @param int lifes The current amount of lives.
		 */
		public function set lifes(lives:int):void
		{
			_lifes = lives;
		}
		
		/**
		 * Returns the current amount of lives.
		 * @return int The current amount of lives.
		 */
		public function get lifes():int
		{
			return _lifes;
		}
		
		/**
		 * Returns the player object.
		 * @return Player The player object.
		 */
		public function player():Player
		{
			return _player;
		}
		
	}
}