package;
import Controls.KeyboardScheme;
import flixel.FlxObject;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import lime.app.Application;
import flixel.addons.ui.FlxInputText;
import flixel.FlxSubState;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import flixel.math.FlxMath;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.math.FlxMath;
using StringTools;

class CodingPlaygroundState extends MusicBeatState{
    // song name, icon, the animation to play
	// icon anims: 0 = neutral, 1 = lose, 2 = win
	var songList:Array<Array<Dynamic>> = [
        ['red-x', 'ruv', 0],
		['omnipotent', 'ruv', 0],
		['ov-dezeption', 'ruv', 2],
		['map-maker', 'lowme', 0],
		['question', 'lowme', 0],
		['contest-outrage', 'lowme', 1],
		['space-trap', 'marsniw', 0],
		['regenerator', 'marsniw', 0],
		['swearing', 'marsniw', 1],
		['go-go-disco', 'sakura', 2],
		['sorcery', 'sakura', 2],
		['starshot', 'sakuraRage', 0]
	];
	public static var curSelected:Int = 0;
	var difficSelector:FlxText;
    var difficultyCounter:Int = 0;
	public var hell:Int = 0;
	var redBG:FlxSprite;
	var skulls:FlxBackdrop;
    var bg:FlxSprite;
	public var songGRP:FlxTypedSpriteGroup<FlxSprite>;
	var stopSpamming:Bool = false;
	public var controlsTXT:FlxText;
	var eee:FlxText;
	var iconP1:HealthIcon;
	var songStats:FlxText;
	#if mobile
    var button:FlxSprite;
	var sswitch:FlxSprite;
    #end

	override function create(){
		PlayState.isStoryFreeplay = true;
		#if desktop
		DiscordClient.changePresence("Picking individual week tracks...", null);
		#end
		if (FlxG.sound.music != null) if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music('freakyMenu'));
			
