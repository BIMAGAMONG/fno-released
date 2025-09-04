package;
import options.*;
import Controls.KeyboardScheme;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import lime.app.Application;
import flixel.text.FlxInputText;
import flixel.FlxSubState;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.math.FlxPoint;
import openfl.display.BitmapData;
import gamejolt.GJClient;
using StringTools;

class MainMenuState extends MusicBeatState{
	var codeBox:FlxInputText;
	var boxSize:Int = Std.int(FlxG.width * 0.2);
	var enterCode:GJActionButton;
	var daWidth:Int;
    var daHeight:Int;
	var skulls:FlxBackdrop;
	var boxSizez:Int = Std.int(FlxG.width * 0.2);
	public var textMiss:FlxText;
	public var textNotes:FlxText;
	public var selectedSomethin:Bool = false;
	public var splashText:FlxText;
	public var integer:Int = FlxG.random.int(1, 6);
	var warning:BrawlPopup = new BrawlPopup();
	var button:Array<String> = ['STORY MODE', 'FREEPLAY', 'CREDITS', 'OPTIONS', 'GAMEJOLT', 'LINKS'];
	var grp:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var curSel:Int = 0;

	override function create(){
		#if desktop
		DiscordClient.changePresence("Im in the Menu...", null);
		FlxG.mouse.visible = true;
		#end
		FlxG.camera.filters = [];
		if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		persistentUpdate = true;

		var path:String = 'assets/images/title/mmbg';
		var array:Array<String> = #if desktop FileSystem.readDirectory(path) #else Assets.list().filter(asset -> asset.startsWith("assets/images/title/mmbg")) #end;
		#if !desktop for (p in 0...array.length) array[p] = StringTools.replace(array[p], 'assets/images/title/mmbg/', ''); #end

		var bg:FlxSprite = new FlxSprite().loadGraphic(BitmapData.fromFile(path + '/${array[FlxG.random.int(0, array.length - 1)]}'));
		bg.antialiasing = false;
		bg.setGraphicSize(Std.int(bg.width * #if desktop 1.1 #else 1.3 #end));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);
		
        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        add(skulls);

		var bgBranches:FlxSprite = new FlxSprite(Paths.image('menuBranches', 'shared'));
		bgBranches.antialiasing = false;
		bgBranches.scale.set(1.5, 1);
		bgBranches.updateHitbox();
		bgBranches.screenCenter();
		add(bgBranches);
		add(grp);
		
		for(i in 0...button.length){
			var spr:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('mainmenu/' + button[i].toLowerCase()));
			spr.antialiasing = FlxG.save.data.antialias;
			spr.ID = i;
			spr.scale.set(0.5, 0.5);
			spr.updateHitbox();
			switch(spr.ID){
				case 0: spr.setPosition(30, 150);
				case 1:
					spr.setPosition(370, 20);
					spr.alpha = FlxG.save.data.freeplayUnlocked ? 1 : 0.5;
				case 2: spr.setPosition(700, 20);
				case 3: spr.setPosition(1000, 100);
				case 4: spr.setPosition(950, 390);
				case 5: spr.setPosition(600, 500);
			}
			#if mobile spr.x += 100; #end
			grp.add(spr);

			var txt:FlxText = new FlxText(0, 0, 0, LangUtil.translate(button[i]), 32);
			txt.setFormat(Paths.font('tardling.ttf'), 32, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
			txt.setPosition(spr.x, spr.y + spr.height);
			txt.antialiasing = FlxG.save.data.antialias;
			txt.x += (spr.width / 2) - (txt.width / 2);
			txt.ID = 9; //not mess up with the menu
			grp.add(txt);
		}

		codeBox = new FlxInputText(38, 463, boxSizez, '', 44);
		codeBox.setFormat(Paths.font('LilitaOne-Regular.ttf'), 40, FlxColor.BLACK, CENTER);
		codeBox.antialiasing = false;
		codeBox.y += 70;
		codeBox.fieldBorderColor = FlxColor.TRANSPARENT;
		codeBox.height = 50;
		codeBox.updateHitbox();
        add(codeBox);

		daWidth = Std.int(FlxG.width * 0.3);
		daHeight = Std.int(FlxG.height * 0.13);
		enterCode = new GJActionButton(codeBox.x + 50, 600, daWidth, daHeight, LangUtil.translate('REDEEM'),function (){loadDaCodeShit(codeBox.text.toLowerCase());});
		add(enterCode);

		#if desktop
		if (sys.io.File.getContent('assets/data/file.txt') == "true") GJClient.trophieAdd(183129);
		if (FlxG.save.data.dfjk) controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);
		#else
		codeBox.x += 100;
		enterCode.x += 120;
		#end
		GJClient.initialize((user) -> trace("Log In successful!"));
		GJClient.trophieAdd(183128);

		var txtAr:Array<String> = LangUtil.getSplashText();
		splashText = new FlxText(0, 0, 0, txtAr[FlxG.random.int(0, txtAr.length - 1)]).setFormat(Paths.font('tardling.ttf'), 60, 0xFF00FE9E, CENTER, OUTLINE, FlxColor.BLACK);
		splashText.screenCenter();
		splashText.borderSize = 4;
		splashText.borderColor = 0xFF00AB6A;
		splashText.antialiasing = FlxG.save.data.antialias;
		add(splashText);

		#if desktop
		textNotes = new FlxText(800, 100, FlxG.width, LangUtil.translate("Total Notes Pressed:") + FlxG.save.data.totalNotesPressed + "\n" + LangUtil.translate("Total Misses:") + FlxG.save.data.totalNotesMissed);
		textNotes.setFormat(Paths.font('LilitaOne-Regular.ttf'), 30, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		textNotes.visible = false;
		textNotes.screenCenter();
		add(textNotes);
		#end
		add(warning);
		super.create();
	}

	override function update(elapsed:Float){
		#if desktop
		if (FlxG.sound.music.volume < 0.8) FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		textNotes.visible = FlxG.keys.pressed.ONE ? true : false;
		#else
		touch = FlxG.touches.getFirst();
		#end
		
		if(!selectedSomethin){
			for(spr in grp.members){
				if(spr.ID != 9){
					#if desktop
					if(FlxG.mouse.overlaps(spr)){
						if(curSel != spr.ID) FlxG.sound.play(Paths.sound('scrollMenu'));
						curSel = spr.ID;
					}
					if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(spr)) select();
					#else
					if(touch != null){
						if(touch.justPressed && touch.overlaps(spr)){
							curSel = spr.ID;
							select();
						}
					}
					#end
				}
			}
		}
		super.update(elapsed);
	}

	function triggerPopup(text:String) warning.activate(LangUtil.translate(text));
	function select(){
		selectedSomethin = true;
		switch(button[curSel]){
            case 'STORY MODE': FlxG.switchState(new StoryMenuState());
            case 'FREEPLAY': 
				if(FlxG.save.data.freeplayUnlocked){
					FlxG.sound.music.stop();
					FlxG.switchState(new FreeplayCustom());
				}else{
					selectedSomethin = false;
					triggerPopup("Complete story mode first!");
				}
            case 'CREDITS': FlxG.switchState(new CreditsState());
            case 'OPTIONS': FlxG.switchState(new OutrageOptions());
            case 'GAMEJOLT': FlxG.switchState(new GameJoltState());
			case 'LINKS': openSubState(new LinksSubstate());
        }
		if(selectedSomethin) FlxG.sound.play(Paths.sound('confirmMenu'));
		else FlxG.sound.play(Paths.sound('blocked'));
	}

	override function closeSubState() {super.closeSubState(); selectedSomethin = false;}
	override function openSubState(lol:FlxSubState) {super.openSubState(lol); selectedSomethin = true;}
	public function loadDaCodeShit(daText:String){
		switch (daText.toLowerCase()){
			// OTHER SHIT
			case 'invasion': fancyOpenURL("https://drive.google.com/file/d/1buHq7JFAmeLNKRdit27ptwYL5OwB7H2Z/view?usp=sharing");
			case 'penkaru': triggerPopup("OVERDONE >:(");
			case '69420228360': triggerPopup("Your credit card was Fanum Taxed successfully.");
			case 'codebreaker': GJClient.trophieAdd(185444);
			// EXTRA CATEGORY (0)
			case 'bread' | 'pan' | 'pão' | 'хлеб': pushSong('far-future', 0);
			// BRAWL CATEGORY (1)
			case 'blas': pushSong('showdown-of-chaos', 1);
		}		
	}
	function pushSong(str:String, cat:Int){
		if (KadeEngineData.unlockedSongsArray.contains(str)) return;
		var desc:Array<String> = [LangUtil.translate("Song can be found in 'Extra' category of Freeplay."), LangUtil.translate("Song can be found in 'Brawl' category of Freeplay.")];
		KadeEngineData.pushUnlockedSong(str);
		openSubState(new SexSubState('freeplay/art/' + (cat == 0 ? 'extra' : 'brawl') + '/cover-' + str, LangUtil.translate('new song unlocked'), desc[cat]));	
	}
}