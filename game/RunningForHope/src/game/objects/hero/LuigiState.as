package game.objects.hero
{
	import citrus.input.Input;
	import nape.geom.Vec2;

	public interface LuigiState
	{
		function update(timeDelta:Number, velocity:Vec2, input:Input):void;
		
		function updateAnimation():void;
	}
}