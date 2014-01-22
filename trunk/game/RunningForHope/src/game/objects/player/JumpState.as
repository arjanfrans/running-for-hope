package game.objects.player
{
	import citrus.core.CitrusEngine;
	import citrus.input.Input;
	import citrus.objects.NapePhysicsObject;
	
	import flash.globalization.LastOperationStatus;
	
	import game.objects.Player;
	
	import model.Model;
	
	import nape.dynamics.Arbiter;
	import nape.dynamics.ArbiterList;
	import nape.geom.Vec2;
	import nape.phys.Body;
	
	import starling.animation.DelayedCall;
	import starling.animation.Tween;
	import starling.core.Starling;
	
	import ui.menus.MenuState;
	
	public class JumpState implements PlayerState
	{
		private var _hero:Player;
		private var jump_triggered:Boolean;
		private var _onGround:Boolean = false;
		private var _wallJumpFlag:Boolean;
		private var _lastWallJumped:NapePhysicsObject = null;
		private var wallJumpCount:int = 0;
		private var oldVelocity:Number;
		
		public function JumpState(hero:Player)
		{
			_hero = hero;
		}
		
		public function init():void
		{
			_hero.onJump.dispatch();
			jump_triggered = true;
			_onGround = false;
			_wallJumpFlag = false;
			_lastWallJumped = null;
			wallJumpCount = 0;
			oldVelocity = _hero.body.velocity.x;
			Main.audio.playSound("jump");
			_hero.view.pivotX = 25;
		}
		
		public function update(timeDelta:Number, velocity:Vec2, input:Input):void
		{
			var moveKeyPressed:Boolean = false;
	
			if(_hero.touchingWall && !_wallJumpFlag) {
				var wh:Number = _hero.lastWallContact.body.bounds.height;
				var wy:Number = _hero.lastWallContact.body.position.y + wh/2;
				var hy:Number = _hero.body.bounds.y;
				var hh:Number = _hero.body.bounds.height;
				var allowJump:Boolean = false;
				
				//TODO fix walljumping
				allowJump = hy > (wy - wh) + (hh/2) ? true : false;
				//trace(_wallJumpFlag);
				//trace(wy - wh, hy, wh, wy);

				if(allowJump && wh > 64 && velocity.y < 100 && Math.abs(oldVelocity) > 100) {
					if((_hero.faceRight && _hero.lastWallContact.body.position.x >= _hero.body.position.x) 
						|| (!_hero.faceRight && _hero.lastWallContact.body.position.x <= _hero.body.position.x)) {
						
						_wallJumpFlag = true;
						Starling.juggler.add(new DelayedCall(function():void {
							_wallJumpFlag = false;
						}, 0.1));
					}
				}
			}
			
			if((input.justDid("jump", _hero.inputChannel) || input.justDid("up", _hero.inputChannel))) jump_triggered = false;
			
			if (wallJumpCount == 0 && input.isDoing("right", _hero.inputChannel))
			{
				velocity.x += _hero.air_acceleration;
				moveKeyPressed = true;
			}
			
			if (wallJumpCount == 0 && input.isDoing("left", _hero.inputChannel))
			{
				velocity.x -= _hero.air_acceleration;
				moveKeyPressed = true;
			}
			
			if(_onGround && _hero.onGround) {
				if(input.isDoing("right", _hero.inputChannel) || input.isDoing("left", _hero.inputChannel)) {
					_hero.state = _hero.walkState;
					moveKeyPressed = true;
					
				}
				else {
					_hero.state = _hero.idleState;
				}
			}
			
			//If player just started moving the hero this tick.
			if (moveKeyPressed && !_hero.playerMovingHero)
			{
				_hero.playerMovingHero = true;
				_hero.material.dynamicFriction = 0; //Take away friction so he can accelerate.
				_hero.material.staticFriction = 0;
			}
				//Player just stopped moving the hero this tick.
			else if (!moveKeyPressed && _hero.playerMovingHero)
			{
				_hero.playerMovingHero = false;
				_hero.material.dynamicFriction = _hero.dynamicFriction; //Add friction so that he stops running
				_hero.material.staticFriction = _hero.staticFriction;
			}
			
			//Wall jumping
			//trace(_hero.touchingWall); //velocity.y < 100 && Math.abs(_hero.oldVelocity.x) > 100 && && input.isDoing("jump", _hero.inputChannel) && !_hero.onGround && !jump_triggered
			//&& !jump_triggered 
			//trace(Math.abs(oldVelocity));
			if (_wallJumpFlag && (input.isDoing("jump", _hero.inputChannel) || input.isDoing("up", _hero.inputChannel)))
			{			
				if(_lastWallJumped == null || _lastWallJumped != _hero.lastWallContact) {
					if(wallJumpCount == 0) Main.audio.playSound("wall_jump");
					else if(wallJumpCount == 1) Main.audio.playSound("wall_jump_1");
					else Main.audio.playSound("wall_jump_2");
					
					velocity.y = -_hero.jumpHeight; //Math.max(velocity.y - 200, -_hero.jumpHeight);
					velocity.x = _hero.faceRight ? -180 : 180;
					_hero.touchingWall = false;
					jump_triggered = true;
					_lastWallJumped = _hero.lastWallContact;
					wallJumpCount++;
				}
			}
			
			//Cap velocities
			if (velocity.x > (_hero.maxVelocity))
				velocity.x = _hero.maxVelocity;
			else if (velocity.x < (-_hero.maxVelocity))
				velocity.x = -_hero.maxVelocity;
			
			_onGround = _hero.onGround;
		}
		
		public function updateAnimation():void
		{
			_hero.animation = "jump";
		}
		
		
	}
}