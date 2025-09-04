package;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import lime.net.curl.CURLCode;
using StringTools;

class StoryMenuState extends MusicBeatState{
	var controlsTXT:FlxText;
	var warning:BrawlPopup = new BrawlPopup();
	var weekArt:FlxSprite = new FlxSprite();
	var weekData:Array<Dynamic> = [
		['Red-X', 'Omnipotent', 'Ov-Dezeption'],
		['Map-Maker', 'Question', 'Contest-Outrage'],
		['Space-Trap', 'Regenerator', 'Swearing'],
		['Go-Go-Disco', 'Sorcery', 'Starshot']
	];
	var setting:Array<String> = [
		"bima",
		"lowme",
		"marsniw",
		"sakura"
	];
	var weekNames:Array<String> = [];
	var txtWeekTitle:FlxText;
	var txtWeekCount:FlxText;
	var curWeek:Int = 0;
	var skulls:FlxBackdrop;
	var difficSelector:FlxText;
	var difficultyCounter:Int = 0;
	var actualDifficulty:String = "";
	#if mobile
	var topButton:FlxSprite;
	var botButton:FlxSprite;
	var button:FlxSprite;
	#end

	override function create(){				
		weekNames = LangUtil.getWeekNames();	
		PlayState.isStoryMode = true;
		#if desktop
		DiscordClient.changePresence("Picking a Week...", null);
		#end
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;
		if (FlxG.sound.music != null) if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		persistentUpdate = persistentDraw = true;

		txtWeekTitle = new FlxText(FlxG.width * 0.7 - 10, 30, 0, "", 25);
		txtWeekTitle.setFormat(Paths.font("LilitaOne-Regular.ttf"), 50, 0xFFFFFFFF, RIGHT);
		txtWeekTitle.alpha = 0.7;

		txtWeekCount = new FlxText(FlxG.width * 0.7 - 10, txtWeekTitle.y + 50, 0, "", 25);
		txtWeekCount.setFormat(Paths.font("LilitaOne-Regular.ttf"), 30, 0xFFFFFFFF, RIGHT);
		txtWeekCount.alpha = 0.7;

        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        add(skulls);
		add(txtWeekTitle);
		add(txtWeekCount);

		difficSelector = new FlxText(0, 0, 0, 'this is an easter egg');
		difficSelector.setFormat(Paths.font("difficultyFont.ttf"), 50, FlxColor.WHITE, LEFT);
		difficSelector.screenCenter(X);
		difficSelector.x -= 250;
		difficSelector.y = 600;
		difficSelector.antialiasing = true;
		add(difficSelector);

		controlsTXT = new FlxText(0, 0, 0, 'A/D/${LangUtil.translate('LEFT')}/${LangUtil.translate('RIGHT')} - ${LangUtil.translate('switch difficulties')}\n${LangUtil.translate('MOUSE WHEEL')}/${LangUtil.translate('UP')}/${LangUtil.translate('DOWN')} - ${LangUtil.translate('change weeks')}');
        controlsTXT.setFormat(Paths.font("funniPsychFont.ttf"), #if desktop 15 #else 45 #end, FlxColor.WHITE, RIGHT, OUTLINE, FlxColor.BLACK);
        controlsTXT.screenCenter();
        controlsTXT.updateHitbox();
        controlsTXT.y += #if desktop 270 #else 300 #end;
		controlsTXT.x += 350;
		controlsTXT.antialiasing = true;
        add(controlsTXT);
		#if desktop
		controlsTXT.text += '\nCTRL - ' + (FlxG.save.data.freeplayUnlocked == false ? LangUtil.translate('LOCKED') : LangUtil.translate('pick tracks'));
		if (!FlxG.save.data.menuinst){
			difficSelector.setFormat(Paths.font("difficultyFont.ttf"), 50, FlxColor.WHITE, CENTER);
			difficSelector.screenCenter(X);
			controlsTXT.destroy();
			remove(controlsTXT);
		}
		#else
		if (FlxG.save.data.menuinst) controlsTXT.text = LangUtil.translate('TOUCH ME') + '\n- ' + (FlxG.save.data.freeplayUnlocked == false ? LangUtil.translate('LOCKED') : LangUtil.translate('pick tracks'));
		else controlsTXT.text = (FlxG.save.data.freeplayUnlocked == false ? LangUtil.translate('LOCKED') : LangUtil.translate('pick tracks').toUpperCase());
		#end

		updateDiff(0);
		weekArt.frames = Paths.getSparrowAtlas('campaign_menu_UI_characters');
		weekArt.setGraphicSize(Std.int(weekArt.width / 1.2));
		weekArt.updateHitbox();
		weekArt.screenCenter();
		add(weekArt);

		#if mobile
		txtWeekTitle.y = weekArt.y + weekArt.height;
		txtWeekCount.y = txtWeekTitle.y + 50;
		topButton = new FlxSprite(0, 0).loadGraphic(Paths.image('mobile/long_button'));
		add(topButton);
		botButton = new FlxSprite(0, 0).loadGraphic(Paths.image('mobile/long_button'));
		botButton.flipY = true;
		add(botButton);
		for(spr in [topButton, botButton]){
			spr.screenCenter(X);
			spr.antialiasing = false;
			spr.alpha = 0.5;
		}
		topButton.x = 0;
		botButton.x = FlxG.width - botButton.width;
		for(tx in [difficSelector, controlsTXT]) tx.y += 5;
		difficSelector.x = 10;
		controlsTXT.x = FlxG.width - controlsTXT.width - 10;

		button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.screenCenter(X);
        button.alpha = 0.5;
		add(button);
		#end
		super.create();
		if (FlxG.save.data.shaders) FlxG.camera.filters = [new ShaderFilter(new shad.CylinderShader())];
		changeWeek(0);
		add(warning);
	}

	public function updateDiff(c:Int){
		difficultyCounter = Difficulty.wrap(difficultyCounter, c);
		difficSelector.text = #if desktop '< ${Difficulty.getDiff(difficultyCounter)} >' #else '${Difficulty.getDiff(difficultyCounter)}' + (FlxG.save.data.menuinst ? '\n(${LangUtil.translate('TOUCH ME')})' : '') #end;
		difficSelector.color = Difficulty.getColor(difficultyCounter);
		actualDifficulty = Difficulty.getPrefix(difficultyCounter);
	}

	override function update(elapsed:Float){
		Conductor.songPosition = FlxG.sound.music.time;
		#if desktop
		FlxG.camera.scroll.x = FlxMath.lerp(FlxG.camera.scroll.x, (FlxG.mouse.screenX-(FlxG.width/2)) * 0.01, (1/30) * 240 * elapsed);
        FlxG.camera.scroll.y = FlxMath.lerp(FlxG.camera.scroll.y, (FlxG.mouse.screenY-6-(FlxG.height/2)) * 0.01, (1/30) * 240 * elapsed);
		#else
		touch = FlxG.touches.getFirst();
		#end

		if (!selectedWeek){
			#if desktop
			if (FlxG.keys.justPressed.D || FlxG.keys.justPressed.RIGHT) updateDiff(1);
	    	else if (FlxG.keys.justPressed.A || FlxG.keys.justPressed.LEFT) updateDiff(-1);
			if (controls.UP_P || FlxG.mouse.wheel > 0) changeWeek(-1);
			if (controls.DOWN_P || FlxG.mouse.wheel < 0) changeWeek(1);
			if (controls.BACK) exit();
			if (controls.ACCEPT || (FlxG.mouse.pressed && FlxG.mouse.overlaps(weekArt))){
				selectWeek();
				DiscordClient.changePresence("Just selected a week!", null);
			}
			if (FlxG.keys.justPressed.CONTROL) check();
			#else
			if(touch != null && touch.justPressed){
				if(touch.overlaps(button)) exit();
				if(touch.overlaps(controlsTXT)) check();
				if(touch.overlaps(difficSelector)) updateDiff(1);
				if(touch.overlaps(botButton)) changeWeek(1);
				if(touch.overlaps(topButton)) changeWeek(-1);
				if(touch.overlaps(weekArt)) selectWeek();
			}
			#end
		}
		super.update(elapsed);
	}

	function exit(){
		PlayState.isStoryMode = false;
		FlxG.sound.play(Paths.sound('cancelMenu'));
		selectedWeek = true;
		FlxG.switchState(new MainMenuState());
	}

	function check(){
		if (FlxG.save.data.freeplayUnlocked){
			PlayState.isStoryMode = false;
			FlxG.sound.play(Paths.sound('switchTabs'));
			FlxG.switchState(new CodingPlaygroundState());
			selectedWeek = true;
		}else triggerPopup();
	}

	function triggerPopup(){
		FlxG.sound.play(Paths.sound('blocked'));
		warning.activate(LangUtil.translate("Complete story mode first!"));
	}

	var selectedWeek:Bool = false;
	function selectWeek(){
		selectedWeek = true;
		FlxG.sound.play(Paths.sound('confirmMenu'));
		FlxTween.tween(FlxG.camera, {zoom: 1.5}, 1, {ease: FlxEase.expoOut});
		new FlxTimer().start(1, function(timer:FlxTimer){
			PlayState.storyPlaylist = weekData[curWeek];
			PlayState.storyDifficulty = difficultyCounter;
			PlayState.SONG = Song.loadFromJson(StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase() + actualDifficulty, StringTools.replace(PlayState.storyPlaylist[0]," ", "-").toLowerCase());
			PlayState.storyWeek = curWeek;
			LoadingState.loadAndSwitchState(new PlayState(), true);
		});
	}

	var intendedScore:Int = 0;
	function changeWeek(change:Int = 0):Void{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		curWeek += change;
		if (curWeek >= weekData.length) curWeek = 0;
		if (curWeek < 0) curWeek = weekData.length - 1;

		weekArt.animation.addByPrefix(setting[curWeek], setting[curWeek]);
		weekArt.animation.play(setting[curWeek]);
		txtWeekTitle.text = weekNames[curWeek].toUpperCase();
		txtWeekTitle.screenCenter(X);
		txtWeekCount.text = LangUtil.translate("WEEK ") + Std.string(curWeek + 1) + "/" + Std.string(weekData.length);
		txtWeekCount.screenCenter(X);
	}
}