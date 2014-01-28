package audio
{
	import citrus.sounds.CitrusSoundGroup;
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
				Main.audio.getGroup(CitrusSoundGroup.BGM).volume = 0.8;
			}
			else if(state == "dialog" || state == "window") {
				Main.audio.getGroup(CitrusSoundGroup.SFX).mute = true;
				Main.audio.stopAllPlayingSounds("level1", "level2", "level3");
				Main.audio.getGroup(CitrusSoundGroup.BGM).volume = 0.3;
			}
			else if(state == "menu") {
				Main.audio.stopAllPlayingSounds();
				Main.audio.getGroup(CitrusSoundGroup.BGM).volume = 1;
			}
			else if(state == "dead") {
				Main.audio.stopAllPlayingSounds("dead");
				Main.audio.getGroup(CitrusSoundGroup.BGM).mute = true;
			}
			else if(state == "continue") {
				Main.audio.getGroup(CitrusSoundGroup.BGM).volume = 0.8;
				Main.audio.getGroup(CitrusSoundGroup.SFX).mute = false;
			}
			else if(state == "mute_background") {
				Main.audio.getGroup(CitrusSoundGroup.BGM).mute = true;
				Main.audio.stopAllPlayingSounds("level1", "level2", "level3");
			}
			else if(state == "unmute_background") {
				Main.audio.getGroup(CitrusSoundGroup.BGM).mute = false;
			}
		}
	}
}