package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	
	public class Collectibles 
	{
		public var orbShards:FlxGroup;
		public var healthPickups:FlxGroup;
		public var collectedOrbShards:Number = 0;
		
		public function Collectibles() 
		{
			orbShards = new FlxGroup();
			healthPickups = new FlxGroup();
		}
		
		public function parseOrbShards(orbShardsGroup:FlxGroup, orbShardsMap:FlxTilemap):void
		{
			for (var ty:int = 0; ty < orbShardsMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < orbShardsMap.widthInTiles; tx++)
				{
					if (orbShardsMap.getTile(tx, ty) == 1)
					{
						orbShardsGroup.add(new OrbShard(tx, ty));
					}
				}
			}
			
			orbShards = orbShardsGroup;
		}
		
		public function createHealthPickup(x:Number, y:Number):void
		{
			healthPickups.add(new HealthPickup(x, y));
		}
		
		public function resetHealth():void
		{
			healthPickups = new FlxGroup();
		}
	}

}