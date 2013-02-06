package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.*;
	
	public class EnemyManager 
	{
		[Embed(source = '../assets/oraclusparticle.png')] private var oraclusParticlePNG:Class;
		
		public var oyos:FlxGroup;
		public var oraclus:FlxGroup;
		public var airOyos:FlxGroup;
		public var enemies:FlxGroup;
		public var oraclusParticles:FlxGroup;
		
		public function EnemyManager() 
		{
			//intializing enemies
			oyos = new FlxGroup();
			oraclus = new FlxGroup();
			airOyos = new FlxGroup();
			oraclusParticles = new FlxGroup();
			enemies = new FlxGroup();
		}		
		
		public function resetGroups():void
		{
			oyos = new FlxGroup();
			oraclus = new FlxGroup();
			airOyos = new FlxGroup();
			enemies = new FlxGroup();
		}
		
		public function parseOyos(oyosGroup:FlxGroup, oyosMap:FlxTilemap):void
		{
			for (var ty:int = 0; ty < oyosMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < oyosMap.widthInTiles; tx++)
				{
					if (oyosMap.getTile(tx, ty) == 1)
					{
						oyosGroup.add(new Oyo(tx, ty));
					}
				}
			}
			
			oyos = oyosGroup;
			enemies.add(oyos);
		}
		
		public function parseOraclus(oraclusGroup:FlxGroup, oraclusMap:FlxTilemap):void
		{
			for (var ty:int = 0; ty < oraclusMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < oraclusMap.widthInTiles; tx++)
				{
					if (oraclusMap.getTile(tx, ty) == 1)
					{
						oraclusGroup.add(new Oraclus(tx, ty));
					}
				}
			}
			
			oraclus = oraclusGroup;
			enemies.add(oraclus);
		}
		
		public function parseAirOyos(airOyosGroup:FlxGroup, airOyosMap:FlxTilemap):void
		{
			for (var ty:int = 0; ty < airOyosMap.heightInTiles; ty++)
			{
				for (var tx:int = 0; tx < airOyosMap.widthInTiles; tx++)
				{
					if (airOyosMap.getTile(tx, ty) == 1)
					{
						airOyosGroup.add(new AirOyo(tx, ty));
					}
				}
			}
			
			airOyos = airOyosGroup;
			enemies.add(airOyos);
		}
		
		public function oraclusFire(px:Number, py:Number, ex:Number, ey:Number):void
		{
			var oraclusParticle:FlxSprite = new FlxSprite(ex, ey);
			oraclusParticle.loadGraphic(oraclusParticlePNG, true, false, 6, 6);
			oraclusParticle.addAnimation("idle", [0, 1, 2], 15, true);
			oraclusParticle.play("idle");
			
			FlxVelocity.moveTowardsObject(oraclusParticle, Registry.player, 60);
			
			oraclusParticles.add(oraclusParticle);
		}
		
		public function oraclusParticlesReset():void
		{
			oraclusParticles = new FlxGroup();
		}
		
		//when transitioning to a new level, give current enemy groups to previous level for keeping track of enemies
		public function transitionLevel():void
		{
			
		}
	}

}