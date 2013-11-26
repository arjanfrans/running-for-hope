package model
{
	public class Score
	{
		public var name:String;
		public var points:int;
		public var time:Number;
		public var score:int;
		
		public function Score(name:String, points:int, time:Number, score:int):void
		{
			this.name = name;
			this.points = points;
			this.time = time;
			this.score = score;
		}
		
		public static function fromObject(obj:Object, level:Level):Score
		{
			var name:String = obj["name"];
			var points:int = obj["points"];
			var time:Number = obj["time"];
			var score:int = Score.calculate(time, points, level);
			return new Score(name, points, time, score);
		}
		
		public static function calculate(time:Number, points:int, level:Level = null):int
		{
			if(level = null) level = Main.getModel().getLevel();
			return 10000 / (time * (1 - ((points as Number) / (level.maxPoints() as Number) * 0.6)));			
		}
		
		public function toObject():Object
		{
			return { name: name, points: points, time: time };
		}
		
		public function toString():String
		{
			return name + " (Score: " + score + ", Time: " + (Math.round(time * 10) / 10) + "s, Points: " + points + ")";
		}
	}
}