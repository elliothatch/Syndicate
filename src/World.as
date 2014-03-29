package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Elliot
	 */
	public class World extends FlxGroup
	{	
		private var m_actorGroup:FlxGroup;
		private var m_itemGroup:FlxGroup;
		
		private var m_tiles:Vector.<Vector.<Tile>>;
		private var m_actors:Vector.<Actor>;
		private var m_idleActors:Vector.<Actor>;
		
		private var m_width:int;
		private var m_height:int;
		
		private var m_currentTurn:uint;
		
		public function World(width:int, height:int)
		{
			super();
			
			m_actorGroup = new FlxGroup();
			m_itemGroup = new FlxGroup();
			
			add(m_itemGroup);
			add(m_actorGroup);
			
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
			m_actorGroup.add(actor);
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
		
		public function equipWeapon(actor:Actor, weapon:Weapon):void
		{
			actor.equipWeapon(weapon);
			removeItem(weapon);
			actor.changeMoveCooldown(1);
		}
		
		public function unequipWeapon(actor:Actor):void
		{
			var weapon:Weapon = actor.getEquippedWeapon();
			actor.equipWeapon(null);
			addItem(actor.getGridX(), actor.getGridY(), weapon);
			actor.changeMoveCooldown(1);
		}
		
		public function addItem(X:int, Y:int, item:Item):void
		{
			m_tiles[X][Y].addItem(item);
			item.setPosition(X, Y);
			m_itemGroup.add(item);
		}
		
		public function removeItem(item:Item):void
		{
			m_tiles[item.getGridX()][item.getGridY()].removeItem(item);
			m_itemGroup.remove(item);
		}
		
		public function getItems(X:int, Y:int):Vector.<Item>
		{
			return m_tiles[X][Y].getItems();
		}
		
		public function getTile(X:int, Y:int):Tile
		{
			return m_tiles[X][Y];
		}
		
		override public function draw():void
		{
			//first draw all the tiles on screen
			for (var x:int = 0; x < m_width; x++)
			{
				for (var y:int = 0; y < m_height; y++)
				{
					if (x >= FlxG.camera.x / -Tile.TILE_SIZE_X && 
						x < FlxG.camera.x / -Tile.TILE_SIZE_X + GameManager.instance().screenTileWidth &&
						y >= FlxG.camera.y / -Tile.TILE_SIZE_Y && 
						y < FlxG.camera.y / -Tile.TILE_SIZE_Y + GameManager.instance().screenTileHeight)
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