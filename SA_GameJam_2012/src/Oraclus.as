package  
{
	import org.flixel.*;
	
	public class Oraclus extends FlxSprite
	{
		[Embed(source = '../assets/oraclus.png')] private var oraclusPNG:Class;
		
		private var attackTimer:Number = 1.5;
		
		public function Oraclus(x:Number,y:Number) 
		{
			super(x * 16, y * 16 - 18);
			
			//load graphics
			loadGraphic(oraclusPNG, true, true, 18, 34);
			addAnimation("idle", [0, 1, 2, 3], 15, true);
			
			
		}
		
		override public function update():void
		{			
			play("idle");
			
			if ((this.x - Registry.player.x < 200) || (Registry.player.x - this.x > 200))
			{
				attackTimer = attackTimer - FlxG.elapsed;
				
				if (attackTimer <= 0)
				{
					Registry.enemies.oraclusFire(Registry.player.x, Registry.player.y + 20, this.x + 9, this.y + 8);
					attackTimer = 3;
				}
			}
		}
		
	}

}