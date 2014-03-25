package  
{
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Elliot
	 */
	public class World extends FlxGroup
	{	
		private var m_tiles:Vector.<Vector.<Tile>>;
		private var m_actors:Vector.<Actor>;
		private var m_idleActors:Vector.<Actor>;
		
		private var m_currentTurn:uint;
		
		public function World()
		{
			super();
			m_tiles = new Vector.<Vector.<Tile>>();
			for (var x:int = 0; x < 50; x++)
			{
				m_tiles.push(new Vector.<Tile>());
				for (var y:int = 0; y < 50; y++)
				{
					if (x == 0 || y == 0 || x == 49 || y == 49)
					{
						var tile:Tile = new Tile(x, y, Tile.TILE_WALL);
						m_tiles[x].push(tile);
						add(tile);
					}
					else
					{
						var tile1:Tile = new Tile(x, y, Tile.TILE_FLOOR);
						m_tiles[x].push(tile1);
						add(tile1);
					}
				}
			}
			
			m_actors = new Vector.<Actor>();
			m_idleActors = new Vector.<Actor>();
			
			m_currentTurn = 0;
		}
		
		public function getWidth():int
		{
			return m_tiles.length;
		}
		
		public function getHeight():int
		{
			return m_tiles[0].length;
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
			trace(m_currentTurn);
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
	}

}