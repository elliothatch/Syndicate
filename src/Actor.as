package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Elliot
	 */
	public class Actor extends FlxSprite
	{
		private var m_moveCooldown:int;
		private var m_gridX:int;
		private var m_gridY:int;
		
		private var m_equippedWeapon:Weapon;
		
		public function Actor(X:int, Y:int) 
		{
			super(X * Tile.TILE_SIZE_X, Y * Tile.TILE_SIZE_Y);
			makeGraphic(Tile.TILE_SIZE_X, Tile.TILE_SIZE_Y, 0xffff0000);
			
			m_moveCooldown = 0;
			m_gridX = X;
			m_gridY = Y;
			m_equippedWeapon = null;
		}
		
		public function changeMoveCooldown(amount:int):void
		{
			m_moveCooldown += amount;
		}
		
		public function getMoveCooldown():int
		{
			return m_moveCooldown;
		}
		
		public function setPosition(X:int, Y:int):void
		{
			m_gridX = X;
			m_gridY = Y;
			x = X * Tile.TILE_SIZE_X;
			y = Y * Tile.TILE_SIZE_Y;
		}
		
		public function getGridX():int
		{
			return m_gridX;
		}
		
		public function getGridY():int
		{
			return m_gridY;
		}
		
		public function equipWeapon(weapon:Weapon):void
		{
			m_equippedWeapon = weapon;
		}
		
		public function getEquippedWeapon():Weapon
		{
			return m_equippedWeapon;
		}
		
	}

}