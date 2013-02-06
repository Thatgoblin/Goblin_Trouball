package  
{
	import org.flixel.*;
	
	public class MapManager 
	{
		[Embed(source = '../assets/tiles.png')] private var tilesPNG:Class;
		[Embed(source = '../assets/background_map1.png')] private var backgroundmap1PNG:Class
		[Embed(source = '../assets/background_map2.png')] private var backgroundmap2PNG:Class
		[Embed(source = '../assets/background_map3.png')] private var backgroundmap3PNG:Class
		[Embed(source = '../assets/background_map4.png')] private var backgroundmap4PNG:Class
		[Embed(source = '../assets/background_map5.png')] private var backgroundmap5PNG:Class
		
		
		public var map:FlxTilemap;
	
		public var backgroundMap1:FlxSprite;
		public var backgroundMap2:FlxSprite;
		public var backgroundMap3:FlxSprite;
		public var backgroundMap4:FlxSprite;
		public var backgroundMap5:FlxSprite;
		
		public function MapManager() 
		{
			backgroundMap1 = new FlxSprite(0, 0, backgroundmap1PNG);
			backgroundMap1.scrollFactor.x = 0.4;
			
			backgroundMap2 = new FlxSprite(0, 0, backgroundmap2PNG);
			backgroundMap2.scrollFactor.x = 0.4;
			
			backgroundMap3 = new FlxSprite(0, 0, backgroundmap3PNG);
			backgroundMap3.scrollFactor.x = 0.4;
			
			backgroundMap4 = new FlxSprite(0, 0, backgroundmap4PNG);
			backgroundMap4.scrollFactor.x = 0.4;
			
			backgroundMap5 = new FlxSprite(0, 0, backgroundmap5PNG);
			backgroundMap5.scrollFactor.x = 0.4;
		}
		
		public function setMap(newMap:FlxTilemap):void
		{
			map = newMap;
			map.setTileProperties(10, FlxObject.NONE);
			map.setTileProperties(11, FlxObject.UP);
			map.setTileProperties(12, FlxObject.UP);
			map.setTileProperties(13, FlxObject.UP);
			map.setTileProperties(14, FlxObject.UP);
			map.setTileProperties(15, FlxObject.UP);
			map.setTileProperties(23, FlxObject.NONE);
		}
	}

}