package game.objects.platforms
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.NapeUtils;
	
	import game.objects.Player;
	
	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.BodyType;
	
	public class MovingPlatform extends Platform
	{
		public var startX:Number = 0;
		public var startY:Number = 0;
		public var endX:Number = 0;
		public var endY:Number = 0;
		public var animationTime:Number = 5;
		private var animationIndex:Number = 0;
		
		public function MovingPlatform(name:String, params:Object=null)
		{
			super(name, params);
			updateCallEnabled = true;
		}
		
		private function get half_way():Number
		{
			return animationTime / 2;
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			animationIndex = (animationIndex + timeDelta) % animationTime;
			
			var pct:Number = Math.abs((animationIndex - half_way) / half_way);
			var target_x:Number = (startX * pct) + (endX * (1 - pct));
			var target_y:Number = (startY * pct) + (endY * (1 - pct));
			
			var pos:Vec2 = new Vec2(x, y);
			var target_pos:Vec2 = new Vec2(target_x, target_y);
			var vel:Vec2 = target_pos.subeq(pos);
			_body.velocity.set(vel);
		}
		
		override protected function defineBody():void
		{
			super.defineBody();
			_bodyType = BodyType.KINEMATIC;
		}
	}
}