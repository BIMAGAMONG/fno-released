package;
import flixel.FlxCamera;
using StringTools;

class ErectState extends MusicBeatState{
    var redBG:FlxSprite;
    var bottomTypeShit:FlxSprite;
    var topTypeShit:FlxSprite;
	var skulls:FlxBackdrop;
    var mainFrame:FlxSprite;
    var coverMain:FlxSprite;
    var songStats:FlxText;
    var songName:FlxText;
    var controlsTXT:FlxText;
    var erectTXT:FlxText;
    var erectSongs:Array<String> = [
        "red-x", "starshot", "question", "regenerator"
    ];
    static var curBoner:Int = 0;
    var lengthText:FlxText;
    var block:Bool = false;
    var camShake:FlxCamera;
    var camStatic:FlxCamera;
    static var curRemix:Int = 3;
    #if mobile
    var leftbutt:FlxSprite;
    var rightbutt:FlxSprite;
    var button:FlxSprite;
    #end

    override public function create(){
        transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

        if (FlxG.sound.music != null) if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music('freplay', 'shared'));

        camStatic = new FlxCamera();
		camStatic.bgColor.alpha = 0;
		FlxG.cameras.add(camStatic);
        camShake = new FlxCamera();
		camShake.bgColor.alpha = 0;
		FlxG.cameras.add(camShake);
        @:privateAccess
        FlxCamera._defaultCameras = [camStatic, camShake];
        
