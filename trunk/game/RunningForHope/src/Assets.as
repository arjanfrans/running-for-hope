package  {
	
	import flash.display.Bitmap;
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class Assets
	{	
		
		[Embed(source="../assets/spritesheet.xml", mimeType="application/octet-stream")]
		public static const SpritesheetXml:Class;
		
		[Embed(source="../assets/spritesheet.png")]
		public static const SpritesheetPng:Class;
		
		[Embed(source="../assets/characters/luigi.xml", mimeType="application/octet-stream")]
		private static const LuigiAnimationXml:Class;
		
		[Embed(source="../assets/characters/luigi.png")]
		private static const LuigiAnimationPng:Class;
		
		[Embed(source="../assets/backgrounds/blue_sky.png")]
		private static const SkyBg:Class;
		[Embed(source="../assets/backgrounds/big_mountain.png")]
		private static const MountainBg:Class;
		
		[Embed(source="../assets/map.tmx", mimeType="application/octet-stream")]
		private static const Level1Map:Class;
		
		private static var gameTextures:Dictionary = new Dictionary();
		private static var gameMaps:Dictionary = new Dictionary();
		
		public static function getTmxMap(name:String):XML
		{
			if(gameMaps[name] == null) {
				gameMaps[name] = XML(create(name + "Map"));
			}
			return gameMaps[name];
		}
		
		public static function getBackground(name:String):Texture {
			var t:Texture = Texture.fromBitmap(create(name) as Bitmap);
			return t;
		}

		public static function getAtlas(name:String):TextureAtlas
		{
			if(gameTextures[name] == null)
			{
				var texture:Texture = Texture.fromBitmap(create(name + "Png") as Bitmap);
				var xml:XML = XML(create(name + "Xml"));
				gameTextures[name] = new TextureAtlas(texture, xml);
			}
			return gameTextures[name];
		}
		
		public static function getTexture(atlasName:String, name:String):Texture
		{
			return gameTextures[atlasName].getTexture(name);
		}
		
		private static function create(name:String):Object
		{
			var textureClass:Class = Assets;
			return new textureClass[name];
		}
	}
}
