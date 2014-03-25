package
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxPowerTools;
	
	public class PlayState extends FlxState
	{
		private var world:World;
		
		private var currentActor:Actor;
		private var playerActor:Actor;
		
		override public function create():void
		{
			super.create();
			
			world = new World();
			
			currentActor = null;
			playerActor = new Actor();
			world.addActor(playerActor);
			world.addActor(new Actor());
			world.addActor(new Actor());
			
		}
		
		override public function update():void
		{
			
			//if(!animationPlaying)
			if (currentActor == null)
				currentActor = world.getNextIdleActor();
			if (currentActor == playerActor)
			{
				//get input
				if (FlxG.keys.justPressed("X"))
				{
					//placeholder-wait
					currentActor.changeMoveCooldown(1);
					currentActor = null;
				}
			}
			else
			{
				//ai control
				currentActor.changeMoveCooldown(2);
				currentActor = null;
			}
			
			super.update();
		}
	}
}