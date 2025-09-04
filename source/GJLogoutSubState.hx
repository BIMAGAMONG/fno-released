package;
import flixel.effects.FlxFlicker;
import gamejolt.GJClient;

class GJLogoutSubState extends MusicBeatSubstate{
    var bg:FlxSprite;
    var info:FlxText;
    var suprcll:FlxSprite;
    var skulls:FlxBackdrop;
    #if mobile
    var deny:FlxSprite;
    var accept:FlxSprite;
    #end
    
    public function new(){
        super();
        openCallback = createMenu;
    }

    function createMenu(){
        bg = new FlxSprite().loadGraphic(Paths.image('gradientBg'));
        bg.antialiasing = FlxG.save.data.antialias;
        bg.scrollFactor.set();
        add(bg);

        skulls = new FlxBackdrop(Paths.image('skull', 'shared'), XY, 190, 190);
		skulls.setGraphicSize(Std.int(skulls.width * 0.4));
		skulls.screenCenter();
		skulls.velocity.x = FlxG.random.int(-50, 50);
		skulls.velocity.y = FlxG.random.int(-50, 50);
        skulls.antialiasing = false;
        add(skulls);

        suprcll = new FlxSprite().loadGraphic(Paths.image('supercellBg'));
        suprcll.scrollFactor.set();
        suprcll.antialiasing = FlxG.save.data.antialias;
        suprcll.scale.set(1.5, 1);
        suprcll.updateHitbox();
        suprcll.screenCenter();
        add(suprcll);

        var lines:Array<String> =[
            LangUtil.translate("You're about to log out of"),
            LangUtil.translate("your GameJolt session here.\n"),
            LangUtil.translate("Your personal information (username and game token)"),
            LangUtil.translate("will be removed from this game.\n"),
            LangUtil.translate("Are you sure you want to log out?") #if desktop ,
            LangUtil.translate("[Press P to Confirm]"),
            LangUtil.translate("[Press BACKSPACE to Cancel]")
            #end
        ];
        GJClient.trophieRemove(183125);
        var curText:String = '';
        for (i in lines) curText += '$i\n';
        info = new FlxText(0, 0, 0, curText);
        info.setFormat(Paths.font('LilitaOne-Regular.ttf'), 30, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        info.screenCenter();
        info.antialiasing = FlxG.save.data.antialias;
        info.scrollFactor.set();
        add(info);
        for(it in [bg, info, suprcll, skulls]){
            it.alpha = 0;
            FlxTween.tween(it, {alpha: 1}, 0.7);
        }
        #if mobile
        var daY:Float = info.y + info.height + 10;
        deny = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        deny.screenCenter(X);
        deny.x += 60;
		add(deny);
        accept = new FlxSprite().loadGraphic(Paths.image('mobile/change_tabs'));
        accept.screenCenter(X);
        accept.x -= 60;
		add(accept);
        for(it in [deny, accept]){
            it.y = daY;
            it.alpha = 0;
            FlxTween.tween(it, {alpha: 0.5}, 0.7);
        }
        #end
    }

    override function update(elapsed:Float){
        #if desktop
        if (FlxG.keys.justPressed.P) picked(true);
        else if (FlxG.keys.justPressed.BACKSPACE) picked(false);
        #else
        touch = FlxG.touches.getFirst();
        if(touch != null && touch.justPressed){
            if(touch.overlaps(accept)) picked(true);
            else if(touch.overlaps(deny)) picked(false);
        }
        #end
        super.update(elapsed);
    }

    function picked(erase:Bool){
        if(erase){
            GJClient.setUserInfo(null, null);
            FlxG.sound.play(Paths.sound('confirmMenu'));
        }else FlxG.sound.play(Paths.sound('cancelMenu'));
            
        FlxFlicker.flicker(info, 0.7, 0.05, false, false, function (flk:FlxFlicker){
            FlxTween.tween(bg, {alpha: 0}, 0.3);
            FlxTween.tween(suprcll, {alpha: 0}, 0.3);
            FlxTween.tween(skulls, {alpha: 0}, 0.3);
            FlxTween.tween(info, {alpha: 0}, 0.3, {onComplete: function (twn:FlxTween){
                if(erase) FlxG.switchState(new MainMenuState());
                else close();
            }});
        });
    }
}