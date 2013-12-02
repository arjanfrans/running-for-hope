package ui.hud {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class HeartsBar extends Sprite{
		
		private var fullHeart:Image;
		private var emptyHeart:Image;
		private var hearts:Array;
		private var numLife:int;
		
		public function HeartsBar() {
			fullHeart =  Assets.getImage("Spritesheet", "FullHeart");
			emptyHeart = Assets.getImage("Spritesheet", "EmptyHeart");
			numLife = 0;
			update();
		}
		
		
		
		public function update():void
		{
			var lives:int = Main.getModel().lifes;
			
			if (lives == numLife) {
				return;
			}
			numLife = lives;
			while (this.numChildren > 0 ) {
				this.removeChildAt(0);
			}
			for(var i:int = 0; i < 5; i++) {
				var img:Image;
				if(lives >= i) {
					img = fullHeart;
				}
				else {
					img = emptyHeart;
				}
				img.x = i * 40;
				addChild(img);
			}
			
			
		}
		
	}
}