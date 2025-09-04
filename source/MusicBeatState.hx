package;
import openfl.Lib;
import Conductor.BPMChangeEvent;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.ui.FlxUIState;
import openfl.system.System;
using StringTools;

class MusicBeatState extends FlxUIState{
	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;
	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var controls(get, never):Controls;
	var array:Array<FlxColor> = [
		FlxColor.fromRGB(148, 0, 211),
		FlxColor.fromRGB(75, 0, 130),
		FlxColor.fromRGB(0, 0, 255),
		FlxColor.fromRGB(0, 255, 0),
		FlxColor.fromRGB(255, 255, 0),
		FlxColor.fromRGB(255, 127, 0),
		FlxColor.fromRGB(255, 0 , 0)
	];
	public var touch(default, default):FlxTouch;
	var lol:Array<String> = [];

	inline function get_controls():Controls return PlayerSettings.player1.controls;
	override function create(){
		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
		if (transIn != null) trace('reg ' + transIn.region);
		// super mega effective cache destroyer 1000 idk what im doing
		lol = Assets.list();
		for(key in lol){
			Assets.cache.removeBitmapData(key);
			Assets.cache.removeFont(key);
			Assets.cache.removeSound(key);
			lol.remove(key);
		}
		FlxG.bitmap.clearUnused();
		Assets.cache.clear();
		System.gc();
		super.create();
		System.gc();
	}

	var skippedFrames = 0;
	override function update(elapsed:Float){
		var oldStep:Int = curStep;
		updateCurStep();
		updateBeat();
		if (oldStep != curStep && curStep > 0) stepHit();
		if (FlxG.save.data.fpsRain && skippedFrames >= 6){
			if (currentColor >= array.length) currentColor = 0;
			(cast (Lib.current.getChildAt(0), Main)).changeFPSColor(array[currentColor]);
			currentColor++;
			skippedFrames = 0;
		}else skippedFrames++;
		#if desktop
		if(FlxG.keys.justPressed.Q){
			var str:String = "";
			lol = Assets.list();
			for(key in lol) if(Assets.cache.hasBitmapData(key) || Assets.cache.hasFont(key) || Assets.cache.hasSound(key)) str += "\n" + key;
			@:privateAccess(flixel.system.frontEnds.BitmapFrontEnd._cache)
			for(key in FlxG.bitmap._cache.keys()) str += "\n" + key;
			trace("\n=== CURRENT CACHE MEMORY ===" + str);
		}
		#end
		if ((cast (Lib.current.getChildAt(0), Main)).getFPSCap != FlxG.save.data.fpsCap && FlxG.save.data.fpsCap <= 290) (cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
		super.update(elapsed);
	}
	override function destroy(){
		super.destroy();
		FlxG.bitmap.clearUnused();
		System.gc();
	}
	private function updateBeat():Void{
		lastBeat = curStep;
		curBeat = Math.floor(curStep / 4);
	}
	public function beatHit():Void{}
	public static var currentColor = 0;
	private function updateCurStep():Void{
		var lastChange:BPMChangeEvent = {stepTime: 0,songTime: 0,bpm: 0}
		for (i in 0...Conductor.bpmChangeMap.length) if (Conductor.songPosition >= Conductor.bpmChangeMap[i].songTime) lastChange = Conductor.bpmChangeMap[i];
		curStep = lastChange.stepTime + Math.floor((Conductor.songPosition - lastChange.songTime) / Conductor.stepCrochet);
	}
	public function stepHit():Void{if (curStep % 4 == 0) beatHit();}
	public function fancyOpenURL(schmancy:String){#if linux Sys.command('/usr/bin/xdg-open', [schmancy, "&"]); #else FlxG.openURL(schmancy); #end}
}
