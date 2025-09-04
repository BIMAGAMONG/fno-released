package;
import openfl.Lib;
#if windows
import llua.Lua;
#end
import Controls.Control;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.sound.FlxSound;
import flixel.FlxCamera;
import flash.system.System;
import options.*;
import Song.SwagSong;
using StringTools;

class PauseSubState extends MusicBeatSubstate{
	var grpMenuShit:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();
    var bgshiz:FlxSprite;
	var menuItems:Array<String> = ['resume', 'restart', 'options', 'exit', 'quit'];
	var curSelected:Int = 0;
	var skulls:FlxBackdrop;
	var selectedSomething:Bool = true;
    var creditsText:FlxText;
	var coverMain:FlxSprite;
	var mainFrame:FlxSprite;
	var sex:String = "";
	var camPAUSE:FlxCamera;

	public function new(song:String, comp:String){
		super();
		FlxG.sound.play(Paths.sound('cancelMenu'));

		camPAUSE = new FlxCamera();
		camPAUSE.bgColor.alpha = 0;
		FlxG.cameras.add(camPAUSE);

		var integer:Int = FlxG.random.int(0, TitleState.titleColors.length - 1);
        bgshiz = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, TitleState.titleColors[integer], 1, 180, true);
		bgshiz.alpha = 0;
		bgshiz.screenCenter();
        bgshiz.antialiasing = false;
        add(bgshiz);

        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        add(skulls);

