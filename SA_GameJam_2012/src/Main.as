package {
import org.flixel.*;

[SWF(width="640", height="480", backgroundColor="#aaaaaa")]
[Frame(factoryClass="Preloader")]

public class Main extends FlxGame
{
	
	public function Main():void
	{	
	super(1920, 240, MenuState, 2);
	forceDebugger = true;
	}

}

}