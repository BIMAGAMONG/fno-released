package;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxSpriteGroup;
import flixel.input.FlxKeyManager;
import flixel.FlxSubState;
using StringTools;

class DialogueBox extends MusicBeatSubstate{
	var box:FlxSprite;
	var curCharacter:String = '';
	var dialogueStuff:Array<String> = [];
	var swagDialogue:FlxTypeText;
	var portraitLeft:FlxSprite;
	var bgFade:FlxSprite;
	var dialogueOpened:Bool = false;
	var dialogueStarted:Bool = false;
	var firstTimePressing:Bool = false;
	var isEnding:Bool = false;
	var spaceToSkip:FlxText;

	public function new(daDial:Array<String>){
		super();
		dialogueStuff = daDial;

		bgFade = new FlxSprite(-200, -200).makeGraphic(Std.int(FlxG.width + 500), Std.int(FlxG.height + 500), 0xFFB3DFd8);
		bgFade.scrollFactor.set(0, 0);
		bgFade.screenCenter();
		bgFade.antialiasing = false;
		bgFade.alpha = 0;
		add(bgFade);

		box = new FlxSprite(0, 490).loadGraphic(Paths.image('dialBox', 'shared'));
		box.scrollFactor.set(0, 0);
		box.alpha = 0;
		box.scale.set(1.6, 1.4);
		box.updateHitbox();
		box.screenCenter(X);
		box.antialiasing = FlxG.save.data.antialias;

		portraitLeft = new FlxSprite(0, 0).loadGraphic(Paths.image('dialoguePorts/bf', 'shared'));
		portraitLeft.setGraphicSize(Std.int(portraitLeft.width * 0.9));
		portraitLeft.updateHitbox();
		portraitLeft.screenCenter();
		portraitLeft.antialiasing = FlxG.save.data.antialias;
		portraitLeft.scrollFactor.set(0, 0);
		portraitLeft.alpha = 0;
		portraitLeft.antialiasing = FlxG.save.data.antialias;
		add(portraitLeft);
		add(box);
	
		swagDialogue = new FlxTypeText(240, box.y + 30, Std.int(box.width-20), "", 32);
		swagDialogue.setFormat(Paths.font("LilitaOne-Regular.ttf"), 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		swagDialogue.color = 0xFFFFFFFF;
		swagDialogue.borderColor = FlxColor.BLACK;
		swagDialogue.borderSize = 2;
		swagDialogue.alpha = 0;
		swagDialogue.antialiasing = true;
		swagDialogue.screenCenter(X);
		add(swagDialogue);

		spaceToSkip = new FlxText(240, 20, 0, #if desktop '${LangUtil.translate("SPACE")}' #else '${LangUtil.translate("TOUCH ME")}' #end + ' ${LangUtil.translate('TO SKIP')}', 32);
		spaceToSkip.setFormat(Paths.font("LilitaOne-Regular.ttf"), 50, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		spaceToSkip.borderSize = 2;
		spaceToSkip.scrollFactor.set(0, 0);
		spaceToSkip.screenCenter(X);
		spaceToSkip.alpha = 0;
		spaceToSkip.antialiasing = true;
		add(spaceToSkip);

		new FlxTimer().start(2, function(tmr:FlxTimer){
			new FlxTimer().start(0.2, function(tmr:FlxTimer){bgFade.alpha += 0.2;}, 3);
			FlxTween.tween(box, {alpha: 1}, 0.6);
			FlxTween.tween(spaceToSkip, {alpha: 1}, 0.6);
			FlxTween.tween(swagDialogue, {alpha: 1}, 0.6, {onComplete: function (twn:FlxTween){dialogueOpened = true;}});
		});
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];
	}

	override function update(elapsed:Float){
		if (dialogueOpened && !dialogueStarted){
			startDialogue();
			dialogueStarted = true;
		}

		if(dialogueStarted && !firstTimePressing){
			#if desktop
			if (FlxG.keys.justPressed.ENTER) check();
			if (FlxG.keys.justPressed.SPACE) endlol();
			#else
			touch = FlxG.touches.getFirst();
			if(touch != null && touch.justPressed){
				if(touch.overlaps(spaceToSkip, FlxG.cameras.list[FlxG.cameras.list.length - 1])) endlol();
				else check();
			}
			#end			
		}

		super.update(elapsed);
	}

	function check(){
		if (dialogueStuff[1] == null && dialogueStuff[0] != null){
			if (!isEnding){
				isEnding = true;
				endlol();
			}
		}else{
			dialogueStuff.remove(dialogueStuff[0]);
			startDialogue();
		}
	}

	function endlol(){
		firstTimePressing = true;
		dialogueStarted = false;
		endDialogue();
	}

	public function endDialogue(){
		new FlxTimer().start(0.2, function(tmr:FlxTimer){
			box.alpha -= 0.2;
			bgFade.alpha -= 0.2;
			portraitLeft.alpha -= 0.2;
			swagDialogue.alpha -= 0.2;
			spaceToSkip.alpha -= 0.2;
		}, 5);
		new FlxTimer().start(1, function(tmr:FlxTimer){
			for(spr in [box, bgFade, portraitLeft, swagDialogue, spaceToSkip]){
            	spr.destroy();
            	remove(spr);
            	spr = null;
			}
			close();
		});
	}

	var curLoaded:String = '';
	public function startDialogue():Void{
		FlxG.sound.play(Paths.sound('switchTabs'), 0.8);
		var splitName:Array<String> = dialogueStuff[0].split(":");
		curCharacter = splitName[0];
		dialogueStuff[0] = dialogueStuff[0].substr(splitName[0].length + 1).trim();
		swagDialogue.resetText(dialogueStuff[0]);
		swagDialogue.start(0.04, true);

		if(curCharacter != curLoaded || curLoaded == ''){
			portraitLeft.alpha = 0;
			FlxTween.tween(portraitLeft, {alpha: 1}, 0.1);
			portraitLeft.loadGraphic(Paths.image('dialoguePorts/${curCharacter}'));
			curLoaded = curCharacter;
		}
	}
}