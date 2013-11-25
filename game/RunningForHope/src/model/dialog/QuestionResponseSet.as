package model.dialog 
{
	/**
	 * One full dialog from start to finish
	 * @author Wim Barelds
	 */
	public class QuestionResponseSet 
	{
		private var questionResponses:Vector.<QuestionResponse>;
		public var length:int = 0;
		
		public function QuestionResponseSet() 
		{
			questionResponses = new Vector.<QuestionResponse>();
		}
		
		public function add(val:QuestionResponse):void
		{
			questionResponses.push(val);
			length++;
		}
		
		public function load(index:int):QuestionResponse
		{
			return questionResponses[index];
		}
		
	}

}