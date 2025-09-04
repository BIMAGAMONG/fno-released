package;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.TransitionData;
import flixel.effects.FlxFlicker;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup;
import flixel.input.gamepad.FlxGamepad;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.sound.FlxSound;
import flixel.system.ui.FlxSoundTray;
import gamejolt.GJClient;
import io.newgrounds.NG;
import lime.app.Application;
import openfl.Assets;
import openfl.display.BitmapData;
using StringTools;
import openfl.filters.ColorMatrixFilter;
#if cpp
import sys.thread.Thread;
#end
#if windows
import Sys;
#end

class TitleState extends MusicBeatState{
	var initialized:Bool = false;
	var blackScreen:FlxSprite;
	public var skulls:FlxBackdrop;
	var wackyImage:FlxSprite;
	public static var titleColors:Array<Array<FlxColor>> = [
		[0xFFff0004, 0xFFd70002], // bema
		[0xFFffff00, 0xFFdbdb00], // lowmeeee
		[0xFFff4d00, 0xFFff7d3e], // mars
		[0xFFc8c8c8, 0xFFdcdcdc], // niw
		[0xFFff00b8, 0xFFdd0088], // sakura
		[0xFFffaf00, 0xFFed9300] // hoshizora
	];
	var warning:BrawlPopup = new BrawlPopup();

	override public function create():Void{
		@:privateAccess{trace("Loaded " + openfl.Assets.getLibrary("default").assetsLoaded + " assets (DEFAULT)");}
		PlayerSettings.init();
		#if desktop
		DiscordClient.initialize();
		Application.current.onExit.add((exitCode) -> DiscordClient.shutdown());
		#end
        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
		#if GAMEJOLT_ALLOWED
		Application.current.onExit.add((exitCode) -> GJClient.logout());
		#end
		super.create();
		FlxG.save.bind('FnO');
		KadeEngineData.initSave();
		Highscore.load();
		FlxG.save.flush();
		setColorBlindFilter();
		FlxG.drawFramerate = FlxG.save.data.fpsCap;
		FlxG.updateFramerate = FlxG.save.data.fpsCap;
		new FlxTimer().start(1, function(tmr:FlxTimer){startIntro();});
	}

