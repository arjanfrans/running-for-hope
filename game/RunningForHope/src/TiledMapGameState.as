package {
	
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.MovingPlatform;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.Nape;
	import citrus.utils.objectmakers.ObjectMakerStarling;
	import citrus.utils.objectmakers.tmx.TmxMap;
	import citrus.utils.objectmakers.tmx.TmxObject;
	import citrus.utils.objectmakers.tmx.TmxObjectGroup;
	import citrus.utils.objectmakers.tmx.TmxPropertySet;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import nape.geom.Vec2;
	
	import objects.Box;
	import objects.Luigi;
	import objects.Token;
	
	import starling.display.Stage;
	import starling.events.ResizeEvent;
	import starling.textures.TextureAtlas;
	import starling.utils.RectangleUtil;
	
	import ui.PlayerStatsUi;
	
	/**
	 * @author Aymeric
	 */
	public class TiledMapGameState extends StarlingState {
		
		private var hero:Luigi;
		private var mapObjects:Array;
		private var sTextureAtlas:TextureAtlas;
		private const VIRTUAL_WIDTH:int = 512;
		private const VIRTUAL_HEIGHT:int = 448;
		private const ASPECT_RATIO:Number = VIRTUAL_WIDTH / VIRTUAL_HEIGHT;
		//private var viewport;
		
		public function TiledMapGameState() {
			super();
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Luigi, Platform, Box, MovingPlatform, Token];
			
		}
		
		private function onResize(event:ResizeEvent):void
		{
/*			var width:Number = this._ce.width;
			var height:Number = this._ce.height;
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
			
			var w:Number = VIRTUAL_WIDTH * scale;
			var h:Number = VIRTUAL_HEIGHT * scale;
			view.camera.bounds = new Rectangle(crop.x, crop.y, w, h);*/
	/*		var w:Number = this._ce.width;
			var h:Number = this._ce.height;
			view.camera.cameraLensWidth = w;
			view.camera.cameraLensHeight = h;
			view.camera.offset.x = w * 0.5;
			view.camera.offset.y = h * 0.5;
			//view.camera.zoomFit(700, 700);
			view.camera.setZoom(event.width / this._ce.width );*/
		}		
		
		override public function initialize():void {	
			super.initialize();
			stage.addEventListener(starling.events.ResizeEvent.RESIZE, onResize);
			var map:XML = Assets.getTmxMap("Level1");
			var tmx:TmxMap = new TmxMap(map);
			
			loadBackground(tmx);
			
			var napePhysics:Nape = new Nape("nape");
			napePhysics.visible = true; //Debug view
			add(napePhysics);
			
			
			
			mapObjects = ObjectMakerStarling.FromTiledMap(map, Assets.getAtlas("Spritesheet"));     
			
			hero = getObjectByName("hero") as Luigi;
			
			initObjectTextures(tmx);
			
			view.camera.allowZoom = true;
			view.camera.setUp(hero, new Point(300, stage.stageHeight), new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			this.addChild(new PlayerStatsUi());
			
		}
		
		
		
		/**
		 * Load the background data from the object named "background" in the tmx file.
		 * */
		private function loadBackground(tmx:TmxMap):void {
			var bgLayers:Vector.<BackgroundLayer> = new Vector.<BackgroundLayer>();
			for each (var group:TmxObjectGroup in tmx.objectGroups) {
				for each (var objectTmx:TmxObject in group.objects) {
					if(objectTmx.name == "background") {						
						bgLayers.push(new BackgroundLayer(objectTmx.custom["layer1"], true, true));
						bgLayers.push(new BackgroundLayer(objectTmx.custom["layer2"], false, false));
					}
				}
				
			}
			this.add(new Background(this, bgLayers));
		}
		
		/**
		 * Load textures for objects, defined by the "texture" property in map objects
		 */
		private function initObjectTextures(tmx:TmxMap):void {
			var objectClass:Class;
			var object:CitrusObject;
			for each (var group:TmxObjectGroup in tmx.objectGroups) {
				for each (var objectTmx:TmxObject in group.objects) {
					var params:Dictionary = new Dictionary();
					for (var param:String in objectTmx.custom) {
						params[param] = objectTmx.custom[param];
					}
					if(params["texture"] != null) {
						var textureName:String = objectTmx.custom["texture"];
						objectClass = getDefinitionByName(objectTmx.type) as Class;
						var type:String = objectTmx.type;
						if(textureName != null) {
							var objVect:Vector.<CitrusObject> = this.getObjectsByType(objectClass);
							for each(var obj:CitrusObject in objVect) {
								if(obj is NapePhysicsObject) {
									var napeObj:NapePhysicsObject = obj as NapePhysicsObject;
									napeObj.view = Assets.getTexture("Spritesheet", textureName);
								}
							}
						}
					}
					
				}
				
			}
		}
		
		public function set setHeight(height:int):void
		{
			this.height = height;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
		}
		
	}
}
