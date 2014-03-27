package  
{
	/**
	 * ...
	 * @author Elliot
	 */
	import org.flixel.*;
	
	public class GameManager 
	{
		private static var gameManager:GameManager = null;
		
		public static function instance():GameManager
		{
			if (gameManager == null)
				gameManager = new GameManager();
			return gameManager;
		}
		
		public var world:World;
		public var playerActor:Actor;
		
		public function GameManager() 
		{
			world = new World(100,100);
			
			playerActor = new Actor(1,1);
			world.addActor(playerActor);
			world.addActor(new Actor(2,1));
			world.addActor(new Actor(3, 6));
			
			reloadWorldSize();
		}
		
		public function reloadWorldSize():void
		{
			FlxG.width = world.getWidth() * Tile.TILE_SIZE_X;
			FlxG.height = world.getHeight() * Tile.TILE_SIZE_Y;
			FlxG.switchState(new PlayState());
		}
		
		public function createNewWorld():void
		{
			//may or may not use this, mostly a reminder that you need to call manualDestroy on the old world
			world.manualDestroy();
			world = new World(100,100);
		}
		
	}

}