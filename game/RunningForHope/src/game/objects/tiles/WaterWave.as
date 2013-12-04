package game.objects.tiles
{
	import citrus.objects.CitrusSprite;
	import citrus.view.starlingview.AnimationSequence;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	public class WaterWave extends CitrusSprite
	{
		public function WaterWave(name:String, params:Object=null)
		{
			super(name, params);
			var ta:TextureAtlas = Assets.getAtlas("WaterWave");
			var seq:AnimationSequence = new AnimationSequence(ta, ["water_wave"], "water_wave", 30, true, Config.SMOOTHING);
			view = seq;
			trace(seq.mcSequences.toString());
		}
	}
}