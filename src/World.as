package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Elliot
	 */
	public class World extends FlxGroup
	{	
		private var m_tiles:Vector.<Vector.<Tile>>;
		private var m_actors:Vector.<Actor>;
		private var m_idleActors:Vector.<Actor>;
		
		private var m_width;
		private var m_height;
		
		private var m_currentTurn:uint;
		
		public function World(width:int, height:int)
		{
			super();
			m_tiles = new Vector.<Vector.<Tile>>();
			m_width = width;
			m_height = height;
			for (var x:int = 0; x < width; x++)
			{
				m_tiles.push(new Vector.<Tile>());
				for (var y:int = 0; y < height; y++)
				{
					if (x == 0 || y == 0 || x == width-1 || y == height-1)
					{
						var tile:Tile = new Tile(x, y, Tile.TILE_WALL);
						m_tiles[x].push(tile);
					}
					else
					{
						var tile1:Tile = new Tile(x, y, Tile.TILE_FLOOR);
						m_tiles[x].push(tile1);
					}
				}
			}
			
			m_actors = new Vector.<Actor>();
			m_idleActors = new Vector.<Actor>();
			
			m_currentTurn = 0;
		}
		
		public function getWidth():int
		{
			return m_width;
		}
		
		public function getHeight():int
		{
			return m_height;
		}
		
		public function addActor(actor:Actor):void
		{
			m_actors.push(actor);
			add(actor);
		}
		
		public function advanceTurn():void
		{
			for each(var actor:Actor in m_actors)
			{
				actor.changeMoveCooldown(-1);
			}
			m_currentTurn++;
		}
		
		public function getNextIdleActor():Actor
		{
			while (m_idleActors.length == 0)
			{
				//add all idle actors this turn
				for each(var actor:Actor in m_actors)
				{
					if (actor.getMoveCooldown() <= 0)
					{
						m_idleActors.push(actor);
					}
				}
				if (m_idleActors.length == 0)
					advanceTurn();
			}
			
			return m_idleActors.pop();
		}
		
		public function moveActor(X:int, Y:int, actor:Actor):void
		{
			actor.setPosition(X, Y);
			actor.changeMoveCooldown(1);
		}
		
		override public function draw():void
		{
			//first draw all the tiles
			for (var x:int = 0; x < m_width; x++)
			{
				for (var y:int = 0; y < m_height; y++)
				{
					if (x * Tile.TILE_SIZE_X > -FlxG.camera.x && x * Tile.TILE_SIZE_X < -FlxG.camera.x + FlxG.stage.stageWidth &&
						y * Tile.TILE_SIZE_Y > -FlxG.camera.y && y * Tile.TILE_SIZE_Y < -FlxG.camera.y + FlxG.stage.stageHeight)
					{
						m_tiles[x][y].draw();
					}
				}
			}
			//next draw the actors
			super.draw();
		}
		
		override public function destroy():void
		{
			//do nothing!
			//World is meant to persist through state changes, we don't want to clear out all the members
		}
		
		//manualDestroy is identical to FlxGroup.destroy(), but it won't be called automatically
		//remember to call this when destroying the old world and creating a new one
		public function manualDestroy():void
		{
			super.destroy();
		}
	}

}