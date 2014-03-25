package  
{
	/**
	 * ...
	 * @author Elliot
	 */
	import org.flixel.*;
	public class StartMenuState extends FlxState
	{
		private var pressX:FlxText;
		
		
		override public function create():void
		{
			pressX = new FlxText(0, FlxG.stage.stageHeight * 0.9, FlxG.stage.stageWidth, "press x to start");
			pressX.size = 16;
			pressX.alignment = "center";
			
			add(pressX);
		}
		override public function update():void
		{
			if(FlxG.keys.X)
				FlxG.switchState(new PlayState);
		}
	}

}