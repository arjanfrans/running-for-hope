package model
{
	public class Player
	{
		private var _gender:String = "Male";
		private var _name:String = "Player";
		
		public function Player()
		{
		}
		
		public function set gender(gender:String):void
		{
			_gender = gender;
		}
		
		public function get gender():String
		{
			return _gender;
		}
		
		public function set name(name:String):void
		{
			_name = name;
		}
		
		public function get name():String
		{
			return _name;
		}
	}
}