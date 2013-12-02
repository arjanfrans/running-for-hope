package model.dialog 
{
	import starling.textures.Texture;

	/**
	 * ...
	 * @author Wim Barelds
	 */
	public class QuestionResponse 
	{
		private var q:String;
		private var a:DialogEntry;
		
		
		public function QuestionResponse(question:String, answer:DialogEntry):void
		{
			q = question;
			a = answer;
		}
		
		public function question(question:String = null):String
		{
			if (question != null) q = question;
			return q;
		}
		
		public function answer(answer:DialogEntry = null):DialogEntry
		{
			if (answer != null) a = answer;
			return a;
		}
	}

}