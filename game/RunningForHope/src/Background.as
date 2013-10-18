package
{
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	
	public class Background extends CitrusObject
	{
		private var gameState:TiledMapGameState;

		
		public function Background(gameState:TiledMapGameState, layers:Vector.<BackgroundLayer>, params:Object=null)
		{
			super("background", params);
			this.gameState = gameState;
			
			var layer1:BackgroundLayer = new BackgroundLayer("SkyBg", true, true);
			layer1.parallaxX = 0.0;
			layer1.x = 0;
			layer1.y = 0;
			
			var layer2:BackgroundLayer = new BackgroundLayer("MountainBg", false, true);
			layer2.parallaxX = 0.4;
			layer2.x = 0;
			layer2.y = _ce.stage.stageHeight - Assets.getBackground("MountainBg").height;

			gameState.add(layer1);
			gameState.add(layer2);
		}
	}
}