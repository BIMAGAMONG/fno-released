package;
import Section.SwagSection;
import Song.SwagSong;
import flixel.FlxBasic;
import flixel.FlxCamera; 
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flash.system.System;
import flixel.graphics.FlxGraphic;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxAssets;
import flixel.sound.FlxSound;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import gamejolt.GJClient;
import haxe.Exception;
import haxe.Json;
import lime.graphics.Image;
import lime.media.AudioContext;
import lime.media.AudioManager;
import lime.utils.Assets;
import openfl.Lib;
import openfl.display.BitmapData;
import lime.app.Application;
import flash.geom.ColorTransform;
import flixel.effects.FlxFlicker;
using StringTools;
import hxvlc.flixel.FlxVideo as VideoHandler;
import minigames.*;
import shad.*;
#if mobile
import openfl.filesystem.File;
#end

typedef SongDatabase ={
	hasDialog:Bool,
	hasCutscene:Bool,
	audiostuff:String,
	visuals:String,
	rpcquote:String,
	misc:String,
	hidegf:Bool,
	hasPostCutscene:Bool,
	hasPostDialogue:Bool
}

class PlayState extends MusicBeatState{
	public static var curSongData:SongDatabase;
	public static var type:String = "";
	public static var weekSicks:Int = 0;
	public static var weekGoods:Int = 0;
	public static var weekBads:Int = 0;
	public static var weekShits:Int = 0;
	public static var weekMisses:Int = 0;
	public static var totalWeekScore:Int = 0;
	public static var meanAccuracy:Float = 0;
	public static var weekNotesHit:Int = 0;
	public static var weekTotalNotesinSong:Int = 0;
	public static var weekCoins:Float = 0;
	public static var weekGems:Float = 0;
	public static var instance:PlayState = null;
	public static var curStage:String = '';
	public static var SONG:SwagSong = null;
    public static var songStringer:String = "";
	public static var isStoryMode:Bool = false;
	public static var isFreeplay:Bool = false;
	public static var isStoryFreeplay:Bool = false;
	public static var isFreeplayWeek:Bool = false;
	public static var storyWeek:Int = 0;
	public static var storyPlaylist:Array<String> = [];
	public static var storyDifficulty:Int = 1;
	public static var shits:Int = 0;
	public static var bads:Int = 0;
	public static var goods:Int = 0;
	public static var sicks:Int = 0;
	public static var misses:Int = 0;
	public static var exiting:Bool = false;
	var limit:Float = 2;
	public var dadCamX:Int = 0;
	public var dadCamY:Int = 0;
	public var bfCamX:Int = 0;
	public var bfCamY:Int = 0;
	public var gfCamX:Int = 0;
	public var gfCamY:Int = 0;
	public var songPosBG:FlxSprite;
	public var songPosBar:FlxBar;
	public var storyAch:Bool;
	public var freeplayextraach:Bool;
	public var freeplaybrawlach:Bool;
	var songLength:Float = 0;
	private var vocals:FlxSound;
	public var dad:Character = null;
	public var gf:Character = null;
	public var boyfriend:Character = null;
	public var singer3:Character = null;
	public var singer4:Character = null;
	public var notes:FlxTypedGroup<Note>;
	private var unspawnNotes:Array<Note> = [];
	public var strumLine:FlxSprite;
	private var curSection:Int = 0;
	private var camFollow:FlxObject;
	private var prevCamFollow:FlxObject;
	public var strumLineNotes:FlxTypedGroup<FlxSprite> = null;
	public var playerStrums:FlxTypedGroup<FlxSprite> = null;
	public var cpuStrums:FlxTypedGroup<FlxSprite> = null;
	public var grpBG:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	public var grpFG:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	public var grpICONS:FlxTypedGroup<HealthIcon> = new FlxTypedGroup<HealthIcon>();
	public var grpRate:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	public var grpBARS:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	private var curSong:String = "";
	private var gfSpeed:Int = 1;
	public var health:Float = 1;
	private var combo:Int = 0;
	private var accuracy:Float = 0.00;
	private var accuracyDefault:Float = 0.00;
	private var totalNotesHit:Float = 0;
	private var totalNotesHitDefault:Float = 0;
	private var totalPlayed:Int = 0;
	public var acutallyHitNotes:Int = 0;
	public var healthBarBG:FlxSprite;
	public var healthBar:FlxBar;
	#if desktop 
	public var healthBarOpponent:FlxBar;
	public var healthBarBGOpponent:FlxSprite;
	#end
	private var curTime:Float = 0;
	private var generatedMusic:Bool = false;
	private var startingSong:Bool = false;
	public var iconP1:HealthIcon;
	public var iconP2:HealthIcon;
	public var iconP3:HealthIcon = null;
	public var camHUD:FlxCamera;
	private var camOther:FlxCamera;
	private var camGame:FlxCamera;
	public var camGREEN:FlxCamera = null;
	var notesHitArray:Array<Date> = [];
	var currentFrames:Int = 0;
	public var songName:FlxText;
	var blackout:FlxSprite;
	public var songAuthor:String;
	var songScore:Int = 0;
	var scoreTxt:FlxText;
	public var bg:FlxSprite;
	var defaultCamZoom:Float = 0.9;
	var inCutscene:Bool = false;
	var dialogueOn:Bool = false;
	public var canPause:Bool = false;
	var startedCountdown:Bool = false;
	#if windows
	public var stateText:String = "";
	public var smallImage:String = "";
	#end
	var yt:FlxSprite;
	var blocc:FlxSprite;
	var boos:FlxSprite;
	var audience:FlxSprite;
	var corruptSky:FlxBackdrop;
	var hoshi:FlxSprite;
	var jumpscareLaugh:FlxSprite;
	var jumpscareStatic:FlxSprite;
	var dastage:FlxSprite;
	var retro:FlxSprite;
	public var totalNotesInSong:Int = 0;
	public static var blockGameOver:Bool = false;
	public var daDir:Array<String> = ['LEFT', 'DOWN', 'UP', 'RIGHT'];
	public var dadDir:Array<String> = ['LEFT', 'RIGHT', 'UP', 'DOWN'];
	public static var stateIsRestarted:Bool = false;
	public var disableCam:Bool = false;
	public var camBackToGF:FlxTimer = new FlxTimer();
	public var isEndOfSong:Bool = false;
	var stepEvents:Array<StepEvent> = [];
	var bfIdle:FlxTimer = new FlxTimer();
	var countTmr:FlxTimer = new FlxTimer();
	var def:Float = 0.1;
	#if mobile
	var pBut:FlxSprite;
	#end
	// SHADERS
	public var vig:Vignette = null;
	public var crt:CRT = null;
	public var spc:SpaceShader = null;

