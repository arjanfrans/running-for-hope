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
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import objects.Box;
	import objects.Luigi;
	import objects.Token;
	
	import starling.display.Stage;
	import starling.textures.TextureAtlas;
	
	import ui.PlayerStatsUi;
	
	/**
	 * @author Aymeric
	 */
	public class TiledMapGameState extends StarlingState {
		
		private var hero:Luigi;
		private var mapObjects:Array;
		private var sTextureAtlas:TextureAtlas;

		public function TiledMapGameState() {
			super();
			// Useful for not forgetting to import object from the Level Editor
			var objects:Array = [Luigi, Platform, Box, MovingPlatform, Token];
			
		}
		
		
		override public function initialize():void {	
			super.initialize();
			new Background(this);
			this._ce.stage.frameRate = 60;
			var napePhysics:Nape = new Nape("nape");
			napePhysics.visible = true; //Debug view
			add(napePhysics);
			
			var map:XML = Assets.getTmxMap("Level1");
			var tmx:TmxMap = new TmxMap(map);
			
			
			mapObjects = ObjectMakerStarling.FromTiledMap(map, Assets.getAtlas("Spritesheet"));     
			
			hero = getObjectByName("hero") as Luigi;
			
			initObjectTextures(tmx);
			
			view.camera.allowZoom = true;
			view.camera.setUp(hero, new Point(300, stage.stageHeight), new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			
			this.addChild(new PlayerStatsUi());
		
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
