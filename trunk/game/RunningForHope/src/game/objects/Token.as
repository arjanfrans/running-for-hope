package game.objects
{
	import citrus.objects.platformer.nape.Coin;
	import citrus.physics.nape.NapeUtils;
	
	import nape.callbacks.InteractionCallback;
	
	import ui.hud.PlayerStatsUi;
	
	public class Token extends Coin
	{
		public function Token(name:String, params:Object=null)
		{
			super(name, params);
			this.collectorClass = "game.objects.Luigi";
		}
		
		/**
		 * When the Hero comes in contact with a Token, the score goes up.
		 */
		override public function handleBeginContact(interactionCallback:InteractionCallback):void {
			super.handleBeginContact(interactionCallback);
			
			if (_collectorClass && NapeUtils.CollisionGetOther(this, interactionCallback) is _collectorClass) {
				kill = true;
				Main.getModel().points++;
			}
				
		}
		
	}
}