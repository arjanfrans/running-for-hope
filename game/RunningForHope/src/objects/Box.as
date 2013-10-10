package objects
{
	import citrus.objects.platformer.nape.Crate;
	
	import starling.textures.Texture;
		
		
	public class Box extends Crate
	{

		public function Box(name:String, params:Object = null)
		{
			super(name, params);
			/*var texture:Texture = Assets.getTexture("Spritesheet", "crate");
			this.view = texture;*/
		}
	}
}