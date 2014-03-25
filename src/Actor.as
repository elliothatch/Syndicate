package  
{
	/**
	 * ...
	 * @author Elliot
	 */
	public class Actor 
	{
		private var m_moveCooldown:int;
		public function Actor() 
		{
			m_moveCooldown = 0;
		}
		
		public function changeMoveCooldown(amount:int):void
		{
			m_moveCooldown += amount;
		}
		
		public function getMoveCooldown():int
		{
			return m_moveCooldown;
		}
		
	}

}