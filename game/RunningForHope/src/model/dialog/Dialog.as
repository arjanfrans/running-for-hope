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
		public var partner_asset:Texture = null;
		public var length:int = 0;
		public var nextObjective:String;
		public var endLevel:Boolean = false;
		
		public function Dialog(partner_asset:Texture, nextObjective:String, endLevel:Boolean = false) 
		{
			messages = new Array();
			this.partner_asset = partner_asset;
			this.nextObjective = nextObjective;
			this.endLevel = endLevel;
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