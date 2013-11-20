package game.objects
{
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import game.GameState;
	import game.objects.BackgroundLayer;
	
	public class Background extends CitrusObject
	{
		private var state:GameState;

		private var layer1:BackgroundLayer;

		private var layer2:BackgroundLayer;

		
		public function Background(state:GameState, layers:Vector.<BackgroundLayer>, params:Object=null)
		{
			super("background", params);
			this.state = state;
			
			layer1 = new BackgroundLayer("SkyBg", true, true);
			layer1.parallaxX = 0.0;
			layer1.x = 0;
			layer1.y = 0;
			
			layer2 = new BackgroundLayer("MountainBg", true, true);
			layer2.parallaxX = 0.4;
			layer2.x = 0;
			layer2.y = _ce.stage.stageHeight - Assets.getBackground("MountainBg").height;

			state.add(layer1);
			state.add(layer2);
		}
		
		public function updateSize():void
		{
			layer1.updateSize();
			layer2.updateSize();
		}
		
	}
}