        var integer:Int = FlxG.random.int(0, TitleState.titleColors.length - 1);
        redBG = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, TitleState.titleColors[integer], 1, 180, true);
		redBG.screenCenter();
        redBG.antialiasing = false;
        add(redBG);
        redBG.cameras = [camStatic];

        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        add(skulls);
        skulls.cameras = [camStatic];

        bottomTypeShit = new FlxSprite(0, 570).makeGraphic(1600, 150, FlxColor.BLACK);
        bottomTypeShit.alpha = 0.6;
        bottomTypeShit.antialiasing = false;
        bottomTypeShit.cameras = [camStatic];
        bottomTypeShit.screenCenter(X);
        add(bottomTypeShit);

        topTypeShit = new FlxSprite(0, 0).makeGraphic(1600, 150, FlxColor.BLACK);
        topTypeShit.alpha = 0.6;
        topTypeShit.antialiasing = false;
        topTypeShit.cameras = [camStatic];
        topTypeShit.screenCenter(X);
        add(topTypeShit);

        mainFrame = new FlxSprite().loadGraphic(Paths.image('freeplay/frame'));
        mainFrame.scale.set(0.8, 0.8);
        mainFrame.updateHitbox();
        mainFrame.screenCenter();
        mainFrame.antialiasing = FlxG.save.data.antialias;
        mainFrame.cameras = [camShake];

        songName = new FlxText(0, 600, 0, "< " + erectSongs[curBoner] + " >");
        songName.text = songName.text.replace("-", " ");
        songName.setFormat(Paths.font("difficultyFont.ttf"), 45, FlxColor.WHITE, CENTER);
        songName.screenCenter(X);
        songName.antialiasing = FlxG.save.data.antialias;
        songName.cameras = [camStatic];

        songStats = new FlxText(10, 610, 0, '');
        songStats.setFormat(Paths.font("funniPsychFont.ttf"), 30, FlxColor.WHITE, LEFT);
        songStats.cameras = [camStatic];
        songStats.antialiasing = FlxG.save.data.antialias;

        erectTXT = new FlxText(0, 25, 0, LangUtil.translate("REMIXES"));
        erectTXT.setFormat(Paths.font("difficultyFont.ttf"), 60, 0xFFFF0099, CENTER);
        erectTXT.cameras = [camStatic];
        erectTXT.antialiasing = FlxG.save.data.antialias;
        erectTXT.screenCenter(X);
        
        coverMain = new FlxSprite();
        loadDaCover();
        add(songStats);
        add(songName);

        lengthText = new FlxText(0, songName.y + 50, 0, "");
        lengthText.setFormat(Paths.font("difficultyFont.ttf"), 30, FlxColor.WHITE, CENTER);
        lengthText.screenCenter(X);
        lengthText.antialiasing = FlxG.save.data.antialias;
        lengthText.cameras = [camStatic];
        add(lengthText);
        
        if (FlxG.save.data.menuinst){
            controlsTXT = new FlxText(0, 610, 0, #if desktop '${LangUtil.translate("LEFT")}/${LangUtil.translate("RIGHT")}/${LangUtil.translate("MOUSE WHEEL")} - ${LangUtil.translate("scroll")}\n${LangUtil.translate("ENTER")}/${LangUtil.translate("CLICK")} - ${LangUtil.translate("select")}\n${LangUtil.translate("ESC")}/${LangUtil.translate("BACKSPACE")} - ${LangUtil.translate("go back")}' #else '${LangUtil.translate("TOUCH")} - ${LangUtil.translate("select")}' #end);
            controlsTXT.setFormat(Paths.font("funniPsychFont.ttf"), 20, FlxColor.WHITE, RIGHT);
            controlsTXT.antialiasing = FlxG.save.data.antialias;
            controlsTXT.cameras = [camStatic];
            controlsTXT.x = FlxG.width - controlsTXT.width - 5;
            add(controlsTXT);
        }
        
        add(erectTXT);
        add(coverMain);
        add(mainFrame);
        #if mobile
        leftbutt = new FlxSprite().loadGraphic(Paths.image('mobile/small_button'));
		add(leftbutt);
		rightbutt = new FlxSprite().loadGraphic(Paths.image('mobile/small_button'));
        rightbutt.flipX = true;
		add(rightbutt);
		for(spr in [leftbutt, rightbutt]){
            spr.scale.set(1.5, 1.5);
            spr.updateHitbox();
			spr.screenCenter(Y);
			spr.antialiasing = false;
			spr.alpha = 0.5;
            spr.cameras = [camStatic];
		}
        leftbutt.x = 0;
        rightbutt.x = FlxG.width - rightbutt.width;
        button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.x = FlxG.width - button.width;
        button.alpha = 0.5;
        button.cameras = [camStatic];
		add(button);
        #end

        changeSel(0);
        super.create();
    }

    public function loadDaCover() {
        var path:String = "";
        openfl.Assets.cache.clear("assets/images/freeplay/art");
        System.gc();
        if (#if desktop FileSystem.exists(Paths.image('freeplay/art/story/cover-' + erectSongs[curBoner])) #else Assets.exists(Paths.image('freeplay/art/story/cover-' + erectSongs[curBoner])) #end) path = 'story';
        else if (#if desktop FileSystem.exists(Paths.image('freeplay/art/brawl/cover-' + erectSongs[curBoner])) #else Assets.exists(Paths.image('freeplay/art/brawl/cover-' + erectSongs[curBoner])) #end) path = 'brawl';            
        else if (#if desktop FileSystem.exists(Paths.image('freeplay/art/extra/cover-' + erectSongs[curBoner])) #else Assets.exists(Paths.image('freeplay/art/extra/cover-' + erectSongs[curBoner])) #end) path = 'extra';           
        else if (#if desktop FileSystem.exists(Paths.image('freeplay/art/weeks/cover-' + erectSongs[curBoner])) #else Assets.exists(Paths.image('freeplay/art/weeks/cover-' + erectSongs[curBoner])) #end) path = 'weeks';
        if (KadeEngineData.erectSongsBeaten.contains(erectSongs[curBoner])){
            coverMain.loadGraphic(Paths.image('freeplay/art/' + path + '/cover-' + erectSongs[curBoner]));
            songName.text = "< " + StringTools.replace(SongLangUtil.trans(erectSongs[curBoner].toUpperCase()), '-', ' ') + " >";
            songName.text = songName.text.replace("-", " ");
        }else{
            coverMain.loadGraphic(Paths.image('freeplay/art/mystery'));
            songName.text = "< ????? >";
        }

        coverMain.scale.set(0.8, 0.8);
        coverMain.updateHitbox();
        coverMain.screenCenter();
        coverMain.antialiasing = FlxG.save.data.antialias;
        coverMain.cameras = [camShake];
    }

    override public function update(elapsed:Float){
        if (FlxG.save.data.shaking) camShake.shake(0.001, 1, null, true);
        songStats.text = '${LangUtil.translate("Score")}: ' + Highscore.getScore(erectSongs[curBoner], curRemix) + '\n${LangUtil.translate("Accuracy")}: ' + Highscore.getAccs(erectSongs[curBoner], curRemix) + "%";
        #if mobile touch = FlxG.touches.getFirst(); #end
        if (!block){
            #if desktop
            if (controls.BACK) exit();
            if (controls.ACCEPT || FlxG.mouse.pressed && (FlxG.mouse.overlaps(mainFrame) || FlxG.mouse.overlaps(coverMain))) accepted();
            if (FlxG.keys.justPressed.RIGHT || FlxG.mouse.wheel < 0) changeSel(1);
            if (FlxG.keys.justPressed.LEFT || FlxG.mouse.wheel > 0) changeSel(-1);
            #else
            if(touch != null && touch.justPressed){
                if(touch.overlaps(mainFrame, camStatic) || touch.overlaps(coverMain, camStatic)) accepted();
                if(touch.overlaps(leftbutt, camStatic)) changeSel(-1);
                if(touch.overlaps(rightbutt, camStatic)) changeSel(1);
                if(touch.overlaps(button, camStatic)) exit();
            }
            #end
        }
        super.update(elapsed);
    }

    function exit(){
        block = true;
        FlxG.sound.play(Paths.sound('cancelMenu'));
        FlxG.switchState(new FreeplayCustom());
    }

    function accepted(){
        block = true;
        LoadingState.invisible = true;
        FlxG.sound.music.fadeOut(1, 0);
        FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
        FlxTween.tween(camStatic, {zoom: 1.5, alpha: 0}, 1, {ease: FlxEase.expoOut});
        FlxTween.tween(camShake, {zoom: 1.5, alpha: 0}, 1, {ease: FlxEase.expoOut});
        PlayState.SONG = Song.loadFromJson(erectSongs[curBoner], erectSongs[curBoner], '-erect');
        PlayState.storyDifficulty = curRemix;
        new FlxTimer().start(1.1, function(timer:FlxTimer){LoadingState.loadAndSwitchState(new PlayState());});
    }

    public function changeSel(change:Int){
        curBoner += change;
        if (curBoner > erectSongs.length - 1) curBoner = 0;
        else if (curBoner < 0) curBoner = erectSongs.length - 1;
        FlxG.sound.play(Paths.sound('scrollMenu'));
        loadDaCover();
        lengthText.text = '${LangUtil.translate("Songs")}: ' + Std.string(curBoner + 1) + '/' + erectSongs.length;
        songName.screenCenter(X);
        erectTXT.screenCenter(X);
        lengthText.screenCenter(X);
    }
}