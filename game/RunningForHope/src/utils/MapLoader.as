package utils
{
	import citrus.core.CitrusObject;
	import citrus.objects.CitrusSprite;
	import citrus.objects.NapePhysicsObject;
	import citrus.utils.objectmakers.tmx.TmxMap;
	import citrus.utils.objectmakers.tmx.TmxObject;
	import citrus.utils.objectmakers.tmx.TmxObjectGroup;
	
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	import game.GameState;
	import game.objects.Background;
	import game.objects.BackgroundLayer;

	/**
	 * Helper class with functions to help with loading the map. Functions are kept in here
	 * to keep the main game state class clean.
	 */
	public class MapLoader
	{
		
		/**
		 * Load the background data from the object named "background" in the tmx file.
		 */
		public static function loadBackground(state:GameState, tmx:TmxMap):Background {
			var bgLayers:Vector.<BackgroundLayer> = new Vector.<BackgroundLayer>();
			for each (var group:TmxObjectGroup in tmx.objectGroups) {
				for each (var objectTmx:TmxObject in group.objects) {
					if(objectTmx.name == "background") {						
						bgLayers.push(new BackgroundLayer(objectTmx.custom["layer1"], true, true));
						bgLayers.push(new BackgroundLayer(objectTmx.custom["layer2"], false, false));
					}
				}
				
			}
			return new Background(state, bgLayers);
		}
		
		/**
		 * Load textures for objects, defined by the "texture" property in map objects
		 */
		public static function loadObjectTextures(state:GameState, tmx:TmxMap):void {
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
							var objVect:Vector.<CitrusObject> = state.getObjectsByType(objectClass);
							for each(var obj:CitrusObject in objVect) {
								if(obj is NapePhysicsObject) {
									(obj as NapePhysicsObject).view = Assets.getTexture("Spritesheet", textureName);
								}
							}
						}
					}
				}
			}
		}
		
	}
}