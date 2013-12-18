package model.dialog 
{
	import starling.textures.Texture;
	import actions.Action;

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
		public var background:Texture;
		private var closingActions:Vector.<Action> = new Vector.<Action>();
		
		public function Dialog(char1Asset:Texture, char2Asset:Texture, background:Texture = null) 
		{
			messages = new Array();
			this.char1_asset = char1Asset;
			this.char2_asset = char2Asset;
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
		
		public function addClosingAction(action:Action):void
		{
			closingActions.push(action);
		}
		
		public function close():void
		{
			for(var i:int = 0; i < closingActions.length; i++) {
				closingActions[i].trigger();
			}
		}
	}

}