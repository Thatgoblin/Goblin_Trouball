package
{
	import lvl.*;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	import org.flixel.plugin.photonstorm.BaseTypes.*;
	import flash.utils.getDefinitionByName;
	import flash.utils.Dictionary;

	public class PlayState extends FlxState
	{
		
		//HUD Elements
		private var orbCount:FlxText;
		private var helpText:FlxText;
		private var elapsedText:FlxText;
		private var orbSprite:OrbShard;
		private var camera:FlxCamera;
		private var healthBar:FlxBar;
		private var heart:FlxSprite;
		private var totalTime:Number;
		private var transitionNum:Number = 1;
		private var masterLayer:FlxGroup;
		private var playerDead:Boolean = false;
		private var playerWin:Boolean = false;
		
		//Level variables
		private var currentLevel:Level;
		private var currentLevelNum:Number = 1;
		private var nextLevel:Level;
		private var nextLevelNum:Number = 2;
		private var previousLevel:Level;
		private var previousLevelNum:Number = 0;
		
		//Misc
		private var worldBoundsRect:FlxRect;
		private var emitters:FlxGroup;

		override public function create():void
		{
			
			
			//DEBUG
			//FlxG.debug = true;
			//FlxG.visualDebug = true;
			
			//creating registry managers
			Registry.player = new Player(60, 140);
			Registry.collectibles = new Collectibles();
			Registry.enemies = new EnemyManager();
			Registry.maps = new MapManager();
			Registry.sounds = new SoundManager();
			
			//initializing level
			currentLevel = new Level1();
			
			//set background color
			FlxG.bgColor = 0xff8bd6e6;
			
			//total time set up
			totalTime = 0;
			
			masterLayer = new FlxGroup();
			
			//creates background
			masterLayer.add(Registry.maps.backgroundMap1);
			masterLayer.add(Registry.maps.backgroundMap2);
			masterLayer.add(Registry.maps.backgroundMap3);
			masterLayer.add(Registry.maps.backgroundMap4);
			masterLayer.add(Registry.maps.backgroundMap5);
			Registry.maps.backgroundMap2.exists = false;
			Registry.maps.backgroundMap3.exists = false;
			Registry.maps.backgroundMap4.exists = false;
			Registry.maps.backgroundMap5.exists = false;
			
			
			//creates tilemap
			masterLayer.add(Registry.maps.map);
			
			
			//creates enemies
			masterLayer.add(Registry.enemies.enemies);
			
			//creates orb shards
			masterLayer.add(Registry.collectibles.orbShards);
			
			//creates health pickups
			masterLayer.add(Registry.collectibles.healthPickups);
			
			//adds oraclus projectiles
			masterLayer.add(Registry.enemies.oraclusParticles);
			
			//creates player
			masterLayer.add(Registry.player);
			
			//creates attack sprite
			masterLayer.add(Registry.player.attack);
			masterLayer.add(Registry.player.projectiles);
			
			//creates emitter group
			emitters = new FlxGroup();
			masterLayer.add(emitters);
			
			//starts BG music
			FlxG.playMusic(Registry.sounds.musicBackground, 0.75);
			
			//***VIEW***
			
			//orb counter 
			orbSprite = new OrbShard(0.2, 2.2);
			orbSprite.scrollFactor.x = orbSprite.scrollFactor.y = 0;
			masterLayer.add(orbSprite);
			orbCount = new FlxText(8, 20, 80);
			orbCount.shadow = 0xff000000;
			orbCount.text = "X " + Registry.collectibles.collectedOrbShards.toString();
			orbCount.scrollFactor.x = orbCount.scrollFactor.y = 0;
			masterLayer.add(orbCount);
			
			//help text
			helpText = new FlxText(120, 2, 150);
			helpText.shadow = 0xff000000;
			helpText.text = "";
			helpText.scrollFactor.x = helpText.scrollFactor.y = 0;
			masterLayer.add(helpText);
			
			//help text
			elapsedText = new FlxText(2, 226, 100);
			elapsedText.shadow = 0xff000000;
			elapsedText.text = "0";
			elapsedText.scrollFactor.x = elapsedText.scrollFactor.y = 0;
			masterLayer.add(elapsedText);
			
			//health bar
			heart = new FlxSprite(2, 2, Registry.heartPNG);
			healthBar = new FlxBar(2, 2, FlxBar.FILL_LEFT_TO_RIGHT, 100, 20);
			healthBar.createImageBar(null, Registry.heartPNG, 0x0);
			healthBar.setRange(0, 5);
			healthBar.currentValue = 5;
			healthBar.scrollFactor.x = healthBar.scrollFactor.y = 0;
			masterLayer.add(healthBar);
			
			//camera settings
			camera = new FlxCamera(0, 0, 320, 240, 2);
			camera.setBounds(0, 240, 1920, 0);
			FlxG.addCamera(camera);
			camera.follow(Registry.player, FlxCamera.STYLE_PLATFORMER);
			
			//area that checks collisions on update()
			//change this to update what the camera shows if fps problems occur
			worldBoundsRect = new FlxRect(0, 0, 1920, 240); 
			FlxG.worldBounds = worldBoundsRect;
			
			add(masterLayer);
		}

		override public function update():void
		{	
			
			
			//updates the game
			super.update();
			
			//collisions
			FlxG.collide(Registry.player, Registry.maps.map);
			FlxG.collide(Registry.player.projectiles, Registry.maps.map);
			FlxG.collide(Registry.enemies.enemies, Registry.maps.map);
			FlxG.collide(Registry.enemies.enemies, Registry.enemies.enemies);
			FlxG.collide(Registry.collectibles.healthPickups, Registry.maps.map);
			FlxG.overlap(Registry.player, Registry.collectibles.healthPickups, overlapPlayerHealth);
			FlxG.overlap(Registry.player, Registry.collectibles.orbShards, overlapPlayerOrbShard);
			FlxG.overlap(Registry.player, Registry.enemies.enemies, overlapPlayerEnemy);
			FlxG.overlap(Registry.player.attack, Registry.enemies.enemies, overlapAttackEnemy);
			FlxG.overlap(Registry.player.projectiles, Registry.enemies.enemies, overlapProjectileEnemy);
			FlxG.overlap(Registry.player.projectiles, Registry.maps.map, overlapProjectileMap);
			FlxG.overlap(Registry.player, Registry.enemies.oraclusParticles, overlapPlayerEnemy);
			
			//updating text
			orbCount.text = "X " + Registry.collectibles.collectedOrbShards.toString();
			
			totalTime += FlxG.elapsed;
			elapsedText.text = "Time: " + FlxU.floor(totalTime).toString();
			
			//if player is dead, restart by pressing space
			if (FlxG.keys.SPACE && Registry.player.alive == false)
			{
				reset();
			}
			
			//If player has beaten all levels
			//press space to return to main menu
			if (FlxG.keys.SPACE && playerWin == true)
			{
				FlxG.switchState(new MenuState);
			}
			
			//if player falls under the map, they die
			if (Registry.player.y > 240)
			{
				Registry.player.health = 0;
				healthBar.currentValue = 0;
				Registry.player.attack.kill();
				Registry.player.kill();
				FlxG.music.stop();
				playerDead = true;
				helpText.text = "Game Over, press Space to restart!";
			}
			
			if (Registry.player.x > 1910 && nextLevelNum >= 9)
			{
				helpText.text = "You win! Press Space to return to the main menu.";
				playerWin = true;
			}
			if (Registry.player.x > 1910 && nextLevelNum <= 8)
			{
				transitionNum = 1;
				transitionLevel(nextLevelNum, 40, 140);
			}
			else if (Registry.player.x < 10 && previousLevelNum >= 1)
			{
				transitionNum = 0;
				transitionLevel(previousLevelNum, 1840, 140);
			}
		}

		//if player and orb shard overlap each other
		private function overlapPlayerOrbShard(player:Player, shard:OrbShard):void
		{
			if (FlxCollision.pixelPerfectCheck(player, shard))
			{
				shard.kill();
				Registry.collectibles.collectedOrbShards++;
				FlxG.play(Registry.sounds.soundOrbPickup, 0.4);
			}
		}
		
		//if player and enemy overlap
		private function overlapPlayerEnemy(player:Player, enemy:FlxSprite):void
		{
			var collision:Boolean = FlxCollision.pixelPerfectCheck(player, enemy);
			
			if (player.flickering == false && collision == true && player.health < 2)
			{
				player.health--;
				healthBar.currentValue--;
				player.kill();
				FlxG.play(Registry.sounds.soundEnemyHit);
				FlxG.music.stop();
				playerDead = true;
				helpText.text = "Game Over, press Space to restart!";
			}
			else if (player.flickering == false && collision == true && player.health > 1)
			{
				player.health--;
				healthBar.currentValue--;
				player.flicker(1);
				FlxG.play(Registry.sounds.soundEnemyHit);
			}
			
		}
		
		//if player's attack sprite overlaps an enemy
		private function overlapAttackEnemy(attack:FlxSprite, enemy:FlxSprite):void
		{
			if (FlxCollision.pixelPerfectCheck(attack, enemy))
			{
				var emitter:FlxEmitter = createEmitter();
				
				if (Math.ceil((Math.random()*3 + 1)) == 3)
				{
					Registry.collectibles.createHealthPickup(enemy.x, enemy.y);
				}
				
				
				
				emitter.at(enemy);
				enemy.kill();
				FlxG.play(Registry.sounds.soundPlayerHit, 1);
			}
		}
		
		public function overlapPlayerHealth(player:Player, health:HealthPickup):void
		{
			if (player.health < 5)
			{
				player.health++;
				healthBar.currentValue++;
			}
			
			FlxG.play(Registry.sounds.soundHealthPickup, 1);
			health.kill();
		}
		
		private function overlapProjectileEnemy(projectile:FlxSprite, enemy:FlxSprite):void
		{
			if (Math.ceil((Math.random()*3 + 1)) == 3)
			{
					Registry.collectibles.createHealthPickup(enemy.x, enemy.y);
			}
				
			projectile.kill();
			Registry.player.projectiles.remove(projectile);
			FlxG.play(Registry.sounds.soundPlayerHit, 1);
			enemy.kill();
		}
		
		private function overlapProjectileMap(projectile:FlxSprite, map:FlxTilemap):void
		{
			if (projectile.isTouching(FlxObject.WALL))
			{
				projectile.kill();
				Registry.player.projectiles.remove(projectile);
			}
		}
		
		//this function will create an emitter at the location specified
		private function createEmitter():FlxEmitter
		{
			[Embed(source = '../assets/deathParticle.png')] var deathParticlePNG:Class;
			var emitter:FlxEmitter = new FlxEmitter();

			emitter.gravity = -200;
			emitter.lifespan = 1;
			emitter.bounce = 2;
			emitter.setXSpeed(-50, 50);
			emitter.setYSpeed(-50, 0);
			
			emitter.makeParticles(deathParticlePNG, 8, 8, false, 0.8);
			
			emitter.start();
			emitters.add(emitter);
			return emitter;
		}
		
		//restarts the level
		private function reset():void
		{
			Registry.player.health = 5;
			healthBar.currentValue = 5;
			helpText.text = "";
			transitionNum = 2;
			transitionLevel(currentLevelNum, 40, 140);		
			
		}

		private static var randomstatic:Level2;
		private static var randomstatic2:Level3;
		private static var randomstatic3:Level4;
		private static var randomstatic4:Level5;
		private static var randomstatic5:Level6;
		private static var randomstatic6:Level7;
		private static var randomstatic7:Level8;
		
		//transition to level specified in parameter
		private function transitionLevel(nextLevelNumber:Number, px:Number, py:Number):void
		{
			var transitionLevel:Level;
			
			transitionLevel = currentLevel;
			
			//previous level
			//NEEDS IF STATEMENT FOR TRANSITIONING
			//FORWARD OR BACK
			//forward = 1
			//backwards = 0
			if (transitionNum == 1)
			{
				previousLevel = currentLevel;
				previousLevelNum = currentLevelNum;
				
				//current level
				currentLevelNum = nextLevelNum;
				
				//next level
				nextLevelNum = currentLevelNum + 1;
			}
			else if (transitionNum == 0)
			{
				nextLevel = currentLevel;
				nextLevelNum = currentLevelNum;
				
				//current level
				currentLevelNum = previousLevelNum;
				
				//next level
				previousLevelNum = currentLevelNum - 1;
			}
			else
			{
				
			}
			
			//clears all current level assets
			Registry.maps.backgroundMap1.exists = false;
			Registry.maps.backgroundMap2.exists = false;
			Registry.maps.map.exists = false;
			Registry.maps.map = null;
			Registry.enemies.enemies.exists = false;
			Registry.enemies.enemies = null;
			Registry.enemies.oyos.exists = false;
			Registry.enemies.oyos = null;
			Registry.enemies.oraclus.exists = false;
			Registry.enemies.oraclus = null;
			Registry.enemies.oraclusParticles.exists = false;
			Registry.enemies.oraclusParticles = null;
			Registry.enemies.oraclusParticlesReset();
			Registry.collectibles.orbShards.exists = false;
			Registry.collectibles.orbShards = null;
			Registry.collectibles.healthPickups.exists = false;
			Registry.collectibles.healthPickups = null;
			Registry.maps.map = null;
			Registry.player.attack.exists = false;
			Registry.player.attack = null;
			Registry.player.projectiles.exists = false;
			Registry.player.projectiles = null;
			Registry.player.exists = false;
			Registry.player = null;
			
			//Removal from the master layer
			masterLayer.remove(orbCount);
			masterLayer.remove(helpText);
			masterLayer.remove(elapsedText);
			masterLayer.remove(healthBar);
			masterLayer.remove(orbSprite);
			masterLayer.remove(emitters);
			masterLayer.remove(Registry.enemies.oraclusParticles);
			
			
			
			//Registry.player.attack = null;
			Registry.enemies.resetGroups();
			Registry.collectibles.resetHealth();
			
			currentLevel = null;
			var newLevel:Class = GetLevelClassFromName(nextLevelNumber.toString()) as Class;
			currentLevel = new newLevel();
			
			//creates new player
			Registry.player = new Player(px, py);
			
			//resets health bar
			healthBar.currentValue = Registry.player.health;
			
			//adds new level's assets
			masterLayer.add(Registry.maps.map);
			masterLayer.add(Registry.enemies.enemies);
			masterLayer.add(Registry.collectibles.orbShards);
			masterLayer.add(Registry.collectibles.healthPickups);
			masterLayer.add(Registry.enemies.oraclusParticles);
			masterLayer.add(Registry.player);
			masterLayer.add(Registry.player.attack);
			masterLayer.add(Registry.player.projectiles);
			masterLayer.add(orbCount);
			masterLayer.add(elapsedText);
			masterLayer.add(helpText);
			masterLayer.add(healthBar);
			masterLayer.add(orbSprite);
			masterLayer.add(emitters);
			masterLayer.add(Registry.enemies.oraclusParticles);
			
			camera.follow(Registry.player, FlxCamera.STYLE_PLATFORMER);
			
			//changes background art
			if ((currentLevelNum == 2) || (currentLevelNum == 8))
			{
				Registry.maps.backgroundMap2.exists = true;
				
				Registry.maps.backgroundMap1.exists = false;
				Registry.maps.backgroundMap3.exists = false;
				Registry.maps.backgroundMap4.exists = false;
				Registry.maps.backgroundMap5.exists = false;
			}
			else if ((currentLevelNum == 3) || (currentLevelNum == 5))
			{
				Registry.maps.backgroundMap4.exists = true;
				
				Registry.maps.backgroundMap2.exists = false;
				Registry.maps.backgroundMap3.exists = false;
				Registry.maps.backgroundMap1.exists = false;
				Registry.maps.backgroundMap5.exists = false;
			}
			else if (currentLevelNum == 7)
			{
				Registry.maps.backgroundMap3.exists = true;
				
				Registry.maps.backgroundMap2.exists = false;
				Registry.maps.backgroundMap1.exists = false;
				Registry.maps.backgroundMap4.exists = false;
				Registry.maps.backgroundMap5.exists = false;
			}
			else if (currentLevelNum == 5)
			{
				Registry.maps.backgroundMap5.exists = true;
				
				Registry.maps.backgroundMap2.exists = false;
				Registry.maps.backgroundMap3.exists = false;
				Registry.maps.backgroundMap4.exists = false;
				Registry.maps.backgroundMap1.exists = false;
			}
			else
			{
				Registry.maps.backgroundMap1.exists = true;
				
				Registry.maps.backgroundMap2.exists = false;
				Registry.maps.backgroundMap3.exists = false;
				Registry.maps.backgroundMap4.exists = false;
				Registry.maps.backgroundMap5.exists = false;
			}
			
			//restarts music
			if (playerDead == true)
			{
				playerDead = false;
				FlxG.playMusic(Registry.sounds.musicBackground, 0.75);
			}
		}
		
		public function GetLevelClassFromName(name:String):Class
		{
			try
			{
				var className:String = "lvl.Level" + name;
				var ClassReference:Class = getDefinitionByName( className ) as Class;
				return ClassReference;
			}
			catch ( error:Error)
			{
			}
			return null;
		}
	}
}