package;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.text.FlxInputText;
import gamejolt.GJClient;
import flixel.addons.transition.FlxTransitionableState;

class GameJoltState extends MusicBeatState{
    var bg:FlxSprite;
    var suprcll:FlxSprite;
    var title:FlxText;
    var skulls:FlxBackdrop;
    var daWidth:Int;
    var daHeight:Int;
    var missInfo:FlxText;
    #if mobile
    var button:FlxSprite;
    #end

    override function create(){
        #if desktop
        DiscordClient.changePresence("Gaming and Jolting!", null);
        FlxG.mouse.visible = true;
        #end
        daWidth = Std.int(FlxG.width * 0.5);
        transIn = FlxTransitionableState.defaultTransIn;
        transOut = FlxTransitionableState.defaultTransOut;
        persistentDraw = persistentUpdate = true;

        bg = new FlxSprite().loadGraphic(Paths.image('gradientBg'));
        bg.antialiasing = false;
        add(bg);

        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.alpha = 1;
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        add(skulls);

        suprcll = new FlxSprite().loadGraphic(Paths.image('supercellBg'));
        suprcll.antialiasing = true;
        suprcll.screenCenter();
        suprcll.setGraphicSize(Std.int(suprcll.width * 1));
        suprcll.x += 400;
        suprcll.antialiasing = false;
        add(suprcll);

        var supBG:Float = suprcll.x + 30;
        title = new FlxText(supBG, 50, 0, 'GAMEJOLT');
        title.setFormat(Paths.font('tardling.ttf'), 55, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        title.screenCenter(X);
        title.x += 250;
        title.borderSize = 4;
        title.antialiasing = FlxG.save.data.antialias;
        add(title);

        #if desktop
        var enterExit = new FlxText(0, 0, '${LangUtil.translate("ESC")} - ${LangUtil.translate("go back")}', false);
        enterExit.setFormat(Paths.font('LilitaOne-Regular.ttf'), 50, FlxColor.BLACK);
        enterExit.size = 30;
        enterExit.antialiasing = FlxG.save.data.antialias;
        #end

        missInfo = new FlxText(0, 0, 0, '');
        missInfo.setFormat(Paths.font('LilitaOne-Regular.ttf'), 45, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        missInfo.screenCenter();
        missInfo.antialiasing = FlxG.save.data.antialias;
        FlxTween.tween(missInfo, {alpha: 0.25}, 0.5, {type: PINGPONG});

        if (!GJClient.hasGameInfo()){
            missInfo.text = LangUtil.translate("No Game Data Available!");
            add(missInfo);
        }else if (GJClient.hasLoginInfo() && !GJClient.logged){
            missInfo.text = LangUtil.translate("ERROR, Something went wrong...");
            add(missInfo);
        }else if (!GJClient.hasLoginInfo()){
            var userTitle:FlxText;
            var tokenTitle:FlxText;
            var userBox:FlxInputText;
            var tokenBox:FlxInputText;
            var logButton:GJActionButton;
            var boxSize:Int = Std.int(FlxG.width * 0.3);

            userTitle = new FlxText(75, FlxG.height * 0.3, LangUtil.translate("Username:"), false);
            userTitle.setFormat(Paths.font('LilitaOne-Regular.ttf'), 50, FlxColor.BLACK);
            userTitle.antialiasing = FlxG.save.data.antialias;

            tokenTitle = new FlxText(75, FlxG.height * 0.5, LangUtil.translate("Game Token:"), false);
            tokenTitle.setFormat(Paths.font('LilitaOne-Regular.ttf'), 50, FlxColor.BLACK);
            tokenTitle.antialiasing = FlxG.save.data.antialias;

            userBox = new FlxInputText(0, userTitle.y + 60, boxSize, '', 44);
            userBox.setFormat(Paths.font('LilitaOne-Regular.ttf'), 40, FlxColor.BLACK, CENTER);
            userBox.screenCenter(X);

            tokenBox = new FlxInputText(0, tokenTitle.y + 60, boxSize, '', 44);
            tokenBox.setFormat(Paths.font('LilitaOne-Regular.ttf'), 40, FlxColor.BLACK, CENTER);
            tokenBox.passwordMode = true;
            tokenBox.screenCenter(X);

            userTitle.size = 30;
            tokenTitle.size = 30;
            tokenBox.x = supBG;
            userBox.x = supBG;
            userTitle.y = userBox.y - 60;
            tokenTitle.y = tokenBox.y - 60;
            userTitle.x = userBox.x;
            tokenTitle.x = tokenBox.x;
            #if desktop
            enterExit.x = tokenBox.x;
            enterExit.y = tokenBox.y + 70;
            add(enterExit);
            #end
            add(userBox);
            add(tokenBox);
            add(userTitle);
            add(tokenTitle);
            logButton = new GJActionButton(userTitle.x, #if desktop enterExit.y + 50 #else tokenBox.y + 80 #end, daWidth, Std.int(FlxG.height * 0.3), LangUtil.translate('Log In'), function (){GJClient.setUserInfo(userBox.text, tokenBox.text);}, new MainMenuState());
            add(logButton);

        }else{
            #if desktop
            enterExit.x = supBG;
            enterExit.y = title.y + title.height;
            add(enterExit);
            #end
            var logout:GJActionButton = new GJActionButton(supBG, 250, daWidth, Std.int(FlxG.height * 0.15),  LangUtil.translate('Log Out'),function (){openSubState(new GJLogoutSubState());});
            var trophy:GJActionButton  = new GJActionButton(supBG, 450, daWidth, Std.int(FlxG.height * 0.15), LangUtil.translate('Trophies'),function (){fancyOpenURL("https://gamejolt.com/games/fridayoutrage/756865/trophies");});
            add(logout);
            add(trophy);
        }
        persistentUpdate = false;
        #if mobile
        button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.x = FlxG.width - button.width;
        button.alpha = 0.5;
		add(button);
        #end
        super.create();
    }

    var block:Bool = false;
    override function update(elapsed:Float){
        #if desktop
        if (!block && FlxG.keys.justPressed.ESCAPE) exit();
        #else
        touch = FlxG.touches.getFirst();
        if(!block && touch != null && touch.justPressed && touch.overlaps(button)) exit();
        #end
        super.update(elapsed);
    }
    
    function exit(){
        FlxG.switchState(new MainMenuState());
        FlxG.sound.play(Paths.sound('cancelMenu'));
        block = true;
    }
}