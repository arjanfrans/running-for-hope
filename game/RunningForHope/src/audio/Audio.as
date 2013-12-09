package audio
{
	/**
	 * Sources for audio:
	 * jump: http://www.sounddogs.com/results.asp?Type=1,&CategoryID=1023&SubcategoryID=27
	 * */
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
			else if(state == "dialog" || state == "window") {
				Main.audio.stopAllPlayingSounds("backgroundMusic"); //TODO make backgroundmusic
			}
			else if(state == "menu") {
				Main.audio.stopAllPlayingSounds();
			}
		}
	}
}