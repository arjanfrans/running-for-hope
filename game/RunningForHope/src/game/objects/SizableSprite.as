package game.objects
{
	import citrus.objects.CitrusSprite;
	
	public class SizableSprite extends CitrusSprite
	{		
		public function SizableSprite(name:String, params:Object=null)
		{
			super(name, params);
			this.view.width = this.width;
			this.view.height = this.height;
		}		
	}
}