package
{
	import citrus.core.CitrusObject;
	import citrus.core.starling.StarlingState;
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
	
	import objects.Box;
	import objects.Luigi;
	import objects.Token;
	
	import starling.textures.TextureAtlas;
	
	import ui.PlayerStatsUi;
	import citrus.core.State;
	
	public class World extends StarlingState
	{
		
		private var hero:Luigi;
		private var mapObjects:Array;
		private var sTextureAtlas:TextureAtlas;

		private var map:XML;
		private var tmx:TmxMap;
		private var napePhysics:Nape;
		
		public function World(levelName:String)
		{
			super();
			map = Assets.getTmxMap(levelName);
			tmx = new TmxMap(map);
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Luigi, Platform, Box, MovingPlatform, Token];
			
			
		}
		
		
		override public function initialize():void {	
			super.initialize();
			loadBackground();

			napePhysics = new Nape("nape");
			if(Config.DEBUG_MODE) napePhysics.visible = true;
			add(napePhysics);		
			
			mapObjects = ObjectMakerStarling.FromTiledMap(map, Assets.getAtlas("Spritesheet"));     
			
			hero = getObjectByName("hero") as Luigi;
			
			loadObjectTextures(tmx);
			
			view.camera.allowZoom = true;
			view.camera.setUp(hero, new Point(300, stage.stageHeight), new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			
			this.addChild(new PlayerStatsUi());
			
		}
		
		private function loadBackground():void {
			var bgLayers:Vector.<BackgroundLayer> = new Vector.<BackgroundLayer>();
			var layerProperty:TmxPropertySet = tmx.getLayer("background").properties
			if(layerProperty.hasOwnProperty("layer1")) {
				var bgLayer:BackgroundLayer = new BackgroundLayer(layerProperty.layer1, true, true);
				bgLayers.push(bgLayer);
			}
			if(layerProperty.hasOwnProperty("layer2")) {
				var bgLayer:BackgroundLayer = new BackgroundLayer(layerProperty.layer2, true, false);
				bgLayers.push(bgLayer);
			}
			add(new Background("background", bgLayers));
		}
		
		/**
		 * Load textures for objects, defined by the "texture" property in map objects
		 */
		private function loadObjectTextures():void {
			
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
	}