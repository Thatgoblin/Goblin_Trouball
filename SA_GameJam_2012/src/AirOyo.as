package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	
	public class AirOyo extends FlxSprite
	{
		[Embed(source = '../assets/airOyos.png')] private var enemyPNG:Class;
		
		private var originPoint:FlxPoint;
		private var pointA:FlxPoint;
		private var pointB:FlxPoint;
		
		private var toA:Boolean;
		private var toB:Boolean;
		private var chasePlayer:Boolean;
		
		public function AirOyo(x:Number, y:Number) 
		{
			super(x * 16, y * 16);
			
			//load graphics
			loadGraphic(enemyPNG, true, true, 24, 16);
			addAnimation("idle", [0, 1, 2, 1], 10, true);
			
			//patrol pathing
			originPoint = new FlxPoint(x * 16 ,y * 16);
			pointA = new FlxPoint(originPoint.x - 48, y);
			pointB = new FlxPoint(originPoint.x + 60, y);
			
			//booleans
			toA = true;
			toB = false;
			chasePlayer = false;
		}
		
		override public function update():void
		{
			play("idle");
			
			if (chasePlayer == true)
			{
				FlxVelocity.moveTowardsObject(this, Registry.player, 35);
			}
			else
			{
				if ((toB == true) && chasePlayer == false)
				{
					if (this.x > originPoint.x + 48)
					{
						toA = true;
						toB = false;
					}
					else if (this.x < originPoint.x + 48)
					{
						FlxVelocity.moveTowardsPoint(this, pointB, 40);
					}
				}
			
				if ((toA == true) && (chasePlayer == false))
				{
					if ((this.x >= pointA.x))
					{
						FlxVelocity.moveTowardsPoint(this, pointA, 40);
					}
					else if (this.x < pointA.x)
					{
						toA = false;
						toB = true;
					}
				}
			}
			
			if ((chasePlayer == false) && ((this.x - Registry.player.x < 10) || (Registry.player.x - this.x > 10)))
			{
				toA = false;
				toB = false;
				chasePlayer = true;
			}
			
			
			
		}
	}

}