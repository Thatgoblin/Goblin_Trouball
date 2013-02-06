package  
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.*;

	public class Registry 
	{
		[Embed(source = '../assets/heart.png')] public static var heartPNG:Class;
		[Embed(source = '../assets/attack.png')] public static var attackPNG:Class;
		[Embed(source = '../assets/attackprojectile.png')] public static var attackProjectilePNG:Class;
		[Embed(source = '../assets/upgradeshop.png')] public static var upgradeShopPNG:Class;
		

		public static var player:Player;
		
		public static var collectibles:Collectibles;
		
		public static var enemies:EnemyManager;
		
		public static var maps:MapManager;
		
		public static var sounds:SoundManager;
		
		public function Registry() 
		{
		}
	}

}