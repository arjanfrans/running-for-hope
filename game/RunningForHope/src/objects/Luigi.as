package objects
{
	import citrus.objects.NapePhysicsObject;
	import citrus.objects.platformer.nape.Hero;
	import citrus.objects.platformer.nape.Platform;
	import citrus.physics.nape.NapeUtils;
	import citrus.view.starlingview.AnimationSequence;
	
	import nape.callbacks.InteractionCallback;
	import nape.geom.Vec2;
	import nape.phys.Body;
	import nape.shape.Polygon;
	import nape.shape.Shape;
	
	import starling.textures.TextureAtlas;
	
	public class Luigi extends Hero
	{
		private static var seq:AnimationSequence;
		private var texture_height:Number;
		private var texture_height_duck:Number;
		private var duckShape:Polygon;
		private var normalShape:Polygon;
		private var isDuckShape:Boolean = false;
		
		public function Luigi(name:String, params:Object=null)
		{
			super(name, params);
			var ta:TextureAtlas = Assets.getAtlas("LuigiAnimation");
			seq = new AnimationSequence(ta, ["walk", "idle", "duck", "hurt", "jump"], "idle", 60);
			this.texture_height = this.height;
			this.texture_height_duck = seq.mcSequences["duck"].height;
			duckShape = new Polygon(Polygon.box(this.width, texture_height_duck), _material)
			this.view = seq;
			normalShape = new Polygon(Polygon.box(this.width, this.height), _material);
			this._shape = normalShape;
			//this.acceleration = 3;
		}		
		
		
		/*protected function createShape():void {
		
		// Used by the Tiled Map Editor software, if we defined a polygon/polyline
		if (points && points.length > 1) {
		
		var verts:Vec2List = new Vec2List();
		for each (var point:Object in points)
		verts.push(new Vec2(point.x as Number, point.y as Number));
		
		var polygon:Polygon = new Polygon(verts, _material);
		var validation:ValidationResult = polygon.validity();
		
		if (validation == ValidationResult.VALID)
		_shape = polygon;
		
		else if (validation == ValidationResult.CONCAVE) {
		
		var concave:GeomPoly = new GeomPoly(verts);
		var convex:GeomPolyList = concave.convexDecomposition();
		convex.foreach(function(p:GeomPoly):void {
		_body.shapes.add(new Polygon(p));
		});
		return;
		
		} else
		throw new Error("Invalid polygon/polyline");
		
		} else {
		
		if (_radius != 0)
		_shape = new Circle(_radius, null, _material);
		else
		_shape = new Polygon(Polygon.box(_width, _height), _material);
		}
		
		_body.shapes.add(_shape);
		}*/
		
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			if (_ducking) {
				this.offsetY = (texture_height - texture_height_duck);
				/*				
				if(!this._body.shapes.has(duckShape)) {
				this._body.shapes.remove(normalShape);
				this._body.shapes.add(duckShape);
				}*/
			}
			else {
				if(offsetY != 0) offsetY = 0;
				/*				if(!this._body.shapes.has(normalShape)) {
				this._body.shapes.remove(duckShape);
				this._body.shapes.add(normalShape);
				}*/
			}
			
		}
		
		override protected function updateAnimation():void 
		{
			var prevAnimation:String = _animation;
			
			//var walkingSpeed:Number = getWalkingSpeed();
			var walkingSpeed:Number = _body.velocity.x; // this won't work long term!
			
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
				//this.y = y + (texture_height - texture_height_duck);
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