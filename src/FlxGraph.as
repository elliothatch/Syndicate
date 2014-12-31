package  
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxColor;
	/**
	 * ...
	 * @author ...
	 */
	public class FlxGraph extends FlxSprite
	{
		protected var m_width:uint;
		protected var m_height:uint;
		
		protected var m_values:Vector.<FlxPoint>;
		protected var m_minX:Number;
		protected var m_maxX:Number;
		protected var m_minY:Number;
		protected var m_maxY:Number;
		
		protected var m_lineColor:uint;
		protected var m_lineThickness:uint;
		
		protected var m_xGridLines:Vector.<Number>;
		protected var m_yGridLines:Vector.<Number>;
		
		protected var m_xGridLineColor:uint;
		protected var m_xGridLineThickness:uint;
		
		protected var m_yGridLineColor:uint;
		protected var m_yGridLineThickness:uint;
		
		public function FlxGraph(X:Number, Y:Number, width:uint, height:uint) 
		{
			super(X, Y);
			this.makeGraphic(width, height, 0x00000000);
			m_width = width;
			m_height = height;
			m_values = new Vector.<FlxPoint>();
			m_minX = Number.MAX_VALUE;
			m_maxX = Number.MIN_VALUE;
			m_minY = Number.MAX_VALUE;
			m_maxY = Number.MIN_VALUE;
			m_lineColor = 0xFF000000;
			m_lineThickness = 1;
			
			m_xGridLines = new Vector.<Number>();
			m_yGridLines = new Vector.<Number>();
			
			m_xGridLineColor = 0xFF000000;
			m_xGridLineThickness = 1;
			
			m_yGridLineColor = 0xFF000000;
			m_yGridLineThickness = 1;
		}
		
		override public function draw():void 
		{
			super.draw();
			var xRange:Number = m_maxX - m_minX;
			var yRange:Number = m_maxY - m_minY;
			
			for each (var gridX:Number in m_xGridLines)
			{
				var x:Number = (gridX - m_minX) / xRange * m_width;
				this.drawLine(x, 0.0, x, m_height, m_xGridLineColor, m_xGridLineThickness);
			}
			
			for each(var gridY:Number in m_yGridLines)
			{
				var y:Number = (1.0-(gridY - m_minY) / yRange) * m_height;
				this.drawLine(0.0, y, m_width, y, m_yGridLineColor, m_yGridLineThickness);
			}
			
			for (var i:int = 0; i < m_values.length - 1; i++)
			{
				
				this.drawLine((m_values[i].x - m_minX) / xRange * m_width, (1.0-(m_values[i].y - m_minY) / yRange) * m_height,
							  (m_values[i + 1].x - m_minX) / xRange * m_width, (1.0-(m_values[i + 1].y - m_minY) / yRange) * m_height,
							   m_lineColor, m_lineThickness);
			}
		}
		
		public function setPoints(points:Vector.<FlxPoint>):void
		{
			m_values = points;
			m_minX = Number.MAX_VALUE;
			m_maxX = Number.MIN_VALUE;
			m_minY = Number.MAX_VALUE;
			m_maxY = Number.MIN_VALUE;
			
			for (var i:int = 0; i < points.length; i++)
			{
				var x:Number = points[i].x;
				var y:Number = points[i].y;
				if (x < m_minX)
					m_minX = x;
				if (x > m_maxX)
					m_maxX = x;
				if (y < m_minY)
					m_minY = y;
				if (y > m_maxY)
					m_maxY = y;
			}
		}
		
		//func must be a function with the signature func(Number):FlxPoint
		public function calcAndSetPoints(func:Function, minX:Number, maxX:Number, stepX:Number):void
		{
			var newPoints:Vector.<FlxPoint> = new Vector.<FlxPoint>();
			for (var x:Number = minX; x < maxX; x += stepX)
			{
				newPoints.push(new FlxPoint(x, func(x)));
			}
			setPoints(newPoints);
		}
		
        public function get lineColor():uint {
            return m_lineColor;
        }

        public function set lineColor(value:uint):void {
            m_lineColor = value;
        }
		
		public function get lineThickness():uint {
            return m_lineThickness;
        }

        public function set lineThickness(value:uint):void {
            m_lineThickness = value;
        }
		
		public function get xGridLines():Vector.<Number> 
		{
			return m_xGridLines;
		}
		
		public function set xGridLines(value:Vector.<Number>):void 
		{
			m_xGridLines = value;
		}
		
		public function get yGridLines():Vector.<Number> 
		{
			return m_yGridLines;
		}
		
		public function set yGridLines(value:Vector.<Number>):void 
		{
			m_yGridLines = value;
		}
		
		public function get xGridLineColor():uint 
		{
			return m_xGridLineColor;
		}
		
		public function set xGridLineColor(value:uint):void 
		{
			m_xGridLineColor = value;
		}
		
		public function get xGridLineThickness():uint 
		{
			return m_xGridLineThickness;
		}
		
		public function set xGridLineThickness(value:uint):void 
		{
			m_xGridLineThickness = value;
		}
		
		public function get yGridLineColor():uint 
		{
			return m_yGridLineColor;
		}
		
		public function set yGridLineColor(value:uint):void 
		{
			m_yGridLineColor = value;
		}
		
		public function get yGridLineThickness():uint 
		{
			return m_yGridLineThickness;
		}
		
		public function set yGridLineThickness(value:uint):void 
		{
			m_yGridLineThickness = value;
		}
		
		public function get minX():Number 
		{
			return m_minX;
		}
		
		public function set minX(value:Number):void 
		{
			m_minX = value;
		}
		
		public function get maxX():Number 
		{
			return m_maxX;
		}
		
		public function set maxX(value:Number):void 
		{
			m_maxX = value;
		}
		
		public function get minY():Number 
		{
			return m_minY;
		}
		
		public function set minY(value:Number):void 
		{
			m_minY = value;
		}
		
		public function get maxY():Number 
		{
			return m_maxY;
		}
		
		public function set maxY(value:Number):void 
		{
			m_maxY = value;
		}
		
	}

}