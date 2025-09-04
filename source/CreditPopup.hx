package;
import flixel.group.FlxSpriteGroup;
using StringTools;
class CreditPopup extends FlxSpriteGroup{
    var sigma:Array<FlxColor> = [0xFF00ff97, 0xFFff003e, 0xFF595dff, 0xFFff00c5, 0xFFfbff00];
	var colRand:Int = 0;
    var topTXT:FlxText;
    var botTXT:FlxText;
    var stick:FlxSprite;

    public function new(){
        super();
        topTXT = new FlxText(10, 10, 0, '', 65);
		topTXT.setFormat(Paths.font("LilitaOne-Regular.ttf"), 65, FlxColor.WHITE, CENTER);
        topTXT.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		topTXT.text = topTXT.text.replace('-', ' ');
        topTXT.antialiasing = false;

        botTXT = new FlxText(10, 10, 0, '', 65);
		botTXT.setFormat(Paths.font("LilitaOne-Regular.ttf"), 65, FlxColor.WHITE, CENTER);
        botTXT.setBorderStyle(OUTLINE, FlxColor.BLACK, 1, 1);
		botTXT.text = botTXT.text.replace('-', ' ');
        botTXT.antialiasing = false;

		stick = new FlxSprite().loadGraphic(Paths.image('songStick', 'shared'));
        stick.antialiasing = false;

		add(topTXT);
        add(botTXT);
		add(stick);
    }
    public function activate(topText:String, bottomText:String){
        colRand = FlxG.random.int(0, sigma.length - 1);

        topTXT.color = sigma[colRand];
        topTXT.text = topText;
        topTXT.screenCenter();
        topTXT.y -= topTXT.height / 2;
        botTXT.color = sigma[colRand];
        botTXT.text = bottomText;
        botTXT.screenCenter();
        botTXT.y += botTXT.height / 2;

        stick.scale.set(0.1, 1);
        stick.color = sigma[colRand];
		FlxTween.tween(stick, {"scale.x": (topTXT.width / 1000) * 2}, 1, {ease: FlxEase.sineOut, onUpdate: function(twn:FlxTween) {stick.screenCenter();}});
    }
    override function destroy(){
        for(spr in [topTXT, botTXT, stick]) spr.destroy();
        super.destroy();
    }
}