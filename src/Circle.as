package
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Elliot
	 */
	public class Circle
	{
		
		public var m_points:Vector.<Point>;
		public var m_center:Point;
		public var m_radius:int;
		public var m_filled:Boolean;
		
		public function Circle(x0:int, y0:int, radius:int, filled:Boolean)
		{
			m_points = new Vector.<Point>();
			m_center = new Point(x0, y0);
			m_radius = radius;
			m_filled = filled;
			if(!filled)
				calculate_unfilled(x0, y0, radius);
			else
				calculate_filled(x0, y0, radius);
		}
		
		private function calculate_unfilled(x0:int, y0:int, radius:int):void
		{
			var x:int = radius;
			var y:int = 0;
			var radiusError:int = 1 - x;
			
			var octants:Vector.<Vector.<Point>> = new Vector.<Vector.<Point>>();
			for (var i:int = 0; i < 8; i++)
			{
				octants.push(new Vector.<Point>());
			}
			
			while (x >= y)
			{
				octants[0].push(new Point(x + x0, y + y0));
				octants[1].push(new Point(y + x0, x + y0));
				octants[2].push(new Point(-x + x0, y + y0));
				octants[3].push(new Point(-y + x0, x + y0));
				octants[4].push(new Point(-x + x0, -y + y0));
				octants[5].push(new Point(-y + x0, -x + y0));
				octants[6].push(new Point(x + x0, -y + y0));
				octants[7].push(new Point(y + x0, -x + y0));
				y++;
				if (radiusError < 0)
				{
					radiusError += 2 * y + 1;
				}
				else
				{
					x--;
					radiusError += 2 * (y - x + 1);
				}
			}
			
			for (i = 0; i < 8; i++)
			{
				for (var j:int = 0; j < octants[i].length; j++)
				{
					m_points.push(octants[i][j]);
				}
			}
		}
		
		private function calculate_filled(x0:int, y0:int, radius:int):void
		{
			for (var x:int = -radius; x < radius; x++)
			{
				for (var y:int = -radius; y < radius; y++)
				{
					if (x * x + y * y < radius * radius)
						m_points.push(new Point(x + x0, y + y0));
				}
			}
		}	
	}
}