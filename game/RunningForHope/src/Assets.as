package  {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	/**
	 * All the game assets are accesed through this class
	 */
	public class Assets
	{	
		
		[Embed(source="../assets/spritesheet.xml", mimeType="application/octet-stream")]
		public static const SpritesheetXml:Class;
		
		[Embed(source="../assets/spritesheet.png")]
		public static const SpritesheetPng:Class;

		
		[Embed(source="../assets/characters/max.xml", mimeType="application/octet-stream")]
		private static const MaxAnimationXml:Class;
		
		[Embed(source="../assets/characters/max.png")]
		private static const MaxAnimationPng:Class;
		
		[Embed(source="../assets/characters/max_female.xml", mimeType="application/octet-stream")]
		private static const MaxAnimation_femaleXml:Class;
		
		[Embed(source="../assets/characters/max_female.png")]
		private static const MaxAnimation_femalePng:Class;
		
		[Embed(source="../assets/static_characters/StaticCharacters.xml", mimeType="application/octet-stream")]
		private static const CharactersXml:Class;
		
		[Embed(source="../assets/static_characters/StaticCharacters.png")]
		private static const CharactersPng:Class;
		
		[Embed(source="../assets/dialogbackgrounds/DialogBackgrounds.xml", mimeType="application/octet-stream")]
		private static const DialogBackgroundsXml:Class;
		
		[Embed(source="../assets/dialogbackgrounds/DialogBackgrounds.png")]
		private static const DialogBackgroundsPng:Class;
		
		[Embed(source="../assets/menus/interface.xml", mimeType="application/octet-stream")]
		private static const InterfaceXml:Class;
		
		[Embed(source="../assets/menus/interface.png")]
		private static const InterfacePng:Class;
		
		[Embed(source="../assets/backgrounds/sky.png")]
		private static const SkyBg:Class;
		
		
		[Embed(source="../assets/backgrounds/big_mountain.png")]
		private static const MountainBg:Class;
		
		//Animated tiles
		[Embed(source="../assets/tiles/animated/water_wave.png")]
		private static const WaterWavePng:Class;
		
		[Embed(source="../assets/tiles/animated/water_wave.xml", mimeType="application/octet-stream")]
		private static const WaterWaveXml:Class;
		
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameMaps:Dictionary = new Dictionary();
				
		public static function getBackground(name:String):Texture
		{
			var t:Texture = Texture.fromBitmap(create(name) as Bitmap);
			return t;
		}

		public static function getAtlas(name:String, filter:ColorMatrixFilter = null):TextureAtlas
		{
			if(gameTextures[name] == null || filter != null)
			{
				var obj:Object = create(name + "Png");
				var bmp:Bitmap = obj as Bitmap;
				if(filter != null){
					var data:BitmapData = bmp.bitmapData;
					data.applyFilter(data, data.rect, new Point(0, 0), filter);
				}
				var texture:Texture = Texture.fromBitmap(bmp);
				var xml:XML = XML(create(name + "Xml"));
				if(filter != null) return new TextureAtlas(texture, xml);
				gameTextures[name] = new TextureAtlas(texture, xml);
			}
			return gameTextures[name];
		}
		
		public static function getTexture(atlasName:String, name:String, filter:ColorMatrixFilter = null):Texture
		{
			return getAtlas(atlasName, filter).getTexture(name);
		}
		
		public static function getImage(atlasName:String, name:String, filter:ColorMatrixFilter = null):Image
		{
			var img:Image = new Image(getTexture(atlasName, name, filter))
			img.smoothing = Config.SMOOTHING;
			return img;
		}
		
		private static function create(name:String):Object
		{
			return new Assets[name]();
		}
	}
}