	// functions from events, code taken from Indie Cross.
	function makeEvent(step:Int, callback:Void -> Void) stepEvents.push(new StepEvent(step, callback));
	function multipleEvents(steps:Array<Int>, callback:Void -> Void) for(i in 0...steps.length) stepEvents.push(new StepEvent(steps[i], callback));
	override public function create(){
		// the great variable set up
		exiting = false;
		isEndOfSong = false;
		instance = this;
		FlxG.camera.filters = [];
		if (FlxG.sound.music != null) FlxG.sound.music.stop();
		sicks = 0;
		bads = 0;
		shits = 0;
		goods = 0;
		misses = 0;
		limit = 2;

		// the great cameras set up
		camGame = new FlxCamera();
		if (FlxG.save.data.greenscreen) camGREEN = new FlxCamera();
		camHUD = new FlxCamera();
		camOther = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		camOther.bgColor.alpha = 0;
		FlxG.cameras.reset(camGame);
		if (FlxG.save.data.greenscreen) FlxG.cameras.add(camGREEN);
		FlxG.cameras.add(camHUD);
		FlxG.cameras.add(camOther);
		@:privateAccess
		FlxCamera._defaultCameras = [camGame];

		persistentUpdate = true;
		persistentDraw = true;
		if (SONG == null) SONG = Song.loadFromJson('red-x');

		Conductor.mapBPMChanges(SONG);
		Conductor.changeBPM(SONG.bpm);
		add(grpBG);
		curStage = SONG.stage;

		// this massive switch statement is for loading the stages
		var stagePath:String = "";
		switch (SONG.stage){
			case 'arcade':{
					defaultCamZoom = 0.7;
					bg = new FlxSprite(-500, -100).loadGraphic(Paths.bg('extras/arcade'));
					bg.antialiasing = FlxG.save.data.antialias;
					bg.setGraphicSize(Std.int(bg.width / 1.5));
					bg.screenCenter();
					grpBG.add(bg);
				}
			case 'bima':{
					var city:FlxSprite = new FlxSprite(-500, -100).loadGraphic(Paths.bg('bimaBack'));
					city.antialiasing = FlxG.save.data.antialias;
					city.scrollFactor.set(0.6, 0.6);
					grpBG.add(city);

					bg = new FlxSprite(-500, -100).loadGraphic(Paths.bg('bima'));
					bg.antialiasing = FlxG.save.data.antialias;
					grpBG.add(bg);

					var lamp:FlxSprite = new FlxSprite(-500, -100).loadGraphic(Paths.bg('bimaLamp'));
					lamp.y += lamp.height / 1.5;
					lamp.antialiasing = FlxG.save.data.antialias;
					grpFG.add(lamp);
				}
			case 'ghost':{
					stagePath = 'ERECT';
					bg = new FlxSprite(0, 0);
					bg.frames = Paths.bgSheet('extras/maro/bgGhost');
					bg.animation.addByPrefix('light', 'bg_', 9, true);
					bg.animation.play('light');
					bg.scrollFactor.set(0.9, 0.9);
					bg.screenCenter();
					bg.antialiasing = false;
					grpBG.add(bg);

					boos = new FlxSprite(0, 0);
					boos.frames = Paths.bgSheet('extras/maro/spoopy');
					boos.animation.addByPrefix('spoky', 'Spok_', 9, true);
					boos.animation.play('spoky');
					boos.alpha = 0;
					boos.screenCenter();
					boos.antialiasing = false;
					grpBG.add(boos);

					blocc = new FlxSprite(0, 0).loadGraphic(Paths.bg(type == '-erect' ? 'erect/normalBloccERECT' : 'extras/maro/normalBlocc'));
					blocc.screenCenter();
					blocc.y += blocc.height - 50;
					blocc.antialiasing = false;
					grpBG.add(blocc);

					var bloccBF:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.bg(type == '-erect' ? 'erect/bfBlocksERECT' : 'extras/maro/bfBlocks'));
					bloccBF.screenCenter();
					bloccBF.x += 452;
					bloccBF.y = blocc.y + 96;
					bloccBF.antialiasing = false;
					grpBG.add(bloccBF);
				}
			case 'future':{
					defaultCamZoom = 0.6;
					bg = new FlxSprite(-600, -200).loadGraphic(Paths.bg('extras/bread/far'));
					bg.antialiasing = FlxG.save.data.antialias;
					bg.screenCenter();
					bg.scrollFactor.set(0.9, 0.9);
					grpBG.add(bg);

					var midBG:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.bg('extras/bread/middle'));
					midBG.antialiasing = FlxG.save.data.antialias;
					midBG.screenCenter();
					midBG.scrollFactor.set(0.95, 0.95);
					midBG.y += 208;
					grpBG.add(midBG);

					var foreG:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.bg('extras/bread/floor'));
					foreG.antialiasing = FlxG.save.data.antialias;
					foreG.screenCenter();
					foreG.y += foreG.height + 100;
					grpBG.add(foreG);
				}
			case 'lab':{
					bg = new FlxSprite(0, 0).loadGraphic(Paths.bg('extras/eyeskkx/lab'));
					bg.antialiasing = FlxG.save.data.antialias;
					bg.setGraphicSize(Std.int(bg.width / 3));
					bg.screenCenter();
					grpBG.add(bg);

					var fg:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.bg('extras/eyeskkx/labFG'));
					fg.antialiasing = FlxG.save.data.antialias;
					fg.setGraphicSize(Std.int(fg.width / 3));
					fg.screenCenter();
					#if desktop fg.x -= 520; #else fg.x -= 620; #end
					fg.y += 360;
					grpFG.add(fg);
				}
			case 'brawlCraft':{
					defaultCamZoom = #if desktop 0.5 #else 0.6 #end;
					switch(type){
						case '-erect':
							stagePath = "erect/stageERECT";
							corruptSky = new FlxBackdrop(Paths.bg('corruptSky'), XY);
							corruptSky.updateHitbox();
							corruptSky.antialiasing = false;
							corruptSky.setGraphicSize(Std.int(corruptSky.width * 0.7));
							corruptSky.screenCenter();
							corruptSky.velocity.x = -30;
							corruptSky.velocity.y = 30;
							grpBG.add(corruptSky);
						default:
							stagePath = "brawlCraft";
							audience = new FlxSprite(-50, 580);
							audience.frames = Paths.bgSheet('audience');
							audience.scale.set(1.7, 1.7);
							audience.alpha = 0.65;
							audience.antialiasing = FlxG.save.data.antialias;
							audience.animation.addByPrefix('play', 'idle', 24, true);
							audience.animation.play('play');

							dastage = new FlxSprite(-600, -100).loadGraphic(Paths.bg('brawlCraftPlatform'));
							dastage.antialiasing = FlxG.save.data.antialias;
							dastage.setGraphicSize(Std.int(dastage.width / 1.5));
							dastage.screenCenter();
							dastage.y -= 230;
					}

					bg = new FlxSprite(-600, -100).loadGraphic(Paths.bg(stagePath));
					bg.antialiasing = FlxG.save.data.antialias;
					bg.setGraphicSize(Std.int(bg.width / 1.5));
					bg.screenCenter();
					if (stagePath == 'erect/stageERECT') bg.y += 530;
					grpBG.add(bg);

					if (type != '-erect'){
						grpFG.add(dastage);
						grpFG.add(audience);
					}
				}
			case 'blas':{
					bg = new FlxSprite(-600, -100).loadGraphic(Paths.bg('brawl/blas/BLASSSSSSSSS'));
					bg.antialiasing = FlxG.save.data.antialias;
					bg.screenCenter();
					grpBG.add(bg);

					var max:FlxSprite = new FlxSprite(-330, -100).loadGraphic(Paths.bg('brawl/blas/maxSpeen'));
					max.frames = Paths.bgSheet('brawl/blas/maxSpeen');
					max.setGraphicSize(Std.int(max.width * 0.7));
					max.animation.addByPrefix('max', 'max', 24, true);
					max.animation.play('max');
					max.screenCenter();
					grpBG.add(max);
				}
			case 'space':{
					var sp:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.bg('space_back'));
					if(FlxG.save.data.shaders) sp.shader = spc = new SpaceShader();
					else sp.scale.set(1.3, 1.3);
					sp.antialiasing = FlxG.save.data.shaders ? false : FlxG.save.data.antialias;
					sp.screenCenter();
					if(FlxG.save.data.shaders) sp.y += 150;
					grpBG.add(sp);

					bg = new FlxSprite(0, 0).loadGraphic(Paths.bg('space'));
					bg.antialiasing = FlxG.save.data.antialias;
					bg.scale.set(1.3, 1.3);
					bg.screenCenter();
					grpBG.add(bg);

					var gr:FlxSprite = new FlxSprite(bg.x, bg.y + (bg.height / 1.5)).loadGraphic(Paths.bg('space_ground'));
					gr.antialiasing = FlxG.save.data.antialias;
					gr.scale.set(1.3, 1.3);
					grpBG.add(gr);

					var light:FlxSprite = new FlxSprite(bg.x, bg.y + 100).loadGraphic(Paths.bg('spacefront'));
					light.antialiasing = false;
					light.scale.set(1.3, 1.3);
					grpFG.add(light);

					if(type == '-erect') for(spr in [bg, gr, light]) spr.color = 0xFFED4242;
				}
			case 'brawlDesert':{
					stagePath = (type == '-erect' ? "erect/starrERECT" : 'brawl/starrForce');
					bg = new FlxSprite(-600, -100).loadGraphic(Paths.bg(stagePath));
					bg.antialiasing = FlxG.save.data.antialias;
					bg.setGraphicSize(Std.int(bg.width * 1));
					bg.screenCenter();
					grpBG.add(bg);
				}
			case 'fangbg':{
					bg = new FlxSprite(-600, -100).loadGraphic(Paths.bg('brawl/fanger'));
					bg.screenCenter();
					bg.setGraphicSize(Std.int(bg.width * 2));
					bg.antialiasing = FlxG.save.data.antialias;
					grpBG.add(bg);
				}
			case 'sakuraStage' | 'rageStage':{
					defaultCamZoom = 0.8;
					if (SONG.stage == 'sakuraStage'){
						var bglol:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.bg('sky'));
						bglol.antialiasing = FlxG.save.data.antialias;
						bglol.setGraphicSize(Std.int(bglol.width / 0.5));
						bglol.screenCenter();
						grpBG.add(bglol);
					}

					corruptSky = new FlxBackdrop(Paths.bg('corruptSky'), XY);
					corruptSky.updateHitbox();
					corruptSky.antialiasing = false;
					corruptSky.setGraphicSize(Std.int(corruptSky.width * 0.7));
					corruptSky.screenCenter();
					corruptSky.velocity.x = -30;
					corruptSky.velocity.y = 30;
					if (SONG.stage != "rageStage") corruptSky.alpha = 0;
					grpBG.add(corruptSky);

					bg = new FlxSprite(-600, -200).loadGraphic(Paths.bg('sakuraStage'));
					bg.antialiasing = FlxG.save.data.antialias;
					bg.setGraphicSize(Std.int(bg.width / 1.4));
					grpBG.add(bg);

					var cat = new FlxSprite(-370, 280).loadGraphic(Paths.bg('catSakura'));
					cat.frames = Paths.bgSheet('catSakura');
					cat.setGraphicSize(Std.int(cat.width * 1.3));
					cat.animation.addByPrefix('pro', 'catStageScreen', 24, true);
					cat.animation.play('pro');
					cat.screenCenter(X);
					cat.antialiasing = FlxG.save.data.antialias;
					grpBG.add(cat);

					if (SONG.stage == 'sakuraStage'){
						hoshi = new FlxSprite(-100, 320).loadGraphic(Paths.bg('hoshi'));
						hoshi.frames = Paths.bgSheet('hoshi');
						hoshi.setGraphicSize(Std.int(hoshi.width * 1.1));
						hoshi.animation.addByPrefix('idlecameo', 'Hoshizora IDLE DANCE', 24, true);
						hoshi.animation.play('idlecameo');
						hoshi.antialiasing = FlxG.save.data.antialias;
						grpBG.add(hoshi);
	
						audience = new FlxSprite(-50, 580);
						audience.frames = Paths.bgSheet('audience');
						audience.antialiasing = FlxG.save.data.antialias;
						audience.scale.set(1.2, 1.2);
						audience.alpha = 0.65;
						audience.animation.addByPrefix('play', 'idle', 24, true);
						audience.animation.play('play');
						grpFG.add(audience);
					}
				}
			case 'youtubeBG':{
					var coryStar:FlxBackdrop;
					coryStar = new FlxBackdrop(Paths.bg('brawl/cory/coryStar'), XY);
					coryStar.updateHitbox();
					coryStar.setGraphicSize(Std.int(coryStar.width * 0.5));
					coryStar.screenCenter();
					coryStar.velocity.set(FlxG.random.int(-30, 30), FlxG.random.int(-30, 30));
					grpBG.add(coryStar);

					yt = new FlxSprite(0, 0).loadGraphic(Paths.bg('brawl/cory/youtubeOverlay'));
					yt.antialiasing = FlxG.save.data.antialias;
					yt.scrollFactor.set(0, 0);
					yt.scale.set(1.15, 1);
					yt.y = FlxG.height - yt.height / 1.7;
					grpFG.add(yt);
				}
			default:{
					curStage = 'white';
					bg = new FlxSprite(-600, -200).makeGraphic(1300, 800, FlxColor.WHITE);
					bg.antialiasing = FlxG.save.data.antialias;
					bg.scrollFactor.set(0, 0);
					bg.screenCenter();
					grpBG.add(bg);
				}
		}

		if (FlxG.save.data.greenscreen){
			camGame.visible = false;
			var greenscreen:FlxSprite = new FlxSprite().makeGraphic(1300, 750, FlxColor.LIME);
			greenscreen.scrollFactor.set(0, 0);
			greenscreen.screenCenter();
			greenscreen.antialiasing = false;
			greenscreen.cameras = [camGREEN];
			add(greenscreen);
		}

		dad = new Character(100, 100, SONG.player2);
		dad.alpha = 1;

		// Repositioning per character
		var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);
		switch (SONG.player2){
			case "ruv":
				dad.y -= 100;
				dad.x -= 100;
			case "lowme" | "lowmealt":
				dad.x -= 100;
				dad.y += 230;
			case "spikek":
				dad.y += 260;
				dad.x -= 50;
			case "ncam": dad.y += 400;
			case "mars":
				dad.y += 300;
				dad.x -= 170;
			case "sakura": dad.y += 200;
			case "sakuraRage": dad.y += 200;
			case "bred": dad.y += 100;
		}

		boyfriend = new Character(770, 450, SONG.player1);
		boyfriend.alpha = 1;

		var songGF:String = '';
		switch(SONG.gfVersion){
			case 'gfshitpost': songGF = 'gfshitpost';
			default: songGF = 'gf';
		}
		gf = new Character(boyfriend.x - 300, boyfriend.y - 200, songGF);
		gf.scrollFactor.set(1, 1);
		gf.alpha = 1;
		if(songGF == 'gfshitpost') gf.x -= 300;

		blackout = new FlxSprite(50, 50).makeGraphic(1300, 800, FlxColor.BLACK);
		blackout.setGraphicSize(Std.int(blackout.width * 10));
		blackout.screenCenter();
		blackout.scrollFactor.set(0, 0);
		blackout.alpha = 0;
		blackout.antialiasing = false;

		// Repositioning per stage
		switch (curStage){
			case 'citysky': gf.y -= 100;
			case 'bima':
				boyfriend.y -= 80;
				gf.y -= 110;
				dad.x -= 300;
				dad.y -= 80;
				dadCamX = 200;
				dadCamY = 80;
				bfCamX = -240;
				bfCamY = -30;
				gfCamX = -200;
				#if mobile
				bfCamX = -350;
				dadCamX = 240;
				#end
			case 'future':
				boyfriend.y = 500;
				dad.y -= 70;
				bfCamX -= 50;
				#if mobile
				defaultCamZoom = FlxG.camera.zoom = 0.7;
				boyfriend.x += 50;
				gf.x += 50;
				gfCamX += 30;
				dad.x += 50;
				dadCamX += 120;
				bfCamX -= 60;
				#end
			case 'brawlDesert':
				dad.x -= 80;
				gf.x -= 20;
				boyfriend.x += 50;
			case 'space':
				boyfriend.x += 100;
				dad.x += 100;
				dad.y -= 90;
				boyfriend.y -= 100;
				gf.y -= 110;
				gf.x += 40;
				gfCamX -= 40;
				dadCamX += 110;
				bfCamX -= 170;
				#if mobile
				FlxG.camera.zoom = defaultCamZoom = 1;
				dadCamX += 50;
				bfCamX -= 50;
				boyfriend.x += 100;
				dad.x += 100;
				gf.x += 100;
				#end
			case 'brawlCraft':
				boyfriend.y -= 70;
				boyfriend.x += 50;
				gf.y -= 80;
				dad.x -= 50;
				dad.y -= 75;
				if (type == '-erect'){
					boyfriend.x += 150;
					dad.x -= 150;
				}
				#if mobile
				boyfriend.x += 100;
				dad.x += 100;
				gf.x += 100;
				#end
			case 'blas': dad.y += 330;
			case 'lab':
				boyfriend.x += 100;
				boyfriend.y -= 150;
				gf.y -= 100;
				bfCamX = -300;
				dadCamX += 200;
				#if mobile
				FlxG.camera.zoom = defaultCamZoom = 1;
				dadCamX += 100;
				bfCamX += 50;
				gfCamX += 30;
				#end
			case 'ghost':
				boyfriend.x += 290;
				boyfriend.y += 85;
				dad.x += 230;
				dad.y += 250;
				bfCamX = -200;
				gf.y -= 30;
				#if mobile
				dad.x += 100;
				boyfriend.x += 100;
				gf.x += 100;
				#end
			case 'youtubeBG':
				boyfriend.y -= 45;
				boyfriend.x += 30;
				dad.x -= 30;
				gf.y -= 20;
			case 'fangbg':
				gf.y += 10;
				dad.y += 30;
				boyfriend.x += 30;
				dad.x -= 30;
			case 'arcade':
				boyfriend.x += 85;
				boyfriend.y += 40;
				gf.y += 25;
				dad.y += 25;
				dad.x -= 100;
				gfCamX -= 80;
				gfCamY -= 65;
				#if mobile
				boyfriend.x += 85;
				dad.x += 40;
				#end
			case 'sakuraStage': gf.y -= 20;
		}

		if(singer3 != null) add(singer3);
		if(singer4 != null) add(singer4);
		add(gf);
		add(dad);
		add(boyfriend);
		switch (SONG.song){
			case 'space-trap' | 'regenerator' | 'swearing': singer3 = new Character(dad.x - (dad.width / 2), dad.y + 160, "niw");
		}	
		if(singer3 != null) add(singer3);
		if(singer4 != null) add(singer4);

		// Timer for BF's color to change back after missing
		bfIdle = new FlxTimer().start(0.1, function(timer:FlxTimer){
			if (boyfriend != null) boyfriend.color = FlxColor.WHITE;
			if (singer4 != null) singer4.color = FlxColor.WHITE;
		});
		curSongData = Json.parse(Assets.getText(Paths.json(SONG.song + '/songData')));
		if (curSongData.hidegf == true) gf.alpha = 0;

		strumLine = new FlxSprite(0, 50).makeGraphic(FlxG.width, 10);
		strumLine.scrollFactor.set();
		if (FlxG.save.data.downscroll){
			strumLine.y = FlxG.height - 120;
			#if mobile strumLine.y -= 30; #end
		}

		// Lane underlay set up
		if (FlxG.save.data.laneAlpha != 0){
			lane = new FlxSprite().makeGraphic(#if desktop 390 #else 940 #end, 725, FlxColor.BLACK);
			lane.screenCenter(X);
			lane.antialiasing = false;
			lane.cameras = [camHUD];
			lane.alpha = 0;
			add(lane);
		}

		strumLineNotes = new FlxTypedGroup<FlxSprite>();
		playerStrums = new FlxTypedGroup<FlxSprite>();
		cpuStrums = new FlxTypedGroup<FlxSprite>();

		var rpcQuote:String = curSongData.rpcquote;
		switch (type){
			case '-erect': switch (SONG.song){
					case "red-x": songAuthor = "TheOrangePenguin & LeNinethGames";
					case "omnipotent": songAuthor = "LeNinethGames";
					case "question" | "starshot" | "regenerator": songAuthor = "TheOrangePenguin";
					default: songAuthor = '???';
				}
			default: switch (SONG.song){
					case "far-future": songAuthor = 'Typically';
					case "red-x": songAuthor = 'TheJuanInigoA';
					case "map-maker" | "cory-time" | "starshot" | "arcade-sludgefest" | "question" | "contest-outrage" | "go-go-disco" | "ear-killer": songAuthor = 'VectorFlame';
					case "regenerator" | "space-symphony" | "starrcade" | "sorcery": songAuthor = 'Clappers46';
					case "astral-descent": songAuthor = 'Clappers46 & KeeganKeegan';
					case "omnipotent": songAuthor = "Clappers46 & Und3rKn1ght";
					case 'ov-dezeption': songAuthor = 'Decybell';
					case 'escalated' | 'swearing': songAuthor = 'NikRetaNCAM';
					case "showdown-of-chaos": songAuthor = 'Aloe Starr';
					case 'space-trap': songAuthor = 'FuryGRTX';
					case 'sakurovania': songAuthor = 'TheUnrealBlu3Cat';
					case 'cyberchase': songAuthor = 'Fuse';
					case 'exe-test' | 'essay' | 'dynamike-song-master': songAuthor = 'bimagamongMOP';
					case 'scrunklywanklyexplodisigmabididotious': songAuthor = 'outrage gyatster gamer 69';
					default: songAuthor = '???';
				}
		}

		generateSong(SONG.song);
		songPosBG = new FlxSprite(0, 0).loadGraphic(Paths.image('timeBar', 'shared'));
		songPosBG.screenCenter(X);
		songPosBG.antialiasing = false;

		songName = new FlxText(songPosBG.x + (songPosBG.width / 2) - 30, songPosBG.y, 0, '', 16);
		songName.setFormat(Paths.font("LilitaOne-Regular.ttf"), 16, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);

		songPosBar = new FlxBar(songPosBG.x + 4, songPosBG.y + 4, LEFT_TO_RIGHT, Std.int(songPosBG.width - 8), Std.int(songPosBG.height - 8), this, 'curTime', 0, songLength);
		songPosBar.numDivisions = 2000;
		if (SONG.song == 'tutorial') songPosBar.createFilledBar(FlxColor.GRAY, 0xFFAB5260); 
		else songPosBar.createFilledBar(FlxColor.GRAY, FlxColor.fromString('#' + dad.playerColor));

		for(spr in [songPosBG, songPosBar, songName]){
			spr.antialiasing = false;
			spr.cameras = [camHUD];
			spr.alpha = 0;
			add(spr);
		}
		add(notes);
		add(strumLineNotes);
		Conductor.songPosition = -999999;
		#if desktop DiscordClient.changePresence(StringTools.replace(PlayState.SONG.song, "-", " ").toUpperCase() + " - " + songAuthor, rpcQuote, null); #end

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollow.setPosition(camPos.x, camPos.y);
		if (prevCamFollow != null){
			camFollow = prevCamFollow;
			prevCamFollow = null;
		}
		camFollow.setPosition(gf.getMidpoint().x + gfCamX, gf.getMidpoint().y + gfCamY);
		add(camFollow);

		FlxG.camera.follow(camFollow, LOCKON, 0.04);
		FlxG.camera.zoom = defaultCamZoom;
		FlxG.camera.focusOn(camFollow.getPosition());
		FlxG.worldBounds.set(0, 0, FlxG.width, FlxG.height);
		FlxG.fixedTimestep = false;

		// Healthbar Hell
		healthBarBG = new FlxSprite(0, strumLine.y + 40).loadGraphic(Paths.image('healthBar', 'shared'));
		healthBarBG.screenCenter(X);
		#if desktop healthBarBG.x += 380; #end
		grpBARS.add(healthBarBG);

		healthBar = new FlxBar(healthBarBG.x + 4, healthBarBG.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBG.width - 8), Std.int(healthBarBG.height - 8), this, 'health', 0, limit);
		#if desktop
		if(singer4 != null) healthBar.createGradientBar([FlxColor.RED], [FlxColor.fromString('#' + singer4.playerColor), FlxColor.fromString('#' + boyfriend.playerColor)], 6, 90, false);
		else healthBar.createFilledBar(FlxColor.RED, FlxColor.fromString('#' + boyfriend.playerColor));
		#else
		if(singer3 != null && singer4 == null) healthBar.createGradientBar([FlxColor.fromString('#' + singer3.playerColor), FlxColor.fromString('#' + dad.playerColor)], [FlxColor.fromString('#' + boyfriend.playerColor)], 6, 90, false);
		else if(singer3 == null && singer4 != null) healthBar.createGradientBar([FlxColor.fromString('#' + dad.playerColor)], [FlxColor.fromString('#' + singer4.playerColor), FlxColor.fromString('#' + boyfriend.playerColor)], 6, 90, false);
		else if(singer3 != null && singer4 != null) healthBar.createGradientBar([FlxColor.fromString('#' + singer3.playerColor), FlxColor.fromString('#' + dad.playerColor)], [FlxColor.fromString('#' + singer4.playerColor), FlxColor.fromString('#' + boyfriend.playerColor)], 6, 90, false);
		else healthBar.createFilledBar(FlxColor.fromString('#' + dad.playerColor), FlxColor.fromString('#' + boyfriend.playerColor));
		#end
		grpBARS.add(healthBar);

		#if desktop
		healthBarBGOpponent = new FlxSprite(0, strumLine.y + 40).loadGraphic(Paths.image('healthBar', 'shared'));
		healthBarBGOpponent.screenCenter(X);
		healthBarBGOpponent.x -= 380;
		grpBARS.add(healthBarBGOpponent);

		healthBarOpponent = new FlxBar(healthBarBGOpponent.x + 4, healthBarBGOpponent.y + 4, RIGHT_TO_LEFT, Std.int(healthBarBGOpponent.width - 8), Std.int(healthBarBGOpponent.height - 8), this, 'health', 0, limit);
		if(singer3 != null) healthBarOpponent.createGradientBar([FlxColor.fromString('#' + singer3.playerColor), FlxColor.fromString('#' + dad.playerColor)], [FlxColor.RED], 6, 90, false);
		else healthBarOpponent.createFilledBar(FlxColor.fromString('#' + dad.playerColor), FlxColor.RED);
		grpBARS.add(healthBarOpponent);
		#end

		iconP1 = new HealthIcon(SONG.player1, true);
		iconP1.y = healthBar.y - (iconP1.height / 2) - 10;
		iconP1.x = (healthBar.x + healthBar.width) - (iconP1.width / 2);
	
		iconP2 = new HealthIcon(SONG.player2, false);
		iconP2.y = #if desktop healthBarOpponent.y #else healthBar.y #end - (iconP2.height / 2) - 10;
		iconP2.x = #if desktop healthBarOpponent.x #else healthBar.x #end - (iconP2.width / 2);

		// ICONS FOR SINGER3
		switch (SONG.song){
			case 'dadrap': iconP3 = new HealthIcon(singer3.curChar, false);
			case 'space-trap' | 'regenerator' | 'swearing': iconP3 = new HealthIcon(singer3.curChar, false);
		}

		if (iconP3 != null){
			iconP3.y = iconP2.y - 30;
			iconP3.x = #if desktop healthBarOpponent.x #else healthBar.x #end;
			grpICONS.add(iconP3);		
			grpBARS.add(iconP3);
		}

		for (ic in [iconP1, iconP2]){
			ic.alpha = 0;
			grpICONS.add(ic);
			grpBARS.add(ic);
		}

		// Setting up some things for a lot of songs
			switch (SONG.song){
				case 'starshot':
					if (type == "-erect"){
						camSwitch(camHUD, 0, 0);	
						camSwitch(camGame, 0, 0);
					}				
				case 'space-trap' | 'regenerator':
					camSwitch(camHUD, 0, 0);	
					if (type == '-erect' || SONG.song == 'space-trap'){
						bgSwitch(0, 0);
						charSwitch(boyfriend, 0, 0);
						charSwitch(dad, 0, 0);
						charSwitch(gf, 0, 0);
						charSwitch(singer3, 0, 0);
					}
				case 'arcade-sludgefest' | 'starrcade':
					camSwitch(camHUD, 0, 0);
					blackout.alpha = 1;										
				case 'escalated':
					jumpscareLaugh = new FlxSprite(Paths.bg('extras/maro/marojumpscare'));
					jumpscareLaugh.frames = Paths.bgSheet('extras/maro/marojumpscare');
					jumpscareLaugh.animation.addByPrefix('scare', 'Laffsalottas_', 14, false);
					jumpscareLaugh.animation.play('scare');
					jumpscareLaugh.setGraphicSize(Std.int(jumpscareLaugh.width * 7.3));

					jumpscareStatic = new FlxSprite(Paths.bg('extras/maro/maroStatic'));
					jumpscareStatic.setGraphicSize(Std.int(jumpscareStatic.width * 0.25));

					for(obj in [jumpscareLaugh, jumpscareStatic]){
						obj.alpha = 0;
						obj.cameras = [camOther];
						obj.antialiasing = false;
						obj.screenCenter();
					}

					camSwitch(camHUD, 0, 0);
					bgSwitch(0, 0);
					boyfriend.alpha = 0;
					dad.alpha = 0;
				case 'astral-descent': blackout.alpha = 1;
				case 'cory-time': camSwitch(camHUD, 0, 0);	
				case 'red-x' | 'omnipotent':
					switch(SONG.song){
						case 'omnipotent':
							blackout.alpha = 1;
							FlxG.camera.zoom = 0.8;
							camSwitch(camHUD, 0, 0);
						case 'red-x':
							if (type == '-erect'){
								camSwitch(camHUD, 0, 0);
								blackout.alpha = 1;
							}
					}
				case 'map-maker' | 'question' | 'contest-outrage':
					if (SONG.song != 'contest-outrage'){
						FlxG.camera.zoom = 0.8;
						if (SONG.song == "question"){
							blackout.alpha = 1;	
							FlxG.camera.zoom = 0.8;		
							camSwitch(camHUD, 0, 0);
						}
					}		
			}

		add(grpFG);
		add(grpBARS);
		add(blackout);

			switch(SONG.song){
				case 'escalated':
					add(jumpscareLaugh);
					add(jumpscareStatic);
			}

		scoreTxt = new FlxText(FlxG.width / 2, FlxG.save.data.downscroll ? 40 : 650, 0, "", 20);
		scoreTxt.setFormat(Paths.font("LilitaOne-Regular.ttf"), 25, FlxColor.fromString('#' + dad.playerColor), CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set(0, 0);
		switch (SONG.song){
			case 'escalated': scoreTxt.setBorderStyle(OUTLINE, FlxColor.WHITE, 1, 1);
			default: scoreTxt.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		}
		if (SONG.song == 'tutorial') scoreTxt.color = 0xFFAB5260;
		scoreTxt.alpha = 0;
		scoreTxt.visible = !FlxG.save.data.hud;
		add(scoreTxt);

		for(obj in [strumLineNotes, notes, scoreTxt]) obj.cameras = [camHUD];
		strumLineNotes.cameras = [camHUD];
		notes.cameras = [camHUD];
		for (shiz in grpBARS.members){
			shiz.alpha = 0;
			shiz.scrollFactor.set(0, 0);
			shiz.antialiasing = false;
			shiz.cameras = [camHUD];
		}
		for (icon in grpICONS.members){
			icon.antialiasing = FlxG.save.data.antialias;
			icon.centerOrigin();
		}
		startingSong = true;
		startedCountdown = false;

		if (FlxG.save.data.shaders){
			switch (SONG.song){
				case 'escalated':
					crt = new CRT();
					for(ca in [camGame, camHUD, camOther, camGREEN]) if(ca != null) ca.filters = [new ShaderFilter(crt)];
				case 'space-symphony':
					if(type == '-erect'){
						vig = new Vignette();
						vig.set_strength(20.0);
						vig.set_reach(0.5);
						camGame.filters = [new ShaderFilter(vig)];
					}
			}
		}

		#if mobile
		pBut = new FlxSprite().loadGraphic(Paths.image('mobile/pause_button'));
		pBut.antialiasing = false;
		pBut.scrollFactor.set(0, 0);
		pBut.cameras = [camOther];
		pBut.alpha = 0.5;
		pBut.x = FlxG.width - pBut.width - 5;
		pBut.y = 5;
		add(pBut);
		#end
		super.create();

		if(SONG.song == 'tutorial'){
			dad.alpha = 0;
			iconP2.changeIcon('gf');
			#if desktop healthBarOpponent.createFilledBar(0xFFAB5260, FlxColor.RED); #else healthBar.createFilledBar(0xFFAB5260, FlxColor.fromString('#' + boyfriend.playerColor)); #end
		}

		camBackToGF.start(0.1, function(tmr:FlxTimer){if (!disableCam && !exiting) camFollow.setPosition(gf.getMidpoint().x + gfCamX, gf.getMidpoint().y + gfCamY);});

		// Setting up cutscenes & dialogue
		var dialPath:String = #if mobile "songs:" + #end 'assets/songs/' + SONG.song + '/dialogue-${LangUtil.curLang}.txt';
		if (type == "" && !stateIsRestarted && !FlxG.save.data.skipScenes){
			dialogueOn = curSongData.hasDialog;
			inCutscene = curSongData.hasCutscene;
			if (dialogueOn && !inCutscene) initPreSongThing(1, dialPath);
			else if (inCutscene && !dialogueOn) initPreSongThing(0);
			else if (inCutscene && dialogueOn) initPreSongThing(2, dialPath);
			else countTmr.start(1, function(tmr:FlxTimer){startCountdown();});
		}else countTmr.start(1, function(tmr:FlxTimer){startCountdown();});
		add(grpRate);
		dialPath = null;
		cookMeThemEvents();
	}

	// automatic camera system!!
	public function changeCameraPosition(posX:Float, posY:Float, ?reqTime:Int = 2){
		camFollow.setPosition(posX, posY);
		camBackToGF.reset(reqTime);
	}

	function startVideo(typeNo:Int, ?dial:String, ?daList:Array<String>){
		video = new VideoHandler();
		video.load(Paths.codeShitVideo('cutscenes/' + SONG.song));
		video.play();
		FlxG.addChildBelowMouse(video);
		video.onEndReached.add(function(){
			switch(typeNo){
				case 0: startCountdown();
				case 1:
					if (#if desktop FileSystem.exists(dial) #else Assets.exists(dial) #end) startDialogue(dial, daList);
					else startCountdown();
				case 2: endDaSongfr();
			}
			video.dispose();
			FlxG.removeChild(video);
			video = null;
			return;
		});
	}
	
	public var video:VideoHandler = null;
	public function initPreSongThing(typeNo:Int, ?dial:String){
		var daPath:String = 'assets/codeshit/cutscenes/' + SONG.song + '.mp4';
		var daList:Array<String> = null;
		switch (typeNo){
			case 0:
				if (#if desktop FileSystem.exists(daPath) #else Assets.exists(daPath) #end) startVideo(0);
				else startCountdown();
			case 1:
				if (#if desktop FileSystem.exists(dial) #else Assets.exists(dial) #end) startDialogue(dial, daList);
				else startCountdown();
			case 2:
				if (#if desktop FileSystem.exists(daPath) #else Assets.exists(daPath) #end) startVideo(1, dial, daList);
				else startCountdown();									
		}
	}

	function startDialogue(dial:String, daList:Array<String>){
		inCutscene = false;
		daList = #if desktop sys.io.File.getContent(dial).trim().split('\n'); #else Assets.getText(dial).trim().split('\n'); #end
		for (i in 0...daList.length) daList[i] = daList[i].trim();
		openSubState(new DialogueBox(daList));
	}

	var pop:CreditPopup = null;
	public function triggerCredits(){
		var credTmr:FlxTimer = new FlxTimer();
		FlxTween.tween(songName, {y: songName.y + 10, alpha: FlxG.save.data.healthBarAlpha}, 1, {ease: FlxEase.circOut});
		if (type == "-erect" && FlxG.save.data.shaking) camOther.shake(0.001, 7, null, true);
		var outrageMixes:Array<String> = ['tutorial', 'arcade-sludgefest'];
		var daStr:String = SongLangUtil.trans(SONG.song.toUpperCase());

		if(type == '-erect') daStr += ' [ERECT]';
		else if(outrageMixes.contains(SONG.song)) daStr += " [OUTRAGE]";

		pop = new CreditPopup();
		pop.cameras = [camOther];
		pop.activate(StringTools.replace(daStr, '-', ' '), songAuthor.toUpperCase());
		add(pop);
		FlxTween.tween(pop, {alpha: 1}, 1, {ease: FlxEase.elasticInOut});
		credTmr.start(6, function(_){
			FlxTween.tween(pop, {alpha: 0}, 1, {ease: FlxEase.elasticInOut, onComplete: function(_){
				pop.destroy();
				remove(pop);
				credTmr.destroy();
			}});
		});
	}

	var startTimer:FlxTimer;
	public var skipCount:Bool = false;
	public var lane:FlxSprite = null;
	function startCountdown():Void{
		inCutscene = false;
		dialogueOn = false;
		stateIsRestarted = false;
		if (lane != null) FlxTween.tween(lane, {alpha: FlxG.save.data.laneAlpha}, 1);
		
		generateStaticArrows(0);
		generateStaticArrows(1);
		startedCountdown = true;
		Conductor.songPosition = 0 - (Conductor.crochet * 5);

		var swagCounter:Int = 0;
		var skipCountdownForSongs:Array<String> = switch(type){
			case '-erect': ["red-x", "question", "regenerator", "starshot"];
			default: ["escalated", "omnipotent", "question"];
		}

		var count:FlxSprite = new FlxSprite();
		count.antialiasing = false;
		count.alpha = 0;
		count.cameras = [camOther];
		add(count);

		if (skipCountdownForSongs.contains(PlayState.SONG.song) && (isFreeplay || isStoryMode)){
			skipCount = true;
			count.destroy();
			remove(count);
		}

		var ln:String = LangUtil.curLang;
		startTimer = new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer){
			for(ch in [dad, gf, boyfriend, singer3, singer4]) if (ch != null) ch.dance();

			if (!skipCount){
				switch (swagCounter){
					case 0:
						count.loadGraphic(Paths.image('introAssets/beforeready', 'shared'));
						FlxG.sound.play(Paths.sound('introSounds/intro3-' + ln), 0.6);
					case 1:
						count.loadGraphic(Paths.image('introAssets/ready', 'shared'));
						FlxG.sound.play(Paths.sound('introSounds/intro2-' + ln), 0.6);
					case 2:
						count.loadGraphic(Paths.image('introAssets/set', 'shared'));
						FlxG.sound.play(Paths.sound('introSounds/intro1-' + ln), 0.6);
					case 3:
						count.loadGraphic(Paths.image('introAssets/go-' + ln, 'shared'));
						FlxG.sound.play(Paths.sound('introSounds/introGo-' + ln), 0.6);
					case 4:		
						count.destroy();
						remove(count);
				}

				if (swagCounter < 4){
					FlxTween.cancelTweensOf(count);
					count.screenCenter();
					count.alpha = 1;
					FlxTween.tween(count, {alpha: 0}, Conductor.crochet / 1000, {ease: FlxEase.cubeInOut});
				}
				swagCounter += 1;
			}
		}, 5);
	}

	var previousFrameTime:Int = 0;
	var songTime:Float = 0;
	function startSong():Void{
		startingSong = false;
		previousFrameTime = FlxG.game.ticks;

		FlxG.sound.playMusic(Paths.inst(PlayState.SONG.song, type), 1, false);
		FlxG.sound.music.onComplete = endSong;
		vocals.play();

		if (!FlxG.save.data.hud){
			FlxTween.tween(songPosBG, {y: songPosBG.y + 10, alpha: FlxG.save.data.healthBarAlpha}, 1, {ease: FlxEase.circOut});
			FlxTween.tween(songPosBar, {y: songPosBar.y + 10, alpha: FlxG.save.data.healthBarAlpha}, 1, {ease: FlxEase.circOut});
		}else{
			for(spr in [songPosBG, songPosBar, songName]){
				spr.destroy();
				remove(spr);
				spr = null;
			}
		}

		for (shiz in grpBARS.members) FlxTween.tween(shiz, {y: shiz.y + 10, alpha: FlxG.save.data.healthBarAlpha}, 1, {ease: FlxEase.circOut});	
		FlxTween.tween(scoreTxt, {y: scoreTxt.y + 10, alpha: FlxG.save.data.healthBarAlpha}, 1, {ease: FlxEase.circOut});	

		#if desktop
		var checkForLua:Array<String> = FileSystem.readDirectory('assets/songs/' + SONG.song);
		var daHell:Int = 0;
		for (item in 0...checkForLua.length){
			if (checkForLua[daHell].endsWith(".lua")){
				blockGameOver = true;
				FlxG.save.data.luaPath = "assets/songs/" + SONG.song;
				FlxG.save.flush();
				health -= 3;
				openfl.Lib.application.window.alert(LangUtil.translate("You thought lua would work? This ain't Psych Engine bud.\nKade Engine lua ain't helping ya either.\nPress 'OK' to continue."));
			}
			daHell += 1;
		}
		#end
		startTimer = new FlxTimer().start(1, function(timer:FlxTimer){
			resyncVocals();
			canPause = true;
			startTimer.destroy();
			countTmr.destroy();
		});
	}

	var debugNum:Int = 0;
	private function generateSong(dataPath:String):Void{
		var songData = SONG;
		Conductor.changeBPM(songData.bpm);
		curSong = songData.song;

		FlxG.sound.music.loadEmbedded(Paths.inst(PlayState.SONG.song, type));
		if (SONG.needsVoices){
			vocals = new FlxSound().loadEmbedded(Paths.voices(PlayState.SONG.song, type));
			vocals.onComplete = function():Void{vocals.stop();}
		}else vocals = new FlxSound();

		switch(curSong){
			default: songLength = FlxG.sound.music.length;
		}
		FlxG.sound.list.add(vocals);
		notes = new FlxTypedGroup<Note>();

		var noteData:Array<SwagSection>;
		noteData = songData.notes;
		var playerCounter:Int = 0;

		var daBeats:Int = 0;
		for (section in noteData){
			var coolSection:Int = Std.int(section.lengthInSteps / 4);
			for (songNotes in section.sectionNotes){
				var daStrumTime:Float = songNotes[0] + FlxG.save.data.offset;
				if (daStrumTime < 0) daStrumTime = 0;
				var daNoteData:Int = Std.int(songNotes[1] % 4);
				var daNoteStyle:String = songNotes[3];
				var gottaHitNote:Bool = section.mustHitSection;
				if (songNotes[1] > 3) gottaHitNote = !section.mustHitSection;

				var oldNote:Note;
				if (unspawnNotes.length > 0) oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
				else oldNote = null;

				var swagNote:Note = new Note(daStrumTime, daNoteData, oldNote, false, daNoteStyle);
				swagNote.sustainLength = songNotes[2];
				swagNote.scrollFactor.set(0, 0);

				var susLength:Float = swagNote.sustainLength;
				susLength = susLength / Conductor.stepCrochet;

				for (susNote in 0...Math.floor(susLength)){
					oldNote = unspawnNotes[Std.int(unspawnNotes.length - 1)];
					var sustainNote:Note = new Note(daStrumTime + (Conductor.stepCrochet * susNote) + Conductor.stepCrochet, daNoteData, oldNote, true, daNoteStyle);
					sustainNote.scrollFactor.set();
					unspawnNotes.push(sustainNote);
					sustainNote.mustPress = gottaHitNote;
					if (sustainNote.mustPress) sustainNote.x += FlxG.width / 2;
				}
				unspawnNotes.push(swagNote);
				swagNote.mustPress = gottaHitNote;
				if (swagNote.mustPress) swagNote.x += FlxG.width / 2;
			}
			daBeats += 1;
		}
		unspawnNotes.sort(sortByShit);
		generatedMusic = true;
	}

	function sortByShit(Obj1:Note, Obj2:Note):Int return FlxSort.byValues(FlxSort.ASCENDING, Obj1.strumTime, Obj2.strumTime);
	private function generateStaticArrows(player:Int):Void{
		var hell:Int = 0;
		for (i in 0...4){
			var babyArrow:FlxSprite = new FlxSprite(0, strumLine.y);
			switch (SONG.noteStyle){
				default:
					babyArrow.frames = Paths.getSparrowAtlas('NOTE_assets');
					babyArrow.animation.addByPrefix('green', 'arrowUP');
					babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
					babyArrow.animation.addByPrefix('purple', 'arrowLEFT');
					babyArrow.animation.addByPrefix('red', 'arrowRIGHT');
					babyArrow.setGraphicSize(Std.int(babyArrow.width * #if desktop 0.7 #else 0.85 #end));
					switch (Math.abs(i)){
						case 0:
							babyArrow.animation.addByPrefix('static', 'arrowLEFT');
							babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
						case 1:
							babyArrow.animation.addByPrefix('static', 'arrowDOWN');
							babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
						case 2:
							babyArrow.animation.addByPrefix('static', 'arrowUP');
							babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
						case 3:
							babyArrow.animation.addByPrefix('static', 'arrowRIGHT');
							babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
							babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
					}
					babyArrow.x += Note.swagWidth * Math.abs(i);
			}
			babyArrow.updateHitbox();
			babyArrow.ID = i;
			babyArrow.alpha = 0;
			babyArrow.y -= 10;
			FlxTween.tween(babyArrow, {y: babyArrow.y + 10, alpha: FlxG.save.data.healthBarAlpha}, 1, {ease: FlxEase.circOut, startDelay: 0.5 + (0.2 * i)});
			switch (player){
				case 0:
					cpuStrums.add(babyArrow);
					babyArrow.antialiasing = false;
					babyArrow.x -= 2000;
				case 1:
					playerStrums.add(babyArrow);
					babyArrow.antialiasing = FlxG.save.data.antialias;
					#if desktop
					babyArrow.x = 452 + (94 * hell);
					#else
					babyArrow.screenCenter(X);
					switch(babyArrow.ID){
						case 0: babyArrow.setPosition(babyArrow.x - 420, strumLine.y);
						case 1: babyArrow.setPosition(babyArrow.x - 280, strumLine.y);
						case 2: babyArrow.setPosition(babyArrow.x + 280, strumLine.y);
						case 3: babyArrow.setPosition(babyArrow.x + 420, strumLine.y);
					}
					#end
					hell += 1;
			}
			babyArrow.animation.play('static');
			strumLineNotes.add(babyArrow);
		}
	}

	override public function openSubState(SubState:FlxSubState){
		if (paused){
			if (FlxG.sound.music != null){
				FlxG.sound.music.pause();
				vocals.pause();
			}
		}
		super.openSubState(SubState);
	}

	override public function closeSubState(){
		if(!exiting){
			if (paused){
				if (FlxG.sound.music != null && !startingSong) resyncVocals();
				paused = false;
			}

			if (dialogueOn == true){
				if (!isEndOfSong){startCountdown();}
				else{
					if (curSongData.hasPostCutscene == true){
						inCutscene = true;
						startVideo(2);
					}else endDaSongfr();				
				}
				dialogueOn = false;
			}
		}else{optimizeTime();}
		super.closeSubState();
	}

	function resyncVocals():Void{
		FlxG.sound.music.play();
		Conductor.songPosition = FlxG.sound.music.time;
		vocals.time = Conductor.songPosition;
		vocals.play();
	}

	function pauseGame(){
		persistentUpdate = false;
		persistentDraw = true;
		paused = true;
        songStringer = curSong;
		openSubState(new PauseSubState(songStringer, songAuthor));
	}

	var holdArray:Array<Bool> = [false, false, false, false];
	var pressArray:Array<Bool> = [false, false, false, false];
	var paused:Bool = false;
	override public function update(elapsed:Float){
		#if mobile
		touch = FlxG.touches.getFirst();
		if(touch != null && touch.overlaps(pBut, camOther) && startedCountdown && canPause) pauseGame();
		#else
		if (FlxG.save.data.botplay && FlxG.keys.justPressed.ONE) camHUD.visible = !camHUD.visible;
		if (FlxG.keys.justPressed.ENTER && startedCountdown && canPause) pauseGame();
		/*if (FlxG.keys.justPressed.SEVEN) FlxG.switchState(new ChartingState());
		if (FlxG.keys.justPressed.EIGHT) FlxG.switchState(new AnimationDebug(SONG.player2));
		if (FlxG.keys.justPressed.NINE) FlxG.switchState(new AnimationDebug(SONG.player1));
		if (FlxG.keys.justPressed.ZERO) FlxG.switchState(new AnimationDebug(SONG.gfVersion));
		if (FlxG.keys.justPressed.ONE) endSong();*/
		#end

		if (!isEndOfSong && !FlxG.save.data.botplay){
			#if mobile
			var touchOne:FlxTouch = FlxG.touches.list[0];
			var touchTwo:FlxTouch = FlxG.touches.list[1];
			for(arr in playerStrums.members){
				if(touchOne != null && touchOne.overlaps(arr, camHUD)) pressArray[arr.ID] = true;
				else if(touchTwo != null && touchTwo.overlaps(arr, camHUD)) pressArray[arr.ID] = true;
				else pressArray[arr.ID] = false;
			}
			if(FlxG.touches.list.length == 0) pressArray = [false, false, false, false];
			holdArray = pressArray;
			#else
			holdArray = [controls.LEFT, controls.DOWN, controls.UP, controls.RIGHT];
			pressArray = [controls.LEFT_P, controls.DOWN_P, controls.UP_P, controls.RIGHT_P];
			#end
		}

		var balls = notesHitArray.length - 1;
		while (balls >= 0){
			var cock:Date = notesHitArray[balls];
			if (cock != null && cock.getTime() + 1000 < Date.now().getTime()) notesHitArray.remove(cock);
			else balls = 0;
			balls--;
		}

		if (!inCutscene && !dialogueOn && !isEndOfSong) keyShit();
		if(inCutscene && #if desktop FlxG.keys.justPressed.SPACE #else (touch != null && touch.justPressed) #end) video.onEndReached.dispatch();
		super.update(elapsed);

		// SHADERS
		if(FlxG.save.data.shaders){
			switch (SONG.song){
				case 'space-trap' | 'regenerator' | 'swearing': spc.upd(elapsed);
			}
		}

		if (health > limit) health = limit;
		scoreTxt.text = Ratings.CalculateRanking(songScore, accuracy);
		scoreTxt.screenCenter(X);

		if (!isEndOfSong){
			for (icon in grpICONS.members){
					var mult:Float = FlxMath.lerp(1, icon.scale.x, CoolUtil.boundTo(1 - (elapsed * 9), 0, 1));
					icon.scale.set(mult, mult);
					icon.updateHitbox();
					if (icon.isPlayer == true){
						if (healthBar.percent < 30) icon.animation.curAnim.curFrame = 1;			
						else if (healthBar.percent > 70) icon.animation.curAnim.curFrame = 2;
						else icon.animation.curAnim.curFrame = 0;
					}else{
						if (healthBar.percent < 30) icon.animation.curAnim.curFrame = 2;
						else if (healthBar.percent > 70) icon.animation.curAnim.curFrame = 1;	
						else icon.animation.curAnim.curFrame = 0;
					}
				icon.centerOffsets();
			}
		}

		if (!dialogueOn && !inCutscene){
			if (startingSong){
				if (startedCountdown){
					Conductor.songPosition += FlxG.elapsed * 1000;
					if (Conductor.songPosition >= 0) startSong();
				}
			}else{
				Conductor.songPosition += FlxG.elapsed * 1000;
				curTime = Conductor.songPosition;
				if (!paused){
					songTime += FlxG.game.ticks - previousFrameTime;
					previousFrameTime = FlxG.game.ticks;
					if (Conductor.lastSongPos != Conductor.songPosition){
						songTime = (songTime + Conductor.songPosition) / 2;
						Conductor.lastSongPos = Conductor.songPosition;
					}
				}
			}
		}

		if (health <= 0 || (FlxG.save.data.resetButton && FlxG.keys.justPressed.R)){
			boyfriend.stunned = true;
			persistentUpdate = false;
			persistentDraw = false;
			paused = true;
			stateIsRestarted = true;
			if (SONG.song == 'starshot') GJClient.trophieAdd(183130);
			vocals.stop();
			FlxG.sound.music.stop();
			#if desktop var rand:Int = FlxG.random.int(0, 49);
			if(rand == 0) FlxG.switchState(new MinigamePlayState('human_becomes_char', 'child_char', 0xFF00F224));
			else #end openSubState(new GameOverSubstate());
		}

		if (unspawnNotes[0] != null){
			if (unspawnNotes[0].strumTime - Conductor.songPosition < 3500){
				var dunceNote:Note = unspawnNotes[0];
				notes.add(dunceNote);
				var index:Int = unspawnNotes.indexOf(dunceNote);
				unspawnNotes.splice(index, 1);
			}
		}

		if (generatedMusic && !isEndOfSong){
			notes.forEachAlive(function(daNote:Note){
				if (!daNote.modifiedByLua) adjustNotePosition(daNote, FlxG.save.data.downscroll);
				if (!daNote.mustPress && daNote.wasGoodHit && daNote.active){
					daNote.active = false;
					var altAnim:String = "";
					if (SONG.notes[Math.floor(curStep / 16)] != null) if (SONG.notes[Math.floor(curStep / 16)].altAnim) altAnim = '-alt';
					if (dad != null){
						if (health > 0.1){
							if (daNote.isSustainNote) health -= 0.05;
							else health -= 0.1;
						}
						var doForce:Bool = !daNote.isSustainNote;
						switch (daNote.noteStyle){
                        	case 'normal': dad.playAnim("sing" + dadDir[daNote.noteData], doForce);
							case 'gfNote': singer3.playAnim("sing" + dadDir[daNote.noteData], doForce);
							case 'normAndgfNote':
								dad.playAnim("sing" + dadDir[daNote.noteData], doForce);
								singer3.playAnim("sing" + dadDir[daNote.noteData], doForce);		
							default: dad.playAnim("sing" + dadDir[daNote.noteData], doForce);
				    	}
						if (!boyfriend.animation.curAnim.name.startsWith('sing') && !disableCam) changeCameraPosition(dad.getMidpoint().x + 150 + dadCamX, dad.getMidpoint().y - 100 + dadCamY);
						else if (!disableCam) changeCameraPosition(gf.getMidpoint().x + gfCamX, gf.getMidpoint().y + gfCamY);

						var daTmr:Float = daNote.isSustainNote ? daNote.sustainLength : 0;
						dad.holdTimer = daTmr;
						if (singer3 != null) singer3.holdTimer = daTmr;
					}
					destroyNote(daNote);
				}

				if (daNote.mustPress){
					daNote.x = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].x;
					if (!daNote.isSustainNote) daNote.angle = playerStrums.members[Math.floor(Math.abs(daNote.noteData))].angle;
				}else if (!daNote.wasGoodHit){
					daNote.x = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].x;
					if (!daNote.isSustainNote) daNote.angle = strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].angle;
				}

				if (daNote.isSustainNote) daNote.x += daNote.width / 2 + 17;
				if (daNote.mustPress && daNote.tooLate && daNote.active){
					daNote.active = false;
					if (daNote.isSustainNote && daNote.wasGoodHit){trace("nothing ig");}
					else{
						health -= 0.075;
						noteMiss(daNote.noteData, daNote);
					}
				}
			});
		}
	}

	public function destroyNote(daNote:Note){
		notes.remove(daNote, true);
		daNote.destroy();
		daNote = null;
	}

	public function adjustNotePosition(daNote:Note, isDownscroll:Bool){
		if (isDownscroll){
			if (daNote.mustPress) daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y + 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(SONG.speed + FlxG.save.data.extraScrollSpeed, 2));
			else daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(SONG.speed + FlxG.save.data.extraScrollSpeed, 2));

			if(daNote.isSustainNote){
				if(daNote.animation.curAnim.name.endsWith('end') && daNote.prevNote != null) daNote.y += daNote.prevNote.height / 6;
				if(!FlxG.save.data.botplay){
					if((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit && !daNote.canBeHit) && daNote.y - daNote.offset.y * daNote.scale.y + daNote.height >= (strumLine.y + Note.swagWidth / 2)){
						var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
						swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
						swagRect.y = daNote.frameHeight - swagRect.height;
						daNote.clipRect = swagRect;
					}
				}else {
					var swagRect = new FlxRect(0, 0, daNote.frameWidth * 2, daNote.frameHeight * 2);
					swagRect.height = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
					swagRect.y = daNote.frameHeight - swagRect.height;
					daNote.clipRect = swagRect;
				}
			}
		}else{
			if (daNote.mustPress) daNote.y = (playerStrums.members[Math.floor(Math.abs(daNote.noteData))].y - 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(SONG.speed + FlxG.save.data.extraScrollSpeed, 2));
			else daNote.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y - 0.45 * (Conductor.songPosition - daNote.strumTime) * FlxMath.roundDecimal(SONG.speed + FlxG.save.data.extraScrollSpeed, 2));

			if(daNote.isSustainNote){
				daNote.y -= daNote.height / 2;
				if(!FlxG.save.data.botplay){
					if((!daNote.mustPress || daNote.wasGoodHit || daNote.prevNote.wasGoodHit && !daNote.canBeHit) && daNote.y + daNote.offset.y * daNote.scale.y <= (strumLine.y + Note.swagWidth / 2)){
						// Clip to strumline
						var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
						swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
						swagRect.height -= swagRect.y;
						daNote.clipRect = swagRect;
					}
				}else{
					var swagRect = new FlxRect(0, 0, daNote.width / daNote.scale.x, daNote.height / daNote.scale.y);
					swagRect.y = (strumLineNotes.members[Math.floor(Math.abs(daNote.noteData))].y + Note.swagWidth / 2 - daNote.y) / daNote.scale.y;
					swagRect.height -= swagRect.y;
					daNote.clipRect = swagRect;
				}
			}
		}
	}

	public function bgSwitch(alphaValue:Float, time:Float){
		if (time == 0){
			for (bgItem in grpBG.members) bgItem.alpha = alphaValue;
			for (bgItem in grpFG.members) bgItem.alpha = alphaValue;
		}else{
			for (bgItem in grpBG.members) FlxTween.tween(bgItem, {alpha: alphaValue}, time);
			for (bgItem in grpFG.members) FlxTween.tween(bgItem, {alpha: alphaValue}, time);
		}
	}

	public function zoomCam(camera:FlxCamera, zoomVal:Float = null, time:Float, ?daEase:String = ''){
		if (zoomVal == null) zoomVal = defaultCamZoom;
		FlxTween.tween(camera, {zoom: zoomVal}, time, {ease: getTweenEaseByString(daEase)});
	}

	public static function getTweenEaseByString(?ease:String = ''){
		switch(ease.toLowerCase().trim()){
			case 'backin': return FlxEase.backIn;
			case 'backinout': return FlxEase.backInOut;
			case 'backout': return FlxEase.backOut;
			case 'bouncein': return FlxEase.bounceIn;
			case 'bounceinout': return FlxEase.bounceInOut;
			case 'bounceout': return FlxEase.bounceOut;
			case 'circin': return FlxEase.circIn;
			case 'circinout': return FlxEase.circInOut;
			case 'circout': return FlxEase.circOut;
			case 'cubein': return FlxEase.cubeIn;
			case 'cubeinout': return FlxEase.cubeInOut;
			case 'cubeout': return FlxEase.cubeOut;
			case 'elasticin': return FlxEase.elasticIn;
			case 'elasticinout': return FlxEase.elasticInOut;
			case 'elasticout': return FlxEase.elasticOut;
			case 'expoin': return FlxEase.expoIn;
			case 'expoinout': return FlxEase.expoInOut;
			case 'expoout': return FlxEase.expoOut;
			case 'quadin': return FlxEase.quadIn;
			case 'quadinout': return FlxEase.quadInOut;
			case 'quadout': return FlxEase.quadOut;
			case 'quartin': return FlxEase.quartIn;
			case 'quartinout': return FlxEase.quartInOut;
			case 'quartout': return FlxEase.quartOut;
			case 'quintin': return FlxEase.quintIn;
			case 'quintinout': return FlxEase.quintInOut;
			case 'quintout': return FlxEase.quintOut;
			case 'sinein': return FlxEase.sineIn;
			case 'sineinout': return FlxEase.sineInOut;
			case 'sineout': return FlxEase.sineOut;
			case 'smoothstepin': return FlxEase.smoothStepIn;
			case 'smoothstepinout': return FlxEase.smoothStepInOut;
			case 'smoothstepout': return FlxEase.smoothStepInOut;
			case 'smootherstepin': return FlxEase.smootherStepIn;
			case 'smootherstepinout': return FlxEase.smootherStepInOut;
			case 'smootherstepout': return FlxEase.smootherStepOut;
		}
		return FlxEase.linear;
	}

	public function camSwitch(camera:FlxCamera, alphaValue:Float, time:Float){
		if (time == 0) camera.alpha = alphaValue;
		else FlxTween.tween(camera, {alpha: alphaValue}, time);
	}

	public function barsSwitch(alphaValue:Float, time:Float){
		var val:Float = alphaValue;
		if (alphaValue == 1) val = FlxG.save.data.healthBarAlpha;
		if (time == 0) for (shiz in grpBARS.members) shiz.alpha = val;
		else for (shiz in grpBARS.members) FlxTween.tween(shiz, {alpha: val}, time);
	}

	public function strumSwitch(alphaValue:Float = null, time:Float){
		var val:Float = alphaValue;
		if (alphaValue == null) val = FlxG.save.data.healthBarAlpha;
		if (time == 0){
			for (noting in playerStrums.members) noting.alpha = val;
			if (lane != null) lane.alpha = val == FlxG.save.data.healthBarAlpha ? FlxG.save.data.laneAlpha : val;
		}else{
			for (noting in playerStrums.members) FlxTween.tween(noting, {alpha: val}, time);
			if (lane != null) FlxTween.tween(lane, {alpha: val == FlxG.save.data.healthBarAlpha ? FlxG.save.data.laneAlpha : val}, 1);
		}
	}

	public function charSwitch(char:Dynamic, alphaValue:Float, time:Float){
		if (time == 0) char.alpha = alphaValue;
		else FlxTween.tween(char, {alpha: alphaValue}, time);
	}

	public function cookMeThemEvents(){	
		switch (curSong){ // CREDITPOPUP!!!
			case 'red-x' | 'starshot' | 'regenerator': makeEvent(128, function(){triggerCredits();});	
			case 'ov-dezeption': makeEvent(256, function(){triggerCredits();});
			case 'space-trap': makeEvent(144, function(){triggerCredits();});	
			case 'sorcery': makeEvent(160, function(){triggerCredits();});
			case 'map-maker': makeEvent(32, function(){triggerCredits();});
			case 'showdown-of-chaos' | 'arcade-sludgefest': makeEvent(64, function(){triggerCredits();});
			case 'go-go-disco': makeEvent(16, function(){triggerCredits();});
			case 'escalated':
				makeEvent(512, function(){
					triggerCredits();
					bgSwitch(1, 0);
					boos.alpha = 0;
					if (FlxG.save.data.flashing)
					{
						camHUD.flash(FlxColor.WHITE, 2);
					}
				});
			case 'omnipotent': //nuh uh
			default: makeEvent(1, function(){triggerCredits();});
		}
		switch(curSong){ // EVENTS
			case 'red-x':
				switch(type){
					case '-erect':
						makeEvent(80, function(){FlxTween.tween(blackout, {alpha: 0}, 6.5);});		
						makeEvent(129, function(){
							camSwitch(camHUD, 1, 0);
							if (FlxG.save.data.flashing) camHUD.flash(FlxColor.RED, 2);													
						});		
						makeEvent(639, function(){
							charSwitch(dad, 0, 0);		
							charSwitch(gf, 0, 0);
							bgSwitch(0, 0);
							camSwitch(camHUD, 0, 0);
							charSwitch(boyfriend, 0, 0);
						});	
						makeEvent(680, function(){
							disableCam = true;
							FlxG.camera.followLerp = 1;
							zoomCam(FlxG.camera, 1.2, 0.5, 'quadinout');
							changeCameraPosition(dad.getMidpoint().x, dad.getMidpoint().y - 160);
						});		
						makeEvent(687, function(){charSwitch(dad, 1, 0.7);});	
						makeEvent(704, function(){
							FlxG.camera.followLerp = 0.04;
							disableCam = false;
							charSwitch(gf, 1, 0);
							bgSwitch(1, 0);
							camSwitch(camHUD, 1, 0);
							charSwitch(boyfriend, 1, 0);
							zoomCam(FlxG.camera, null, 0.5, 'quadinout');
							if (FlxG.save.data.flashing) camHUD.flash(FlxColor.RED, 2);
						});	
						makeEvent(1439, function(){
							camSwitch(camGame, 0, 0);
							camSwitch(camHUD, 0, 0);		
						});	
					default:
						makeEvent(624, function(){
							camSwitch(camHUD, 0, 1);
							changeCameraPosition(dad.getMidpoint().x + 150 + dadCamX, dad.getMidpoint().y - 100 + dadCamY, 5);
						});			
						multipleEvents([640, 648, 656, 660, 664, 668], function(){
							FlxG.camera.followLerp = 1;
							FlxG.camera.zoom += 0.1;	
							changeCameraPosition(camFollow.x - 50, camFollow.y - 15, 5);				
						});		
						makeEvent(672, function(){
							FlxG.camera.followLerp = 0.04;
							zoomCam(FlxG.camera, null, 2, 'quadinout');
						});	
						makeEvent(720, function(){camSwitch(camHUD, 1, 1);});
						makeEvent(1440, function(){camSwitch(camHUD, 0, 0);});
						makeEvent(1452, function(){if (isStoryMode) camSwitch(camGame, 0, 0);});	
				}
			case 'omnipotent':
				makeEvent(1, function(){
					zoomCam(FlxG.camera, null, 15, 'quadinout');
					FlxTween.tween(blackout, {alpha: 0}, 15, {ease: FlxEase.quadInOut});
					camSwitch(camHUD, 1, 15);
					triggerCredits();
				});
				makeEvent(1184, function(){
					zoomCam(camGame, 1.3, 5, 'quadinout');
					camSwitch(camHUD, 0, 1);
				});
				makeEvent(1296, function(){camSwitch(camHUD, 1, 1);});
				makeEvent(1440, function(){zoomCam(camGame, null, 5, 'quadinout');});	
			case 'map-maker':
				multipleEvents([1, 191, 255, 320, 384, 512, 1023, 1151], function(){camSwitch(camHUD, 0, 0.5);});	
				multipleEvents([215, 280, 344, 438, 564, 1080, 1208], function(){camSwitch(camHUD, 1, 0.5);});
				makeEvent(20, function(){FlxTween.tween(blackout, {alpha: 1}, 1.5);});		
				makeEvent(80, function(){FlxTween.tween(blackout, {alpha: 0}, 5);});		
				makeEvent(127, function(){camSwitch(camHUD, 1, 0);});	
				multipleEvents([256, 895, 1279], function(){zoomCam(FlxG.camera, null, 2, 'expoout');});
				multipleEvents([768, 1023, 1552], function(){zoomCam(FlxG.camera, 0.8, 2, 'expoout');});	
				makeEvent(1551, function(){
					camSwitch(camHUD, 0, 0);
					bgSwitch(0, 0);
					charSwitch(gf, 0, 2);
					charSwitch(dad, 0, 2);		
					charSwitch(boyfriend, 0, 2);		
				});	
			case 'question':
				makeEvent(2, function(){
					FlxTween.tween(blackout, {alpha: 0}, 5);	
					zoomCam(FlxG.camera, null, 5, 'quadinout');
					camSwitch(camHUD, 1, 5);
				});	
				switch (type){
					case '-erect':
						makeEvent(752, function(){
							camSwitch(camGame, 0, 0.5);
							zoomCam(FlxG.camera, 0.7, 0.5, 'quadinout');
						});	
						makeEvent(770, function(){
							camSwitch(camGame, 1, 1);
							zoomCam(FlxG.camera, null, 1, 'quadinout');
						});	
						makeEvent(1539, function(){zoomCam(FlxG.camera, 0.7, 0.8, 'quadinout');});	
						makeEvent(1539, function(){camSwitch(camHUD, 0, 0);});	
					default:
						multipleEvents([512, 640, 1794, 2112], function(){camSwitch(camHUD, 0, 0.5);});	
						multipleEvents([566, 696, 1910], function(){camSwitch(camHUD, 1, 0.5);});	
						multipleEvents([511, 1472, 1792], function(){zoomCam(FlxG.camera, 0.8, 2, 'expoout');});			
						multipleEvents([768, 1536, 1920], function(){zoomCam(FlxG.camera, null, 2, 'expoout');});	
				}
			case 'contest-outrage':
				multipleEvents([383, 895, 1023, 1407, 1534, 1919, 2175], function(){camSwitch(camHUD, 0, 0.5);});	
				multipleEvents([182, 438, 949, 1078, 1463, 1590, 1976, 2198], function(){camSwitch(camHUD, 1, 0.5);});	
				multipleEvents([382, 895, 2431, 3072], function(){zoomCam(FlxG.camera, 0.8, 2, 'expoout');});			
				multipleEvents([639, 1151], function(){zoomCam(FlxG.camera, null, 2, 'quadinout');});	
				multipleEvents([1536, 1540, 1544, 1548, 1552, 1556, 1560, 1564, 1568, 1600, 1604, 1608, 1612, 1616, 1620, 1624, 1628, 1632,
				2944, 2948, 2952, 2956, 2960, 2964, 2968, 2972, 2975, 3008, 3012, 3016, 3020, 3024, 3028, 3032, 3036, 3040], function(){
					camGame.zoom = 0.6;
					zoomCam(FlxG.camera, null, 0.05, 'quadinout');										
				});	
				makeEvent(3087, function(){camSwitch(camHUD, 0, 0);});	
				if (isStoryMode) makeEvent(3103, function(){camSwitch(camGame, 0, 0);});	
			case 'space-trap':
				makeEvent(1, function(){
					charSwitch(boyfriend, 1, 1);
					charSwitch(dad, 1, 1);
				});	
				makeEvent(32, function(){
					charSwitch(gf, 1, 1);
					charSwitch(singer3, 1, 1);
				});	
				makeEvent(64, function(){
					if(FlxG.save.data.flashing) camGame.flash(0xFF5AD6EA, 2);
					bgSwitch(1, 0);
				});
				multipleEvents([115, 116, 117, 140, 142, 144], function(){FlxG.camera.zoom += 0.2;});
				multipleEvents([122, 124, 125, 152, 156], function(){FlxG.camera.zoom -= 0.2;});
				makeEvent(160, function(){camSwitch(camHUD, 1, 1);});
				makeEvent(912, function(){
					disableCam = true;
					changeCameraPosition(dad.getMidpoint().x + 150 + dadCamX, dad.getMidpoint().y - 100 + dadCamY);
				});
				makeEvent(928, function(){
					camHUD.alpha = 0;
					boyfriend.blockIdle = true;
					singer3.blockIdle = true;
					boyfriend.playAnim('hey');
					singer3.playAnim('shocked');
				});
			case 'regenerator':
				switch (type){
					case '-erect':
						makeEvent(1, function(){charSwitch(singer3, 1, 1);});	
						makeEvent(32, function(){charSwitch(dad, 1, 1);});	
						makeEvent(48, function(){
							camSwitch(camHUD, 1, 2);
							charSwitch(boyfriend, 1, 1);	
						});	
						makeEvent(129, function(){
							charSwitch(gf, 1, 1);	
							bgSwitch(1, 1);	
						});	
						if (FlxG.save.data.flashing){
							makeEvent(1015, function(){
								FlxFlicker.flicker(gf, 1, 0.001, false);
								for (item in grpBG.members) FlxFlicker.flicker(item, 1, 0.001, false);
								for (item in grpFG.members) FlxFlicker.flicker(item, 1, 0.001, false);
							});	
							makeEvent(1408, function(){
								gf.visible = true;
								for (item in grpBG.members) item.visible = true;
								for (item in grpFG.members) item.visible = true;
								camHUD.flash(FlxColor.RED, 2);
							});	
						}else{
							makeEvent(1015, function(){
								charSwitch(gf, 0, 1);	
								bgSwitch(0, 1);	
							});	
							makeEvent(1408, function(){
								charSwitch(gf, 1, 1);	
								bgSwitch(1, 1);	
							});	
						}
					default:
						makeEvent(50, function(){camSwitch(camHUD, 1, 1);});	
						makeEvent(1152, function(){
							bgSwitch(0, 1);
							camSwitch(camHUD, 0, 1);	
							charSwitch(gf, 0, 0.5);
							charSwitch(dad, 0, 0.5);
							charSwitch(boyfriend, 0, 0.5);			
						});	
						makeEvent(1232, function(){charSwitch(dad, 1, 0.5);});	
						makeEvent(1274, function(){	
							camSwitch(camHUD, 1, 0.5);	
							charSwitch(dad, 0, 0.5);
							charSwitch(gf, 1, 0.5);
							charSwitch(singer3, 0, 0.5);
							charSwitch(boyfriend, 1, 0.5);	
						});	
						makeEvent(1408, function(){
							if (FlxG.save.data.flashing) camHUD.flash(0xFF5AD6EA, 2);	
							bgSwitch(1, 1);
							charSwitch(dad, 1, 0.5);
							charSwitch(singer3, 1, 0.5);
						});	
						makeEvent(1536, function(){camSwitch(camHUD, 0, 0.5);});			
				}
			case 'swearing':
				var marsIdleTimer:FlxTimer = new FlxTimer();
				makeEvent(1310, function(){dad.blockIdle = true;});
				multipleEvents([1314, 1322, 1330, 1599, 1604, 1608, 1612, 1614, 1616, 1680, 1683, 1691, 1700, 1708, 1710, 1716, 1724, 1732, 1740, 1742, 1872, 2074,
				2076, 2078, 2090, 2092, 2094, 2130, 2132, 2134, 2272, 2288, 2292, 2304, 2320, 2324, 2328, 2333, 2336, 2352, 2356, 2368, 2384, 2388, 2392, 2856], function(){
					marsIdleTimer.reset(0.5);
					dad.blockIdle = true;
					if(healthBar.percent > 30) health -= 0.1;
					dad.playAnim('swear', true);
					marsIdleTimer.start(0.5, function(tmr:FlxTimer){dad.blockIdle = false;});
				});
				multipleEvents([1626, 2875], function(){
					dad.blockIdle = false;
					dad.playAnim('idle', true);
				});
			case 'go-go-disco':
				var fore:FlxSprite = new FlxSprite(dad.x, dad.y);
				fore.frames = Paths.getSparrowAtlas('characters/sakuraRage');
				fore.animation.addByPrefix('left', 'Xakura LEFT Note', 24, true);
				fore.animation.addByPrefix('right', 'Xakura RIGHT Note', 24, true);
				fore.alpha = 0;
				fore.antialiasing = true;
				fore.setGraphicSize(Std.int(fore.width * 1.2));
				fore.updateHitbox();
				add(fore);

				multipleEvents([3, 6, 9], function(){FlxG.camera.zoom += 0.3;});	
				multipleEvents([12, 14], function(){FlxG.camera.zoom -= 0.45;});
				makeEvent(768, function(){
					disableCam = true;
					changeCameraPosition(dad.getMidpoint().x + 150 + dadCamX, dad.getMidpoint().y - 100 + dadCamY);
				});
				makeEvent(784, function(){
					if(FlxG.save.data.flashing) camHUD.flash(FlxColor.BLACK, 1);
					dad.alpha = 0;
					audience.alpha = 0;
					corruptSky.alpha = 1;
					fore.alpha = 1;
					fore.animation.play('left');
					fore.offset.set(4, 1);
					iconP2.changeIcon('sakuraRage');
					hoshi.alpha = 0;
				});
				makeEvent(792, function(){
					fore.animation.play('right');
					fore.offset.set(54, 1);
				});
				makeEvent(800, function(){
					corruptSky.destroy();
					fore.destroy();
					remove(fore);
					remove(corruptSky);
					disableCam = false;
					dad.alpha = 1;
					audience.alpha = 0.65;
					hoshi.alpha = 1;
					iconP2.changeIcon('sakura');
					if(FlxG.save.data.flashing) camHUD.flash(FlxColor.BLACK, 1);
				});
			case 'sorcery':
				makeEvent(1, function(){
					disableCam = true;
					FlxG.camera.followLerp = 1;
					FlxG.camera.zoom += 1;
					changeCameraPosition(boyfriend.getMidpoint().x, boyfriend.getMidpoint().y - 100);
				});
				makeEvent(12, function(){changeCameraPosition(gf.getMidpoint().x, gf.getMidpoint().y - 100);});
				makeEvent(28, function(){changeCameraPosition(dad.getMidpoint().x, dad.getMidpoint().y - 150);});
				makeEvent(32, function(){
					FlxG.camera.followLerp = 0.04;
					FlxG.camera.zoom -= 1;
					disableCam = false;
					changeCameraPosition(dad.getMidpoint().x + 150 + dadCamX, dad.getMidpoint().y - 100 + dadCamY);
				});
				makeEvent(1056, function(){
					disableCam = true;
					changeCameraPosition(dad.getMidpoint().x + 150 + dadCamX, dad.getMidpoint().y - 100 + dadCamY);
				});
				makeEvent(1065, function(){
					iconP2.changeIcon("sakuraRage");
					remove(dad);
					dad = new Character(100, 300, 'sakuraRage');
					add(dad);
					dad.blockIdle = true;
					dad.playAnim('transform');
					FlxTween.tween(corruptSky, {alpha: 1}, 1);
					FlxTween.tween(audience, {alpha: 0}, 1);
					FlxTween.tween(hoshi, {alpha: 0}, 1);
				});	
				makeEvent(1090, function(){
					disableCam = false;
					dad.blockIdle = false;
					audience.destroy();
					hoshi.destroy();
					remove(audience);
					remove(hoshi);
				});
			case 'starshot':
				switch (type){
					case '-erect':
						makeEvent(80, function(){
							camSwitch(camGame, 1, 7);
							camSwitch(camHUD, 1, 7);
						});
						makeEvent(2207, function(){
							camSwitch(camHUD, 0, 3);
							charSwitch(dad, 0, 3);
						});
					default: makeEvent(2080, function(){charSwitch(dad, 0, 3);});
				}
			case 'starrcade':
				makeEvent(2, function(){FlxTween.tween(blackout, {alpha: 0}, 5);});
				makeEvent(98, function(){
					camSwitch(camHUD, 1, 1);
					dad.playAnim('alright');
				});
				multipleEvents([128, 640],function(){
					disableCam = false;
					dad.blockIdle = false;
				});
				multipleEvents([95, 622],function(){
					disableCam = true;
					dad.blockIdle = true;
					changeCameraPosition(dad.getMidpoint().x + 150 + dadCamX, dad.getMidpoint().y - 100 + dadCamY);
				});
				makeEvent(630, function(){dad.playAnim('woo');});
			case 'escalated':
				makeEvent(248, function()
				{
					charSwitch(dad, 1, 3);
					FlxTween.tween(dad, {alpha: 1}, 3);					
				});
				makeEvent(364, function()
				{
					camSwitch(camHUD, 1, 1);
					charSwitch(boyfriend, 1, 3);
				});
				makeEvent(1647, function()
				{
					charSwitch(dad, 0, 1);	
				});
				makeEvent(1663, function()
				{
					FlxTween.tween(jumpscareLaugh, {alpha: 0.7}, 1);
					jumpscareLaugh.animation.play('scare');		
				});
				multipleEvents([1715, 1721, 1728], function()
				{
					jumpscareLaugh.alpha = 0;
					if (curStep == 1728)
					{
						remove(jumpscareLaugh);
						dad.alpha = 1;
						FlxG.camera.shake(0.05, 0.5, null, true);
						FlxTween.tween(blocc, {y: blocc.y + 500}, 1, {ease: FlxEase.expoInOut, onComplete:
							function (twn:FlxTween)
							{
								blocc.destroy();
								remove(blocc);
							}
						});
						FlxTween.tween(boos, {alpha: 0.7}, 1);
						jumpscareLaugh.destroy();
					}
				});
				multipleEvents([1718, 1723], function()
				{
					jumpscareLaugh.alpha = 1;
				});
				makeEvent(2015, function()
				{
					camSwitch(camGame, 0, 0);
					camSwitch(camHUD, 0, 0);
					camOther.shake(0.05, 4, null, true);
					jumpscareStatic.alpha = 1;	
				});
			case 'astral-descent':
				makeEvent(128, function(){blackout.alpha = 0;});
				makeEvent(250, function(){camSwitch(camHUD, 1, 0.5);});
				makeEvent(1920, function(){blackout.alpha = 1;});
			case 'arcade-sludgefest':
				makeEvent(1, function(){
					FlxG.camera.zoom = 0.6;
					changeCameraPosition(gf.getMidpoint().x + gfCamX, gf.getMidpoint().y + gfCamY);
					zoomCam(FlxG.camera, null, 10);
					FlxTween.tween(blackout, {alpha: 0}, 10);
				});
				makeEvent(112, function(){camSwitch(camHUD, 1, 0.5);});
				makeEvent(1504, function(){
					changeCameraPosition(gf.getMidpoint().x + gfCamX, gf.getMidpoint().y + gfCamY);
					camSwitch(camHUD, 0, 10);
				});
			case 'cory-time':
				makeEvent(16, function(){camSwitch(camHUD, 1, 0.5);});
				makeEvent(1296, function(){camSwitch(camHUD, 0, 1);});
				makeEvent(1360, function(){
					FlxTween.tween(blackout, {alpha: 1}, 8);		
					zoomCam(FlxG.camera, 1, 8);		
				});
		}
	}

	var coinsCollected:Float = 0;
	var gemsCollected:Float = 0;
	function endSong():Void{
		isEndOfSong = true;
		canPause = false;
		FlxG.sound.music.volume = 0;
		camHUD.alpha = 0;
		FlxG.save.data.totalNotesPressed += shits + bads + goods + sicks;
		FlxG.save.data.totalNotesMissed += misses;

		accuracy = FlxMath.roundDecimal(accuracy, 1);
		coinsCollected += Math.floor(accuracy - misses);
		gemsCollected += Math.floor(accuracy / 10 - misses);

		if (coinsCollected > 0){
			FlxG.save.data.coins += coinsCollected;
			FlxG.save.data.coins = Math.floor(FlxG.save.data.coins);
			if (FlxG.save.data.coins > 999) {FlxG.save.data.coins = 999;}
		}
		
		if (gemsCollected > 0){
			FlxG.save.data.gems += gemsCollected;
			FlxG.save.data.gems = Math.floor(FlxG.save.data.gems);
			if (FlxG.save.data.gems > 999) {FlxG.save.data.gems = 999;}
		}

		#if !switch
		Highscore.saveScore(SONG.song, songScore, storyDifficulty);
		Highscore.saveAccs(SONG.song, accuracy, storyDifficulty);
		#end

		if (!KadeEngineData.songBeatenArray.contains(SONG.song) && type == ''){
			KadeEngineData.songBeatenArray.push(SONG.song);
			FlxG.save.data.songsBeaten = KadeEngineData.songBeatenArray;
			trace("COMPLETED SONGS: " + FlxG.save.data.songsBeaten);
		}

		if (isStoryMode){
			var requiredStorySongs:Array<String> = ['ov-dezeption', 'contest-outrage', 'swearing', 'starshot'];
			var giveTrophy:Bool = false;
			var keepchecking:Bool = true;
			for (i in 0...requiredStorySongs.length){
				if (!KadeEngineData.songBeatenArray.contains(requiredStorySongs[i])){
					keepchecking = false;
					giveTrophy = false;
				}
				if (KadeEngineData.songBeatenArray.contains(requiredStorySongs[i])){
					if (keepchecking){
						giveTrophy = true;
						switch (requiredStorySongs[i]){
							case "ov-dezeption": GJClient.trophieAdd(183125);
							case "contest-outrage": GJClient.trophieAdd(183126);
							case "swearing": GJClient.trophieAdd(183554);
							case "starshot": GJClient.trophieAdd(183127);
						}
					}
				}
			}

			if (giveTrophy){
				GJClient.trophieAdd(183183);
				FlxG.save.data.freeplayUnlocked = true;
				storyAch = true;
			}
		}
		
		var requiredBrawlSongs:Array<String> = ["space-symphony", "starrcade", "showdown-of-chaos", "cory-time"];
		var requiredExtraSongs:Array<String> = ["far-future", "arcade-sludgefest", "astral-descent", "escalated"];
		var keepcheckingtoo:Bool = true;
		var keepcheckingtree:Bool = true;
		for (i in 0...requiredBrawlSongs.length){
			if (!KadeEngineData.songBeatenArray.contains(requiredBrawlSongs[i])){
				freeplaybrawlach = false;
				keepcheckingtoo = false;
			}
			if (KadeEngineData.songBeatenArray.contains(requiredBrawlSongs[i])) if (keepcheckingtoo) freeplaybrawlach = true;
		}

		for (i in 0...requiredExtraSongs.length){
			if (!KadeEngineData.songBeatenArray.contains(requiredExtraSongs[i])){
				freeplayextraach = false;
				keepcheckingtree = false;
			}
			if (KadeEngineData.songBeatenArray.contains(requiredExtraSongs[i])) if (keepcheckingtree) freeplayextraach = true;
		}
		
		if (freeplaybrawlach) {GJClient.trophieAdd(183181); trace("Freeplay Brawl Trophy Gained");}
		if (freeplayextraach) {GJClient.trophieAdd(183182); trace("Freeplay Extra Trophy Gained");}
		if (FlxG.save.data.totalNotesPressed >= 100000) GJClient.trophieAdd(184495);
		if (misses == 0) GJClient.trophieAdd(184496);
		if (storyAch == true && freeplayextraach == true && freeplaybrawlach == true) GJClient.trophieAdd(183184);
		FlxG.save.flush();

		var daPath:String = 'assets/codeshit/cutscenes/post-' + SONG.song + '.mp4';
		var daList:Array<String> = null;
		var dial:String = #if mobile "songs:" + #end "assets/songs/" + SONG.song + '/dialogue-post-${LangUtil.curLang}.txt';
		if (type == "" && !FlxG.save.data.skipScenes){
			dialogueOn = curSongData.hasPostDialogue;
			inCutscene = curSongData.hasPostCutscene;
			if (inCutscene && !dialogueOn){
				if (#if desktop FileSystem.exists(daPath) #else Assets.exists(daPath) #end){
					video = new VideoHandler();
					video.load(Paths.codeShitVideo('cutscenes/post-' + SONG.song));
					video.play();
					FlxG.addChildBelowMouse(video);
					video.onEndReached.add(function(){
						video.dispose();
						inCutscene = false;
						endDaSongfr();
						return;
					});
				}else endDaSongfr();					
			}else if (dialogueOn && !inCutscene){
				if (#if desktop FileSystem.exists(dial) #else Assets.exists(dial) #end) startDialogue(dial, daList);
				else endDaSongfr();						
			}else if (dialogueOn && inCutscene){
				if (#if desktop FileSystem.exists(dial) #else Assets.exists(dial) #end) startDialogue(dial, daList);
				else endDaSongfr();					
			}else endDaSongfr();
		}else{
			if (!KadeEngineData.erectSongsBeaten.contains(SONG.song) && type == "-erect") KadeEngineData.pushErectSong(SONG.song);
			endDaSongfr();
		}
	}

	public function endDaSongfr(){
		var data:Array<Dynamic> = [boyfriend.x, boyfriend.y, boyfriend.curChar];
		LoadingState.invisible = false;
		storyPlaylist.remove(storyPlaylist[0]);
			FlxTween.tween(dad, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
			FlxTween.tween(gf, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
			if (singer3 != null) FlxTween.tween(singer3, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
			if (singer4 != null) FlxTween.tween(singer4, {alpha: 0}, 0.5, {ease: FlxEase.quadOut});
			FlxTween.tween(FlxG.camera, {zoom: 0.9}, 0.5, {ease: FlxEase.quadOut});
			changeCameraPosition(boyfriend.getMidpoint().x - 100 + bfCamX, boyfriend.getMidpoint().y - 100 + bfCamY, 0);

		if (isStoryMode){
			weekSicks += sicks;
			weekGoods += goods;
			weekBads += bads;
			weekShits += shits;
			weekMisses += misses;
			totalWeekScore += songScore;
			if (meanAccuracy < accuracy) meanAccuracy = accuracy;
			weekNotesHit += acutallyHitNotes;
			weekTotalNotesinSong += totalNotesInSong;
			weekCoins += coinsCollected;
			weekGems += gemsCollected;
		}

		countTmr = new FlxTimer().start(0.5, function(timer:FlxTimer){
			optimizeTime();
			if (storyPlaylist.length <= 0) openSubState(new ResultsSubState(sicks, goods, bads, shits, misses, songScore, accuracy, acutallyHitNotes, totalNotesInSong, coinsCollected, gemsCollected, data));
			else{
				var postSongLoadingInvisible:Array<String> = ['red-x', 'map-maker'];
				LoadingState.invisible = postSongLoadingInvisible.contains(SONG.song);
				ResultsSubState.dieAllShit();
			}
			countTmr.destroy();
		});
	}

	function optimizeTime(){
		persistentUpdate = false;
		for(obj in [boyfriend, dad, gf, singer3, singer4, scoreTxt, songName, songPosBG, songPosBar, pop]){
			if(obj != null){
				obj.destroy();
				remove(obj);
				obj = null;
			}
		}
		var groupArray:Array<FlxTypedGroup<Dynamic>> = [notes, grpRate, grpBARS, grpICONS, strumLineNotes, playerStrums, cpuStrums];
		for(grp in groupArray){
			if(grp != null && (grp.members != null && grp.members != [])){
				for(mem in grp.members){
					if(mem != null){
						mem.destroy();
						grp.remove(mem, true);
					}
				}
				grp.destroy();
				remove(grp);
			}
		}
	}

	var endingSong:Bool = false;
	var hits:Array<Float> = [];
	var offsetTest:Float = 0;
	private function popUpScore(daNote:Note):Void{
		var noteDiff:Float = Math.abs(Conductor.songPosition - daNote.strumTime);
		var wife:Float = EtternaFunctions.wife3(noteDiff, Conductor.timeScale);
		var placement:String = Std.string(combo);
		var score:Float = 0;
		if (FlxG.save.data.accuracyMod == 1) totalNotesHit += wife;
		var daRating = daNote.rating;

		switch (daRating){
			case 'bad':
				daRating = 'bad';
				score = -250;
				bads += 1;
				health -= 0.05;
				if (FlxG.save.data.accuracyMod == 0) totalNotesHit -= 0.05;
			case 'good':
				daRating = 'good';
				score = 250;
				goods += 1;
				health += 0.05;
				if (FlxG.save.data.accuracyMod == 0) totalNotesHit += 0.75;
			case 'sick':
				daRating = 'sick';
				score = 500;
				sicks += 1;
				health += 0.1;
				if (FlxG.save.data.accuracyMod == 0) totalNotesHit += 1;
			default:
				daRating = 'shit';
				score = -500;
				shits += 1;
				health -= 0.1;
				if (FlxG.save.data.accuracyMod == 0) totalNotesHit -= 0.1;
		}

		songScore += Math.round(score);

		if (FlxG.save.data.comboViewOption){
			for (ratingSpr in grpRate.members) if (ratingSpr != null) grpRate.remove(ratingSpr);
			var int:Int = switch(daRating){
				case 'sick': 0;
				case 'good': 1;		
				case 'bad':  2;	
				default: 3;
			}
			var rating:FlxSprite = new FlxSprite(60, 280);
			rating.loadGraphic(Paths.image('ratings/${daRating}-' + LangUtil.getRat(int), 'shared'));
			rating.setGraphicSize(Std.int(rating.width * 0.7));
			grpRate.add(rating);

			var seperatedScore:Array<Int> = [];
			var comboSplit:Array<String> = (combo + "").split('');
			for (i in 0...comboSplit.length){
				var str:String = comboSplit[i];
				seperatedScore.push(Std.parseInt(str));
			}

			if (combo >= 10){
				var daLoop:Int = 0;
				for (i in seperatedScore){
					var numScore:FlxSprite = new FlxSprite().loadGraphic(Paths.image('ratings/tallieNumber', 'shared'));
					numScore.frames = Paths.getSparrowAtlas('ratings/tallieNumber');
					numScore.animation.addByPrefix(Std.string(Std.int(i)), Std.string(Std.int(i)), 24, false);
					numScore.animation.play(Std.string(Std.int(i)));
					numScore.setGraphicSize(Std.int(numScore.width * 1));
					numScore.x = rating.x + (43 * daLoop) + 70;
					numScore.y = rating.y + 150;	
					grpRate.add(numScore);
					daLoop++;
				}
			}
			
			for (ratingSpr in grpRate.members){
				if (ratingSpr != null){
					ratingSpr.scrollFactor.set(0, 0);
					ratingSpr.cameras = [camOther];
					ratingSpr.antialiasing = false;
					ratingSpr.updateHitbox();
					ratingSpr.acceleration.y = FlxG.random.int(200, 300);
					ratingSpr.velocity.y -= FlxG.random.int(140, 160);
					FlxTween.tween(ratingSpr, {alpha: 0}, 0.3, {onComplete: function(tween:FlxTween){grpRate.remove(ratingSpr);}, startDelay: Conductor.crochet * 0.001, ease: FlxEase.backInOut});	
				}
			}
	    }
		curSection += 1;
	}

	public function convertScore(noteDiff:Float):Int{
		var daSigma:String = Ratings.CalculateRating(noteDiff, 166);
		switch(daSigma){
			case 'shit': return -500;
			case 'bad': return -250;
			case 'good': return 250;
			case 'sick': return 500;
		}
		return 0;
	}

	private function keyShit():Void{
		if (holdArray.contains(true) && generatedMusic) notes.forEachAlive(function(daNote:Note){if (daNote.isSustainNote && daNote.canBeHit && daNote.mustPress && holdArray[daNote.noteData]) goodNoteHit(daNote);});
		if (pressArray.contains(true) && generatedMusic){
			if (boyfriend != null) boyfriend.holdTimer = 0;
			if (singer4 != null) singer4.holdTimer = 0;
			var possibleNotes:Array<Note> = []; // notes that can be hit
			var directionList:Array<Int> = []; // directions that can be hit
			var dumbNotes:Array<Note> = []; // notes to kill later
			notes.forEachAlive(function(daNote:Note){
				if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit){
					if (directionList.contains(daNote.noteData)){
						for (coolNote in possibleNotes){
							if (coolNote.noteData == daNote.noteData && Math.abs(daNote.strumTime - coolNote.strumTime) < 10){
								dumbNotes.push(daNote);
								break;
							}else if (coolNote.noteData == daNote.noteData && daNote.strumTime < coolNote.strumTime){
								possibleNotes.remove(coolNote);
								possibleNotes.push(daNote);
								break;
							}
						}
					}else{
						possibleNotes.push(daNote);
						directionList.push(daNote.noteData);
					}
				}
			});

			for (note in dumbNotes) destroyNote(note);
			possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

			var dontCheck = false;
			for (i in 0...pressArray.length) if (pressArray[i] && !directionList.contains(i)) dontCheck = true;
			if (possibleNotes.length > 0 && !dontCheck){
				for (shit in 0...pressArray.length) if (pressArray[shit] && !directionList.contains(shit)) noteMiss(shit, null);
				for (coolNote in possibleNotes){
					if (pressArray[coolNote.noteData]){
						if (mashViolations != 0) mashViolations--;
						goodNoteHit(coolNote);
					}
				}
			}else for (shit in 0...pressArray.length) if (pressArray[shit]) noteMiss(shit, null);

			if (dontCheck && possibleNotes.length > 0 && !FlxG.save.data.botplay){
				if (mashViolations > 8) noteMiss(0, null);
				else mashViolations++;
			}
		}

		notes.forEachAlive(function(daNote:Note){
			if (FlxG.save.data.downscroll && daNote.y > strumLine.y || !FlxG.save.data.downscroll && daNote.y < strumLine.y){
				if (FlxG.save.data.botplay && (daNote.canBeHit || daNote.tooLate) && daNote.mustPress){
					goodNoteHit(daNote);
					if (boyfriend != null) boyfriend.holdTimer = daNote.sustainLength;
					if (singer4 != null) singer4.holdTimer = daNote.sustainLength;
				}
			}
		});

		if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && (!holdArray.contains(true) || FlxG.save.data.botplay)) if (boyfriend.animation.curAnim.finished) boyfriend.playAnim('idle');
		playerStrums.forEach(function(spr:FlxSprite){
			if (pressArray[spr.ID] && spr.animation.curAnim.name != 'confirm') spr.animation.play('pressed');
			if (!holdArray[spr.ID]) spr.animation.play('static');
			if (spr.animation.curAnim.name == 'confirm'){
				spr.centerOffsets();
				#if desktop
				spr.offset.x -= 18;
				spr.offset.y -= 18;
				#else
				spr.offset.x -= 20;
				spr.offset.y -= 20;
				#end
			}else spr.centerOffsets();
		});
	}

	function noteMiss(direction:Int = 1, daNote:Note):Void{	
		#if mobile if(daNote == null) return; #end
			if(!boyfriend.stunned){
				if (daNote != null){
					switch (daNote.noteStyle){
						case 'playerfour': singer4.color = 0xFFA6007F;
						case 'normAndFourDuet':
							boyfriend.color = 0xFFA6007F;	
							singer4.color = 0xFFA6007F;				
						default: boyfriend.color = 0xFFA6007F;		
					}
				}else boyfriend.color = 0xFFA6007F;			

				boyfriend.playAnim('idle');	
				if (singer4 != null) singer4.playAnim('idle');		
				bfIdle.reset(2);		
			}
		
		if (daNote != null){
			destroyNote(daNote);
			if (!daNote.isSustainNote) totalNotesInSong += 1;
		}

		if(boyfriend != null && !boyfriend.stunned){
			health -= FlxG.save.data.instakill ? 3 : def;
			if (FlxG.save.data.accuracyMod == 1) totalNotesHit -= 1;
			if (FlxG.save.data.missSounds) FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), 1);
			combo = 0;
			misses += 1;
			songScore -= 1000;
			updateAccuracy();
		}
	}

	function updateAccuracy(){
		totalPlayed += 1;
		accuracy = Math.max(0, totalNotesHit / totalPlayed * 100);
		accuracyDefault = Math.max(0, totalNotesHitDefault / totalPlayed * 100);
	}

	var mashViolations:Int = 0;
	function goodNoteHit(note:Note, resetMashViolation = true):Void{
		if (!note.isSustainNote){
			totalNotesInSong += 1;
			acutallyHitNotes += 1;
		}
		var noteDiff:Float = Math.abs(note.strumTime - Conductor.songPosition);
		note.rating = Ratings.CalculateRating(noteDiff);
		if (!note.isSustainNote) notesHitArray.unshift(Date.now());
		if (!resetMashViolation && mashViolations >= 1) mashViolations--;
		if (mashViolations < 0) mashViolations = 0;
		if (!note.wasGoodHit){
			if (!note.isSustainNote){
				popUpScore(note);
				combo += 1;
			}else{
				totalNotesHit += 1;
				health += 0.05;
			}

				boyfriend.color = FlxColor.WHITE;
				var doForce:Bool = !note.isSustainNote;
				switch (note.noteStyle){
					case 'playerfour': singer4.playAnim("sing" + daDir[note.noteData], doForce);
					case 'normAndFourDuet':
						boyfriend.playAnim("sing" + daDir[note.noteData], doForce);	
						singer4.playAnim("sing" + daDir[note.noteData], doForce);	
					default: boyfriend.playAnim("sing" + daDir[note.noteData], doForce);				
				}
				boyfriend.holdTimer = 0;
				if (singer4 != null) singer4.holdTimer = 0;
				if (!dad.animation.curAnim.name.startsWith('sing') && !disableCam) changeCameraPosition(boyfriend.getMidpoint().x - 100 + bfCamX, boyfriend.getMidpoint().y - 100 + bfCamY);
				else if (!disableCam) changeCameraPosition(gf.getMidpoint().x + gfCamX, gf.getMidpoint().y + gfCamY);
			playerStrums.forEach(function(spr:FlxSprite){if (Math.abs(note.noteData) == spr.ID) spr.animation.play('confirm', true);});
			note.wasGoodHit = true;
			destroyNote(note);
			updateAccuracy();
		}
	}

	override function stepHit(){
		super.stepHit();
		if(stepEvents != null){
			for(event in stepEvents){
				if(event != null){
					if(curStep == event.step){
						event.callback();
						stepEvents.remove(event);
					}
				}
			}
		}

		if(songName != null){
			songName.text = StringTools.replace(SongLangUtil.trans(SONG.song.toUpperCase()), '-', ' ') + " | " + FlxStringUtil.formatTime(curTime / 1000, false) + " / " + FlxStringUtil.formatTime(songLength / 1000, false);
			songName.screenCenter(X);
		}
	}

	override function beatHit(){
		super.beatHit();
		if (generatedMusic) notes.sort(FlxSort.byY, (FlxG.save.data.downscroll ? FlxSort.ASCENDING : FlxSort.DESCENDING));
		if (!isEndOfSong){
			if (SONG.notes[Math.floor(curStep / 16)] != null){
				if (SONG.notes[Math.floor(curStep / 16)].changeBPM){
					Conductor.changeBPM(SONG.notes[Math.floor(curStep / 16)].bpm);
					FlxG.log.add('CHANGED BPM!');
				}
				dad.dance();
				if (curBeat % gfSpeed == 0) gf.dance();
				if (!boyfriend.animation.curAnim.name.startsWith("sing")) boyfriend.dance();
				if (singer3 != null) singer3.dance();
				if (singer4 != null) singer4.dance();
			}

				for (icon in grpICONS.members){
					icon.setGraphicSize(Std.int(icon.width + 30));
					icon.updateHitbox();
				}
				if (curBeat % 4 == 0){
					camHUD.zoom += 0.03;
					FlxTween.tween(camHUD, {zoom: 1}, 1.5 * Conductor.stepCrochet / 1000, {ease: FlxEase.quadInOut});
				}
		}
	}
}