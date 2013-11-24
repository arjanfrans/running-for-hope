package model
{
	import flash.net.SharedObject;
	import flash.utils.Dictionary;

	public class Highscores
	{
		private var highscores:SharedObject;
		private var level:Level;
		
		public function Highscores(level:Level)
		{
			this.level = level;
			this.highscores = SharedObject.getLocal("running/Highscore");
			
			// Make sure the required data structure is there
			if (highscores.data.levels == undefined) {
				highscores.data.levels = new Object();
			}
			
			// Add filler data if no data there yet
			if(highscores.data.levels[level.name] == undefined){
				highscores.data.levels[level.name] = new <Object> [
					{ name: "[Placeholder]", points: 0, time: 10000 },
					{ name: "[Placeholder]", points: 0, time: 10000 },
					{ name: "[Placeholder]", points: 0, time: 10000 },
					{ name: "[Placeholder]", points: 0, time: 10000 },
					{ name: "[Placeholder]", points: 0, time: 10000 }
				];
			}
		}
		
		public function submitScore():int
		{
			var m:Model = Main.getModel();
			var levelScores:Vector.<Object> = highscores.data.levels[level.name];
			
			var name:String = m.player().name;
			var points:int = m.points;
			var time:Number = m.time;
			var score:int = Score.calculate(time, points, level);
			var newScore:Score = new Score(name, points, time, score);
			
			var rank:int = -1;
			for(var i:int = 0; i < 5; i++) {
				var oldScore:Score = Score.fromObject(levelScores[i], level);
				if(newScore.score > oldScore.score) {
					levelScores.splice(i, 0, newScore.toObject());
					rank = i + 1;
					break;
				}
			}
			while (levelScores.length > 5) levelScores.splice(5, 1);
			return rank;
		}
		
		public function getHighScore(rank:int):Score {
			var obj:Object = highscores.data.levels[level.name][rank];
			return Score.fromObject(obj, level);
		}
	}
}