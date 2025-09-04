package;
import flixel.FlxObject;
import flixel.addons.text.FlxTypeText;
import flixel.graphics.FlxGraphic;
import haxe.Json;
import openfl.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
using StringTools;

typedef CreditsData ={
	name:String,
	?quote:String,
	?link:String
}

class CreditsState extends MusicBeatState{	
	var bg:FlxSprite;
	var nameBar:FlxSprite;
	var memberName:FlxTypeText;
	var memberQuote:FlxTypeText;
	var left:FlxSprite;
	var right:FlxSprite;
	var portrait:FlxSprite;
	var counter:FlxText;
	var pressForLink:FlxText;
	var memberData:Array<CreditsData>;
	var grpHUD:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
	var curMember:Int = 0;
    var curCategory:Int = 0;
	var categoryArray = ['coders', 'visuals', 'audio', 'charters', 'characters', 'voice actors', 'misc'];
	public static var egg:Bool = false;
	public static var chance:Int = 0;
	var skulls:FlxBackdrop;
	#if mobile
	var upB:FlxSprite;
	var downB:FlxSprite;
	var leftB:FlxSprite;
	var rightB:FlxSprite;
	var button:FlxSprite;
	#end

	override public function create(){
		egg = false;
		chance = FlxG.random.int(0, 4);
		trace("chance: " + Std.string(chance));
		super.create();
		FlxG.sound.playMusic(Paths.music('freakyCredits'));
		Conductor.changeBPM(164);
		#if desktop
		DiscordClient.changePresence("Supporting the developers!", null);
		#end

		memberData = Json.parse(Assets.getText('assets/data/creditsData.json')).coders;
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		bg = new FlxSprite(0, FlxG.height).loadGraphic(Paths.image('creditsBG'));
		bg.setGraphicSize(Std.int(FlxG.width * 1.2), Std.int(FlxG.height * 1.2));
		bg.updateHitbox();
		bg.scrollFactor.set();
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.antialias;

		skulls = new FlxBackdrop(Paths.image('credits_circle', 'shared'), XY, 100, 100);
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = 80;
		skulls.velocity.y = 80;
        skulls.antialiasing = false;
		skulls.alpha = 0;

		pressForLink = new FlxText(50, FlxG.height * 0.05 + 10);
		pressForLink.setFormat(Paths.font('LilitaOne-Regular.ttf'), 25, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);

		nameBar = new FlxSprite().loadGraphic(Paths.image('creditsNameBar'));
		nameBar.scale.set(0.7, 0.65);
		nameBar.updateHitbox();
		nameBar.scrollFactor.set();
		nameBar.y = FlxG.height * 0.9 - nameBar.height;
		nameBar.x = 0 - nameBar.width;
		nameBar.antialiasing = FlxG.save.data.antialias;

		memberName = new FlxTypeText(0, 0, FlxG.width, '');
		memberName.setFormat(Paths.font('LilitaOne-Regular.ttf'), 85, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
		memberName.bold = true;
		memberName.wordWrap = false;
		memberName.autoSize = true;
		memberName.updateHitbox();
		memberName.skipKeys = [];
		memberName.antialiasing = true;
		memberName.scrollFactor.set();

		memberQuote = new FlxTypeText(0, 0, Std.int(nameBar.width * 0.8), '');
		memberQuote.setFormat(Paths.font('LilitaOne-Regular.ttf'), 35, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		memberQuote.skipKeys = [];
		memberQuote.antialiasing = true;
		memberQuote.scrollFactor.set();
		memberQuote.x = nameBar.width/2 - memberQuote.width/2;
		memberName.x = 15;

		counter = new FlxText();
		counter.setFormat(Paths.font('LilitaOne-Regular.ttf'), 25, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		counter.updateHitbox();
		counter.antialiasing = true;
		counter.x = FlxG.width * 0.75 - counter.width/2;
		counter.y = FlxG.height * 0.175 - counter.height/2;

		left = new FlxSprite().loadGraphic(Paths.image('creditArrow'));
		left.setGraphicSize(Std.int(counter.height), Std.int(counter.height));
		left.updateHitbox();
		left.color = FlxColor.LIME;
		left.antialiasing = FlxG.save.data.antialias;

		right = new FlxSprite().loadGraphic(Paths.image('creditArrow'));
		right.setGraphicSize(Std.int(left.width), Std.int(left.height));
		right.updateHitbox();
		right.color = FlxColor.RED;
		right.flipX = true;
		right.flipY = true;
		right.antialiasing = FlxG.save.data.antialias;
		
		portrait = new FlxSprite();
		portrait.antialiasing = FlxG.save.data.antialias;
		left.y = right.y = counter.y;
		memberName.y = nameBar.y + nameBar.height/2 - memberName.height/2;

		add(bg);
		add(skulls);
		grpHUD.add(pressForLink);
		grpHUD.add(nameBar);
		grpHUD.add(memberName);
		grpHUD.add(memberQuote);
		grpHUD.add(counter);
		grpHUD.add(left);
		grpHUD.add(right);
		add(portrait);
		#if mobile
		leftB = new FlxSprite().loadGraphic(Paths.image('mobile/small_button'));
		rightB = new FlxSprite().loadGraphic(Paths.image('mobile/small_button'));
		rightB.flipX = true;
		upB = new FlxSprite().loadGraphic(Paths.image('mobile/small_button'));
		upB.angle += 90;
		downB = new FlxSprite().loadGraphic(Paths.image('mobile/small_button'));
		downB.flipX = true;
		downB.angle += 90;
		var he:Float = FlxG.height - 105;
		leftB.setPosition(5, he);
		rightB.setPosition(110, he);
		downB.setPosition(215, he);
		upB.setPosition(320, he);
		for(sp in [downB, leftB, upB, rightB]){
			sp.antialiasing = false;
			sp.alpha = 0.5;
			grpHUD.add(sp);
		}
		button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.x = FlxG.width - button.width;
        button.alpha = 0.5;
		grpHUD.add(button);
		#end
		add(grpHUD);
		infoChange(true);
	}

	override function update(elapsed:Float){
		#if mobile touch = FlxG.touches.getFirst(); #end
		counter.x = FlxG.width * 0.75 - counter.width/2;
		counter.text = '${curMember+1}/${memberData.length}\n${LangUtil.translate('Category (UP/DOWN)')} :\n${LangUtil.translate(categoryArray[curCategory].toUpperCase())}';
		Conductor.songPosition = FlxG.sound.music.time;

		if (!egg){
			#if desktop
			if (controls.LEFT_P || controls.RIGHT_P || FlxG.mouse.wheel > 0 || FlxG.mouse.wheel < 0){
				if (controls.LEFT_P || FlxG.mouse.wheel > 0) curMember--;
				if (controls.RIGHT_P || FlxG.mouse.wheel < 0) curMember++;
				if (curMember < 0) curMember = memberData.length - 1;
				if (curMember > memberData.length - 1) curMember = 0;
				infoChange(false);
			}
			
			if (controls.UP_P || controls.DOWN_P){
				if (controls.UP_P) curCategory--;
				if (controls.DOWN_P) curCategory++;
				if (curCategory < 0) curCategory = categoryArray.length - 1;
				if (curCategory > categoryArray.length - 1) curCategory = 0;
				infoChange(true);
			}
			
			if (controls.ACCEPT) openLink();
			if (controls.BACK) exit();
			#else
			if(touch != null && touch.justPressed){
				if(touch.overlaps(leftB) || touch.overlaps(rightB)){
					if (touch.overlaps(leftB)) curMember--;
					else if (touch.overlaps(rightB)) curMember++;
					if (curMember < 0) curMember = memberData.length - 1;
					if (curMember > memberData.length - 1) curMember = 0;
					infoChange(false);
				}else if (touch.overlaps(upB) || touch.overlaps(downB)){
					if (touch.overlaps(upB)) curCategory--;
					else if (touch.overlaps(downB)) curCategory++;
					if (curCategory < 0) curCategory = categoryArray.length - 1;
					if (curCategory > categoryArray.length - 1) curCategory = 0;
					infoChange(true);
				}else if (touch.justPressed && touch.overlaps(button)){exit();}
				else openLink();
			}
			#end
		}
		super.update(elapsed);

		bg.y = CoolUtil.slideEffect(8, COS, 2, 0.75, 0 - FlxG.height * 0.15);
		left.x = CoolUtil.slideEffect(8, SIN, 0.5, 0, counter.x - left.width * 1.5);
		right.x = CoolUtil.slideEffect(8, COS, 0.5, 1.25, counter.x + counter.width + right.width * 0.5);
		memberQuote.y = nameBar.y - memberQuote.height - 75;

		if (chance == 2 && FlxG.sound.music.time >= 81000){
			FlxTween.tween(skulls, {alpha: 0.2}, 1);
			for (item in grpHUD.members) FlxTween.tween(item, {alpha: 0}, 1);
			new FlxTimer().start(10, function(tmr:FlxTimer){
				egg = false;
				for (item in grpHUD.members) FlxTween.tween(item, {alpha: 1}, 1);
			});
			chance = 10;
			egg = true;
		}
	}

	function exit(){
		FlxG.sound.play(Paths.sound('cancelMenu'));
		FlxG.sound.playMusic(Paths.music('freakyMenu'));
		FlxG.switchState(new MainMenuState());
	}

	function openLink(){
		if (memberData[curMember].link == null) FlxG.openURL('https://www.youtube.com/watch?v=ZK1pNGmNBEc&list=PLN1LPImPw_PlDRy10sDskVGszKZcbXaDn&index=2');
		else FlxG.openURL(memberData[curMember].link);
	}

	function infoChange(switchingCateg:Bool){
		FlxG.sound.play(Paths.sound('scrollMenu'));
		if (switchingCateg){
			curMember = 0;
			switch (curCategory){
				case 0: memberData = Json.parse(Assets.getText('assets/data/creditsData.json')).coders;
				case 1: memberData = Json.parse(Assets.getText('assets/data/creditsData.json')).visuals;
				case 2: memberData = Json.parse(Assets.getText('assets/data/creditsData.json')).audio;
				case 3: memberData = Json.parse(Assets.getText('assets/data/creditsData.json')).charters;
				case 4: memberData = Json.parse(Assets.getText('assets/data/creditsData.json')).oc;
				case 5: memberData = Json.parse(Assets.getText('assets/data/creditsData.json')).voice;
				case 6: memberData = Json.parse(Assets.getText('assets/data/creditsData.json')).misc;
			}
		}

		var user:String = memberData[curMember].name;
		var quote:Null<String> = memberData[curMember].quote;
		var link:Null<String> = memberData[curMember].link;
		FlxTween.cancelTweensOf(nameBar);
		FlxTween.cancelTweensOf(portrait);
		remove(portrait);

		nameBar.x = 0 - nameBar.width;
		pressForLink.text = link != null ? #if desktop '${LangUtil.translate("Press 'ENTER' to support")} $user' #else '${LangUtil.translate('TOUCH')} - ${LangUtil.translate('select')}' #end : LangUtil.translate("No Link Available");
		memberName.resetText(user);
		memberQuote.resetText(quote != null ? '$quote' : "N/A");

		var portFile = 'assets/images/credits/${user.toLowerCase()}.png';
		if (#if desktop FileSystem.exists(portFile) #else Assets.exists(portFile) #end) portrait.loadGraphic(Paths.image('credits/${user.toLowerCase()}'));
		else portrait.loadGraphic(Paths.image('credits/special-thanks'));

		portrait.setGraphicSize(Std.int(portrait.width * 0.5));
		portrait.updateHitbox();
		portrait.x = (FlxG.width * 0.825) - (portrait.width/1.5);
		portrait.antialiasing = FlxG.save.data.antialias;
		add(portrait);

		if (chance != 10){
			portrait.y = FlxG.height;
			FlxTween.tween(portrait, {y: FlxG.height - portrait.height}, 0.35, {ease: FlxEase.smoothStepIn});
		}else portrait.y = FlxG.height - portrait.height;

		FlxTween.tween(nameBar, {x: 0}, 0.35, {ease: FlxEase.elasticOut});
		memberQuote.start(0.03);
		memberName.start(0.03);
	}

	override public function beatHit(){
		super.beatHit();
		if (egg || chance == 10){
			FlxTween.completeTweensOf(portrait);
			portrait.flipX = !portrait.flipX;
			portrait.y += 10;
			FlxTween.tween(portrait, {y: portrait.y - 10}, 0.2, {ease: FlxEase.quadInOut});
		}
	}
}
