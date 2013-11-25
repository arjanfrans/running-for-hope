package game {
	
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
	import starling.events.ResizeEvent;
	
	import ui.hud.PlayerStatsUi;
	import ui.menus.PauseMenu;
	
	/**
	 * The main game state, this is where the gameplay happens. The level gets setup here.
	 */
	public class GameState extends StarlingState {
		
		private const VIRTUAL_WIDTH:int = 800;
		private const VIRTUAL_HEIGHT:int = 600;
		private const ASPECT_RATIO:Number = VIRTUAL_WIDTH / VIRTUAL_HEIGHT;
		
		private var hero:Luigi;
		private var background:SizableSprite;
		private var playerStatsUi:PlayerStatsUi;
		private var pauseMenu:PauseMenu = null;
		
		public function GameState() {
			super();
			//Objects which can be found in a map
			var objects:Array = [Luigi, FallSensor, EndLevelSensor, DialogSensor, Platform, Box, MovingPlatform, Token, Water];

			_ce.stage.align = StageAlign.TOP_LEFT;
			_ce.stage.scaleMode = StageScaleMode.NO_SCALE;
		}
		
		override public function initialize():void {	
			super.initialize();
			
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
			if(pauseMenu != null) return;
			Main.getModel().pause = true;
			pauseMenu = new PauseMenu(this);
			addChild(pauseMenu);
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
				if(aspectRatio > ASPECT_RATIO)
				{
					scale = height / VIRTUAL_HEIGHT;
					crop.x = (width - VIRTUAL_WIDTH * scale) / 2;
				}
				else if(aspectRatio < ASPECT_RATIO)
				{
					scale = width / VIRTUAL_WIDTH;
					crop.y = (height - VIRTUAL_HEIGHT*scale) / 2;
				}
				else
				{
					scale = width / VIRTUAL_WIDTH;
				}
				newWidth = VIRTUAL_WIDTH * scale;
				newHeight = VIRTUAL_HEIGHT * scale;
			}
			
			var viewPortRectangle:Rectangle = new Rectangle();
			viewPortRectangle.width = newWidth;
			viewPortRectangle.height = newHeight;
			
			//To center the view calculate an offset, Nape debug view is not in sync with the view!
			if(!Config.DEBUG_MODE) viewPortRectangle.x = (width - newWidth) / 2;
			
			Starling.current.stage.stageWidth = newWidth;
			Starling.current.stage.stageHeight = newHeight;
			Starling.current.viewPort = viewPortRectangle;
			
			//TODO background scaling doesn't work properly
			//background.updateSize();
			
			view.camera.cameraLensWidth = newWidth;
			view.camera.cameraLensHeight = newHeight;
			view.camera.offset = new Point(newWidth/2, newHeight/2);
			view.camera.zoomFit(newWidth, newHeight);
			view.camera.reset();
			
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
