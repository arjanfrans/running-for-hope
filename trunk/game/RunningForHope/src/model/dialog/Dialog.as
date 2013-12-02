package model.dialog 
{
	import starling.textures.Texture;

	/**
	 * One dialog instance
	 * @author Wim Barelds
	 */
	public class Dialog 
	{
		private var messages:Array;
		public var char1_asset:Texture = null;
		public var char2_asset:Texture = null;
		public var length:int = 0;
		public var nextObjective:String;
		public var endLevel:Boolean = false;
		public var background:Texture;
		
		public function Dialog(char1Asset:Texture, char2Asset:Texture, nextObjective:String, endLevel:Boolean = false, background:Texture = null) 
		{
			messages = new Array();
			this.char1_asset = char1Asset;
			this.char2_asset = char2Asset;
			this.nextObjective = nextObjective;
			this.endLevel = endLevel;
			this.background = background;
		}
		
		public function add(val:Object):void
		{
			messages.push(val);
			length++;
		}
		
		public function load(index:int):Object
		{
			return messages[index];
		}
	}

}