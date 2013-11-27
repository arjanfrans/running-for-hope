package game {
	
	import citrus.CustomSprite;
	import citrus.core.starling.StarlingState;
	import citrus.objects.platformer.nape.*;
	import citrus.physics.nape.Nape;
	import citrus.utils.objectmakers.ObjectMakerStarling;
	
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import game.objects.*;
	import game.objects.platforms.*;
	import game.objects.sensors.*;
	
	import model.Level;
	
	import nape.geom.Vec2;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.ResizeEvent;
	
	import ui.dialog.DialogView;
	import ui.hud.PlayerStatsUi;
	import ui.menus.PauseMenu;
	import model.Model;
	
	/**
	 * The main game state, this is where the gameplay happens. The level gets setup here.
	 */
	public class GameState extends StarlingState {
	
		private var hero:Luigi;
		private var playerStatsUi:PlayerStatsUi;
		private var pauseMenu:PauseMenu = null;
		
		public function GameState() {
			super();
			
			//Objects which can be found in a map
			var objects:Array = [Luigi, CustomSprite, FallSensor, EndLevelSensor, DialogSensor, Platform, Box, MovingPlatform, Token, Water];

			_ce.stage.align = StageAlign.TOP_LEFT;
			_ce.stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		override public function initialize():void {	
			super.initialize();
			
			// Reset model for this level
			var m:Model = Main.getModel();
			m.pause = false;
			m.points = 0;
			m.time = 0;
			m.lifes = Config.LIFES;
			
			var napePhysics:Nape = new Nape("nape");
			if(Config.DEBUG_MODE) napePhysics.visible = true;
			add(napePhysics);
			
			/* Adjust timeStep to match framerate, so 30 or 60 fps will act the same			*/
			napePhysics.timeStep = 2*(1/Config.INTERNAL_FPS);


			Main.getModel().getLevel().load(initFlash, true);
			playerStatsUi = new PlayerStatsUi(openPauseMenu);
			this.addChild(playerStatsUi); //Add the HUD
		}
		
		private function openPauseMenu():void
		{
			// Don't open a pause menu upon another pause menu
			if(pauseMenu != null) return;
			// Don't open a pause menu on top of dialog
			for(var i:int = 0; i < numChildren; i++) {
				var obj:DisplayObject = getChildAt(i);
				if(obj is DialogView) return;
			}
			
			// Show pause menu
			Main.getModel().pause = true;
			pauseMenu = new PauseMenu(this);
			addChild(pauseMenu);
			//Adjust size of pause menu to game size
			onResize(new ResizeEvent("init", Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight));
		}
		
		public function closePauseMenu():void
		{
			if(pauseMenu != null) removeChild(pauseMenu);
			Main.getModel().pause = false;
			pauseMenu = null;
		}
		
		private function initFlash(flashLevel:MovieClip):void
		{
			var level:Level = Main.getModel().getLevel();
			ObjectMakerStarling.FromMovieClip(flashLevel, Assets.getAtlas("Spritesheet"));
			hero = getObjectByName("Hero") as Luigi;
			
			view.camera.allowZoom = true;
			view.camera.easing = new Point(1, 1);
			view.camera.setUp(hero, new Point(_ce.stage.width/2, _ce.stage.height/2), new Rectangle(0, 0, level.width, level.height));
			
			stage.addEventListener(starling.events.ResizeEvent.RESIZE, onResize);
			onResize(new ResizeEvent("init", Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight));
		}
		
		/**
		 * Update the game dimensions/size/zoom when a resize of the screen is done.
		 */
		private function onResize(event:ResizeEvent):void
		{	
			var width:Number = event.width;
			var height:Number = event.height;
			var newWidth:Number = width;
			var newHeight:Number = height;
			
			if(Config.KEEP_SCALING_RATIO) {
				var aspectRatio:Number = width / height;
				var scale:Number = 1;
				var crop:Vec2 = new Vec2(0, 0);
				if(aspectRatio > Config.ASPECT_RATIO)
				{
					scale = height / Config.VIRTUAL_HEIGHT;
					crop.x = (width - Config.VIRTUAL_WIDTH * scale) / 2;
				}
				else if(aspectRatio < Config.ASPECT_RATIO)
				{
					scale = width / Config.VIRTUAL_WIDTH;
					crop.y = (height - Config.VIRTUAL_HEIGHT*scale) / 2;
				}
				else
				{
					scale = width / Config.VIRTUAL_WIDTH;
				}
				newWidth = Config.VIRTUAL_WIDTH * scale;
				newHeight = Config.VIRTUAL_HEIGHT * scale;
			}
			
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = newWidth;
			viewPortRectangle.height = newHeight;
			
			//To center the view calculate an offset, Nape debug view is not in sync with the view!
			if(!Config.DEBUG_MODE) viewPortRectangle.x = (width - newWidth) / 2;
			
			
			Starling.current.stage.stageWidth = newWidth;
			Starling.current.stage.stageHeight = newHeight;
			Starling.current.viewPort = viewPortRectangle;
			
			
			view.camera.cameraLensWidth = newWidth;
			view.camera.cameraLensHeight = newHeight;
			view.camera.offset = new Point(newWidth/2, newHeight/2);
			view.camera.zoomFit(newWidth, newHeight);
			view.camera.reset();
			
			playerStatsUi.width = (newWidth / Config.VIRTUAL_WIDTH) * playerStatsUi.originalWidth;
			playerStatsUi.height = (newWidth / Config.VIRTUAL_WIDTH) * playerStatsUi.originalHeight;

			if(pauseMenu != null) {
				pauseMenu.width = newWidth;
				pauseMenu.height = newHeight;
			}
			
			//TODO scaling down too small will cause the game to crash/not work as it should
		}	
		
		override public function update(timeDelta:Number):void
		{
			if(!Main.getModel().pause) Main.getModel().time += timeDelta;
			super.update(timeDelta);
			playerStatsUi.updateUi();
		}
	}
}
