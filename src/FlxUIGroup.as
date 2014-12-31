package  
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author ...
	 */
	public class FlxUIGroup extends FlxGroup
	{
		protected var offsets:Dictionary;
		
		public function FlxUIGroup() 
		{
			super();
			offsets = new Dictionary();
		}
		
		override public function add(Object:FlxBasic):FlxBasic 
		{
			var obj:FlxObject = Object as FlxObject;
			offsets[Object] = new FlxPoint(obj.x, obj.y);
			return super.add(Object);
		}
		
		override public function update():void 
		{
			for each(var obj:FlxObject in members)
			{
				var offset:FlxPoint = offsets[obj];
				obj.x = offset.x - FlxG.camera.x;
				obj.y = offset.y - FlxG.camera.y;
			}
			super.update();
		}
		
	}

}