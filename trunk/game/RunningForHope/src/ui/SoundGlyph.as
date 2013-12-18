package ui
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	
	public class SoundGlyph extends Sprite
	{
		private var img:Image;
		private var ignoreKeyboard:Boolean;
		
		public function SoundGlyph(ignoreKeyboard:Boolean = false)
		{
			super();
			this.ignoreKeyboard = ignoreKeyboard;
			this.touchable = true;
			this.useHandCursor = true;
			
			addEventListener(Event.ADDED_TO_STAGE, init);
			addEventListener(TouchEvent.TOUCH, touch);
		}
		
		private function init():void
		{
			if(!ignoreKeyboard) {
				addEventListener(Event.REMOVED_FROM_STAGE, destroy);
				stage.addEventListener(KeyboardEvent.KEY_UP, keyboardListener);
			}
			redrawSoundGlyph();
			x = stage.width - img.width - 10;
			y = stage.height - img.height - 10;
		}
		
		private function touch(e:TouchEvent):void
		{
			try {
				if (e.getTouch(this).phase == TouchPhase.BEGAN && e.interactsWith(this)) {
					toggle();
				}
			}
			catch(e:Error){}
		}
		
		private function destroy(e:Event):void
		{
			stage.removeEventListener(KeyboardEvent.KEY_UP, keyboardListener);
		}
		
		private function redrawSoundGlyph():void
		{
			if(img !== null) {
				removeChild(img);
			}
			
			var glyph:String = Main.getModel().soundMuted ? "SoundOff" : "SoundOn";
			img = Assets.getImage("Interface", glyph);
			addChild(img);
		}
		
		private function keyboardListener(e:KeyboardEvent):void
		{
			if(e.keyCode === 77) toggle();
		}
		
		private function toggle():void
		{
			Main.getModel().toggleSound();
			redrawSoundGlyph();
		}
		
	}
}