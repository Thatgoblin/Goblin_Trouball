package  
{
	import org.flixel.FlxSound;
	
	public class SoundManager 
	{
		[Embed(source = '../assets/jump.mp3')] public var soundJump:Class;
		[Embed(source = '../assets/enemyhit.mp3')] public var soundEnemyHit:Class;
		[Embed(source = '../assets/playerhit.mp3')] public var soundPlayerHit:Class;
		[Embed(source = '../assets/orbpickup.mp3')] public var soundOrbPickup:Class;
		[Embed(source = '../assets/healthpickup.mp3')] public var soundHealthPickup:Class;
		[Embed(source = '../assets/gobbosong.mp3')] public var musicBackground:Class;
		
		
		public var jumpSound:FlxSound;
		
		public function SoundManager() 
		{
			jumpSound = new FlxSound();
			jumpSound.loadEmbedded(soundJump);
		}
		
	}

}