package;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.FlxCamera;

class GameOverSubstate extends MusicBeatSubstate{
	var camFollow:FlxObject;
    var gameOver:FlxText;
	var stageSuffix:String = "";
	var block:Bool = true;
	var sigma:FlxSprite;
	var sickBeat:Int = 0;
	public var camGAMEOVER:FlxCamera;
	#if mobile
	var restart:FlxSprite;
	var quit:FlxSprite;
	#end

	public function new(){
		var daBf:String = '';
		super();
		camGAMEOVER = new FlxCamera();
        FlxG.cameras.add(camGAMEOVER);
		Conductor.songPosition = 0;
		Conductor.changeBPM(109);

		sigma = new FlxSprite();
		sigma.antialiasing = FlxG.save.data.antialias;
		switch (PlayState.SONG.player1){
			case 'bfSMBW':
				daBf = 'bf-smbw';
				sigma.antialiasing = false;
			default: daBf = 'bf';
		}
		sigma.loadGraphic(Paths.image('resultScreen/game-over/' + daBf, 'shared'));
		sigma.scrollFactor.set(0, 0);
		sigma.scale.set(1.1, 1.1);
		sigma.screenCenter();
        sigma.y += 50;
		sigma.alpha = 0;
		add(sigma);

		gameOver = new FlxText(0, sigma.y - 150, 0, '-- ' + LangUtil.translate('You Died!') + ' --\n' + "'" +  LangUtil.getGameOverQuote() + "'", 25);
		gameOver.setFormat(Paths.font("difficultyFont.ttf"), 30, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		gameOver.scrollFactor.set(0, 0);
		gameOver.alpha = 0;
		add(gameOver);
		
		#if desktop if (FlxG.save.data.menuinst == true) gameOver.text += '\n${LangUtil.translate('ENTER')}/${LangUtil.translate('SPACE')} - ${LangUtil.translate('restart')}, ${LangUtil.translate('BACKSPACE')}/${LangUtil.translate('ESC')} - ${LangUtil.translate('exit')}'; #end
		gameOver.screenCenter(X);

		#if mobile
		restart = new FlxSprite().loadGraphic(Paths.image('mobile/change_tabs'));
		add(restart);
		quit = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
		add(quit);
		for(sp in [restart, quit]){
			sp.cameras = [camGAMEOVER];
			sp.scrollFactor.set(0, 0);
			sp.antialiasing = false;
			sp.alpha = 0;
			sp.scale.set(1.2, 1.2);
			sp.updateHitbox();
			sp.screenCenter();
		}
		restart.x -= sigma.width * 1.2;
		quit.x += sigma.width * 1.2;
		#end

		#if desktop
		new FlxTimer().start(2, function(timer:FlxTimer){
			FlxTween.tween(sigma, {alpha: 1}, 1);
			FlxTween.tween(gameOver, {alpha: 1}, 1);
			if (!PlayState.blockGameOver){
				block = false;
				FlxG.sound.playMusic(Paths.music('freakyLose'));
			}else{
				FlxG.sound.volume = 0;
				gameOver.text = "";
			}
		});
		#else
		FlxTween.tween(sigma, {alpha: 1}, 1, {startDelay: 2});
		FlxTween.tween(gameOver, {alpha: 1}, 1, {startDelay: 2});
		FlxTween.tween(restart, {alpha: 0.5}, 1, {startDelay: 2});
		FlxTween.tween(quit, {alpha: 0.5}, 1, {startDelay: 2, onComplete:function(twn:FlxTween){
			block = false;
			FlxG.sound.playMusic(Paths.music('freakyLose'));
		}});
		#end
		cameras = [camGAMEOVER];
	}

	override function update(elapsed:Float){
		#if mobile touch = FlxG.touches.getFirst(); #end
		if (!block){
			#if desktop
			if (controls.ACCEPT) endBullshit();
			else if (controls.BACK) quitLol();
			#else
			if(touch != null && touch.justPressed){
				if(touch.overlaps(restart, camGAMEOVER)) endBullshit();
				else if(touch.overlaps(quit, camGAMEOVER)) quitLol();
			}
			#end
		}
		super.update(elapsed);
		if (FlxG.sound.music.playing) Conductor.songPosition = FlxG.sound.music.time;
	}

	function quitLol(){
		block = true;           
		FlxG.cameras.remove(camGAMEOVER);
		ResultsSubState.dieAllShit();
	}

	override function beatHit(){
		if (!PlayState.blockGameOver){
			gameOver.scale.set(1.1, 1.1);
			FlxTween.tween(gameOver, {"scale.x": 1, "scale.y": 1}, 0.3);
		}else{
			switch (sickBeat){
				case 8: gameOver.text = LangUtil.translate("YOU CANNOT CHEAT HERE");
				case 14: gameOver.text = LangUtil.translate("DELETE THE FILE");
				case 22: gameOver.text = LangUtil.translate("YOU'RE STUCK HERE UNTIL THEN");
				case 30:
					sigma.alpha = 0;
					gameOver.screenCenter(Y);
					gameOver.text = LangUtil.translate("CLOSE THE GAME");
			}
			sickBeat += 1;
			gameOver.screenCenter(X);
		}
		super.beatHit();
	}

	function endBullshit():Void{
		block = true;
		FlxG.sound.music.stop();
		FlxG.sound.play(Paths.music('gameOverEnd'));
		FlxTween.tween(sigma, {alpha: 0}, 1);
		FlxTween.tween(gameOver, {y: gameOver.y - 200}, 1);
		#if mobile
		FlxTween.tween(restart, {alpha: 0}, 1);
		FlxTween.tween(quit, {alpha: 0}, 1);
		#end
		new FlxTimer().start(1, function(tmr:FlxTimer){
			FlxG.cameras.remove(camGAMEOVER);
			LoadingState.loadAndSwitchState(new PlayState());
		});
	}
}