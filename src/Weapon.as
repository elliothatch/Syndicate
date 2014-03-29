package 
{
	
	/**
	 * ...
	 * @author Elliot
	 */
	public class Weapon extends Item 
	{
		private var m_weaponType:int;
		
		public function Weapon(X:int, Y:int, weaponType:int)
		{
			super(X, Y, ITEM_WEAPON);
			m_weaponType = weaponType;
		}
	}
	
}