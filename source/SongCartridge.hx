package;
import flixel.group.FlxSpriteGroup;
using StringTools;

class SongCartridge extends FlxSpriteGroup{
    public var song:String;
    var text:FlxText;
    var spr:FlxSprite;

    public function new(x:Float, y:Float, datext:String){
        this.song = datext;
        super();
        text = new FlxText(x, y, 0, StringTools.replace(SongLangUtil.trans(song.toUpperCase()), '-', ' '));
        if (!KadeEngineData.unlockedSongsArray.contains(song) && FreeplayCustom.curCategory != 'weeks'){
            // for some reasons, I have to include an A for latin languages and A for slavic languages, I have no idea why.
            text.text = text.text.replace('A', '4');
            text.text = text.text.replace('А', '4');
            text.text = text.text.replace('Я', '4');
            text.text = text.text.replace('E', '3');
            text.text = text.text.replace('Е', '3');
            text.text = text.text.replace('Э', '3');
            text.text = text.text.replace('I', '1');
            text.text = text.text.replace('L', '1');
            text.text = text.text.replace('O', '0');
            text.text = text.text.replace('О', '0');
            text.text = text.text.replace('Q', '0');
            text.text = text.text.replace('Ф', '0');
            text.text = text.text.replace('T', '7');
            text.text = text.text.replace('Т', '7');
            text.text = text.text.replace('Г', '7');
            text.text = text.text.replace('S', '5');
            text.text = text.text.replace('B', '8');
            text.text = text.text.replace('В', '8');
            text.text = text.text.replace('G', '6');
            text.text = text.text.replace('J', '9');
        }
        text.setFormat(Paths.font("funniPsychFont.ttf"), #if desktop 30 #else 40 #end, FlxColor.WHITE, LEFT, OUTLINE, FlxColor.BLACK);
        text.antialiasing = FlxG.save.data.antialias;

        spr = new FlxSprite(x, y).loadGraphic(Paths.image('freeplay/songArt_top'));
        spr.antialiasing = false;
        #if desktop
        text.x += 10;
        #else
        spr.scale.set(1.3, 1.3);
        spr.updateHitbox();
        text.x += 13;
        #end
        text.y += (spr.height / 2) - (text.height / 2);
        add(spr);
        add(text);
    }
    override function destroy(){
        for(obj in [spr, text]){
            obj.destroy();
            remove(obj);
            obj = null;
        }
        super.destroy();
    }
}