		var integer:Int = FlxG.random.int(0, TitleState.titleColors.length - 1);
		redBG = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, TitleState.titleColors[integer], 1, 180, true);
		redBG.screenCenter();
		redBG.antialiasing = false;
		add(redBG);

        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        add(skulls);

        bg = new FlxSprite().loadGraphic(Paths.image('menuBranches', 'shared'));
        bg.antialiasing = FlxG.save.data.antialias;
		bg.flipX = true;
		bg.scale.set(1.5, 1);
		bg.updateHitbox();
		bg.screenCenter();
        add(bg);

		transIn = FlxTransitionableState.defaultTransIn;
        transOut = FlxTransitionableState.defaultTransOut;
		songGRP = new FlxTypedSpriteGroup<FlxSprite>();
		for (i in 0...songList.length) {
			var songArt:FlxSprite = new FlxSprite().loadGraphic(Paths.image('freeplay/art/story/cover-' + songList[hell][0]));
			songArt.scale.set(0.7, 0.7);
			songArt.updateHitbox();
			songArt.screenCenter();
			songArt.x += hell * FlxG.width / 2;
			songArt.y += hell * FlxG.height / 2;
			songArt.ID = hell;
			songGRP.add(songArt);
			var frame:FlxSprite = new FlxSprite().loadGraphic(Paths.image('freeplay/frame'));
			frame.setGraphicSize(Std.int(frame.width * 0.7));
			frame.updateHitbox();
			frame.screenCenter();
			frame.x += hell * FlxG.width / 2;
			frame.y += hell * FlxG.height / 2;
			frame.ID = hell;
			songGRP.add(frame);			
			hell += 1;
		}

		difficSelector = new FlxText(0, FlxG.height - 700, 0, '');
		difficSelector.setFormat(Paths.font("difficultyFont.ttf"), 50, FlxColor.WHITE, CENTER);
		difficSelector.screenCenter(X);
		difficSelector.antialiasing = true;
		add(difficSelector);
		add(songGRP);

	    iconP1 = new HealthIcon(songList[curSelected][1], true);
		iconP1.screenCenter();
		iconP1.y = 380;
		iconP1.x = 80;
		iconP1.scale.set(1.3, 1.3);
		iconP1.flipX = true;
		iconP1.animation.curAnim.curFrame = songList[curSelected][2];
		iconP1.antialiasing = FlxG.save.data.antialias;
		add(iconP1);

		eee = new FlxText(80, 580, 0, songList[curSelected][0]);
		eee.setFormat(Paths.font("difficultyFont.ttf"), 50, FlxColor.WHITE, RIGHT);
		eee.text = eee.text.replace('-', ' ');
		eee.antialiasing = true;
		add(eee);

		#if desktop
		controlsTXT = new FlxText(0, 180, 1500, 'A/D - ${LangUtil.translate('switch difficulties')}\nCTRL - ${LangUtil.translate('go back')}\n${LangUtil.translate('UP')}/${LangUtil.translate('LEFT')}- ${LangUtil.translate('scroll up')}\n${LangUtil.translate('DOWN')}/${LangUtil.translate('RIGHT')} - ${LangUtil.translate('scroll down')}');
        controlsTXT.setFormat(Paths.font("funniPsychFont.ttf"), 20, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
        controlsTXT.updateHitbox();
		controlsTXT.antialiasing = true;
		controlsTXT.x = FlxG.width - controlsTXT.width - 5;
        add(controlsTXT);
		if (!FlxG.save.data.menuinst){
			controlsTXT.destroy();
			remove(controlsTXT);
		}
		#end
		
		songStats = new FlxText(1100, #if desktop controlsTXT.y - 90 #else 170 #end, 0, '');
		songStats.antialiasing = true;
        songStats.setFormat(Paths.font("funniPsychFont.ttf"), #if desktop 20 #else 30 #end, FlxColor.WHITE, RIGHT);
        add(songStats);
		for (item in songGRP.members) {
			item.antialiasing = FlxG.save.data.antialias;
			if(curSelected != item.ID) FlxTween.tween(item, {"scale.x": 0.5, "scale.y": 0.5, alpha: 0.5}, 0.2, {ease: FlxEase.expoOut});
			if(curSelected == item.ID) FlxTween.tween(item, {"scale.x": 0.7, "scale.y": 0.7, alpha: 1}, 0.2, {ease: FlxEase.expoOut});
		}
		updateDiff(0);
		changedSelect(0);
		#if mobile
        button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.x = FlxG.width - button.width;
        button.alpha = 0.5;
		add(button);
		sswitch = new FlxSprite().loadGraphic(Paths.image('mobile/change_tabs'));
        sswitch.x = button.x - button.width - 5;
        sswitch.alpha = 0.5;
		add(sswitch);
        #end
		super.create();
		if (FlxG.save.data.shaders) FlxG.camera.filters = [new ShaderFilter(new shad.CylinderShader())];
	}

	public function updateDiff(c:Int){
		difficultyCounter = Difficulty.wrap(difficultyCounter, c);
		difficSelector.text = #if desktop '< ${Difficulty.getDiff(difficultyCounter)} >' #else '${Difficulty.getDiff(difficultyCounter)}' #end;
		difficSelector.color = Difficulty.getColor(difficultyCounter);
		difficSelector.screenCenter(X);
		updScores();
	}

	function updScores(){
		songStats.text = '${LangUtil.translate("Score")}: ' + Highscore.getScore(songList[curSelected][0], difficultyCounter) + '\n${LangUtil.translate("Accuracy")}: ' + Highscore.getAccs(songList[curSelected][0], difficultyCounter) + "%";
		songStats.x = FlxG.width - songStats.width - 5;
	}

	override function update(elapsed:Float){
		#if mobile touch = FlxG.touches.getFirst(); #end
		if (!stopSpamming){
			#if desktop
			if (FlxG.keys.justPressed.D) updateDiff(1);
        	else if (FlxG.keys.justPressed.A) updateDiff(-1);
			if (FlxG.keys.justPressed.CONTROL) changeSwitch();
			if (controls.BACK) exit();
			if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.DOWN) changedSelect(1);
			if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.UP) changedSelect(-1);
			if (controls.ACCEPT || FlxG.mouse.pressed && FlxG.mouse.overlaps(songGRP)) trans();
			#else
			if (touch != null && touch.justPressed){
				if(touch.overlaps(difficSelector)) updateDiff(1);
				if(touch.overlaps(sswitch)) changeSwitch();
				if(touch.overlaps(button)) exit();
			}
			#end

			for (item in songGRP.members){
				#if desktop
				if(FlxG.mouse.overlaps(item)){
					if (item.ID == curSelected + 1) changedSelect(1);
					else if (item.ID == curSelected - 1) changedSelect(-1);
				}
				#else
				if(touch != null && touch.justPressed){
					if(touch.overlaps(item)){
						if(item.ID == curSelected + 1) changedSelect(1);
						else if(item.ID == curSelected - 1) changedSelect(-1);
						if (!stopSpamming && item.ID == curSelected) trans(); //have to do this
					}
				}
				#end
			}
		}
		super.update(elapsed);
	}

	function changeSwitch(){
		stopSpamming = true;
		PlayState.isStoryFreeplay = false;
		FlxG.sound.play(Paths.sound('switchTabs'));
		FlxG.switchState(new StoryMenuState());
	}

	function exit(){
		stopSpamming = true;
		PlayState.isStoryFreeplay = false;
		FlxG.sound.play(Paths.sound('cancelMenu'));
		FlxG.switchState(new MainMenuState());
	}

	function trans(){
		stopSpamming = true;
		var poop:String = Highscore.formatSong(songList[curSelected][0], difficultyCounter);
		FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
		for (item in songGRP.members) if (item.ID != curSelected) FlxTween.tween(item, {alpha: 0}, 0.5, {ease: FlxEase.expoOut});
		for (obj in [#if desktop controlsTXT,#end iconP1, eee, bg]) FlxTween.tween(obj, {alpha: 0}, 0.5, {ease: FlxEase.expoOut});
		FlxTween.tween(FlxG.camera, {zoom: 1.4}, 1, {ease: FlxEase.expoOut});
		new FlxTimer().start(1, function(timer:FlxTimer){
			PlayState.SONG = Song.loadFromJson(poop, songList[curSelected][0]);
			PlayState.storyDifficulty = difficultyCounter;
			LoadingState.loadAndSwitchState(new PlayState());
		});
	}

	public function changedSelect(change:Int){
		curSelected += change;
		if (curSelected < 0){curSelected = 0; FlxG.sound.play(Paths.sound('blocked'));}
		else if (curSelected > songList.length - 1){curSelected = songList.length - 1; FlxG.sound.play(Paths.sound('blocked'));}
		else{
			stopSpamming = true;
			FlxG.sound.play(Paths.sound('scrollMenu'));
			
			if (change == 1){
				iconP1.y = 640;
				iconP1.x = 280;
				eee.x += 200;
				eee.y += 200;
			}else{
				iconP1.y = 40;
				iconP1.x = -180;
				eee.x -= 200;
				eee.y -= 200;
			}
			
			updScores();
			iconP1.changeIcon(songList[curSelected][1]);
			iconP1.animation.curAnim.curFrame = songList[curSelected][2];
			eee.text = StringTools.replace(SongLangUtil.trans(songList[curSelected][0].toUpperCase()), '-', ' ');
			eee.text = eee.text.replace('-', ' ');
			FlxTween.tween(eee, {x: 80, y: 580}, 0.2, {ease: FlxEase.expoOut});
			FlxTween.tween(iconP1, {x: 80, y: 380}, 0.2, {ease: FlxEase.expoOut});

			for (item in songGRP.members){
				if(curSelected != item.ID) FlxTween.tween(item, {"scale.x": 0.5, "scale.y": 0.5, alpha: 0.5}, 0.2, {ease: FlxEase.expoOut});
				if(curSelected == item.ID) FlxTween.tween(item, {"scale.x": 0.7, "scale.y": 0.7, alpha: 1}, 0.2, {ease: FlxEase.expoOut});
				if (item.ID <= curSelected - 2 || item.ID >= curSelected + 2) item.kill();
				else if (item.ID == curSelected + 1 || item.ID == curSelected - 1) item.revive();
			}
			FlxTween.tween(songGRP, {x: -(FlxG.width / 2 * curSelected), y: -(FlxG.height / 2 * curSelected)}, 0.2, {ease: FlxEase.expoOut,onComplete:function(twn:FlxTween){stopSpamming = false;}});
		}
	}
}