package {
	
	import citrus.core.IState;
	import citrus.core.citrus_internal;
	import citrus.core.starling.StarlingCitrusEngine;
	import citrus.core.starling.StarlingState;
	import citrus.sounds.CitrusSoundGroup;
	import citrus.sounds.SoundManager;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.GameState;
	
	import model.Model;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.utils.RectangleUtil;
	import starling.utils.ScaleMode;
	
	import ui.dialog.DialogMessage;
	import ui.hud.PlayerStatsUi;
	import ui.menus.MenuState;
	import flash.display.StageDisplayState;	
	[SWF(backgroundColor="#000000", width="800", height="600", frameRate="30")]
	public class Main extends StarlingCitrusEngine {
		
		private static var _this:Main;
		private var _level:int = 0;
		private var _model:Model;
		public static var audio:SoundManager;

		public function Main() {
			_this = this;
			_model = new Model();
			this.stage.frameRate = Config.INTERNAL_FPS;
			setUpStarling(Config.DEBUG_MODE);
			state = new MenuState();
			audio = this.sound;
			initSound();

		}
	
		
		public static function getModel():Model
		{
			return _this._model;
		}
		
		public static function setState(state:StarlingState):void
		{
			Main.audio.stopAllPlayingSounds();
			_this.state = state;
		}
		
		public static function getState():IState
		{
			return _this.state;
		}
		
		public static function level(level:int = -1):int
		{
			if(level >= 0) _this._level = level;
			return _this._level;
			
		}
		
		private function initSound():void
		{
/*			sound.addSound("Collect", {sound:"sounds/collect.mp3",group:CitrusSoundGroup.SFX});
			sound.addSound("Hurt", {sound:"sounds/hurt.mp3",group:CitrusSoundGroup.SFX});*/
			sound.addSound("jump", {sound: "audio/jump.mp3",group:CitrusSoundGroup.SFX});
			sound.addSound("wall_jump", {sound: "audio/wall_jump.mp3",group:CitrusSoundGroup.SFX});
			sound.addSound("wall_jump_1", {sound: "audio/wall_jump_1.mp3",group:CitrusSoundGroup.SFX});
			sound.addSound("wall_jump_2", {sound: "audio/wall_jump_2.mp3",group:CitrusSoundGroup.SFX});
			sound.addSound("walk", {sound:"audio/walk1.mp3", timesToPlay: 0, group:CitrusSoundGroup.SFX } );
			sound.addSound("theme_song", {sound:"audio/main_theme.mp3",timesToPlay:-1,group:CitrusSoundGroup.BGM});
			sound.addSound("level1", {sound:"audio/level1.mp3", timesToPlay:-1,group:CitrusSoundGroup.BGM});
/*			sound.addSound("Kill", {sound:"sounds/kill.mp3",group:CitrusSoundGroup.SFX});
			sound.addSound("Skid", {sound:"sounds/skid.mp3",group:CitrusSoundGroup.SFX});
			sound.addSound("Song", {sound:"sounds/song.mp3",timesToPlay:-1,group:CitrusSoundGroup.BGM});
			sound.addSound("Walk", { sound:"sounds/walk.mp3",timesToPlay: -1, volume:1, group:CitrusSoundGroup.SFX } );*/
		}
	}
}