package  
{
	/**
	 * ...
	 * @author Elliot
	 */
	import org.flixel.*;
	public class Tile extends FlxSprite
	{
		public static const TILE_FLOOR:int = 0;
		public static const TILE_HALFWALL:int = 1;
		public static const TILE_WALL:int = 2;
		
		public static const TILE_SIZE_X:Number = 15;
		public static const TILE_SIZE_Y:Number = 15;
		
		private var m_type:int;
		private var m_items:Vector.<Item>
		
		public function Tile(X:int, Y:int, type:int) 
		{
			super(X * TILE_SIZE_X, Y * TILE_SIZE_Y);
			
			m_type = type;
			m_items = new Vector.<Item>();
			
			if (m_type == TILE_FLOOR)
			{
				this.x += TILE_SIZE_X / 3;
				this.y += TILE_SIZE_Y / 3;
				makeGraphic(TILE_SIZE_X/3, TILE_SIZE_Y/3, 0xff000000);
			}
			else if (m_type == TILE_HALFWALL)
			{
				makeGraphic(TILE_SIZE_X, TILE_SIZE_Y, 0xffaaaaaa);
			}
			else
			{
				makeGraphic(TILE_SIZE_X, TILE_SIZE_Y, 0xff111111);
			}
		}
		
		public function addItem(item:Item):void
		{
			m_items.push(item);
		}
		
		public function removeItem(item:Item):void
		{
			m_items.splice(m_items.indexOf(item), 1);
		}
		
		public function getItems():Vector.<Item>
		{
			return m_items;
		}
		
		public function getType():int
		{
			return m_type;
		}
	}

}