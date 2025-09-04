package;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.FlxCamera;
using StringTools;

class ResultsSubState extends MusicBeatSubstate{
    var sickArray:Array<Int> = [];
    var sickSplit:Array<String> = [];
    var goodArray:Array<Int> = [];
    var goodSplit:Array<String> = [];
    var badArray:Array<Int> = [];
    var badSplit:Array<String> = [];
    var shitArray:Array<Int> = [];
    var shitSplit:Array<String> = [];
    var missArray:Array<Int> = [];
    var missSplit:Array<String> = [];
    var scoreArray:Array<Int> = [];
    var scoreSplit:Array<String> = [];
    var comboArray:Array<Int> = [];
    var comboSplit:Array<String> = [];

    var sickspr:FlxSprite;
    var shitspr:FlxSprite;
    var goodspr:FlxSprite;
    var badspr:FlxSprite;
    var missesspr:FlxText;
    var combospr:FlxText;
    var scorespr:FlxText;
    var soundSys:FlxSprite;
    var currencyText:FlxText;
    var totalNotesTXT:FlxText;
    var bfHey:FlxSprite;

    var block:Bool = true;
	var blackBar:FlxBackdrop;
    var cameraRESULTS:FlxCamera = new FlxCamera();
    var scoreGetter:Int;
    var notesGetter:Int;
    var comboLoop:Int = 0;
    var sickLoop:Int = 0;
    var goodLoop:Int = 0;
    var badLoop:Int = 0;
    var shitLoop:Int = 0;
    var missLoop:Int = 0;
    var scoreLoop:Int = 0;
    
