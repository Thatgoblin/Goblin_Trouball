package  
{
	import org.flixel.*;
	
	public class Oyo extends FlxSprite
	{
		[Embed(source = '../assets/oyos.png')] private var enemyPNG:Class;
		
		private var moveSpeed:Number = 20;
		
		public function Oyo(x:Number,y:Number) 
		{
			super(x * 16, y * 16);
			
			if (Math.random() * 2 > 1)
			{
				velocity.x = -moveSpeed;
			}
			else
			{
				velocity.x = moveSpeed;
			}
			
			
			//load graphics
			loadGraphic(enemyPNG, true, true, 16, 20);
			addAnimation("idle", [0], 1, true);
			addAnimation("walk", [0, 1, 2, 3, 4, 5, 6], 5, true);
			
			acceleration.y = 200;
		}
		
		override public function update():void
		{			
			if (this.velocity.x == 0)
			{
				play("idle");
			}
			else if(this.velocity.x < 0)
			{
				facing = LEFT;
				play("walk");
			}
			else if (this.velocity.x > 0)
			{
				facing = RIGHT;
				play("walk");
			}
			
			if (!this.isTouching(FlxObject.FLOOR) && facing == LEFT)
			{
				velocity.x = moveSpeed;
			}
			else if (!this.isTouching(FlxObject.FLOOR) && facing == RIGHT)
			{
				velocity.x = -moveSpeed;
			}
			else if (this.isTouching(LEFT))
			{
				velocity.x = moveSpeed;
			}
			else if (this.isTouching(RIGHT))
			{
				velocity.x = -moveSpeed;
			}
		}
		
	}

}