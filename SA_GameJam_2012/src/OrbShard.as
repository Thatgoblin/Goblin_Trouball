package
{
import org.flixel.*;
import org.flixel.plugin.photonstorm.*;

public class OrbShard extends FlxSprite
	{		
	[Embed(source = '../assets/shardanimation.png')]private var ImgShard:Class;
	
		public function OrbShard(x:Number, y:Number):void
		{
			super(x * 7, y * 10);
			loadGraphic(ImgShard, true, false, 7, 10);
			addAnimation("idle", [0, 1, 2, 3], 30, true);
			
		}
		
		override public function update():void
		{
			play("idle");
			
			super.update();
		}

	}

}