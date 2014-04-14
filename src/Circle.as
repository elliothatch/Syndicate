package
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Elliot
	 */
	public class Circle
	{
		
		public var points:Vector.<Point>;
		public var center:Point;
		public var radius:int;
		
		public function Circle(x0:int, y0:int, radius:int)
		{
			points = new Vector.<Point>();
			center = new Point(x0, y0);
			radius = radius;
			calculate(x0, y0, radius);
		}
		
		private function calculate(x0:int, y0:int, radius:int):void
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
					points.push(octants[i][j]);
				}
			}
		}	
	}
}