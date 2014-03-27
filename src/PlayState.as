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
			FlxG.bgColor = 0xffffffff;
			
			world = GameManager.instance().world;
			playerActor = GameManager.instance().playerActor;
			currentActor = null;
			
			//FlxG.camera.width = FlxG.stage.stageWidth;
			//FlxG.camera.height = FlxG.stage.stageHeight;
			
			add(world);
			trace("create playstate");
			
		}
		
		override public function update():void
		{
			FlxG.camera.x = playerActor.getGridX() * -Tile.TILE_SIZE_X + FlxG.stage.stageWidth/2.0;
			FlxG.camera.y = playerActor.getGridY() * -Tile.TILE_SIZE_Y + FlxG.stage.stageHeight / 2.0;
			//if(!animationPlaying)
			if (currentActor == null)
				currentActor = world.getNextIdleActor();
			
			var acted:Boolean = false;
			if (currentActor == playerActor)
			{
				//get input
				if (FlxG.keys.justPressed("RIGHT"))
				{
					world.moveActor(currentActor.getGridX() + 1, currentActor.getGridY(), currentActor);
					acted = true;
				}
				else if (FlxG.keys.justPressed("UP"))
				{
					world.moveActor(currentActor.getGridX(), currentActor.getGridY() - 1, currentActor);
					acted = true;
				}
				else if (FlxG.keys.justPressed("LEFT"))
				{
					world.moveActor(currentActor.getGridX() - 1, currentActor.getGridY(), currentActor);
					acted = true;
				}
				else if (FlxG.keys.justPressed("DOWN"))
				{
					world.moveActor(currentActor.getGridX(), currentActor.getGridY() + 1, currentActor);
					acted = true;
				}
				if (acted)
				{
					currentActor = world.getNextIdleActor();
				}
			}
			else
			{
				while (currentActor != playerActor)
				{
					//ai control
					world.moveActor(currentActor.getGridX() + 1, currentActor.getGridY(), currentActor);
					currentActor.changeMoveCooldown(1);
					currentActor = world.getNextIdleActor();
				}
			}
			
			super.update();
		}
		
	}
}