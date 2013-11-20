package game.objects  {
	
	import citrus.objects.CitrusSprite;
	import citrus.objects.platformer.awayphysics.Hero;
	
	
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

		private var img:Image;

		public function BackgroundLayer(name:String, stretchX:Boolean = false, stretchY:Boolean = false, 
										x:Number = 0, y:Number = 0, params:Object = null)
		{
			super(name, params);
			layerSprite = new Sprite();
			img = new Image(Assets.getBackground(name));
			img.x = x;
			img.y = y;
			updateSize();
			layerSprite.addChild(img);
			this.view = layerSprite;
			
		}
		
		public function updateSize():void
		{
			img.width = _ce.stage.stage.width;
			img.height = _ce.stage.stageHeight;
		}
		
		
	}
}