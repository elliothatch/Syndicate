package  
{
	/**
	 * ...
	 * @author Elliot
	 */
	public class World 
	{
		private static const TILE_FLOOR:int = 0;
		private static const TILE_HALFWALL:int = 1;
		private static const TILE_WALL:int = 2;
		
		private var m_tiles:Vector.<Vector.<int>>;
		private var m_actors:Vector.<Actor>;
		private var m_idleActors:Vector.<Actor>;
		
		private var m_currentTurn:uint;
		
		public function World() 
		{
			m_tiles = new Vector.<Vector.<int>>();
			for (var x:int = 0; x < 50; x++)
			{
				m_tiles.push(new Vector.<int>());
				for (var y:int = 0; y < 50; y++)
				{
					if (x == 0 || y == 0 || x == 49 || y == 49)
					{
						m_tiles[x].push(TILE_WALL);
					}
					else
					{
						m_tiles[x].push(TILE_FLOOR);
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
		
	}

}