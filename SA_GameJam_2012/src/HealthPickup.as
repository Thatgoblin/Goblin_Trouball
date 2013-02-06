package
{
import org.flixel.*;
import org.flixel.plugin.photonstorm.*;

public class HealthPickup extends FlxSprite
	{		
	[Embed(source = '../assets/healthsprite.png')]private var ImgHeart:Class;
	
		public function HealthPickup(x:Number, y:Number):void
		{
			super(x, y);
			loadGraphic(ImgHeart, true, false, 9, 8);
			
			velocity.y = -30;
			acceleration.y = 30;
		}
		
		override public function update():void
		{
			super.update();
		}

	}

}