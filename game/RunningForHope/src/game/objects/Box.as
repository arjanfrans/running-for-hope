package game.objects
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Crate;
	import citrus.physics.nape.NapeUtils;
	
	import game.objects.platforms.Water;
	
	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	import nape.phys.Material;
	
	import starling.textures.Texture;
		
	public class Box extends Crate
	{

		public function Box(name:String, params:Object = null)
		{
			super(name, params);
		}
		
		override protected function createMaterial():void
		{
			super.createMaterial();
			this._material.density = 0.5;
			this._material.rollingFriction = -1;
			this._material.dynamicFriction = 0.6;
			this.beginContactCallEnabled = true;
		}
		
		override protected function createBody():void
		{
			super.createBody();
			_body.allowRotation = true;
			_body.gravMassScale = 0.4; //Lowered the gravity on the box, to make pushing up hill easier.
			
		}
		
		
		/**
		 * Function when this object is contacted. When the box comes in contact with water it will stop
		 * rotating. A rotating box in the water is too hard for the player to stand on.
		 */
		override public function handleBeginContact(callback:InteractionCallback):void
		{
			super.handleBeginContact(callback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, callback);
			if (collider is Water)
			{
				//When the Box falls into the water, we do not want it to rotate again.
				_body.angularVel = 0;
				_body.rotation = 0;
				_body.allowRotation = false;
				this.beginContactCallEnabled = false;				
			}
		}
		
		
		
		
	}
}