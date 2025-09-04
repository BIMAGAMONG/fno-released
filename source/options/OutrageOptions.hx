package options;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import options.*;
using StringTools;

class OutrageOptions extends MusicBeatState{
    var categories:Array<String> = [#if desktop 'Controls',#end 'General & Accessibility', 'Gameplay', 'Display', 'Misc', 'Language', 'Clear Save Data'];
	var opt:FlxTypedSpriteGroup<FlxText> = new FlxTypedSpriteGroup<FlxText>();
	var skulls:FlxBackdrop;
    var curS:Int = 0;
    var block:Bool = false;
    var redBG:FlxSprite;
    var bg:FlxSprite;
    public static var desc:FlxText;
    public static var defText:String = "";
    public static var subText:String = "";
    #if mobile
    var button:FlxSprite;
    #end
    
    override function create(){
        #if desktop
        defText = '${LangUtil.translate("UP")}/${LangUtil.translate("DOWN")}/${LangUtil.translate("MOUSE WHEEL")} - ${LangUtil.translate("scroll")}, ${LangUtil.translate("ENTER")}/${LangUtil.translate("CLICK")} - ${LangUtil.translate("select")}';
        subText = '${LangUtil.translate("UP")}/${LangUtil.translate("DOWN")}/${LangUtil.translate("MOUSE WHEEL")} - ${LangUtil.translate("scroll")}, ${LangUtil.translate("ENTER")}/${LangUtil.translate("CLICK")} - ${LangUtil.translate("toggle on/off")}, ${LangUtil.translate("MOUSE WHEEL")} + ${LangUtil.translate("SHIFT")} - ${LangUtil.translate("change value")}';
        #else
        defText = '${LangUtil.translate("TOUCH")} - ${LangUtil.translate("select")}';
        subText = '${LangUtil.translate("TOUCH")} - ${LangUtil.translate("select")}, ${LangUtil.translate("toggle on/off")}, ${LangUtil.translate("change value")}';
        #end
        for (item in 0...categories.length){
            var text:FlxText = new FlxText(0, 0, 0, LangUtil.translate(categories[item]) + (categories[item] == 'Language' ? ': ' + KadeEngineData.languages[FlxG.save.data.lang].toUpperCase() : ""), 25);
            text.setFormat(Paths.font("LilitaOne-Regular.ttf"), #if desktop 35 #else 70 #end, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            text.screenCenter();
            text.ID = item;
			text.y += (#if desktop 50 #else 80 #end * (item - (categories.length / 2))) #if mobile + 20 #end;
            text.antialiasing = true;
            opt.add(text);
        }
        change(0, false);

        var integer:Int = FlxG.random.int(0, TitleState.titleColors.length - 1);
		redBG = FlxGradient.createGradientFlxSprite(FlxG.width, FlxG.height, TitleState.titleColors[integer], 1, 180, true);
		redBG.screenCenter();
		redBG.antialiasing = false;
		add(redBG);

        bg = new FlxSprite().loadGraphic(Paths.image('menuBranches', 'shared'));
        bg.antialiasing = FlxG.save.data.antialias;
		bg.scale.set(1.5, 1.5);
		bg.updateHitbox();
		bg.screenCenter();

        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        add(skulls);
        add(bg);
        
        remove(desc);
        desc = new FlxText(0, 0, 1280, defText, 25);
        desc.setFormat(Paths.font("LilitaOne-Regular.ttf"), 25, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        desc.screenCenter(X);
        desc.y = FlxG.height - desc.height - 5;
        desc.antialiasing = true;
        add(desc);
        add(opt);
        persistentUpdate = persistentDraw = true;
        #if mobile
        button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.x = FlxG.width - button.width;
        button.alpha = 0.5;
		add(button);
        #end
        super.create();
    }

    function exit() {
        block = true;
        FlxG.sound.play(Paths.sound('cancelMenu'));
        if (PlayState.stateIsRestarted) FlxG.switchState(new PlayState());
        else FlxG.switchState(new MainMenuState());
    }

    override function update(elasped:Float){
        #if mobile touch = FlxG.touches.getFirst(); #end
        if (!block){
            #if desktop
            if (FlxG.keys.justPressed.UP || FlxG.mouse.wheel > 0) change(-1);
            else if (FlxG.keys.justPressed.DOWN || FlxG.mouse.wheel < 0) change(1);
            if (FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed) openReqSubstate(categories[curS]);
            if (controls.BACK) exit();
            #else
            if(touch != null && touch.justPressed && touch.overlaps(button)) exit();
            for(tx in opt.members){
                if(touch != null){
                    if(touch.justPressed && touch.overlaps(tx)){
                        if (curS != tx.ID){
                            curS = tx.ID;
                            change(0);
                        }else openReqSubstate(categories[curS]);
                    }
                }
            }
            #end
        }
        super.update(elasped);
    }

    function openReqSubstate(label:String){
        #if mobile button.visible = false; #end
        block = true;
        if (label != 'Controls' && label != 'Clear Save Data' && label != 'Language') for (item in opt.members) item.alpha = 0;
        switch(label){
            case 'Controls': openSubState(new KeyBindMenu());
            case 'Clear Save Data': openSubState(new ClearSaveData());
            case 'Language':
                FlxG.save.data.lang += 1;
                if (FlxG.save.data.lang > KadeEngineData.languages.length - 1) FlxG.save.data.lang = 0;
                LangUtil.curLang = KadeEngineData.languages[FlxG.save.data.lang];
                FlxG.save.flush();
                #if desktop desc.text = '${LangUtil.translate("UP")}/${LangUtil.translate("DOWN")}/${LangUtil.translate("MOUSE WHEEL")} - ${LangUtil.translate("scroll")}, ${LangUtil.translate("ENTER")}/${LangUtil.translate("CLICK")} - ${LangUtil.translate("select")}';
                #else desc.text = '${LangUtil.translate("TOUCH")} - ${LangUtil.translate("select")}'; #end
                change(0);
                Difficulty.init();
                for (text in opt.members) if(categories[text.ID] == 'Language') text.text = '> ${LangUtil.translate('Language')}: ${KadeEngineData.languages[FlxG.save.data.lang].toUpperCase()} (' + #if desktop '${LangUtil.translate('ENTER')}' #else '${LangUtil.translate("TOUCH")}' #end + ') <';
                block = false;
            default: openSubState(new OutrageOptionsSubState(label));
        }
    }

    override function closeSubState(){
        #if mobile button.visible = true; #end
        block = false;
        for (item in opt.members) item.alpha = 1;
        #if desktop desc.text = '${LangUtil.translate("UP")}/${LangUtil.translate("DOWN")}/${LangUtil.translate("MOUSE WHEEL")} - ${LangUtil.translate("scroll")}, ${LangUtil.translate("ENTER")}/${LangUtil.translate("CLICK")} - ${LangUtil.translate("select")}';
        #else desc.text = '${LangUtil.translate("TOUCH")} - ${LangUtil.translate("select")}'; #end
        desc.y = FlxG.height - desc.height - 5;
        super.closeSubState();
    }

    function change(num:Int, ?snd:Bool = true){
        curS += num;
        if (snd) FlxG.sound.play(Paths.sound('scrollMenu'));
        if (curS > categories.length - 1) curS = 0;
        else if (curS < 0) curS = categories.length - 1;

        for (item in opt.members){
            item.color = FlxColor.WHITE;
            if (categories[item.ID]== 'Language') item.text = LangUtil.translate('Language') + ': ' + KadeEngineData.languages[FlxG.save.data.lang].toUpperCase();
            else item.text = LangUtil.translate(categories[item.ID]);
            if (item.ID == curS){
                if (categories[item.ID] == 'Language') item.text = '> ${LangUtil.translate('Language')}: ' + KadeEngineData.languages[FlxG.save.data.lang].toUpperCase() + ' (' + #if desktop '${LangUtil.translate('ENTER')}' #else '${LangUtil.translate("TOUCH")}' #end + ') <';
                else item.text = '> ${LangUtil.translate(categories[item.ID])} <';
                item.color = FlxColor.YELLOW;
            }
            item.screenCenter(X);
        }
    }

    public static function updateDesc(daText:String){
        desc.text = daText + '\n' + subText;
        desc.screenCenter(X);
        desc.y = FlxG.height - desc.height - 10;
        FlxTween.tween(desc, {y: desc.y + 5}, 0.1, {ease: FlxEase.quadOut});
    }
}