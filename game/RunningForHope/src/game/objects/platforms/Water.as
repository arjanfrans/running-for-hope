package game.objects.platforms
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.NapeUtils;
	
	import nape.callbacks.InteractionCallback;
	import nape.phys.FluidProperties;
	
	import game.objects.Luigi;

	/**
	 * A water platform which is fluid. It is deadly to the hero
	 */
	public class Water extends Platform
	{
		public function Water(name:String, params:Object=null)
		{
			super(name, params);
			this._beginContactCallEnabled = true;	
		}
		
		
		
		/**
		 * Function when this object is contacted
		 */
		override public function handleBeginContact(callback:InteractionCallback):void
		{
			super.handleBeginContact(callback);
			var collider:NapePhysicsObject = NapeUtils.CollisionGetOther(this, callback);
			
			if (collider is Luigi)
			{
				(collider as Luigi).dead = true;
			}
		}
		
		
		/**
		 * Overrided from parten. 'Fluid' properties for water are added
		 */
		override protected function createShape():void
		{
			super.createShape();
			_shape.fluidEnabled = true;
			this._shape.fluidEnabled = true;
			this._shape.fluidProperties = new FluidProperties(5, 20); 
		}
		
		
	}
}