package model.dialog 
{
	import starling.textures.Texture;

	/**
	 * One dialog instance
	 * @author Wim Barelds
	 */
	public class Dialog 
	{
		private var sets:Vector.<QuestionResponseSet>;
		public var root:String = null;
		public var partner_asset:Texture = null;
		public var partner_name:String;
		public var length:int = 0;
		
		public function Dialog(partner_asset:Texture, partner_name:String, root:String = null) 
		{
			sets = new Vector.<QuestionResponseSet>();
			this.partner_asset = partner_asset;
			this.partner_name = partner_name;
			this.root = root;
		}
		
		public function add(val:QuestionResponseSet):void
		{
			sets.push(val);
			length++;
		}
		
		public function load(index:int):QuestionResponseSet
		{
			return sets[index];
		}
	}

}