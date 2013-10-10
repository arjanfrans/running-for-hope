package objects
{
	import citrus.objects.platformer.nape.Hero;
	import citrus.view.starlingview.AnimationSequence;
	
	import flash.display.Bitmap;
	
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.phys.Material;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	
	public class Luigi extends Hero
	{
		private static var seq:AnimationSequence;
		private var texture_height:Number;
		private var texture_height_duck:Number;
		private var duckBody:Body;
		private var tempBody:Body;
		
		public function Luigi(name:String, params:Object=null)
		{
			super(name, params);
			var ta:TextureAtlas = Assets.getAtlas("LuigiAnimation");
			seq = new AnimationSequence(ta, ["walk", "idle", "duck", "hurt", "jump"], "idle", 60);
			this.texture_height = this.height;
			this.texture_height_duck = seq.mcSequences["duck"].height;
			this.view = seq;
			//this.acceleration = 3;
		}		
		
		override protected function updateAnimation():void 
		{
			var prevAnimation:String = _animation;
			
			//var walkingSpeed:Number = getWalkingSpeed();
			var walkingSpeed:Number = _body.velocity.x; // this won't work long term!

/*			if(!_ducking) {
				this._body = tempBody;
			}*/
			
			if(_hurt) {
				_animation = "hurt";
			}
			else if (!_onGround) {
				
				_animation = "jump";
				
				if (walkingSpeed < -acceleration) {
					_inverted = true;
				}
				else if (walkingSpeed > acceleration) {
					_inverted = false;
				}
			} else if (_ducking) {
				//adjust hero to size of duck texture
				this.y = y + (texture_height - texture_height_duck);
				_animation = "duck";
			}
			else {
				if (walkingSpeed < -acceleration) {
					_inverted = true;
					_animation = "walk";
				} else if (walkingSpeed > acceleration) {
					_inverted = false;
					_animation = "walk";
					
				}
				else {
					_animation = "idle";
				}
			}
			if (prevAnimation != _animation) {
				onAnimationChange.dispatch();
			}
		}
	}
}