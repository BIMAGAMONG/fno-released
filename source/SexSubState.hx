package;

class SexSubState extends MusicBeatSubstate{
    var blackBox:FlxSprite;
    var infoText:FlxText;
    var text:FlxText;
    var images:FlxSprite;
    #if mobile
    var block:Bool = true;
    #end

    public function new(path:String, display:String, desc:String){
        super();
        images = new FlxSprite(10, 10).loadGraphic(Paths.image(path));
        images.scale.set(0.7, 0.7);
        images.updateHitbox();
        images.antialiasing = FlxG.save.data.antialias;
        images.alpha = 0;
        images.screenCenter();

        text = new FlxText(0, 70, 0, display.toUpperCase());
        text.setFormat(Paths.font("tardling.ttf"), 50, 0xFF00FE9E, CENTER, OUTLINE, FlxColor.BLACK);
        text.borderSize = 4;
        text.alpha = 0;
        text.antialiasing = FlxG.save.data.antialias;
        text.screenCenter(X);

        infoText = new FlxText(10, 590, 0, desc #if mobile + '\n${LangUtil.translate('TOUCH')} - ${LangUtil.translate('go back')}' #end, 24);
        infoText.setFormat(Paths.font("LilitaOne-Regular.ttf"), 30, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
        infoText.alpha = 0;
        infoText.screenCenter(X);
    }

    override public function create(){
        FlxG.sound.play(Paths.sound('majorUnlock'));
        blackBox = new FlxSprite(0, 0).makeGraphic(FlxG.width + 10, FlxG.height + 10, FlxColor.BLACK);
        blackBox.antialiasing = false;
        blackBox.alpha = 0;
        add(blackBox);
        add(infoText);
        add(text);
        add(images);
        FlxTween.tween(infoText, {alpha: 1}, 0.5, {ease: FlxEase.expoInOut});
        FlxTween.tween(text, {alpha: 1}, 0.5, {ease: FlxEase.expoInOut});
        FlxTween.tween(images, {alpha: 1}, 0.5, {ease: FlxEase.expoInOut});
        FlxTween.tween(blackBox, {alpha: 0.7}, 0.5, {ease: FlxEase.expoInOut #if mobile , onComplete: function(_){block = false;}#end});
    	super.create();
    }

    override public function update(elapsed:Float){
        #if desktop
        if (FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE || FlxG.keys.justPressed.BACKSPACE) close();
        #else
        if(!block){
            touch = FlxG.touches.getFirst();
            if (touch != null && touch.justPressed) close();
        }
        #end
    	super.update(elapsed);
    }
}