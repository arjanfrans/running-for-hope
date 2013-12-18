package ui.menus
{
	import game.GameState;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.HAlign;
	
	import ui.buttons.NumberButton;
	
	public class ChooseGender extends Sprite
	{
		public function ChooseGender() 
		{
			var femaleButton:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPink"), 1, "Girl", btnGirl, 0, 0xFF220022);
			femaleButton.x = 141;
			femaleButton.y = 175;
			
			var maleButton:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnBlue"), 2, "Boy", btnBoy, 0, 0xFF0112233);
			maleButton.x = 141;
			maleButton.y = 350;
			
			addChild(femaleButton);
			addChild(maleButton);
			
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init():void
		{
			MenuState.setTitle("Are you a boy or a girl?", 65, 140, HAlign.CENTER);
		}
		
		private function btnGirl():void
		{
			Main.getModel().player().gender = "Female";
			MenuState.openMenu(new ChooseName());
		}
		
		private function btnBoy():void
		{
			Main.getModel().player().gender = "Male";
			MenuState.openMenu(new ChooseName());
		}
	}
}