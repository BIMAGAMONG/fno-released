package;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import Song.SwagSong;
using StringTools;

class Character extends FlxSprite{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;
    public var playerColor:String;
	public var isPlayer:Bool = false;
	public var curChar:String = 'bf';
	public var holdTimer:Float = 0;
	public var isRating:Bool = false;
	public var blockIdle:Bool = false;
	public var stunned:Bool = false;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false){
		super(x, y);
		animOffsets = new Map<String, Array<Dynamic>>();
		curChar = character;
		this.isPlayer = isPlayer;

		var antialArray:Array<String> = ['maro', 'bfSMBW', 'bf-atari', 'bima-atari'];
		antialiasing = antialArray.contains(curChar) ? false : FlxG.save.data.antialias;

		var path:String = '';
		if(curChar.startsWith('bf')) path = 'bfs/';
		else if(curChar.startsWith('gf')) path = 'gfs/';
		else{
			switch(curChar){
				case 'lowmealt': curChar = 'lowme';
			}
		}

		/* TEMPLATE
			newAnim('idle', '', [0, 0], 24);
			newAnim('singLEFT', '', [], 24);
			newAnim('singRIGHT', '', [], 24);
			newAnim('singUP', '', [], 24);
			newAnim('singDOWN', '', [], 24);
		*/
		frames = Paths.getSparrowAtlas('characters/' + path + curChar, 'shared');
		switch (curChar){
			case 'scr':
                playerColor = "612E38";
				newAnim('idle', 'idle', [0, 0], 20);
				newAnim('singLEFT', 'left', [0, 0], 20);
				newAnim('singRIGHT', 'right', [0, 0], 20);
				newAnim('singUP', 'up', [0, 0], 20);
				newAnim('singDOWN', 'down', [0, 0], 20);
			case 'bf-shitpost':
                playerColor = "52AADE";
				newAnim('idle', 'idle', [0, 0], 24);
				newAnim('singLEFT', 'left', [8, 1], 24);
				newAnim('singRIGHT', 'right', [-62, 2], 24);
				newAnim('singUP', 'up', [-47, 47], 24);
				newAnim('singDOWN', 'down', [-18, -40], 24);
				newAnim('hey', 'hey', [-14, 17], 24);
			case 'goofyexe':
                playerColor = "fb4646";
				newAnim('idle', 'idle_', [0, 0], 24);
				newAnim('singLEFT', 'left_', [0, 0], 24);
				newAnim('singRIGHT', 'right_', [0, 0], 24);
				newAnim('singUP', 'up_', [0, 0], 24);
				newAnim('singDOWN', 'down_', [0, 0], 24);
			case 'gfshitpost':
                playerColor = "AB5260";
				animation.addByPrefix('danceLeft', 'GF Dancing Beat', 24, false);
				animation.addByPrefix('danceRight', 'GF Dancing Beat', 24, false);
				addOffset('danceLeft', 0, 0);
				addOffset('danceRight', 0, 0);
				playAnim('danceRight');
				setGraphicSize(Std.int(width * 1.1));
			case 'gf':
                playerColor = "AB5260";
				animation.addByIndices('danceLeft', 'GFIDLELOL', [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], "", 24, false);
				animation.addByIndices('danceRight', 'GFIDLELOL', [16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				addOffset('danceLeft', 0, -9);
				addOffset('danceRight', 0, -9);
				setGraphicSize(Std.int(width * (PlayState.SONG.stage == 'space' ? 1 : 1.2)));
			case 'bf':
                playerColor = "52AADE";
				if(PlayState.SONG.stage == 'space'){
					newAnim('idle', 'idle', [0, 0], 24);
					newAnim('singLEFT', 'left', [6, 1], 24);
					newAnim('singRIGHT', 'right', [-49, 2], 24);
					newAnim('singUP', 'up', [-37, 37], 24);
					newAnim('singDOWN', 'down', [-13, -30], 24);
					newAnim('hey', 'hey', [-10, 14], 24);
					setGraphicSize(Std.int(width * 0.8));
				}else{
					newAnim('idle', 'idle', [0, 0], 24);
					newAnim('singLEFT', 'left', [8, 1], 24);
					newAnim('singRIGHT', 'right', [-62, 2], 24);
					newAnim('singUP', 'up', [-47, 47], 24);
					newAnim('singDOWN', 'down', [-18, -40], 24);
					newAnim('hey', 'hey', [-14, 17], 24);
				}
			case 'bima-atari':
                playerColor = "612E38";
				newAnim('idle', 'idle', [0, 0], 2);
				newAnim('singLEFT', 'left', [0, 0], 4);
				newAnim('singRIGHT', 'up', [0, 0], 4);
				newAnim('singUP', 'right', [0, 0], 4);
				newAnim('singDOWN', 'down', [0, 0], 4);
				setGraphicSize(Std.int(width * 0.5));
				updateHitbox();
			case 'bf-atari':
                playerColor = "0F9FDC";
				newAnim('idle', 'idle', [0, 0], 2);
				newAnim('singLEFT', 'left', [0, 0], 4);
				newAnim('singRIGHT', 'up', [0, 0], 4);
				newAnim('singUP', 'right', [0, 0], 4);
				newAnim('singDOWN', 'down', [0, 0], 4);
				setGraphicSize(Std.int(width * 0.5));
				updateHitbox();
			case 'bfSMBW':
				playerColor = "546AAA";
				newAnim('idle', 'bf-smbw idle', [0, 0], 24);
				newAnim('singLEFT', 'bf-smbw left', [-10, 0], 20);
				newAnim('singRIGHT', 'bf-smbw right', [0, 0], 20);
				newAnim('singUP', 'bf-smbw up', [0, 0], 20);
				newAnim('singDOWN', 'bf-smbw down', [-5, 0], 20);
				setGraphicSize(Std.int(width * 7));
				flipX = true;
			case 'maro':
				playerColor = "000106";
				newAnim('idle', 'maro idle', [0, 0], 14);
				newAnim('singLEFT', 'maro left', [-20, -12], 24);
				newAnim('singRIGHT', 'maro right', [75, 10], 24);
				newAnim('singUP', 'maro up', [42, -112], 24);
				newAnim('singDOWN', 'maro down', [15, -2], 24);
				setGraphicSize(Std.int(width * 7));
			case 'bfshiz':
                playerColor = "0F9FDC";
				newAnim('idle', 'BF IDLE dance', [0, 0], 24);
				newAnim('singLEFT', 'BF Left note', [16, 16], 24);
				newAnim('singRIGHT', 'BF Right note', [-22, 13], 24);
				newAnim('singUP', 'BF Up note', [-66, 42], 24);
				newAnim('singDOWN', 'BF Down note', [31, -22], 24);
				setGraphicSize(Std.int(width * 1.2));
			case 'ruv':
                playerColor = "612E38";
				newAnim('idle', 'idle', [0, 0], 24);
				newAnim('singLEFT', 'left', [-16, -5], 24);
				newAnim('singRIGHT', 'right', [0, -11], 24);
				newAnim('singUP', 'up', [120, -5], 24);
				newAnim('singDOWN', 'down', [-45, -50], 24);
			case 'eyeskkx':
				playerColor = "46548B";
				newAnim('idle', 'idle', [0, 0], 24);
				newAnim('singLEFT', 'left', [-26, 0], 24);
				newAnim('singRIGHT', 'right', [60, -4], 24);
				newAnim('singUP', 'up', [29, 16], 24);
				newAnim('singDOWN', 'down', [-29, -30], 24);
			case 'cory':
				playerColor = "D5575D";
				newAnim('idle', 'idle', [0, 0], 24);
				newAnim('singLEFT', 'left', [222, 9], 24);
				newAnim('singRIGHT', 'right', [2, -15], 24);
				newAnim('singUP', 'up', [-3, 11], 24);
				newAnim('singDOWN', 'down', [96, -8], 24);
			case 'blas':
				playerColor = "6D7DBD";
				newAnim('idle', 'blas idle', [0, 0], 12);
				newAnim('singLEFT', 'blas left', [-4, 4], 12);
				newAnim('singRIGHT', 'blas right', [117, -11], 12);
				newAnim('singUP', 'blas up', [47, 43], 12);
				newAnim('singDOWN', 'blas down', [45, -50], 12);
				flipX = true;
			case 'lowme' | 'lowmealt':
                playerColor = "DE805B";
				newAnim('idle', character == 'lowme' ? 'Idle' : 'altIdle', [0, 0], 24);
				newAnim('singLEFT', 'Left', [-44, 1], 24);
				newAnim('singRIGHT', 'Right', [121, -2], 24);
				newAnim('singUP', 'Up', [-9, 162], 24);
				newAnim('singDOWN', 'Down', [3, 13], 24);
				setGraphicSize(Std.int(width * 1.1));
				updateHitbox();
			case 'mars':
                playerColor = "DE8274";
				newAnim('idle', 'Mars IDLE Dance', [0, 0], 24);
				newAnim('singLEFT', 'Mars Left Note', [3, 1], 24);
				newAnim('singRIGHT', 'Mars Right Note', [4, 0], 24);
				newAnim('singUP', 'Mars Up Note', [3, 1], 24);
				newAnim('singDOWN', 'Mars Down Note', [2, 0], 24);
				newAnim('swear', 'Mars SWEARING ANIM', [7, 19], 24);
				setGraphicSize(Std.int(width * 0.7));
			case 'niw':
				playerColor = "DFC8C7";
				newAnim('idle', 'NoIWont IDLE Dance', [0, 0], 24);
				newAnim('singLEFT', 'NoIWont Left Note', [8, 0], 24);
				newAnim('singRIGHT', 'NoIWont Right Note', [-99, 0], 24);
				newAnim('singUP', 'NoIWont Up Note', [-71, 17], 24);
				newAnim('singDOWN', 'NoIWont Down Note', [-70, -9], 24);
				newAnim('shocked', 'NoIWont SHOCKED ANIM', [9, 44], 24);
				setGraphicSize(Std.int(width * 0.8));
			case 'bred':
				playerColor = "C67FB0";				
				newAnim('idle', 'Anorra IDLE DANCE', [0, 0], 24);
				newAnim('singLEFT', 'Anorra Left Note', [41, 7], 24);
				newAnim('singRIGHT', 'Anorra Right Note', [5, -5], 24);
				newAnim('singUP', 'Anorra Up Note', [-6, 6], 24);
				newAnim('singDOWN', 'Anorra Down Note', [-26, -22], 24);
				setGraphicSize(Std.int(width * 1.2));
				updateHitbox();
			case 'sakura':
				playerColor = "DC79A9"; 	
				newAnim('idle', 'Sakura IDLE DANCE', [0, 0], 24);
				newAnim('singLEFT', 'Sakura LEFT Note', [3, 0], 24);
				newAnim('singRIGHT', 'Sakura RIGHT Note', [60, -1], 24);
				newAnim('singUP', 'Sakura UP Note', [20, 24], 24);
				newAnim('singDOWN', 'Sakura DOWN Note', [54, -17], 24);
				setGraphicSize(Std.int(width * 1.1));
				updateHitbox();
			case 'sakuraRage':
				playerColor = "DA6F9F";
				newAnim('idle', 'Xakura IDLE DANCE', [0, 0], 24);
				newAnim('singLEFT', 'Xakura LEFT Note', [4, 1], 24);
				newAnim('singRIGHT', 'Xakura RIGHT Note', [54, 1], 24);
				newAnim('singUP', 'Xakura UP Note', [17, 23], 24);
				newAnim('singDOWN', 'Xakura DOWN Note', [46, -14], 24);
				newAnim('transform', 'Sakura TRANSFROMATION in Xakura', [-11, 6], 24);
				setGraphicSize(Std.int(width * 1.2));
				updateHitbox();								
			case 'spikek':
				playerColor = "83E5EF";
				newAnim("idle", 'DLSpike IDLE DANCE', [0, 0], 24);
				newAnim("singUP", "DLSpike Up Note", [99, 55], 24);
				newAnim("singRIGHT", "DLSpike Right Note", [-71, -5], 24);
				newAnim("singDOWN", "DLSpike Down Note", [17, -1], 24);
				newAnim("singLEFT", 'DLSpike Left Note', [33, 3], 24);
				setGraphicSize(Std.int(width * 1.2));
				updateHitbox();
			case 'fang':
				playerColor = "73B8E1";	
				newAnim("idle", 'idle', [0, 0], 24);
				newAnim("singUP", 'up', [88, 141], 24);		
				newAnim("singRIGHT", 'right', [-11, -85], 24);	
				newAnim("singLEFT", 'left', [105, -5], 24);	
				newAnim("singDOWN", 'down', [-16, -94], 24);	
				newAnim("alright", 'alt1', [-5, -75], 24);	
				newAnim("woo", 'alt2', [2, -72], 24);	
				setGraphicSize(Std.int(width * 1.1));
				updateHitbox();
		}
		dance();
		if (!curChar.startsWith('gf')) addOffset('idle');
		if (isPlayer){
			flipX = !flipX;
			if (!curChar.startsWith('bf')){
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;
			}
		}
	}

	function newAnim(pref:String, name:String, off:Array<Float>, fps:Int, loop:Bool = false){
		animation.addByPrefix(pref, name, fps, loop);
		addOffset(pref, off[0], off[1]);
	} 

	override function update(elapsed:Float){
		super.update(elapsed);
		if (animation.curAnim.name.startsWith('sing') && !debugMode) holdTimer += elapsed;
		if (!curChar.startsWith('bf')){
			if (holdTimer >= Conductor.stepCrochet * 4 * 0.001){
				dance();
				holdTimer = 0;
			}
		}else{if (!debugMode) if (!animation.curAnim.name.startsWith('sing')) holdTimer = 0;}
	}

	private var danced:Bool = false;
	public function dance(){
		if (!debugMode){
			switch (curChar){
				case 'gf' | 'gfshitpost':
					danced = !danced;
					if (danced) playAnim('danceRight');
					else playAnim('danceLeft');
				default: if(!blockIdle) playAnim('idle');
			}
		}
	}
	public function addOffset(name:String, x:Float = 0, y:Float = 0) animOffsets[name] = [x, y];
	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void{
		animation.play(AnimName, Force, Reversed, Frame);
		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName)) offset.set(daOffset[0], daOffset[1]);
		else offset.set(0, 0);
		if (curChar.startsWith('gf')){
			if (AnimName == 'singLEFT') danced = true;
			else if (AnimName == 'singRIGHT') danced = false;
			if (AnimName == 'singUP' || AnimName == 'singDOWN') danced = !danced;
		}
	}
}