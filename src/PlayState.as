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
			
			add(world);
			
		}
		
		override public function update():void
		{
			FlxG.camera.x = (playerActor.getGridX() - int(GameManager.instance().screenTileWidth / 2)) * -Tile.TILE_SIZE_X;
			FlxG.camera.y = (playerActor.getGridY() - int(GameManager.instance().screenTileHeight / 2)) * -Tile.TILE_SIZE_Y;
			//if(!animationPlaying)
			if (currentActor == null)
				currentActor = world.getNextIdleActor();
			
			var acted:Boolean = false;
			if (currentActor == playerActor)
			{
				//get input
				if (FlxG.keys.justPressed("RIGHT"))
				{
					if (world.getTile(currentActor.getGridX() + 1, currentActor.getGridY()).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX() + 1, currentActor.getGridY(), currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("UP"))
				{
					if (world.getTile(currentActor.getGridX(), currentActor.getGridY() - 1).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX(), currentActor.getGridY() - 1, currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("LEFT"))
				{
					if (world.getTile(currentActor.getGridX() - 1, currentActor.getGridY()).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX() - 1, currentActor.getGridY(), currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("DOWN"))
				{
					if (world.getTile(currentActor.getGridX(), currentActor.getGridY() + 1).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX(), currentActor.getGridY() + 1, currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("X"))
				{
					var items:Vector.<Item> = world.getItems(currentActor.getGridX(), currentActor.getGridY());
					if (items.length > 0)
					{
						world.equipWeapon(currentActor, items[0] as Weapon);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("Z"))
				{
					if (currentActor.getEquippedWeapon() != null)
					{
						world.unequipWeapon(currentActor);
						acted = true;
					}
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
					if (world.getTile(currentActor.getGridX() + 1, currentActor.getGridY()).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX() + 1, currentActor.getGridY(), currentActor);
					}
					currentActor.changeMoveCooldown(1);
					currentActor = world.getNextIdleActor();
				}
			}
			
			super.update();
		}
		
	}
}