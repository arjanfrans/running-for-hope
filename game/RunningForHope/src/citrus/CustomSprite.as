package citrus
{
	import citrus.objects.CitrusSprite;
	
	/**
	 * Extends the built in CitrusSprite. Added functionality to give it the size as the Symbol that is drawn in flash.
	 */
	public class CustomSprite extends CitrusSprite
	{		
		public function CustomSprite(name:String, params:Object=null)
		{
			super(name, params);
			this.view.width = this.width;
			this.view.height = this.height;

		}		
	}
}