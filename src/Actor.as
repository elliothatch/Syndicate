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
		
		private var m_turnsAimed:int;
		private var m_targetAimed:Actor;
		private var m_recoil:Number;
		
		public function Actor(X:int, Y:int) 
		{
			super(X * Tile.TILE_SIZE_X, Y * Tile.TILE_SIZE_Y);
			makeGraphic(Tile.TILE_SIZE_X, Tile.TILE_SIZE_Y, 0xffff0000);
			
			m_moveCooldown = 0;
			m_gridX = X;
			m_gridY = Y;
			m_equippedWeapon = null;
			
			m_turnsAimed = 0;
			m_targetAimed = null;
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
		
		public function aimAtTarget(target:Actor):void
		{
			if(target == m_targetAimed)
				m_turnsAimed++;
			else
			{
				m_targetAimed = target;
				m_turnsAimed = 1;
			}
		}
		
		public function cancelAim():void
		{
			m_targetAimed = null;
			m_turnsAimed = 0;
		}
		
		public function getTurnsAimed(target:Actor):Number
		{
			var turnsAimed:uint = 0;
			if (target == m_targetAimed)
				turnsAimed = m_turnsAimed;
				
			return turnsAimed;
		}
		
		public function getCurrentHitChance(target:Actor):Number
		{
			return getHitChance(target, this.getTurnsAimed(target));
		}
		
		public function getHitChance(target:Actor, turnsAimed:Number ):Number
		{
			//weapon stats: accuracy over distance, recoil
			//player stats: weapon skill, recoil recovery, recoil resistance, specific buffs, exhaustion
			//target stats: distance, speed, turns since last move (moving target)
			
			//accuracy over time:
			//y=(min-max)*rate^-x + max
			
			//min: accuracy over distance + weapon skill (small)
			//max: accuracy over distance + weapon skill (medium)
			//rate:accuracy over distance + weapon skill (large)
			
			//recoil curve: y=(min-1)*rate^x+1
			//x = x + recoil * recoilResistance - recoilRecovery (delayed)
			//accuracy = accuracy over time - recoilCurve
			
			if (m_equippedWeapon == null)
				return 0;
				
			if (!GameManager.instance().world.tileVisible(target.getGridX(), target.getGridY(), this))
				return 0;
				
			var distance:Number = Math.sqrt(Math.pow(m_gridX - target.getGridX(), 2) + Math.pow(m_gridY - target.getGridY(), 2));
			var min:Number = m_equippedWeapon.getMinAccuracyAtDistance(distance);
			var max:Number = m_equippedWeapon.getMaxAccuracyAtDistance(distance);
			var rate:Number = m_equippedWeapon.getAccuracyGrowthAtDistance(distance);
			
			return (min - max) * Math.pow(rate, -turnsAimed) + max;
			//return -0.5 * Math.pow(2, -turnsAimed) + 1.0;
		}
		
	}

}