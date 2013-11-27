package ui.hud {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class HeartsBar extends Sprite{
		
		var fullHeart:Texture;
		var emptyHeart:Texture;
		var hearts:Array;
		var numLife:int;
		
		public function HeartsBar() {
			fullHeart =  Assets.getTexture("Spritesheet", "FullHeart");
			emptyHeart = Assets.getTexture("Spritesheet", "EmptyHeart");
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
					img = new Image(fullHeart);
				}
				else {
					img = new Image(emptyHeart);
				}
				img.x = i * 40;
				addChild(img);
			}
			
			
		}
		
	}
}