	var logoBl:FlxSprite;
	var danceLeft:Bool = false;
	var titleText:FlxSprite;
	function startIntro(){
		if (!initialized){
			var diamond:FlxGraphic = FlxGraphic.fromClass(GraphicTransTileDiamond);
			diamond.persist = true;
			diamond.destroyOnNoUse = true;
			FlxTransitionableState.defaultTransIn = new TransitionData(TILES, FlxColor.BLACK, 1, new FlxPoint(0, 1), {asset: diamond, width: 32, height: 32},new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			FlxTransitionableState.defaultTransOut = new TransitionData(TILES, FlxColor.BLACK, 1, new FlxPoint(0, 1), {asset: diamond, width: 32, height: 32},new FlxRect(-200, -200, FlxG.width * 1.4, FlxG.height * 1.4));
			transIn = FlxTransitionableState.defaultTransIn;
			transOut = FlxTransitionableState.defaultTransOut;
			FlxG.sound.playMusic(Paths.music('freakyMenu'), 0);
			FlxG.sound.music.fadeIn(4, 0, 0.5);
		}

		Conductor.changeBPM(104);
		persistentUpdate = true;
		var spr:FlxSprite = new FlxSprite().loadGraphic(Paths.image('title/gradientBG'));
		spr.scale.set(1.5, 1);
		spr.updateHitbox();
		spr.screenCenter();
		spr.antialiasing = false;
		add(spr);
		add(skulls);

		if (KadeEngineData.menuData.customColors != []){
			var hell:Int = 0;
			if (KadeEngineData.menuData.useExistColors == false) titleColors = [];				
			for (color in 0...KadeEngineData.menuData.customColors.length){
				var splittingLol:Array<Dynamic> = KadeEngineData.menuData.customColors[hell].split(":");
				var mergerLol:Array<FlxColor> = [];
				mergerLol = [FlxColor.fromRGB(splittingLol[0], splittingLol[1], splittingLol[2]), FlxColor.fromRGB(splittingLol[3], splittingLol[4], splittingLol[5])];
				titleColors.push(mergerLol);
				hell += 1;
			}
		}
		KadeEngineData.menuData = null;

		logoBl = new FlxSprite(0, 50).loadGraphic(Paths.image('logoBumpin'));
		logoBl.antialiasing = FlxG.save.data.antialias;
		logoBl.setGraphicSize(Std.int(logoBl.width * 0.5));
		logoBl.updateHitbox();
		logoBl.screenCenter(X);
		add(logoBl);

		titleText = new FlxSprite(0, 0).loadGraphic(Paths.image('title/enter'));
		titleText.antialiasing = FlxG.save.data.antialias;
		titleText.setGraphicSize(Std.int(titleText.width * 0.5));
		titleText.updateHitbox();
		titleText.y = FlxG.height - titleText.height - 40;
		titleText.screenCenter(X);
		add(titleText);

		blackScreen = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		add(blackScreen);
		add(warning);
		skipIntro();
	}

	var transitioning:Bool = false;
	override function update(elapsed:Float){
		if (FlxG.sound.music != null) Conductor.songPosition = FlxG.sound.music.time;
		if(initialized && !transitioning && skippedIntro){
			#if desktop
			if (FlxG.keys.justPressed.ENTER || FlxG.mouse.pressed) act();
			if (FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.Z) FlxG.sound.play(Paths.sound('blocked'));
			#else
			touch = FlxG.touches.getFirst();
			if(touch != null && touch.justPressed) act();
			#end
		}
		super.update(elapsed);
	}

	function act(){
		if (FlxG.save.data.flashing) FlxFlicker.flicker(titleText, 2, 0.06, true, true);
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		FlxTween.tween(logoBl, {y: logoBl.y - 600}, 2, {ease: FlxEase.backIn});
		FlxTween.tween(titleText, {y: titleText.y + 600}, 2, {ease: FlxEase.backIn});
		transitioning = true;
		new FlxTimer().start(1, function(tmr:FlxTimer){
			#if desktop
            if (FlxG.save.data.secTime == true) FlxG.switchState(new OutdatedSubState());
			else FlxG.switchState(new MainMenuState());
			#else
			FlxG.switchState(new MainMenuState());
			#end
		});
	}

	override function beatHit(){
		super.beatHit();
		logoBl.scale.set(0.51, 0.51);
		titleText.scale.set(0.51, 0.51);
		FlxTween.tween(logoBl, {"scale.x": 0.5, "scale.y": 0.5}, Conductor.stepCrochet / 1000, {ease: FlxEase.sineInOut});
		FlxTween.tween(titleText, {"scale.x": 0.5, "scale.y": 0.5}, Conductor.stepCrochet / 1000, {ease: FlxEase.sineInOut});
	}

	var skippedIntro:Bool = false;
	function skipIntro():Void{
		if (!skippedIntro){
			FlxG.camera.flash(FlxColor.BLACK, 2);
			remove(blackScreen);
			blackScreen.destroy();
			initialized = true;
			skippedIntro = true;
		}
	}

	public static function setColorBlindFilter(){
		var matrix:Array<Float> = switch(Reflect.getProperty(FlxG.save.data, 'colorBlindFilter')) {
			case 1:[0.43, 0.72, -.15, 0, 0, 0.34, 0.57, 0.09, 0, 0, -.02, 0.03, 1, 0, 0, 0, 0, 0, 1, 0,];
			case 2:[0.20, 0.99, -.19, 0, 0, 0.16, 0.79, 0.04, 0, 0, 0.01, -.01, 1, 0, 0, 0, 0, 0, 1, 0,];
			case 3:[0.97, 0.11, -.08, 0, 0, 0.02, 0.82, 0.16, 0, 0, 0.06, 0.88, 0.18, 0, 0, 0, 0, 0, 1, 0,];
			default:[];
		}
		/*Should i use these instead of the ones im using rn? Which ones are accurate?
		'Protanopia':[0.567,0.433,0,0,0, 0.558,0.442,0,0,0, 0,0.242,0.758,0,0, 0,0,0,1,0, 0,0,0,0,1],
		'Protanomaly':[0.817,0.183,0,0,0, 0.333,0.667,0,0,0, 0,0.125,0.875,0,0, 0,0,0,1,0, 0,0,0,0,1],
		'Deuteranopia':[0.625,0.375,0,0,0, 0.7,0.3,0,0,0, 0,0.3,0.7,0,0, 0,0,0,1,0, 0,0,0,0,1],
		'Deuteranomaly':[0.8,0.2,0,0,0, 0.258,0.742,0,0,0, 0,0.142,0.858,0,0, 0,0,0,1,0, 0,0,0,0,1],
		'Tritanopia':[0.95,0.05,0,0,0, 0,0.433,0.567,0,0, 0,0.475,0.525,0,0, 0,0,0,1,0, 0,0,0,0,1],
		'Tritanomaly':[0.967,0.033,0,0,0, 0,0.733,0.267,0,0, 0,0.183,0.817,0,0, 0,0,0,1,0, 0,0,0,0,1],
		'Achromatopsia':[0.299,0.587,0.114,0,0, 0.299,0.587,0.114,0,0, 0.299,0.587,0.114,0,0, 0,0,0,1,0, 0,0,0,0,1],
		'Achromatomaly':[0.618,0.320,0.062,0,0, 0.163,0.775,0.062,0,0, 0.163,0.320,0.516,0,0, 0,0,0,1,0,0,0,0,]*/
		FlxG.game.setFilters(FlxG.save.data.colorBlindFilter == 0 ? [] : [new ColorMatrixFilter(matrix)]);
	}
}