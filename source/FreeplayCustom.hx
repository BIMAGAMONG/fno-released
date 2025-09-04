package;
import flixel.addons.transition.FlxTransitionableState;
import flash.text.TextField;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import lime.utils.Assets;
import flixel.input.keyboard.FlxKey;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import flixel.FlxCamera;
using StringTools;

class FreeplayCustom extends MusicBeatState{
    var songs:Map<String, Array<Dynamic>> = [
        'extra' => [// name, description, if its unlockable IN A NON-CURRENNCY MANNER
            ['arcade-sludgefest', "Immerse yourself in Starr Park's arcade classics...", false],
            ['astral-descent', 'Eyes.kkx - An experiment gone horribly wrong.', false],
			['far-future', 'Catch a glimpse of the VERY near future....', true],         
			['escalated', "Insane and isolated in a emulated copy of SMW.", false]
		],'brawl' => [
            ['space-symphony', 'The dark lord himself attacked, and you are here to stop him.', false],
            ['starrcade', 'The Tiger Pit Tournament - but you sing, instead of fighting.', false],
            ['showdown-of-chaos', "The screaming menace, wearing his iconic blue glasses.", true],
            ['cory-time', 'A face off with a content creator, live on YouTube.', false]
		],'shitpost' => [
            ['cyberchase', 'Why she looks scary', false],                 
            ['essay', 'TWITTER AND OPINIONS CLASH AGAIN', false],
            ['ear-killer', 'We are getting rid of sound waves with this one', false],
            ['exe-test', 'Just a burning memory...', false],
            ['sakurovania', 'Woah', false],
            ['scrunklywanklyexplodisigmabididotious', 'Good luck saying the name of this song fluently.', false],
            ['dynamike-song-master', 'Get ready for bimas musical masterpiece....', false]
		]
	];

    // the true binary
    public static var curSelected:Int = 0;
    public static var counter:Int = 0;
    var coverX:Float = 0;
    var coverY:Float = 0;
    var difficultyCounter:Int = 0;
    // the flxtext legion
    var songDesc:FlxText;
    var songStats:FlxText;
    var coinCount:FlxText;
    var gemCount:FlxText;
    var categoryText:FlxText;
    var difficSelector:FlxText;
    var controlsTXT:FlxText;
    var inst:FlxText;
    // the flxsprite clan
    var gemIcon:FlxSprite;
    var coinIcon:FlxSprite;
    var coverMain:FlxSprite;
    var mainFrame:FlxSprite;
    var lockedMain:FlxSprite;
    var redBG:FlxSprite;
    public var songGRP:FlxTypedSpriteGroup<FlxSprite> = new FlxTypedSpriteGroup<FlxSprite>();
    var folderHolder:FlxSprite;
    var blackBG:FlxSprite;
    // the outcasts
    var skulls:FlxBackdrop;
    var warning:BrawlPopup = new BrawlPopup();
    var camGRP:FlxCamera;
    var camREST:FlxCamera;
    public static var curCategory:String = "shitpost";
    var songString:String;
    #if mobile
    var button:FlxSprite;
    #end

    override function create(){
        PlayState.isFreeplay = true;
        #if desktop
        DiscordClient.changePresence("Picking songs in Freeplay...", null);
        #end
        // efficient translation chat.....
        for (item in songs.get('shitpost')) item[2] = SongLangUtil.trans(item[2]);
        for (item in songs.get('extra')) item[1] = SongLangUtil.trans(item[1]);
        for (item in songs.get('brawl')) item[1] = SongLangUtil.trans(item[1]);
        
		if (FlxG.sound.music != null) if (!FlxG.sound.music.playing) FlxG.sound.playMusic(Paths.music('freplay', 'shared'));
        transIn = FlxTransitionableState.defaultTransIn;
        transOut = FlxTransitionableState.defaultTransOut;
        if (isLocked(songs.get(curCategory)[curSelected][0])) curSelected = 0;

        camGRP = new FlxCamera();
		camGRP.bgColor.alpha = 0;
		FlxG.cameras.add(camGRP);
        camREST = new FlxCamera();
		camREST.bgColor.alpha = 0;
		FlxG.cameras.add(camREST);
        @:privateAccess
        FlxCamera._defaultCameras = [camREST, camGRP];

        var integer:Int = FlxG.random.int(0, TitleState.titleColors.length - 1);
        redBG = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, TitleState.titleColors[integer], 1, 180, true);
		redBG.screenCenter();
        redBG.antialiasing = false;
        redBG.cameras = [camGRP];
        add(redBG);

        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        skulls.cameras = [camGRP];
        add(skulls);

