package;
import flixel.group.FlxGroup.FlxTypedGroup;
class LinksSubstate extends MusicBeatSubstate{
	var all:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();
    var bg:FlxSprite;
    var text:FlxText;
    var cur:Int = 0;
    var block:Bool = true;
    var links:Array<Array<String>> = [
        ['Outrageous Hijinks', 'https://gamebanana.com/mods/534267'],
        ['Escalated D-Side', 'https://gamebanana.com/mods/593183'],
        ['Bima Birthday Mod', 'https://gamebanana.com/mods/601295'],
        ['Twitter', 'https://x.com/FridayOutrage'],
        ['Friday Night Outrage Discord', 'https://discord.gg/VVay5uMexh'],
        ['Mods News Funkin [RUS]', 'https://discord.gg/DBEWPqZEZy']
    ];
    #if mobile
    var button:FlxSprite;
    #end

    public function new() super();
    override public function create(){
        bg = new FlxSprite().makeGraphic(1600, 730, FlxColor.BLACK);
        bg.screenCenter();
        bg.antialiasing = false;
        bg.alpha = 0;
        add(bg);
        FlxTween.tween(bg, {alpha: 0.5}, 0.5);

        text = new FlxText(0, 50, 0, LangUtil.translate("LINKS"));
        text.setFormat(Paths.font("tardling.ttf"), 60, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		text.borderSize = 4;
        text.antialiasing = FlxG.save.data.antialias;
        text.screenCenter(X);
        text.alpha = 0;
		add(text);
        FlxTween.tween(text, {alpha: 1}, 0.5, {onComplete:function(_){block = false;}});

        for(i in 0...links.length){
            var tx:FlxText = new FlxText(0, #if desktop 260 #else 190 #end, 0, links[i][0]);
            tx.setFormat(Paths.font("tardling.ttf"), #if desktop 60 #else 75 #end, 0xFF00FE9E, CENTER, OUTLINE, FlxColor.BLACK);
		    tx.borderSize = 4;
            tx.ID = i;
            tx.antialiasing = FlxG.save.data.antialias;
            tx.alpha = 0;
            tx.screenCenter(X);
            tx.y += tx.height * i;
		    all.add(tx);
            FlxTween.tween(tx, {alpha: 1}, 0.5);
        }
        add(all);
        change();

        #if mobile
        button = new FlxSprite().loadGraphic(Paths.image('mobile/exit_button'));
        button.x = FlxG.width - button.width;
        button.alpha = 0.5;
		add(button);
        #end
    	super.create();
    }

    override public function update(elapsed:Float){
        #if mobile touch = FlxG.touches.getFirst(); #end
        if(!block){
            #if desktop
            if(FlxG.keys.justPressed.ESCAPE || FlxG.keys.justPressed.BACKSPACE) close();
            if(FlxG.keys.justPressed.UP || FlxG.mouse.wheel > 0) change(-1);
            else if(FlxG.keys.justPressed.DOWN || FlxG.mouse.wheel < 0) change(1);
            if(FlxG.keys.justPressed.ENTER || FlxG.mouse.justPressed) select();
            #else
            touch = FlxG.touches.getFirst();
            if(touch != null && touch.justPressed && touch.overlaps(button)) close();
            #end
            for(tx in all.members){
                #if desktop
                if(FlxG.mouse.overlaps(tx)){
                    if(cur != tx.ID) FlxG.sound.play(Paths.sound('scrollMenu'));
                    cur = tx.ID;
                    change(0);
                }
                #else
                if(touch != null && touch.justPressed && touch.overlaps(tx)){
                    if(cur != tx.ID){
                        FlxG.sound.play(Paths.sound('scrollMenu'));
                        cur = tx.ID;
                        change(0);
                    }else select();
                }
                #end
            }
        }
    	super.update(elapsed);
    }

    function select() FlxG.openURL(links[cur][1]);
    function change(c:Int = 0){
        if(c != 0) FlxG.sound.play(Paths.sound('scrollMenu'));
        cur += c;
        if(cur > links.length - 1) cur = links.length - 1;
        else if (cur < 0) cur = 0;
        for(tx in all.members){
            if(cur == tx.ID){
                tx.color = 0xFFA6FFDD;
                tx.borderColor = 0xFF02DB88;
            }else{
                tx.color = 0xFF00FE9E;
                tx.borderColor = 0xFF00AB6A;
            }
        }
    }
}
