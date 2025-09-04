package minigames;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.graphics.frames.FlxAtlasFrames;

class Player extends FlxSprite{
	static inline var SPEED:Float = 100;
	public function new(x:Float = 0, y:Float = 0, char:String, colTag:FlxColor){
		super(x, y);
		frames = FlxAtlasFrames.fromSparrow(Paths.getLevelThing('chars/' + char + '.png'), Paths.getLevelThing('chars/' + char + '.xml'));
		animation.addByPrefix('anim', 'anim', 2, true);
		animation.play('anim');
		color = colTag;
		drag.x = drag.y = 900;
	}

	override function update(elapsed:Float){
		updateMovement();
		super.update(elapsed);
	}

	function updateMovement(){
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;
		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down) up = down = false;
		if (left && right) left = right = false;
		if (up || down || left || right){
			var newAngle:Float = 0;
			if (up){
				newAngle = -90;
				if (left) newAngle -= 45;
				else if (right) newAngle += 45;
				facing = UP;
			}
			else if (down){
				newAngle = 90;
				if (left) newAngle += 45;
				else if (right) newAngle -= 45;
				facing = DOWN;
			}
			else if (left){
				newAngle = 180;
				facing = LEFT;
			}
			else if (right){
				newAngle = 0;
				facing = RIGHT;
			}
			velocity.setPolarDegrees(SPEED, newAngle);
		}

		var action = "idle";
		if ((velocity.x != 0 || velocity.y != 0) && touching == NONE) action = "walk";
		switch (facing){
			case LEFT: flipX = true;
			case RIGHT: flipX = false;
			case _:
		}
	}
}
