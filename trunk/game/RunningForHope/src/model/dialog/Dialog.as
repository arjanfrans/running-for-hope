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
		public var root:String = null;
		public var partner_asset:Texture = null;
		public var partner_name:String;
		public var length:int = 0;
		
		public function Dialog(partner_asset:Texture, partner_name:String, root:String = null) 
		{
			messages = new Array();
			this.partner_asset = partner_asset;
			this.partner_name = partner_name;
			this.root = root;
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