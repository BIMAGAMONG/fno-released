package;
import flixel.FlxObject;

class BrawlPopup extends FlxText{
    public function new(){
        super();
        this.text = "";
        this.setFormat(Paths.font("LilitaOne-Regular.ttf"), 40, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        this.alpha = 0;
    }

    public function activate(popText:String){
        FlxTween.cancelTweensOf(this);
        this.alpha = 0;
        this.text = popText;
        this.screenCenter();
        FlxTween.tween(this, {alpha: 1}, 0.5);
        FlxTween.tween(this, {y: this.y - 150}, 5, {onComplete: function(twn:FlxTween){FlxTween.tween(this, {alpha: 0}, 0.5);}});
    }
}