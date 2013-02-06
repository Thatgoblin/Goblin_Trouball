package lvl
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxTilemap;
	import org.flixel.system.FlxTile;
	
	public class Level7 extends Level
	{
		[Embed(source = '../../assets/leveldata/Level7/mapCSV_Level7_Level.csv', mimeType = 'application/octet-stream')] public var map1CSV:Class;
		[Embed(source = '../../assets/leveldata/Level7/mapCSV_Level7_OrbShards.csv', mimeType = 'application/octet-stream')] public var map1orbshardsCSV:Class;
		[Embed(source = '../../assets/leveldata/Level7//mapCSV_Level7_Oyos.csv', mimeType = 'application/octet-stream')] public var map1oyosCSV:Class;
		[Embed(source = '../../assets/leveldata/Level7//mapCSV_Level7_airOyos.csv', mimeType = 'application/octet-stream')] public var map1airOyosCSV:Class;
		[Embed(source = '../../assets/leveldata/Level7/mapCSV_Level7_Oraclus.csv', mimeType = 'application/octet-stream')] public var map1oraclusCSV:Class;
		[Embed(source = '../../assets/tiles.png')] private var tilesPNG:Class;
		
		private var map:FlxTilemap;
		private var orbshards:FlxTilemap;
		private var oyos:FlxTilemap;
		private var oraclus:FlxTilemap;
		private var airOyos:FlxTilemap;
		
		private var enemies_local:FlxGroup;
		private var oyos_local:FlxGroup;
		private var airOyos_local:FlxGroup;
		private var oraclus_local:FlxGroup;
		private var orbShards_local:FlxGroup;
		private var map_local:FlxGroup;
		public var masterLayer:FlxGroup;
		
		public function Level7() 
		{
			//initializing local groups
			enemies_local = new FlxGroup();
			oyos_local = new FlxGroup();
			airOyos_local = new FlxGroup();
			oraclus_local = new FlxGroup();
			orbShards_local = new FlxGroup();
			map_local = new FlxGroup();
			masterLayer = new FlxGroup();
			
			//loading tilemaps
			map = new FlxTilemap();
			map.loadMap(new map1CSV, tilesPNG, 16, 16);			
			oyos = new FlxTilemap();
			oyos.loadMap(new map1oyosCSV, tilesPNG, 16, 16);
			airOyos = new FlxTilemap();
			airOyos.loadMap(new map1airOyosCSV, tilesPNG, 16, 16);
			orbshards = new FlxTilemap();
			orbshards.loadMap(new map1orbshardsCSV, tilesPNG, 7, 10);			
			oraclus = new FlxTilemap();
			oraclus.loadMap(new map1oraclusCSV, tilesPNG, 16, 16);
 			
			//parse enemy and orb shard locations
			Registry.enemies.parseOyos(oyos_local, oyos);
			Registry.enemies.parseAirOyos(airOyos_local, airOyos);
			Registry.enemies.parseOraclus(oraclus_local, oraclus);
			Registry.collectibles.parseOrbShards(orbShards_local, orbshards);
			Registry.maps.setMap(map);
			
			//adding local groups to master layer
			enemies_local.add(oyos_local);
			enemies_local.add(airOyos_local);
			enemies_local.add(oraclus_local);
			masterLayer.add(enemies_local);
			masterLayer.add(orbShards_local);
			masterLayer.add(map_local);
		}
		
		public function getTilemap():FlxTilemap
		{
			return map;
		}
		
		public function getOyos():FlxTilemap
		{
			return oyos;
		}
		
		public function getairOyos():FlxTilemap
		{
			return airOyos;
		}
		
		public function getOrbShards():FlxTilemap
		{
			return orbshards;
		}
		
		public function getOraclus():FlxTilemap
		{
			return oraclus;
		}
	}

}