package model.dialog
{
	import starling.display.Image;
	import starling.textures.Texture;

	public class DialogEntry
	{
		private var _message:String;
		private var _from:String;
		private var _side:String;
		
		public function DialogEntry(from:String, message:String, side:String)
		{
			_from = from;
			_message = message;
			_side = side;
		}
		
		public function get message():String
		{
			return _message;
		}
		
		public function set message(msg:String):void
		{
			_message = msg;
		}
		
		public function get from():String
		{
			return _from;
		}
		
		public function set from(from:String):void
		{
			_from = from;
		}
		
		public function get side():String
		{
			return _side;
		}
		
		public function set side(side:String):void
		{
			_side = side;
		}
	}
}