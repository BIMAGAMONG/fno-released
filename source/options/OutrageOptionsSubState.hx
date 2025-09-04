package options;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import openfl.Lib;
using StringTools;

class OutrageOptionsSubState extends MusicBeatSubstate{
    var daList:Map<String, Array<Array<Dynamic>>> = new Map();
	var daOpt:FlxTypedSpriteGroup<FlxText> = new FlxTypedSpriteGroup<FlxText>();
    var categ:String = "";
    var integerCurSel:Int = 0;
    var upperBound:Float = 0;
    var lowerBound:Float = 0;
    var blocc:Bool = true;
    #if mobile
    var leftbutt:FlxSprite;
    var rightbutt:FlxSprite;
    var button:FlxSprite;
    #end

    public function new(categString:String){
        this.categ = categString;
        super();
        /* boolean options require an array of 3 elements:
        textThatAppearsInTheMenu:String, description:String, theExactNameOfTheSaveVariable:String (eg. FlxG.save.data.--> flashing <---)
        Integer/Float options require an array of the following elements:
        textThatAppearsInTheMenu:String, description:String, theExactNameOfTheSaveVariable:String (eg. FlxG.save.data.--> flashing <---), lowerBound:Float, upperBound:Float, unitPerPress:Float*/
        daList = [
            'General & Accessibility' => [                       
                ["Flashing Lights", "Also affects other things that flash.", "flashing"],
                ["Miss Sounds", "Play sound effects when missing notes.", "missSounds"],
                ["Skip Cutscenes & Dialogue", "", "skipScenes"],
                ["Menu Instructions", "Menus display instructions on how to use them (this menu is not affected by this).", "menuinst"],
                ["Lane Underlay Opacity", "Change opacity of the background under the notes.", "laneAlpha", 0, 1, 0.1],
                ["Colorblind Filter", "", "colorBlindFilter", 0, 3, 1]
            ],'Gameplay' => [                       
                ["Instakill Key", "Pressing 'R' with this enabled will result in an instant game over.", "resetButton"],
                ["Botplay", "The game plays for you, no strings attached.", "botplay"],
                ["View Combo and Rating", "View the ratings (Eg. Outrage!) and combo numbers when hitting notes.", "comboViewOption"],
                #if desktop ["Downscroll", "Notes will come from above, your strums will be at the bottom of the screen.", "downscroll"], #end
                ["Accuracy Calculation", "", "accuracyMod", 0, 1, 1],
                ["Note Offset", "Determines how late a note spawns, useful for dealing with audio lag from wireless earphones. Also hold CTRL to scroll faster.", "offset", 0, 10000, 1]
            ],'Display' => [
                #if desktop ["Shaders", "", "shaders"], #end
                ["Anti-Aliasing", "If turned on, graphics are smoother, otherwise, they lose their smoothness but improves performance.", "antialias"],
                ["Shaking", "", "shaking"],
                ["Hide HUD", "Hides stats and song time and name during gameplay.", "hud"],
                ["HUD Opacity", "Sets transparency for all gameplay HUD elements. Lane underlay IS NOT AFFECTED by this.", "healthBarAlpha", 0.5, 1, 0.1],
                ["Framerate", "Set the framerate the game runs on.", "fpsCap", 60, 120, 10]
            ],'Misc' => [
                #if desktop ["Auto Pause", "If this is enabled, the game will pause when not focused on.", "autopause"],
                ["FPS Counter", "Appears on the top left corner of the screen.", "fps"],
                ["Rainbow FPS Counter", "Photosensitive Warning!", "fpsRain"], #end
                ["Instakill on Miss", "", "instakill"],
                ["Green Screen Mode", "When enabled, the gameplay would be just a green screen with the HUD.", "greenscreen"],     
                ["Extra Scroll Speed", "The number gets added onto the scroll speed for all songs.", "extraScrollSpeed", -0.5, 1, 0.1]     
            ]    
        ];
        for (item in daList.get(categ)){
            item[0] = LangUtil.translate(item[0]);
            if (item[1] != "") item[1] = LangUtil.translate(item[1]);
        }
    }

