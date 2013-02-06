package
{
import org.flixel.*;
import org.flixel.plugin.photonstorm.*;

public class Player extends FlxSprite
	{		
	[Embed(source = '../assets/player.png')]private var ImgPlayer:Class;

	
	public var attack:FlxSprite;
	public var projectiles:FlxGroup;
	private var attackTimer:Number = 0.7;
	private var _crouching:Boolean = false;
	
		public function Player(px:Number, py:Number):void
		{
			projectiles = new FlxGroup(3);
			
			//sprite settings
			this.x = px;
			this.y = py;
			health = 5;
			
			//adds sprite animation
			loadGraphic(ImgPlayer, true, true, 28, 40);
			addAnimation("idle", [0], 30);
			addAnimation("walk", [0, 1, 2], 10, true);
			addAnimation("jump", [3], 1, true);
			addAnimation("attack", [6, 5, 4, 5, 6, 0], 10);
			addAnimation("crouch", [7], 30, true);
			
			width = 14;
			centerOffsets();
			
			//adds attack sprite
			attack = new FlxSprite(0, -50);
			attack.loadGraphic(Registry.attackPNG, false, true);
			attack.exists = false;
			
			//plugin
			if (FlxG.getPlugin(FlxControl) == null)
			{
				FlxG.addPlugin(new FlxControl);
			}
			
			//controls
			FlxControl.create(this, FlxControlHandler.MOVEMENT_ACCELERATES, FlxControlHandler.STOPPING_DECELERATES, 1, true, false);
			FlxControl.player1.setCursorControl(false, false, true, true);
			FlxControl.player1.setJumpButton("Z", FlxControlHandler.KEYMODE_PRESSED, 200, FlxObject.FLOOR, 250, 200);
			
			//movement speed
			FlxControl.player1.setMovementSpeed(500, 0, 125, 350, 550, 400);
			FlxControl.player1.setGravity(0, 550);
		}
		
		override public function update():void
		{
			super.update();
			
			
			if (FlxG.keys.DOWN){
				crouching = true;
			}
			else 
			{
				crouching = false;
			}
			
			//increment timer
			attackTimer = attackTimer - FlxG.elapsed;
			
			
			
			
			//attack sprite
			if ((attack.visible == true) && (attackTimer <= 0))
			{
				attack.exists = false;
				attackTimer = 0.7;
			}
			
			if (this._facing == RIGHT)
			{
				attack.facing = RIGHT;
				attack.x = this.x + 16;
				attack.y = this.y + 20;
			}
			else if (this._facing == LEFT)
			{
				attack.facing = LEFT;
				attack.x = this.x - 32;
				attack.y = this.y + 20;
			}
			
			//animation events
			if (FlxG.keys.DOWN)
			{
				play("crouch");
			}
			else if (attack.exists == true)
			{
				play("attack");
			}
			else if (this.isTouching(FLOOR) != true)
			{
				play("jump");
			}
			else if (FlxG.keys.LEFT)
			{
				play("walk");
			}
			else if (FlxG.keys.RIGHT)
			{
				play("walk");
			}
			else
			{
				play("idle");
			}
			
			//jump sound event
			if (FlxG.keys.justPressed("Z") && this.isTouching(FLOOR) == true)
			{
				FlxG.play(Registry.sounds.soundJump, 0.4);
			}
			
			//attack event
			if (FlxG.keys.justPressed("X") && _crouching == false)
			{
				attack.exists = true;				
			}
			
			//projectile event
			if (FlxG.keys.justPressed("C") && _crouching == false)
			{
				if (this.facing == LEFT)
				{
					projectiles.add(new Projectile(this.x, this.y, -1));
				}
				else
				{
					projectiles.add(new Projectile(this.x, this.y, 1));
				}
				
				play("attack");
			}
		}
		
		private function set crouching(value:Boolean):void 
		{
		if (_crouching == value) return;
			_crouching = value;		
		//Collision box adjustments
		if (_crouching) {
			height = 20;
			offset.y = 20;
			y += 20;
		}
		else {
			height = 40;
			offset.y = 0;
			y -= 20;
	}
}
	}
}