import openfl.Lib;
import haxe.Json;
import lime.utils.Assets;

typedef MenuParameters ={
	useExistColors:Bool,
	customColors:Array<String>
}

class KadeEngineData{
	public static var menuData:MenuParameters;
	public static var unlockedSongsArray:Array<String> = [];
	public static var songBeatenArray:Array<String> = [];
	public static var erectSongsBeaten:Array<String> = [];
	public static var languages:Array<String> = ['eng', 'esp', 'ita', 'rus', 'ptbr'];

	public static function pushUnlockedSong(song:String){
		unlockedSongsArray.push(song);
		FlxG.save.data.unlockedSongs = unlockedSongsArray;
		FlxG.save.flush();
	}

	public static function pushErectSong(song:String){
		erectSongsBeaten.push(song);
		FlxG.save.data.erectSongs = erectSongsBeaten;
		FlxG.save.flush();
	}

    public static function initSave(){
		menuData = Json.parse(Assets.getText("assets/data/menuParameters.json"));
		// CURRENCY
		if (FlxG.save.data.coins == null) FlxG.save.data.coins = 0;
		if (FlxG.save.data.gems == null) FlxG.save.data.gems = 0;
		
		// SETTINGS
		if (FlxG.save.data.lang == null) FlxG.save.data.lang = 0; // number corresponds to the 'languages' array above
		if (FlxG.save.data.colorBlindFilter == null) FlxG.save.data.colorBlindFilter = 0;
		if (FlxG.save.data.laneAlpha == null) FlxG.save.data.laneAlpha = 0;
		if (FlxG.save.data.extraScrollSpeed == null) FlxG.save.data.extraScrollSpeed = 0;
		if (FlxG.save.data.instakill == null) FlxG.save.data.instakill = false;
		if (FlxG.save.data.greenscreen == null) FlxG.save.data.greenscreen = false;
		if (FlxG.save.data.luaPath == null) FlxG.save.data.luaPath = "";
		if (FlxG.save.data.autopause == null) FlxG.save.data.autopause = true;
		#if desktop if (FlxG.save.data.downscroll == null) FlxG.save.data.downscroll = false; #else FlxG.save.data.downscroll = true; #end
		if (FlxG.save.data.dfjk == null) FlxG.save.data.dfjk = false;
		if (FlxG.save.data.offset == null) FlxG.save.data.offset = 0;
		if (FlxG.save.data.fps == null) FlxG.save.data.fps = false;
		if (FlxG.save.data.fpsRain == null) FlxG.save.data.fpsRain = false;
		if (FlxG.save.data.fpsCap == null) FlxG.save.data.fpsCap = 120;
		if (FlxG.save.data.accuracyMod == null) FlxG.save.data.accuracyMod = 1;
		if (FlxG.save.data.resetButton == null) FlxG.save.data.resetButton = true;
		if (FlxG.save.data.botplay == null) FlxG.save.data.botplay = false;
		if (FlxG.save.data.comboViewOption == null) FlxG.save.data.comboViewOption = true;
		if (FlxG.save.data.antialias == null) FlxG.save.data.antialias = true;
		if (FlxG.save.data.secTime == null) FlxG.save.data.secTime = true;
		if (FlxG.save.data.flashing == null) FlxG.save.data.flashing = true;
		if (FlxG.save.data.missSounds == null) FlxG.save.data.missSounds = true;
		if (FlxG.save.data.healthBarAlpha == null) FlxG.save.data.healthBarAlpha = 1;
		#if desktop if (FlxG.save.data.shaders == null) FlxG.save.data.shaders = true; #else FlxG.save.data.shaders = false; #end
		if (FlxG.save.data.menuinst == null) FlxG.save.data.menuinst = true;
		if (FlxG.save.data.skipScenes == null) FlxG.save.data.skipScenes = false;
		if (FlxG.save.data.shaking == null) FlxG.save.data.shaking = true;
		if (FlxG.save.data.hud == null) FlxG.save.data.hud = false;

		// PROGRESSION THINGS
		if (FlxG.save.data.freeplayUnlocked == null) FlxG.save.data.freeplayUnlocked = false;
		if (FlxG.save.data.firstTimeErect == null) FlxG.save.data.firstTimeErect = true;
		if (FlxG.save.data.erectSongs == null) FlxG.save.data.erectSongs = [];
		if (FlxG.save.data.songsBeaten == null) FlxG.save.data.songsBeaten = [];
		if (FlxG.save.data.unlockedSongs == null) FlxG.save.data.unlockedSongs = ['space-symphony', 'arcade-sludgefest'];

		unlockedSongsArray = FlxG.save.data.unlockedSongs;
		songBeatenArray = FlxG.save.data.songsBeaten;
		erectSongsBeaten = FlxG.save.data.erectSongs;
		LangUtil.curLang = languages[FlxG.save.data.lang];
		Difficulty.init();
		Conductor.recalculateTimings();
		PlayerSettings.player1.controls.loadKeyBinds();
		KeyBinds.keyCheck();
		FlxG.save.bind('FnO');
		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
	}
}