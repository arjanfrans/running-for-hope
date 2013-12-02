package audio
{
	public class Audio
	{
		public function Audio()
		{
		}
		
		public static function setState(state:String):void
		{
			if(state == "game") {
				Main.audio.stopAllPlayingSounds();	
			}
			else if(state == "dialog") {
				Main.audio.stopAllPlayingSounds("backgroundMusic"); //TODO make backgroundmusic
			}
			else if(state == "menu") {
				Main.audio.stopAllPlayingSounds();
			}
		}
	}
}