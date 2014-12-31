package
{
	/**
	 * ...
	 * @author Elliot Hatch
	 */
	import flash.geom.Point;
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxPowerTools;
	
	public class PlayState extends FlxState
	{
		private var world:World;
		
		private var currentActor:Actor;
		private var playerActor:Actor;
		private var cameraGridX:int;
		private var cameraGridY:int;
		private var cameraAimMode:Boolean;
		private var aimLine:FlxGroup;
		private var acted:Boolean;
		
		
		private var hud:FlxUIGroup;
		private var hitAccuracyText:FlxText;
		private var hitAccuracyGraph:FlxGraph;
		
		override public function create():void
		{
			super.create();
			FlxG.bgColor = 0xff333333;
			
			world = GameManager.instance().world;
			playerActor = GameManager.instance().playerActor;
			currentActor = null;
			cameraGridX = 0;
			cameraGridY = 0;
			cameraAimMode = false;
			aimLine = new FlxGroup();
			acted = false;
			
			hud = new FlxUIGroup();
			
			hitAccuracyText = new FlxText(10, 10, 100);
			hitAccuracyText.color = 0x00aa11;
			hitAccuracyText.visible = false;
			hud.add(hitAccuracyText);
			
			hitAccuracyGraph = new FlxGraph(10, 30, 100, 100);
			//hitAccuracyGraph.calcAndSetPoints(function(x:Number):Number { return -0.5 * Math.pow(2, -x) + 1.0; }, 0.0, 5.0, 0.2);
			hitAccuracyGraph.lineThickness = 2;
			hitAccuracyGraph.xGridLines = new <Number>[0,1,2,3,4,5];
			hitAccuracyGraph.yGridLines = new <Number>[0.01,0.51, 0.7, 0.8, 0.9, 0.98];
			hitAccuracyGraph.minX = 0.0;
			hitAccuracyGraph.minY = 0.0;
			hud.add(hitAccuracyGraph);
			
			
			add(world);
			add(aimLine);
			add(hud);
			
		}
		
		override public function update():void
		{
			if (!cameraAimMode)
			{
				cameraGridX = playerActor.getGridX();
				cameraGridY = playerActor.getGridY();
			}
			FlxG.camera.x = (cameraGridX - int(GameManager.instance().screenTileWidth / 2)) * -Tile.TILE_SIZE_X;
			FlxG.camera.y = (cameraGridY - int(GameManager.instance().screenTileHeight / 2)) * -Tile.TILE_SIZE_Y;
			FlxG.camera.x = Math.min(0, Math.max(-(FlxG.width - FlxG.stage.stageWidth), FlxG.camera.x));
			FlxG.camera.y = Math.min(0, Math.max(-(FlxG.height - FlxG.stage.stageHeight), FlxG.camera.y));
			//if(!animationPlaying)
			if (currentActor == null)
				currentActor = world.getNextIdleActor();
			
			acted = false;
			if (currentActor == playerActor)
			{
				//get input
				//more branches for menus, etc.
				if (!cameraAimMode)
				{
					processInput()
				}
				else
				{
					processInputAimMode();
				}
				if (acted)
				{
					world.calculateVisibility(currentActor);
					currentActor = world.getNextIdleActor();
				}
			}
			else
			{
				while (currentActor != playerActor)
				{
					//ai control
					if (world.getTile(currentActor.getGridX() + 1, currentActor.getGridY()).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX() + 1, currentActor.getGridY(), currentActor);
					}
					currentActor.changeMoveCooldown(1);
					currentActor = world.getNextIdleActor();
				}
			}
			
			super.update();
		}
		
		
		private function processInput():void
		{
			if (FlxG.keys.justPressed("RIGHT"))
				{
					if (world.getTile(currentActor.getGridX() + 1, currentActor.getGridY()).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX() + 1, currentActor.getGridY(), currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("UP"))
				{
					if (world.getTile(currentActor.getGridX(), currentActor.getGridY() - 1).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX(), currentActor.getGridY() - 1, currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("LEFT"))
				{
					if (world.getTile(currentActor.getGridX() - 1, currentActor.getGridY()).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX() - 1, currentActor.getGridY(), currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("DOWN"))
				{
					if (world.getTile(currentActor.getGridX(), currentActor.getGridY() + 1).getType() == Tile.TILE_FLOOR)
					{
						world.moveActor(currentActor.getGridX(), currentActor.getGridY() + 1, currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("X"))
				{
					var items:Vector.<Item> = world.getItems(currentActor.getGridX(), currentActor.getGridY());
					if (items.length > 0)
					{
						world.equipWeapon(currentActor, items[0] as Weapon);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("Z"))
				{
					if (currentActor.getEquippedWeapon() != null)
					{
						world.unequipWeapon(currentActor);
						acted = true;
					}
				}
				else if (FlxG.keys.justPressed("F"))
				{
					//enter aim mode
					cameraAimMode = true;
					hitAccuracyText.visible = true;
					hitAccuracyText.text = "accuracy: ";
					updateAimLine();
				}
		}
		private function processInputAimMode():void
		{
			if (FlxG.keys.justPressed("RIGHT"))
				{
					if (cameraGridX < world.getWidth())
					{
						cameraGridX++;
						updateAimLine();
						updateAccuracyText();
					}
				}
				else if (FlxG.keys.justPressed("UP"))
				{
					if (cameraGridY > 0)
					{
						cameraGridY--;
						updateAimLine();
						updateAccuracyText();
					}
				}
				else if (FlxG.keys.justPressed("LEFT"))
				{
					if (cameraGridX > 0)
					{
						cameraGridX--;
						updateAimLine();
						updateAccuracyText();
					}
				}
				else if (FlxG.keys.justPressed("DOWN"))
				{
					if (cameraGridY < world.getHeight())
					{
						cameraGridY++;
						updateAimLine();
						updateAccuracyText();
					}
				}
				else if (FlxG.keys.justPressed("F"))
				{
					exitAimMode();
				}
				else if (FlxG.keys.justPressed("X"))
				{
					var target:Actor = world.getActor(cameraGridX, cameraGridY);
					if (target != null)
					{
						world.aimAtTarget(playerActor, target);
						acted = true;
						updateAccuracyText();
						//exitAimMode();
					}
				}
		}
		
		private function exitAimMode():void
		{
			for each(var oldSprite:FlxSprite in aimLine)
				oldSprite.destroy();
			aimLine.clear();
			cameraAimMode = false;
			hitAccuracyText.visible = false;
		}
		
		private function updateAimLine():void
		{
			for each(var oldSprite:FlxSprite in aimLine)
				oldSprite.destroy();
			aimLine.clear();
			var line:Line = new Line(currentActor.getGridX(), currentActor.getGridY(), cameraGridX, cameraGridY);
			var obstructed:Boolean = false;
			var visible:Boolean = world.tileVisible(cameraGridX, cameraGridY, currentActor);
			for each(var point:Point in line.points)
			{
				var sprite:FlxSprite = new FlxSprite(point.x * Tile.TILE_SIZE_X, point.y * Tile.TILE_SIZE_X);
				if (!visible && !obstructed && 
				(world.getTile(point.x, point.y).getType() == Tile.TILE_WALL || !world.tileVisible(point.x, point.y, currentActor)))
				{
					obstructed = true;
				}
				if(!obstructed)
					sprite.makeGraphic(Tile.TILE_SIZE_X, Tile.TILE_SIZE_Y, 0xff33ff33);
				else
					sprite.makeGraphic(Tile.TILE_SIZE_X, Tile.TILE_SIZE_Y, 0xffff3333);
				aimLine.add(sprite);
			}
		}
		
		private function updateAccuracyText():void
		{
			//update accuracy text
			var target:Actor = world.getActor(cameraGridX, cameraGridY);
			if (target != null)
			{
				hitAccuracyText.text = "accuracy: " + playerActor.getCurrentHitChance(target) + "%";
				hitAccuracyGraph.calcAndSetPoints(function(x:Number) { return playerActor.getHitChance(target, x); }, 0.0, 8.0, 0.2);
				hitAccuracyGraph.minY = 0.0;
				hitAccuracyGraph.maxY = 1.0;
			}
			else
			{
				hitAccuracyText.text = "accuracy: ???%";
			}
		}
	}
}