package  
{
	import org.flixel.*;
	
	public class Projectile extends FlxSprite
	{
		
		public function Projectile(x:Number,y:Number, direction:int) 
		{
			super(x + (10*direction), y + 20);
			
			//x velocity
			if (direction == -1)
			{
				velocity.x = -200;
			}
			else
			{
				velocity.x = 200;
			}
			
			loadGraphic(Registry.attackProjectilePNG, true, false, 8, 8);
			addAnimation("idle", [0, 1, 2], 10, true);
		}
		
		override public function update():void
		{
			play("idle");
			
			if (((this.x - Registry.player.x) > 200) || ((this.x - Registry.player.x) < -200))
			{
				this.kill();
				Registry.player.projectiles.remove(this);
			}
			
			super.update();
		}
		
	}

}