    public function changeValue(isNegativeNum:Bool){
        FlxG.sound.play(Paths.sound('soundtray/VolUp'));
        var curValue:Float = Reflect.getProperty(FlxG.save.data, daList.get(categ)[integerCurSel][2]);
        var lowerBound:Float = daList.get(categ)[integerCurSel][3];
        var upperBound:Float = daList.get(categ)[integerCurSel][4];
        // FOR SOME STUPID REASON when this function has a num:Float parameter, negative values immideatly were turned into zeros when
        // calling the function like this: changeValue(-daList.get(categ)[integerCurSel][5]);, so this is a work around.
        if (isNegativeNum){
            if (daList.get(categ)[integerCurSel][2] == 'offset' && FlxG.keys.pressed.CONTROL) curValue -= 100;
            else curValue -= daList.get(categ)[integerCurSel][5];
        }else {
            if (daList.get(categ)[integerCurSel][2] == 'offset' && FlxG.keys.pressed.CONTROL) curValue += 100;
            else curValue += daList.get(categ)[integerCurSel][5];
        }
        // these vars are fucked for some reason so i need to include this
        if (daList.get(categ)[integerCurSel][2] == "offset" || daList.get(categ)[integerCurSel][2] == "extraScrollSpeed" || daList.get(categ)[integerCurSel][2] == "laneAlpha") curValue = CoolUtil.truncateFloat(curValue,1);

        if (curValue > upperBound) curValue = lowerBound;
        else if (curValue < lowerBound) curValue = upperBound;
        Reflect.setProperty(FlxG.save.data, daList.get(categ)[integerCurSel][2], curValue);
        FlxG.save.flush();
        textChange();
    }

