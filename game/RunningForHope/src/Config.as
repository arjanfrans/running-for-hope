package 
{
	public class Config
	{
		public static const INTERNAL_FPS:int = 30;
		public static const DEBUG_MODE:Boolean = true;
		
		/**
		 * Wheter you keep a ratio on the game view. If true, black borders will be added around the view.
		 * This option is here, because if you don't keep the ratio, someone with a wider screen will see more.
		 * To keep the game fair, everyone should see the same.
		 * It should be 'true' in a production version.
		 * Note: Only effective when DEBUG_MODE = false.
		 */
		public static const KEEP_SCALING_RATIO:Boolean = DEBUG_MODE ? false : true;

	}
}