package model.dialog 
{
	/**
	 * Contains all dialog and gives access to it
	 * @author Wim Barelds
	 */
	public class DialogLibrary 
	{
		private var keys:Vector.<String>;
		private var values:Vector.<Dialog>;
		public var length:int = 0;
		
		public function DialogLibrary():void
		{
			keys = new Vector.<String>()
			values = new Vector.<Dialog>();
		}
		
		public function put(key:String, value:Dialog):void
		{
			var index:int = keys.indexOf(key);
			if (index >= 0) values[index] = value;
			else {
				keys.push(key);
				values.push(value);
				length++;
			}
		}
		
		public function take(key:String):Dialog
		{
			var index:int = keys.indexOf(key);
			if (index >= 0) return values[index];
			return null;
		}
		
		public function remove(key:String):Dialog
		{
			var index:int = keys.indexOf(key);
			if (index >= 0) {
				var r:Dialog = values[index];
				keys.splice(index, 1);
				values.splice(index, 1);
				length--;
				return r;
			}
			return null;
		}
	}

}