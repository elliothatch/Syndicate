package  
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*
	[SWF(width = "640", height = "480", backgroundColor = "#00000000")]
	[Frame(factoryClass="Preloader")]
	
	public class Syndicate extends FlxGame
	{
	
		public function Syndicate() 
		{
			super(640, 480, PlayState);
		}
		
	}

}