        folderHolder = new FlxSprite().loadGraphic(Paths.image('freeplay/folder'));
        folderHolder.screenCenter(Y);
        folderHolder.cameras = [camREST];

        controlsTXT = new FlxText(folderHolder.width - 90, FlxG.height, 0, '');
        controlsTXT.setFormat(Paths.font("funniPsychFont.ttf"), #if desktop 20 #else 40 #end, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        controlsTXT.antialiasing = true;
        controlsTXT.cameras = [camREST];
        add(controlsTXT);
        #if desktop
        controlsTXT.text = 'A/D - ${LangUtil.translate('switch difficulties')}, ${LangUtil.translate('ENTER')}/${LangUtil.translate('CLICK')} - ${LangUtil.translate('select')}\n${LangUtil.translate('UP')}/${LangUtil.translate('DOWN')}/${LangUtil.translate('MOUSE WHEEL')} - ${LangUtil.translate('scroll')}';
        if (FlxG.save.data.firstTimeErect == false) controlsTXT.text += LangUtil.translate(", E - remixes");
        #else
        controlsTXT.text = '${LangUtil.translate('TOUCH ME')} - ???';
        if (FlxG.save.data.firstTimeErect == false){
            controlsTXT.text = StringTools.replace(controlsTXT.text, '???', LangUtil.translate(", E - remixes"));
            controlsTXT.text = StringTools.replace(controlsTXT.text, ", E - ", "");
        }else controlsTXT.alpha = 0;
        #end
        controlsTXT.y = FlxG.height - controlsTXT.height - 5;

        mainFrame = new FlxSprite().loadGraphic(Paths.image('freeplay/frame'));
        mainFrame.scale.set(0.7, 0.7);
        mainFrame.updateHitbox();
        mainFrame.screenCenter();
        mainFrame.antialiasing = FlxG.save.data.antialias;
        mainFrame.cameras = [camREST];

        coverMain = new FlxSprite().loadGraphic(Paths.image('freeplay/art/' + curCategory + '/cover-' + songs.get(curCategory)[curSelected][0].toLowerCase()));
        coverMain.scale.set(0.7, 0.7);
        coverMain.updateHitbox();
        coverMain.screenCenter();
        coverMain.antialiasing = FlxG.save.data.antialias;
        coverMain.cameras = [camREST];

        coverMain.y -= 80;
        mainFrame.y -= 80;
        #if mobile
        mainFrame.x = FlxG.width - mainFrame.width - 5;
		coverMain.x = mainFrame.x + 29;
        #else
        mainFrame.x += 350;
        coverMain.x += 350;
        #end

        blackBG = new FlxSprite(mainFrame.x + 1, 0).makeGraphic(Std.int(mainFrame.width) - 1, 730, FlxColor.BLACK);
        blackBG.antialiasing = false;
        blackBG.alpha = 0.5;
        blackBG.cameras = [camREST];

        add(blackBG);
        add(coverMain);
        add(mainFrame);
        coverX = coverMain.x - (coverMain.width / 2);
        coverY = coverMain.y + coverMain.height;

        categoryText = new FlxText(folderHolder.width + 10, 10, 0, LangUtil.translate(curCategory.toUpperCase() + "\nCATEGORY"));
        categoryText.setFormat(Paths.font("difficultyFont.ttf"), 50, FlxColor.WHITE, LEFT);
        categoryText.antialiasing = FlxG.save.data.antialias;
        categoryText.cameras = [camREST];
        add(categoryText);
        
        inst = new FlxText(folderHolder.width + 10, categoryText.y + categoryText.height, 0, '');
        inst.setFormat(Paths.font("difficultyFont.ttf"), #if desktop 23 #else 35 #end, FlxColor.WHITE, LEFT);
        inst.antialiasing = FlxG.save.data.antialias;
        inst.cameras = [camREST];
        add(inst);
        inst.text = #if mobile '${LangUtil.translate('TOUCH ME')}' + ' ${LangUtil.translate('to switch')}'; #else '${LangUtil.translate('LEFT')}/${LangUtil.translate('RIGHT')}/${LangUtil.translate('MOUSE WHEEL')} + ${LangUtil.translate('SHIFT')}\n${LangUtil.translate('to switch')}'; #end

        difficSelector = new FlxText(coverX, coverY + 40, coverMain.width, '');
        difficSelector.setFormat(Paths.font("difficultyFont.ttf"), 50, FlxColor.WHITE, CENTER);
        difficSelector.antialiasing = FlxG.save.data.antialias;
        difficSelector.cameras = [camREST];

        songStats = new FlxText(coverX, coverY + 22, coverMain.width, '');
        songStats.setFormat(Paths.font("funniPsychFont.ttf"), 20, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        songStats.antialiasing = FlxG.save.data.antialias;
        songStats.cameras = [camREST];
        add(songStats);

        songDesc = new FlxText(coverX, coverY + 90, coverMain.width, '');
        songDesc.text = songs.get(curCategory)[curSelected][2];
        songDesc.setFormat(Paths.font("funniPsychFont.ttf"), 30, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        songDesc.antialiasing = FlxG.save.data.antialias;
        songDesc.cameras = [camREST];
        add(songDesc);

        lockedMain = new FlxSprite().loadGraphic(Paths.image('freeplay/art/locked'));
        lockedMain.scale.set(0.7, 0.7);
        lockedMain.screenCenter();
        lockedMain.alpha = 0;
        lockedMain.antialiasing = false;
        lockedMain.cameras = [camREST];
        #if mobile
        lockedMain.y -= 5;
		lockedMain.x = mainFrame.x + 29;
        #else
        lockedMain.y -= 80;
        lockedMain.x += 350;
        #end
        add(lockedMain);
        add(folderHolder);

        coinIcon = new FlxSprite(20, FlxG.height - 100).loadGraphic(Paths.image('freeplay/coins'));
        coinIcon.scale.set(.3, .3);
        coinIcon.updateHitbox();
        coinIcon.antialiasing = false;
        coinIcon.cameras = [camREST];
        add(coinIcon);

        coinCount = new FlxText(coinIcon.x + 45, coinIcon.y + 5, 200, ': ' + FlxG.save.data.coins);
        coinCount.setFormat(Paths.font('LilitaOne-Regular.ttf'), 30, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        coinCount.antialiasing = FlxG.save.data.antialias;
        coinCount.cameras = [camREST];
        add(coinCount);

        gemIcon = new FlxSprite(coinIcon.x, coinIcon.y + 50).loadGraphic(Paths.image('freeplay/gems'));
        gemIcon.scale.set(.3, .3);
        gemIcon.updateHitbox();
        gemIcon.antialiasing = false;
        gemIcon.cameras = [camREST];
        add(gemIcon);

        gemCount = new FlxText(gemIcon.x + 45, gemIcon.y + 5, 200, ': ' + FlxG.save.data.gems);
        gemCount.setFormat(Paths.font('LilitaOne-Regular.ttf'), 30, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        gemCount.antialiasing = FlxG.save.data.antialias;
        gemCount.cameras = [camREST];
        add(gemCount);
        add(difficSelector);

        FlxG.save.flush();
        changeCovers(curSelected, false);
        updateDiff(0);
        reloadList(false);
        
        if (!FlxG.save.data.menuinst) {
            inst.destroy();
            remove(inst);
            #if desktop
            controlsTXT.destroy();
            remove(controlsTXT);
            #end
        }
        add(warning);
        #if mobile
        button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.x = FlxG.width - button.width;
        button.alpha = 0.5;
		add(button);
        #end
        super.create();
    }

    var hell:Int = 0;
    public function reloadList(?changingCateg:Bool = true){
        if (changingCateg) curSelected = 0;
        songGRP.destroy();
        songGRP = new FlxTypedSpriteGroup<FlxSprite>();
        songGRP.cameras = [camGRP];
        add(songGRP);
        hell = 0;
        for (item in 0...songs.get(curCategory).length) {
            var cart:SongCartridge = new SongCartridge(100, #if desktop 220 #else 300 #end, songs.get(curCategory)[hell][0]);
            cart.ID = hell;
            cart.y += hell * cart.height;
            songGRP.add(cart);
            hell += 1;
        }
        tweenShit();
    }

    public function tweenShit(){
        selectedSomethin = true;
        if (curSelected < 0) {curSelected = 0; FlxG.sound.play(Paths.sound('blocked'));}
		else if (curSelected > songs.get(curCategory).length - 1) {curSelected = songs.get(curCategory).length - 1; FlxG.sound.play(Paths.sound('blocked'));}
        else{
            updScores();
            for (item in songGRP.members){
                if (item.ID == curSelected) FlxTween.tween(item, {x: 100}, 0.2, {ease: FlxEase.expoOut});   
                else if (item.ID > curSelected && item.ID <= curSelected + 2) FlxTween.tween(item, {x: 50}, 0.2, {ease: FlxEase.expoOut});   
                else if (item.ID < curSelected) FlxTween.tween(item, {x: #if desktop -500 #else -350 #end}, 0.2, {ease: FlxEase.expoOut});   
                else FlxTween.tween(item, {x: 0}, 0.2, {ease: FlxEase.expoOut}); 
            }
            FlxTween.tween(songGRP, {y: -(songGRP.members[0].height * curSelected)}, 0.2, {ease: FlxEase.expoOut, onComplete:function(_){selectedSomethin = false;}});
        }
    }

    var selectedSomethin:Bool = false;
    public function updateDiff(c:Int){   
		difficultyCounter = Difficulty.wrap(difficultyCounter, c);
		difficSelector.text = #if desktop '< ${Difficulty.getDiff(difficultyCounter)} >' #else '${Difficulty.getDiff(difficultyCounter)}' #end;
		difficSelector.color = Difficulty.getColor(difficultyCounter);
        if (curCategory == "weeks") difficSelector.alpha = 0;
        else difficSelector.alpha = 1;
        updScores();
    }

    function updScores() songStats.text = '${LangUtil.translate('Score')}: ' + Highscore.getScore(songs.get(curCategory)[curSelected][0], difficultyCounter) + ' - ${LangUtil.translate('Accuracy')}: ' + Highscore.getAccs(songs.get(curCategory)[curSelected][0], difficultyCounter) + "%";
    public function changeCounter(num:Int){
        counter += num;
        if(counter > 2) counter = 0;
        else if(counter < 0) counter = 2;
        curSelected = 0;
        switch(counter){
            case 0: curCategory = "shitpost";
            case 1: curCategory = "extra";
            case 2: curCategory = "brawl";
        }
        categoryText.text = LangUtil.translate(curCategory.toUpperCase() + "\nCATEGORY");
        reloadList();
        changeCovers(curSelected);
        updateDiff(0);
    }

    override function update(elapsed:Float){
        #if mobile touch = FlxG.touches.getFirst(); #end
        difficSelector.x = coverX + (difficSelector.width / 2);
        songStats.x = coverX + (songStats.width / 2);
        songDesc.x = coverX + (songDesc.width / 2);
        difficSelector.visible = (curCategory == 'shitpost' ? false : true);
        if(!selectedSomethin){
            #if desktop
            if (FlxG.keys.justPressed.D) updateDiff(1);
            else if (FlxG.keys.justPressed.A) updateDiff(-1);
            if (FlxG.keys.justPressed.E) erect();
            if(controls.ACCEPT || FlxG.mouse.justPressed && (FlxG.mouse.overlaps(coverMain) || FlxG.mouse.overlaps(mainFrame))) accepted();
            if(FlxG.keys.justPressed.RIGHT || FlxG.mouse.wheel > 0 && FlxG.keys.pressed.SHIFT) changeCounter(1);
            else if(FlxG.keys.justPressed.LEFT || FlxG.mouse.wheel < 0 && FlxG.keys.pressed.SHIFT) changeCounter(-1);

            if(controls.BACK) exit();
            if(FlxG.keys.justPressed.UP || !FlxG.keys.pressed.SHIFT && FlxG.mouse.wheel > 0){
                curSelected -= 1;
                if(curSelected < 0) curSelected = songs.get(curCategory).length - 1;
                tweenShit();
                changeCovers(curSelected);
            }

            if(FlxG.keys.justPressed.DOWN || !FlxG.keys.pressed.SHIFT && FlxG.mouse.wheel < 0){
                curSelected += 1;
                if(curSelected > songs.get(curCategory).length - 1) curSelected = 0;
                tweenShit();
                changeCovers(curSelected);
            }
            #else
            if(touch != null && touch.justPressed){
                if(touch.overlaps(button)) exit();
                if(touch.overlaps(difficSelector)) updateDiff(1);
                if(touch.overlaps(controlsTXT)) erect();
                if(touch.overlaps(categoryText) || (inst != null && touch.overlaps(inst))) changeCounter(1);
                if(touch.overlaps(coverMain) && touch.overlaps(mainFrame)) accepted();
                if(touch.overlaps(songGRP)){
                    for(it in songGRP.members){
                        if(touch.overlaps(it)){
                            if (curSelected != it.ID){
                                curSelected = it.ID;
                                tweenShit();
                                changeCovers(curSelected);
                            }else accepted();
                        }
                    }
                }
            }
            #end
        }
        super.update(elapsed);
    }

    function exit(){
        PlayState.isFreeplay = false;
        selectedSomethin = true;
		FlxG.sound.play(Paths.sound('cancelMenu'));
		FlxG.sound.music.stop();
		FlxG.sound.playMusic(Paths.music('freakyMenu'));
		FlxG.switchState(new MainMenuState());
    }

    function accepted(){
        var song:String = songs.get(curCategory)[curSelected][0];
        var exit:Bool = false;
        if (curCategory != 'lol'){
            if(isLocked(song)){
                if(isUnlockable(song)){
                    if(curCategory == 'shitpost'){
                        if(FlxG.save.data.gems >= 10){unlock(song, true);}
                        else{
                            exit = true;
                            warning.activate(LangUtil.translate("Not enough gems!"));            
                        }
                    }else{
                        if(FlxG.save.data.coins >= 200){unlock(song);}
                        else{
                            exit = true;
                            warning.activate(LangUtil.translate("Not enough coins!"));                       
                        }
                    }
                }else{
                    exit = true;
                    warning.activate(LangUtil.translate("Song not unlocked yet!"));    
                }
            }
    
            if(!exit){
                #if desktop DiscordClient.changePresence("Just selected a song!", null); #end
                selectedSomethin = true;
                triggerTran();
                if(curCategory == 'shitpost') difficultyCounter = 0;
                var songLowercase:String = song.toLowerCase();
                var poop:String = Highscore.formatSong(songLowercase, difficultyCounter);
                new FlxTimer().start(2, function(timer:FlxTimer){
                    PlayState.SONG = Song.loadFromJson(poop, songLowercase);
                    PlayState.storyDifficulty = difficultyCounter;
                    LoadingState.loadAndSwitchState(new PlayState());
                });
            }else{
                exit = false;
                FlxG.sound.play(Paths.sound('blocked'));
            }
        }else{
            PlayState.isFreeplay = false;
            #if desktop DiscordClient.changePresence("Just selected a week!", null); #end
            selectedSomethin = true;
            var temp:String = song;
            var songDash:String = temp.replace(' ', '-');
            FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
            triggerTran();
        }
    }

    function erect(){
        selectedSomethin = true;
        if (FlxG.save.data.firstTimeErect == true){
            FlxG.sound.music.fadeOut(1, 0);
            FlxTween.tween(camREST, {alpha: 0}, 1, {ease: FlxEase.expoOut});
            FlxTween.tween(camGRP, {alpha: 0}, 1, {ease: FlxEase.expoOut});
            FlxG.save.data.firstTimeErect = false;
            FlxG.save.flush();

            var randomSong:Array<String> = ['red-x', 'question', 'regenerator', 'starshot'];
            var randomPick:Int = FlxG.random.int(0, randomSong.length - 1);
            new FlxTimer().start(1, function(timer:FlxTimer){
                PlayState.SONG = Song.loadFromJson(randomSong[randomPick], randomSong[randomPick], '-erect');
    			PlayState.storyDifficulty = 3;
                LoadingState.invisible = true;
                LoadingState.loadAndSwitchState(new PlayState());
            });
        }else FlxG.switchState(new ErectState());
    }

    public function triggerTran(){
        FlxG.sound.play(Paths.sound("confirmMenu"), 1.5);
        for(sp in [songDesc, songStats, difficSelector, inst, blackBG]) FlxTween.tween(sp, {alpha: 0}, 1);
        for(sp in [mainFrame, coverMain]){
            FlxTween.cancelTweensOf(sp);
            FlxTween.tween(sp, {x: (FlxG.width / 2) - (sp.width / 2), y: (FlxG.height / 2) - (sp.height / 2)}, 1, {ease: FlxEase.expoOut});
        } 
        for (item in songGRP.members) FlxTween.tween(item, {x: item.x - 800}, 1, {ease: FlxEase.sineInOut});
        FlxTween.tween(folderHolder, {x: folderHolder.x - 800}, 1, {ease: FlxEase.sineInOut});
        FlxTween.tween(camREST, {zoom: 1.5}, 1.5, {ease: FlxEase.expoOut});
        FlxTween.tween(camGRP, {zoom: 1.5}, 1.5, {ease: FlxEase.expoOut});
    }

    public function unlock(song:String, ?shitpost:Bool = false){
        FlxG.sound.play(Paths.sound('payment'), 1.5);
        lockedMain.alpha = 0;
        KadeEngineData.pushUnlockedSong(song);
        if(shitpost) FlxG.save.data.gems -= 10;
        else FlxG.save.data.coins -= 200;
        FlxG.save.flush();
        coinCount.text = ': ' + FlxG.save.data.coins;
        gemCount.text =  ': ' + FlxG.save.data.gems;
        songDesc.text = songs.get(curCategory)[curSelected][1];
    }

    function changeCovers(num:Int, ?sound:Bool = true){
        openfl.Assets.cache.clear("assets/images/freeplay/art");
        System.gc();
        var song:String = songs.get(curCategory)[num][0];
        if (sound) FlxG.sound.play(Paths.sound('scrollMenu'));

        songString = songs.get(curCategory)[num][0];
        songString = songString.replace("-", " ");
        songDesc.text = songs.get(curCategory)[num][1];
        lockedMain.alpha = 0;
        
        if (curCategory != 'lol'){
            if(isLocked(songs.get(curCategory)[num][0])){
                switch song{ 
                    case 'showdown-of-chaos': songDesc.text = "Figure out the name of the song and search it, the answer is the channel name.";
                    case 'far-future': songDesc.text = "The creator of 'Firm Grip' map in Brawl Stars. The food is the clue.";
                    default: songDesc.text = (curCategory == 'shitpost' ? 'Unlock with Gems!\nCost: 10' : 'Unlock with Coins!\nCost: 200');
                }
                lockedMain.alpha = 1;
            }
        }
        songDesc.text = SongLangUtil.trans(songDesc.text);
        if (#if desktop FileSystem.exists(Paths.image('freeplay/art/' + curCategory + '/cover-' + songs.get(curCategory)[num][0])) #else Assets.exists(Paths.image('freeplay/art/' + curCategory + '/cover-' + songs.get(curCategory)[num][0])) #end && KadeEngineData.songBeatenArray.contains(song)) coverMain.loadGraphic(Paths.image('freeplay/art/' + curCategory + '/cover-' + songs.get(curCategory)[num][0]));
        else coverMain.loadGraphic(Paths.image('freeplay/art/mystery'));

        mainFrame.scale.set(0.9, 0.9);
        coverMain.scale.set(0.9, 0.9);
        lockedMain.scale.set(0.9, 0.9);
        FlxTween.tween(mainFrame, {"scale.x": 0.7, "scale.y": 0.7}, 0.2, {ease: FlxEase.expoOut,onComplete:function(_){mainFrame.updateHitbox();}});
        FlxTween.tween(coverMain, {"scale.x": 0.7, "scale.y": 0.7}, 0.2, {ease: FlxEase.expoOut,onComplete:function(_){coverMain.updateHitbox();}});
        FlxTween.tween(lockedMain, {"scale.x": 0.7, "scale.y": 0.7}, 0.2, {ease: FlxEase.expoOut #if mobile ,onComplete:function(_){lockedMain.updateHitbox();} #end});
    }
    function isLocked(song:String):Bool return !KadeEngineData.unlockedSongsArray.contains(song);
    function isUnlockable(song:String):Bool{
        var justABool:Bool = false;
        if (songs.get(curCategory)[curSelected][2] != true){
            if (!KadeEngineData.unlockedSongsArray.contains(song)) justABool = true;
            else justABool = false;
        }
        if(curCategory == 'shitpost') justABool = true;
        return justABool;
    }
}