    override function create(){
        for (item in 0...daList.get(categ).length){
            var text:FlxText = new FlxText(0, 0, 0, daList.get(categ)[item][0], 25);
            text.setFormat(Paths.font("LilitaOne-Regular.ttf"), #if desktop 35 #else 70 #end, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
            text.screenCenter();
            text.ID = item;
			text.y += (#if desktop 50 #else 80 #end * (item - (daList.get(categ).length / 2))) #if mobile + 20 #end;
            text.antialiasing = true;
            daOpt.add(text);

            if (Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[item][2])) == "true" || Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[item][2])) == "false") text.color = Reflect.getProperty(FlxG.save.data, daList.get(categ)[item][2]) ? FlxColor.LIME : FlxColor.RED;
            else {
                text.text = ': ' + Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[item][2]));
                updateValueText(text);
            }
        }
        new FlxTimer().start(0.1, function(timer:FlxTimer){blocc = false;});
        change(0, false);
        add(daOpt);

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
            spr.visible = false;
			spr.alpha = 0.5;
		}
        leftbutt.x = 0;
        rightbutt.x = FlxG.width - rightbutt.width;
        button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.x = FlxG.width - button.width;
        button.alpha = 0.5;
		add(button);
        #end
        super.create();
    }

    public function textChange(){
        for (item in daOpt.members){
            if (Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[item.ID][2])) == "true" || Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[item.ID][2])) == "false"){
                item.text = daList.get(categ)[item.ID][0];
                if (item.ID == integerCurSel) item.text = '> ' + daList.get(categ)[item.ID][0] + ' <';
            }else{
                item.text = daList.get(categ)[item.ID][0] + ': ' + Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[item.ID][2]));
                if (item.ID == integerCurSel) item.text = daList.get(categ)[item.ID][0] + ': < ' + Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[item.ID][2])) + ' >';
                updateValueText(item);
            }
            item.screenCenter(X);
        }
        OutrageOptions.updateDesc(daList.get(categ)[integerCurSel][1] == "" ? LangUtil.translate("Self-explanatory.") : daList.get(categ)[integerCurSel][1]);
    }

    function updateValueText(item:FlxText){
        switch (daList.get(categ)[item.ID][2]){
            case 'accuracyMod': item.text = item.text.replace(Std.string(FlxG.save.data.accuracyMod), LangUtil.translate(FlxG.save.data.accuracyMod == 0 ? "Simple" : "Milisecond Based"));
            case 'colorBlindFilter':
                var string:String = switch(Reflect.getProperty(FlxG.save.data, 'colorBlindFilter')) {
                    case 1: 'DEUTERANOPIA';
                    case 2: 'PROTANOPIA';
                    case 3: 'TRITANOPIA';
                    default: 'NONE';
                }
                TitleState.setColorBlindFilter();
                item.text = item.text.replace(Std.string(FlxG.save.data.colorBlindFilter), LangUtil.translate(string));
        }
    }

    override function update(elapsed:Float){
        #if mobile touch = FlxG.touches.getFirst(); #end
        if (!blocc){
            #if desktop
            if (FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.BACKSPACE) exit();
            if (FlxG.keys.justPressed.UP || (FlxG.mouse.wheel > 0 && !FlxG.keys.pressed.SHIFT)) change(-1);
            else if (FlxG.keys.justPressed.DOWN || (FlxG.mouse.wheel < 0 && !FlxG.keys.pressed.SHIFT)) change(1);

            if ((FlxG.keys.justPressed.LEFT || FlxG.mouse.wheel < 0 && FlxG.keys.pressed.SHIFT) && daList.get(categ)[integerCurSel][5] != null) changeValue(true);
            else if ((FlxG.keys.justPressed.RIGHT || FlxG.mouse.wheel > 0 && FlxG.keys.pressed.SHIFT) && daList.get(categ)[integerCurSel][5] != null) changeValue(false);

            if ((FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed) && (Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[integerCurSel][2])) == "true" || Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[integerCurSel][2])) == "false")) selected();
            #else
            for(spr in [leftbutt, rightbutt]) spr.visible = (daList.get(categ)[integerCurSel][5] != null ? true : false);
            for(tx in daOpt.members){
                if(touch != null){
                    if(touch.justPressed && touch.overlaps(tx) && (!touch.overlaps(leftbutt) && !touch.overlaps(rightbutt))){
                        if(integerCurSel != tx.ID){
                            integerCurSel = tx.ID;
                            change(0);
                        }else{if(Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[integerCurSel][2])) == "true" || Std.string(Reflect.getProperty(FlxG.save.data, daList.get(categ)[integerCurSel][2])) == "false") selected();}
                    }
                }
            }
            if (touch != null && touch.justPressed){
                if(touch.overlaps(leftbutt) && daList.get(categ)[integerCurSel][5] != null) changeValue(true);
                else if(touch.overlaps(rightbutt) && daList.get(categ)[integerCurSel][5] != null) changeValue(false);
                if(touch.overlaps(button)) exit();
            }
            #end
        }
        super.update(elapsed);
    }

    function exit(){
        blocc = true;
        FlxG.sound.play(Paths.sound('cancelMenu'));
        close();
    }

    function selected(){
        FlxG.sound.play(Paths.sound('soundtray/VolUp'));
        for (item in daOpt.members){
            if (item.ID == integerCurSel){
                Reflect.setProperty(FlxG.save.data, daList.get(categ)[item.ID][2], !Reflect.getProperty(FlxG.save.data, daList.get(categ)[item.ID][2]));
                item.color = Reflect.getProperty(FlxG.save.data, daList.get(categ)[item.ID][2]) ? FlxColor.LIME : FlxColor.RED;
            }
        }
        FlxG.save.flush();
        updateSumShiz(daList.get(categ)[integerCurSel][2]);
    }

    function updateSumShiz(setting:String){
        switch(setting){
            case 'fps': (cast (Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
            case 'fpsRain': (cast (Lib.current.getChildAt(0), Main)).changeFPSColor(FlxColor.WHITE);
            case 'autopause': (cast (Lib.current.getChildAt(0), Main)).autoPausing(FlxG.save.data.autopause);
            case 'fpsCap':
                (cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);
                FlxG.drawFramerate = FlxG.save.data.fpsCap;
                FlxG.updateFramerate = FlxG.save.data.fpsCap;
        }
    }

    function change(intnum:Int, ?snd:Bool = true){
        integerCurSel += intnum;
        if (snd) FlxG.sound.play(Paths.sound('scrollMenu'));
        if (integerCurSel > daList.get(categ).length - 1) integerCurSel = 0;
        else if (integerCurSel < 0) integerCurSel = Std.int(daList.get(categ).length - 1);
        textChange();
    }
}