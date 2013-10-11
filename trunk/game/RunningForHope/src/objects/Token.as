package objects
{
	import citrus.objects.platformer.nape.Coin;
	import nape.callbacks.InteractionCallback;
	import citrus.physics.nape.NapeUtils;
	
	public class Token extends Coin
	{
		public function Token(name:String, params:Object=null)
		{
			super(name, params);
			this.collectorClass = "objects.Luigi";
		}
		
		override public function handleBeginContact(interactionCallback:InteractionCallback):void {
			super.handleBeginContact(interactionCallback);
			
			if (_collectorClass && NapeUtils.CollisionGetOther(this, interactionCallback) is _collectorClass) {
				kill = true;
				//update the UI???
			}
				
		}
		
	}
}