		for (i in 0...menuItems.length){
			var text:FlxText = new FlxText(50, 600, 0, LangUtil.translate(menuItems[i]).toUpperCase());
        	text.setFormat(Paths.font("tardling.ttf"), 60, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
			text.borderSize = 4;
        	text.antialiasing = FlxG.save.data.antialias;
			text.screenCenter(X);
			text.ID = i;
			text.x += 550 * i;
			text.alpha = curSelected == text.ID ? 1 : 0.5;
			text.scrollFactor.set(0, 0);
			grpMenuShit.add(text);
		}
		add(grpMenuShit);

		if (#if desktop sys.FileSystem.exists(Paths.image('freeplay/art/story/cover-' + song)) #else Assets.exists(Paths.image('freeplay/art/story/cover-' + song)) #end) sex = "story";
		else sex = FreeplayCustom.curCategory;

		mainFrame = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay/frame'));
		coverMain = new FlxSprite(0, 0).loadGraphic(Paths.image('freeplay/art/' + sex + '/cover-' + song));

		for (sp in [coverMain, mainFrame]){
			sp.scale.set(0.7, 0.7);
			sp.alpha = 0;
        	sp.antialiasing = FlxG.save.data.antialias;
			sp.scrollFactor.set(0, 0);
			#if mobile
			sp.updateHitbox();
			sp.screenCenter(Y);
			#else
			sp.screenCenter();
			sp.x += 380;
			#end
			sp.y -= 80;
		}

		creditsText = new FlxText(5, 0, 0, "", 25);
		creditsText.setFormat(Paths.font("LilitaOne-Regular.ttf"), 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		creditsText.borderSize = 2;
		creditsText.y = coverMain.y + 40;
		creditsText.scrollFactor.set(0, 0);
		creditsText.antialiasing = true;

		#if mobile
		mainFrame.x += FlxG.width - mainFrame.width - 5;
		coverMain.x = mainFrame.x + 29;
		creditsText.size = 25;
		creditsText.y = coverMain.y - 10;
		for(tx in grpMenuShit.members){
			tx.size = 70;
			tx.y = FlxG.height - tx.height - 30;
		}
		#end

		add(coverMain);
		add(mainFrame);
		add(creditsText);
		FlxTween.tween(creditsText, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(bgshiz, {alpha: 0.5}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(skulls, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(mainFrame, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});
		FlxTween.tween(coverMain, {alpha: 1}, 0.4, {ease: FlxEase.quartInOut});

		var isn:Bool = (PlayState.curSongData.audiostuff == "" ? true : false);
		creditsText.text = '--- AUDIO ---\nSong - $comp\n' + (isn ? "\n" : '${PlayState.curSongData.audiostuff}\n\n') + "--- VISUALS ---\n" + PlayState.curSongData.visuals + "\n\n--- MISC ---\n" + PlayState.curSongData.misc;
		creditsText.text = creditsText.text.replace('AUDIO', LangUtil.translate('AUDIO'));
		creditsText.text = creditsText.text.replace('VISUALS', LangUtil.translate('VISUALS'));
		creditsText.text = creditsText.text.replace('MISC', LangUtil.translate('MISC'));
		creditsText.text = creditsText.text.replace('Background', LangUtil.translate('Background'));
		creditsText.text = creditsText.text.replace('Characters', LangUtil.translate('Characters'));
		creditsText.text = creditsText.text.replace('Song', LangUtil.translate('Song'));
		creditsText.text = creditsText.text.replace('Sprites', LangUtil.translate('Sprites'));
		creditsText.text = creditsText.text.replace('Chart', LangUtil.translate('Chart'));
		creditsText.text = creditsText.text.replace('Chromatics', LangUtil.translate('Chromatics'));
		new FlxTimer().start(0.4, function(timer:FlxTimer){selectedSomething = false;});
		cameras = [camPAUSE];
	}

	function accepted(){
		selectedSomething = true;
		var daSelected:String = menuItems[curSelected];
		destroyShit();
		switch (daSelected){
			case "resume":
				pauseCountdown();
			case "restart":
				PlayState.stateIsRestarted = true;
				PlayState.exiting = true;
				FlxG.resetState();
				close();
			case "options":
				PlayState.stateIsRestarted = true;
				PlayState.exiting = true;
				FlxG.switchState(new OutrageOptions());
				close();
			case "exit":
				PlayState.stateIsRestarted = false;
				PlayState.exiting = true;
				LoadingState.invisible = false;
				if (!PlayState.isStoryMode){ResultsSubState.dieAllShit();}
				else{
					FlxG.sound.music.stop();
					PlayState.type = "";
					FlxG.switchState(new StoryMenuState());
				}
				close();
			case "quit": System.exit(0);
		}
	}

	function destroyShit(){
		for(obj in [bgshiz, skulls, creditsText, coverMain, mainFrame]){
			obj.destroy();
			remove(obj);
			obj = null;
		}
	}

	override function update(elapsed:Float){
		#if mobile
		touch = FlxG.touches.getFirst();
		if(touch != null && touch.justPressed && !selectedSomething){
			for(it in grpMenuShit.members){
				if(touch.overlaps(it, camPAUSE)){
					if(it.ID != curSelected){
						if(it.ID > curSelected) changeSelection(1);
						else if(it.ID < curSelected) changeSelection(-1);
					}else accepted();
				}
			}
		}
		#end
		super.update(elapsed);
		if (PlayState.type == "-erect" && FlxG.save.data.shaking) camPAUSE.shake(0.001, 1, null, true);
		#if desktop
		if (FlxG.keys.justPressed.LEFT && selectedSomething == false || FlxG.mouse.wheel > 0 && selectedSomething == false) changeSelection(-1);
   		else if (FlxG.keys.justPressed.RIGHT && selectedSomething == false || FlxG.mouse.wheel < 0 && selectedSomething == false) changeSelection(1);
		if ((FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.ENTER) && selectedSomething == false || FlxG.mouse.justPressed && selectedSomething == false) accepted();
		#end
	}

	public function pauseCountdown(){	
		var swagCount:Int = 0;
		for (item in grpMenuShit.members) item.alpha = 0;
		coverMain.alpha = 0;
		mainFrame.alpha = 0;
		creditsText.alpha = 0;

		var count:FlxSprite = new FlxSprite();
		count.scrollFactor.set(0, 0);
		count.antialiasing = FlxG.save.data.antialias;
		count.alpha = 0;
		add(count);

		var ln:String = LangUtil.curLang;
		new FlxTimer().start(0.5, function(tmr:FlxTimer){
			switch (swagCount){
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
					new FlxTimer().start(0.02, function(tmr:FlxTimer) {
						FlxG.cameras.remove(camPAUSE);
						close();
					});
			}

			if (swagCount < 4){
				FlxTween.cancelTweensOf(count);
				count.screenCenter();
				count.alpha = 1;
				FlxTween.tween(count, {alpha: 0}, 0.5, {ease: FlxEase.cubeInOut});
			}
			swagCount += 1;
		}, 5);
	}

	public function changeSelection(change:Int){
		selectedSomething = true;
        for (item in grpMenuShit.members){
			if (change == 1 && curSelected != menuItems.length - 1) FlxTween.tween(item, {x: item.x - 550}, 0.2, {ease: FlxEase.expoOut});
			else if (change == -1 && curSelected != 0) FlxTween.tween(item, {x: item.x + 550}, 0.2, {ease: FlxEase.expoOut});
		}

		curSelected += change;
		if (curSelected < 0) {curSelected = 0; FlxG.sound.play(Paths.sound('blocked'));}
		else if (curSelected > menuItems.length - 1) {curSelected = menuItems.length - 1; FlxG.sound.play(Paths.sound('blocked'));}
		else {FlxG.sound.play(Paths.sound('scrollMenu'));}

		for (item in grpMenuShit.members){
			if (item.ID != curSelected) item.alpha = 0.5;
			if (item.ID == curSelected) item.alpha = 1;
		}
		new FlxTimer().start(0.2, function(timer:FlxTimer){selectedSomething = false;});
	}
}