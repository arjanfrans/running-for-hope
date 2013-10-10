package  {
	
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.awayphysics.Hero;
	
	import objects.Luigi;
	
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * This class defines the whole InGame background containing multiple background layers.
	 *  
	 * @author hsharma
	 * 
	 */
	public class BackgroundLayer extends CitrusSprite
	{
		private var layerSprite:Sprite;

		public function BackgroundLayer(name:String, stretchX:Boolean = false, stretchY:Boolean = false, 
										x:Number = 0, y:Number = 0, params:Object = null)
		{
			super(name, params);
			layerSprite = new Sprite();
			var img:Image = new Image(Assets.getBackground(name));
			img.x = x;
			img.y = y;
			if(stretchX) {
				img.width = _ce.stage.stage.width;
				trace(_ce.stage.stage.width);
			}
			if(stretchY) {
				img.height = _ce.stage.stageHeight;
			}
			layerSprite.addChild(img);
			this.view = layerSprite;
		}
	}
}