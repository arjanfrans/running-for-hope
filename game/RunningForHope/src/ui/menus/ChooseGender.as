package ui.menus
{
	import starling.display.Sprite;
	import ui.buttons.NumberButton;
	import game.GameState;
	
	public class ChooseGender extends Sprite
	{
		public function ChooseGender() 
		{
			MenuState.setTitle("Are you a boy or a girl?");
			
			var femaleButton:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnPink"), 1, "Girl", btnGirl, 0, 0xFF220022);
			femaleButton.x = 141;
			femaleButton.y = 175;
			
			var maleButton:NumberButton = new NumberButton(Assets.getTexture("Interface", "btnBlue"), 2, "Boy", btnBoy, 0, 0xFF0112233);
			maleButton.x = 141;
			maleButton.y = 350;
			
			addChild(femaleButton);
			addChild(maleButton);
		}
		
		private function btnGirl():void
		{
			//Game.player_gender("f");
			MenuState.openMenu(new ChooseName());
		}
		
		private function btnBoy():void
		{
			//Game.player_gender("m");
			MenuState.openMenu(new ChooseName());
		}
	}
}