    public function new(sick:Int, good:Int, bad:Int, shit:Int, miss:Int, score:Int, acc:Float, combo:Int, totalSongNotes:Int, coins:Float, gems:Float, data:Array<Dynamic>){
        super();
        scoreGetter = score;
        notesGetter = totalSongNotes;
		cameraRESULTS.bgColor.alpha = 0;
        cameraRESULTS.zoom = 0.9;
        FlxG.cameras.add(cameraRESULTS);
        sickSplit = (sick + "").split('');
        goodSplit = (good + "").split('');
        badSplit = (bad + "").split('');
        shitSplit = (shit + "").split('');
        missSplit = (miss + "").split('');
        scoreSplit = (score + "").split('');
        comboSplit = (combo + "").split('');

        for (i in 0...sickSplit.length){
			var str:String = sickSplit[i];
			sickArray.push(Std.parseInt(str));
		}
        for (i in 0...comboSplit.length){
            var str:String = comboSplit[i];
            comboArray.push(Std.parseInt(str));
        }
        for (i in 0...goodSplit.length){
            var str:String = goodSplit[i];
            goodArray.push(Std.parseInt(str));
        }
        for (i in 0...badSplit.length){
            var str:String = badSplit[i];
            badArray.push(Std.parseInt(str));
        }
        for (i in 0...shitSplit.length){
            var str:String = shitSplit[i];
            shitArray.push(Std.parseInt(str));
        }
        for (i in 0...missSplit.length){
            var str:String = missSplit[i];
            missArray.push(Std.parseInt(str));
        }
        for (i in 0...scoreSplit.length){
            var str:String = scoreSplit[i];
            scoreArray.push(Std.parseInt(str));
        }
        FlxG.sound.playMusic(Paths.music('results', 'shared'));

        var fps:Int = 24;
        bfHey = new FlxSprite(data[0], data[1]);
        bfHey.antialiasing = FlxG.save.data.antialias;
        switch (data[2]){
            case 'bfSMBW':
                bfHey.frames = Paths.getSparrowAtlas('characters/bfs/bfSMWhey', 'shared');
                bfHey.antialiasing = false;
                fps = 8;
                FlxTween.tween(bfHey, {x: #if desktop 700 #else 800 #end, y: 50}, 1, {ease: FlxEase.quadOut});       
            default:
                bfHey.frames = Paths.getSparrowAtlas('characters/bfs/bf', 'shared');
                FlxTween.tween(bfHey, {x: #if desktop 800 #else 900 #end, y: 200}, 1, {ease: FlxEase.quadOut});
        }
        FlxTween.tween(bfHey, {"scale.x": 1.5, "scale.y": 1.5}, 1, {ease: FlxEase.quadOut});
        bfHey.animation.addByPrefix('bfHey', 'hey', fps, false);
        bfHey.animation.play('bfHey');
        add(bfHey);

        blackBar = new FlxBackdrop(Paths.image('resultScreen/topBarBlack', 'shared'), X, 0, 0);
		blackBar.velocity.x = FlxG.random.int(-50, 50);
        blackBar.antialiasing = FlxG.save.data.antialias;
        blackBar.x = 0;
        blackBar.y = 0 - blackBar.height - 50;

        soundSys = new FlxSprite(0, 0);
        soundSys.frames = Paths.getSparrowAtlas('resultScreen/soundSystem', 'shared');
        soundSys.animation.addByPrefix("drop", "sound system", 24, false);
        soundSys.scale.set(1.2, 1.2);
        soundSys.screenCenter();
        soundSys.x -= 330;
        soundSys.y -= 100;
        soundSys.cameras = [cameraRESULTS];
        soundSys.antialiasing = FlxG.save.data.antialias;

        combospr = new FlxText(-20, 100, 0, LangUtil.translate('Notes') + ':');
        combospr.setFormat(Paths.font("LilitaOne-Regular.ttf"), 50, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        combospr.alpha = 0;
        combospr.cameras = [cameraRESULTS];
        combospr.antialiasing = true;

        sickspr = new FlxSprite(-20, 170).loadGraphic(Paths.image('ratings/sick-' + LangUtil.getRat(0), 'shared'));
        sickspr.cameras = [cameraRESULTS];
        sickspr.scale.set(0.5, 0.5);
        sickspr.updateHitbox();
        sickspr.alpha = 0;
        sickspr.antialiasing = FlxG.save.data.antialias;

        goodspr = new FlxSprite(-20, 270).loadGraphic(Paths.image('ratings/good-' + LangUtil.getRat(1), 'shared'));
        goodspr.cameras = [cameraRESULTS];
        goodspr.scale.set(0.5, 0.5);
        goodspr.updateHitbox();
        goodspr.alpha = 0;
        goodspr.antialiasing = FlxG.save.data.antialias;

        badspr = new FlxSprite(-20, 350).loadGraphic(Paths.image('ratings/bad-' + LangUtil.getRat(2), 'shared'));
        badspr.cameras = [cameraRESULTS];
        badspr.scale.set(0.5, 0.5);
        badspr.updateHitbox();
        badspr.alpha = 0;
        badspr.antialiasing = FlxG.save.data.antialias;

        shitspr = new FlxSprite(-20, 440).loadGraphic(Paths.image('ratings/shit-' + LangUtil.getRat(3), 'shared'));
        shitspr.cameras = [cameraRESULTS];
        shitspr.scale.set(0.4, 0.4);
        shitspr.updateHitbox();
        shitspr.alpha = 0;
        shitspr.antialiasing = FlxG.save.data.antialias;

        missesspr = new FlxText(-20, 535, 0, LangUtil.translate('Misses') + ':');
        missesspr.setFormat(Paths.font("LilitaOne-Regular.ttf"), 50, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        missesspr.alpha = 0;
        missesspr.cameras = [cameraRESULTS];
        missesspr.antialiasing = true;

        scorespr = new FlxText(-20, 660, 0, LangUtil.translate('Score') + ':');
        scorespr.setFormat(Paths.font("LilitaOne-Regular.ttf"), 50, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        scorespr.alpha = 0;
        scorespr.cameras = [cameraRESULTS];
        scorespr.antialiasing = true;

        currencyText = new FlxText(830, 580, 0, LangUtil.translate('Coins Earned') + ': $coins\n' + LangUtil.translate('Gems Earned') + ': $gems\n' + LangUtil.translate('Accuracy') + ': $acc%');
        currencyText.setFormat(Paths.font("LilitaOne-Regular.ttf"), 50, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        currencyText.alpha = 0;
        currencyText.cameras = [cameraRESULTS];
        currencyText.antialiasing = true;

        if (0 > coins) currencyText.text = currencyText.text.replace(Std.string(coins), "0");
        if (0 > gems) currencyText.text = currencyText.text.replace(Std.string(gems), "0");
        soundSys.animation.play("drop");
        add(soundSys);
        add(blackBar);
        add(combospr);
        add(scorespr);
        add(missesspr);
        FlxTween.tween(blackBar, {y:-50}, 1, {ease: FlxEase.expoInOut, onComplete: function(_) {initRatings();}});
        cameras = [cameraRESULTS];
    }

    override function update(elapsed:Float){
        if (!block){
            #if desktop
            if (FlxG.keys.justPressed.ENTER) skipResults();
            #else
            touch = FlxG.touches.getFirst();
            if(touch != null && touch.justPressed) skipResults();
            #end
        }
        super.update(elapsed);
    }

    function skipResults(){
        block = true;
        for(spr in [sickspr, goodspr, badspr, shitspr, soundSys, bfHey, missesspr, combospr, scorespr, currencyText, totalNotesTXT, blackBar]){
            spr.destroy();
            remove(spr);
            spr = null;
        }
        dieAllShit();
        close();
    }

    public static function dieAllShit(){   
        FlxG.sound.music.stop();
        PlayState.exiting = true;
        if (PlayState.isStoryMode){
            if (PlayState.storyPlaylist.length <= 0 || PlayState.stateIsRestarted){
                FlxG.sound.playMusic(Paths.music('freakyMenu'));
                PlayState.SONG = null;
                PlayState.weekSicks = 0;
				PlayState.weekGoods = 0;
				PlayState.weekBads = 0;
				PlayState.weekShits = 0;
				PlayState.weekMisses = 0;
				PlayState.totalWeekScore = 0;
				PlayState.meanAccuracy = 0;
				PlayState.weekNotesHit = 0;
				PlayState.weekTotalNotesinSong = 0;
				PlayState.weekCoins = 0;
				PlayState.weekGems = 0;
                FlxG.switchState(new StoryMenuState());
                FlxG.save.flush();
            }else{
                FlxTransitionableState.skipNextTransIn = true;
                FlxTransitionableState.skipNextTransOut = true;   
                PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + Difficulty.getPrefix(PlayState.storyDifficulty), PlayState.storyPlaylist[0]);
                LoadingState.loadAndSwitchState(new PlayState());
            }
        }else if (PlayState.isFreeplay){
            FlxG.sound.playMusic(Paths.music('freplay', 'shared'));
            switch (PlayState.type){
                case '-erect': FlxG.switchState(new ErectState());
                default: FlxG.switchState(new FreeplayCustom());
            }
        }else if (PlayState.isStoryFreeplay){
            FlxG.sound.playMusic(Paths.music('freakyMenu'));
            FlxG.switchState(new CodingPlaygroundState());
        }
        if(!PlayState.isStoryMode){
            PlayState.SONG = null;
            PlayState.storyPlaylist = [];
        } 
        PlayState.type = "";
        PlayState.stateIsRestarted = false;
        PlayState.curSongData = null;
        PlayState.instance = null;
    }

    function initRatings(){
        FlxTween.tween(combospr, {alpha: 1}, 0.3);
        new FlxTimer().start(0.3, function(timer:FlxTimer){ 
            for (i in comboArray) {
                var numScore:FlxSprite = new FlxSprite(combospr.x + combospr.width + (30 * comboLoop) + 30, combospr.y + 10);
                numScore.frames = Paths.getSparrowAtlas('ratings/tallieNumber');
                loadNumberSprite(numScore, i);
                comboLoop += 1;
                add(numScore);
            } 

            totalNotesTXT = new FlxText(combospr.x + 400, combospr.y + 10, 1500, '/$notesGetter');
            totalNotesTXT.setFormat(Paths.font("LilitaOne-Regular.ttf"), 30, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
            totalNotesTXT.cameras = [cameraRESULTS];
            totalNotesTXT.antialiasing = FlxG.save.data.antialias;
            totalNotesTXT.alpha = 0;
            FlxTween.tween(totalNotesTXT, {alpha: 1}, 0.3, {ease: FlxEase.quadInOut});
            add(totalNotesTXT);
        });

        add(sickspr);
        add(goodspr);
        add(badspr);
        add(shitspr);

        // bracket nightmare
        FlxTween.tween(sickspr, {alpha: 1}, 0.6, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween){
            for (i in sickArray){
                var numScore:FlxSprite = new FlxSprite(sickspr.x + sickspr.width + (30 * sickLoop) + 30, sickspr.y + 10);
                loadNumberSprite(numScore, i);
                sickLoop += 1;
                add(numScore);
            }

            FlxTween.tween(goodspr, {alpha: 1}, 0.6, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween){
                for (i in goodArray){
                    var numScore:FlxSprite = new FlxSprite(goodspr.x + goodspr.width + (30 * goodLoop) + 30, goodspr.y + 10);
                    loadNumberSprite(numScore, i);
                    goodLoop += 1;
                    add(numScore);
                }

                FlxTween.tween(badspr, {alpha: 1}, 0.6, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween){
                    for (i in badArray) {
                        var numScore:FlxSprite = new FlxSprite(badspr.x + badspr.width + (30 * badLoop) + 30, badspr.y + 10);
                        loadNumberSprite(numScore, i);
                        badLoop += 1;
                        add(numScore);
                    }

                    FlxTween.tween(shitspr, {alpha: 1}, 0.6, {ease: FlxEase.quadInOut, onComplete: function(twn:FlxTween){
                        for (i in shitArray){
                            var numScore:FlxSprite = new FlxSprite(shitspr.x + shitspr.width + (30 * shitLoop) + 30, shitspr.y + 10);
                            loadNumberSprite(numScore, i);
                            shitLoop += 1;
                            add(numScore);
                        }
                        FlxTween.tween(missesspr, {alpha: 1}, 0.3);
                        new FlxTimer().start(0.6, function(timer:FlxTimer){ 
                            for (i in missArray){
                                var numScore:FlxSprite = new FlxSprite(missesspr.x + missesspr.width + (30 * missLoop) + 30, missesspr.y + 10);
                                loadNumberSprite(numScore, i);
                                missLoop += 1; 
                                add(numScore);
                            }
                            FlxTween.tween(scorespr, {alpha: 1}, 0.3);
                            initScore();
                        });
                    }});
                }});
            }});
        }});
    }

    function loadNumberSprite(sprite:FlxSprite, number:Int, path:String = 'ratings/tallieNumber'){
        if (path != 'lol') sprite.frames = Paths.getSparrowAtlas(path);
        sprite.animation.addByPrefix(Std.string(number), Std.string(number), 24, false);
        sprite.animation.play(path == 'lol' ? 'disabled' : Std.string(number));
        sprite.cameras = [cameraRESULTS];
        sprite.antialiasing = FlxG.save.data.antialias;
        sprite.alpha = 0;
        FlxTween.tween(sprite, {"scale.x": 0.9, "scale.y": 0.9, alpha: 1}, 0.3, {ease: FlxEase.quadInOut});
        add(sprite);
    }

    function initScore(){
        add(currencyText);
        FlxTween.tween(currencyText, {alpha: 1}, 0.5, {ease: FlxEase.quadInOut});
        for (i in scoreArray){
            var numScore:FlxSprite = new FlxSprite(scorespr.x + scorespr.width + (55 * scoreLoop), scorespr.y - 25);
            numScore.frames = Paths.getSparrowAtlas('resultScreen/score-digital-numbers', 'shared');
            numScore.animation.addByPrefix('disabled', 'DISABLED', 1, false);
            loadNumberSprite(numScore, i, 'lol');
            scoreLoop += 1;
            new FlxTimer().start(0.6, function(timer:FlxTimer){numScore.animation.play(Std.string(i)); block = false;});
        }
    }
}