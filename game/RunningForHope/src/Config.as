package 
{
	import starling.textures.TextureSmoothing;

	public class Config
	{
		public static var INTERNAL_FPS:int = 30;
		public static const DEBUG_MODE:Boolean = false;
		public static const LIFES:int = 4;	
		
		
		/**
		 * Set the smoothing filter to be used on images: NONE, BILINEAR, TRILINEAR
		 */
		public static const SMOOTHING:String = TextureSmoothing.TRILINEAR;
		
		/**
		 * Wheter you keep a ratio on the game view. If true, black borders will be added around the view.
		 * This option is here, because if you don't keep the ratio, someone with a wider screen will see more.
		 * To keep the game fair, everyone should see the same.
		 * It should be 'true' in a production version.
		 * Note: Only effective when DEBUG_MODE = false.
		 */
		public static const KEEP_SCALING_RATIO:Boolean = DEBUG_MODE ? false : true;
		
		public static const VIRTUAL_WIDTH:int = 800;
		public static const VIRTUAL_HEIGHT:int = 600;
		public static const ASPECT_RATIO:Number = VIRTUAL_WIDTH / VIRTUAL_HEIGHT;
		
		public static const FULLSCREEN:Boolean = false;

	}
}