package levels.dialog
{
	import model.dialog.Dialog;
	import model.dialog.DialogEntry;
	import model.dialog.DialogLibrary;
	import model.dialog.QuestionResponse;
	import model.dialog.QuestionResponseSet;

	public class Level3Dialog
	{
		private static var loaded:Boolean = false;
		
		public function Level3Dialog()
		{
		}
		
		private static function response(message:String, from:String = "Hope"):DialogEntry
		{
			return new DialogEntry(from, message, "right"); 
		}
		
		public static function load():void
		{
			loaded = true;
		}
	}
}