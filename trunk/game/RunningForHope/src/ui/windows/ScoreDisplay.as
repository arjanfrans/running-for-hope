package ui.windows
{
	import actions.Action;
	
	import audio.Audio;
	
	import citrus.core.CitrusEngine;
	
	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.display3D.textures.Texture;
	import flash.filters.*;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	
	import game.GameState;
	
	import starling.display.Image;
	import starling.text.TextField;
	
	import ui.menus.MenuState;

	public class ScoreDisplay extends InfoWindow
	{
		public function ScoreDisplay()
		{
			super();
			super.closeFunc = close;
			Audio.setState("mute_background");
			
			// Add the title last
			var title:Image = Assets.getImage("Interface", "LevelCompleted");
			addChild(title);
			title.y = -10;
			
			var rank:int = Main.getModel().getLevel().highscores().submitScore();
			var text:TextField;
			if(rank === -1) {
				text = new TextField(345, 40, "You didn't manage to get a high-score.", "Arial", 16);
				Main.audio.playSound("win_no_hs");
			}
			else {
				var rankTxt:String = "" + rank;
				switch(rank) {
					case 1: rankTxt += "st"; break;
					case 2: rankTxt += "nd"; break;
					case 3: rankTxt += "rd"; break;
					default: rankTxt += "th"; break;
				}
				text = new TextField(345, 40, "You ranked " + rankTxt, "Arial", 24);
				Main.audio.playSound("win_hs");
			}
			appendChild(text, 10);
			if(rank > 1) {
				appendChild(new TextField(345, 50, "To get the highscore you need\n" + "to be a little faster still!", "Arial", 16), 10);
			}
			
			var closeText:TextField = new TextField(345, 20, "Press Enter to continue", "Arial", 12);
			appendChild(closeText, 10);
		}
		
		private function close():void
		{		
			(Main.getState() as GameState).closePopup();
			(Main.getState() as GameState).openPopup(new LevelSummary());
			
			// Change level
			//check whether there are any levels left after this one and increase level counter.
/*			if(Main.getModel().level + 1 >= Main.getModel().numLevels()) {
				//go to main menu
				Main.setState(new MenuState());
				return;
			}
			//load next level.
			Main.getModel().level++;
			Main.setState(new GameState());*/
		}
		
	}
}