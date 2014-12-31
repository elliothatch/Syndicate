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
		
		public function getMinAccuracyAtDistance(distance:Number):Number
		{
			return 0.5 * Math.pow(1.2, -distance);
		}
		
		public function getMaxAccuracyAtDistance(distance:Number):Number
		{
			return 1.0 * Math.pow(1.02, -distance);
		}
		
		public function getAccuracyGrowthAtDistance(distance:Number):Number
		{
			return (2.0 - 1.0) * Math.pow(1.3, -distance) + 1.0;
		}
	}
	
}