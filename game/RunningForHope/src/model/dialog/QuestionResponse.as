package model.dialog 
{
	/**
	 * ...
	 * @author Wim Barelds
	 */
	public class QuestionResponse 
	{
		private var q:String;
		private var a:String;
		
		public function QuestionResponse(question:String, answer:String):void
		{
			q = question;
			a = answer;
		}
		
		public function question(question:String = null):String
		{
			if (question != null) q = question;
			return q;
		}
		
		public function answer(answer:String = null):String
		{
			if (answer != null) a = answer;
			return a;
		}
	}

}