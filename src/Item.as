package  
{
	/**
	 * ...
	 * @author Elliot
	 */
	import org.flixel.*;
	public class Item extends FlxSprite
	{
		private var m_gridX:int;
		private var m_gridY:int;
		private var m_type:int;
		
		public function Item(X:int, Y:int, type:int) 
		{
			super(X * Tile.TILE_SIZE_X, Y * Tile.TILE_SIZE_Y);
			makeGraphic(Tile.TILE_SIZE_X, Tile.TILE_SIZE_Y, 0xff00aaaa);
			
			m_gridX = X;
			m_gridY = Y;
			m_type = type;
		}
		
		public function getGridX():int
		{
			return m_gridX;
		}
		
		public function getGridY():int
		{
			return m_gridY;
		}
		
		public function setPosition(X:int, Y:int):void
		{
			m_gridX = X;
			m_gridY = Y;
			x = X * Tile.TILE_SIZE_X;
			y = Y * Tile.TILE_SIZE_Y;
		}
		
	}

}