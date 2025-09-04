package;
import flixel.FlxState;
import flixel.addons.ui.FlxUIGroup;

class GJActionButton extends FlxUIGroup{
    var actions:() -> Void;
    var redirectTo:Null<FlxState>;

    public function new(x:Float, y:Float, sizeX:Int, sizeY:Int, title:String, actions:() -> Void, ?redirectTo:FlxState){
        super(x, y);
        this.actions = actions;
        this.redirectTo = redirectTo;

        var buttonBG = new FlxSprite().loadGraphic(Paths.image("button", 'shared'));
        buttonBG.setGraphicSize(Std.int(buttonBG.width * 0.2));
        buttonBG.updateHitbox();
        buttonBG.antialiasing = FlxG.save.data.antialias;
        var buttonText = new FlxText(0, 0, 0, title);
        buttonText.setFormat(Paths.font('LilitaOne-Regular.ttf'), 30, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        CoolUtil.objectCenter(buttonText, buttonBG);
        add(buttonBG);
        add(buttonText);
    }

    override function update(elapsed:Float){
        super.update(elapsed);
        if (FlxG.mouse.overlaps(this)){
            members[0].color = FlxColor.BLUE;
            if (FlxG.mouse.justPressed){
                actions();
                if (redirectTo != null) FlxG.switchState(redirectTo);
            }
        } else members[0].color = FlxColor.CYAN;
    }
}