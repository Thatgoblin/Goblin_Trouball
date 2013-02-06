package
{
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
 
	public class MenuState extends FlxState
	{
		[Embed(source = '../assets/mainmenu.png')] private var mainMenuPNG:Class;
		[Embed(source = '../assets/menusprite.png')] private var menuSpritePNG:Class;
		private var mainMenu:FlxSprite;
		private var menuSprite:FlxSprite;
		private var helpBackground:FlxSprite;
		private var currentSelection:int = 0;
		private var credits:Boolean = false;
		private var locked:Boolean = false;
		private var helpText:FlxText;
		private var creditsText:FlxText;
		
		override public function create():void
		{
			mainMenu = new FlxSprite(0, 0, mainMenuPNG);
			add(mainMenu);
			
			menuSprite = new FlxSprite(124, FlxG.height - 60, menuSpritePNG);
			add(menuSprite);
			
			helpBackground = new FlxSprite(64, 64);
			helpBackground.makeGraphic(200, 60, 0xdd3d8096);
			add(helpBackground);
			helpBackground.visible = false;
			
			//menu texts
			var title:FlxText;
			title = new FlxText(0, 16, 320, "Goblin Trouball");
			title.setFormat (null, 16, 0xFFFFFFFF, "center", 0xff000000);
			add(title);
 
			var instructions:FlxText;
			instructions = new FlxText(0, FlxG.height - 96, 320, "Start Game");
			instructions.setFormat (null, 8, 0xFFFFFFFF, "center",0xff000000);
			add(instructions);
			
			var instructions3:FlxText;
			instructions3 = new FlxText(0, FlxG.height - 64, 320, "Help");
			instructions3.setFormat (null, 8, 0xFFFFFFFF, "center",0xff000000);
			add(instructions3);
			
			var instructions2:FlxText;
			instructions2 = new FlxText(0, FlxG.height - 32, 320, "About");
			instructions2.setFormat (null, 8, 0xFFFFFFFF, "center",0xff000000);
			add(instructions2);
			
			//help and credit texts
			helpText = new FlxText(66, 76, 200, "Left + Right = Movement" + "                        " 
				+ "Down = Crouch, Z = Jump" + "                          "
				+ "X = Melee Attack, C = Projectile Attack");
			helpText.setFormat (null, 8, 0xFFFFFFFF, "left",0xff000000);
			add(helpText);
			helpText.visible = false;
			
			creditsText = new FlxText(66, 84, 200, "Everything Except Music: That Gobbo Music: Locklear");
			creditsText.setFormat (null, 8, 0xFFFFFFFF, "left",0xff000000);
			add(creditsText);
			creditsText.visible = false;
		}
 
 
		override public function update():void
		{
			super.update(); // calls update on everything you added to the game loop
 
			//navigate menu
			if (FlxG.keys.justPressed("UP") && locked == false)
			{
				if (currentSelection >= 1)
				{
					currentSelection--;
				}
			}
			if (FlxG.keys.justPressed("DOWN") && locked == false)
			{
				if (currentSelection <= 1)
				{
					currentSelection++;
				}
			}
			
			//sprite locations
			if (currentSelection == 2)
			{
				//sprite location
				menuSprite.x = 134;
				menuSprite.y = FlxG.height - 28;
			}
			else if (currentSelection == 1)
			{
				//sprite location
				menuSprite.x = 140;
				menuSprite.y = FlxG.height - 61;
			}
			else if (currentSelection == 0)
			{
				//sprite location
				menuSprite.x = 124;
				menuSprite.y = FlxG.height - 92;
			}
			
			//starting a game
			if ((checkKeys() == true) && currentSelection == 0)
			{
				FlxG.switchState(new PlayState());
			}
			//help
			else if ((checkKeys() == true) && currentSelection == 1)
			{
				if (locked == false)
				{
					helpBackground.visible = true;
					helpText.visible = true;
					locked = true;
				}
				else
				{
					helpBackground.visible = false;
					helpText.visible = false;
					locked = false;
				}
			}
			//credits
			else if ((checkKeys() == true) && currentSelection == 2)
			{
				if (locked == false)
				{
					helpBackground.visible = true;
					creditsText.visible = true;
					locked = true;
				}
				else
				{
					helpBackground.visible = false;
					creditsText.visible = false;
					locked = false;
				}
			}
		}
 
 
		public function MenuState()
		{
			super();
 
		} 
		
		private function checkKeys():Boolean
		{
			if (FlxG.keys.justPressed("Z") || FlxG.keys.justPressed("X") || FlxG.keys.justPressed("SPACE"))
			{
				return true;
			}
			else
			{
				return false;
			}
		}
 
	}
}