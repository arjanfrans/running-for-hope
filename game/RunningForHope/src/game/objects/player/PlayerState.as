package game.objects.player
{
	import citrus.input.Input;
	import nape.geom.Vec2;

	public interface PlayerState
	{
		function update(timeDelta:Number, velocity:Vec2, input:Input):void;
		
		function updateAnimation():void;
		
		function init():void;
	}
}