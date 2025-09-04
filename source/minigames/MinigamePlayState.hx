package minigames;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
using flixel.util.FlxSpriteUtil;
import minigames.*;
import shad.*;

class MinigamePlayState extends MusicBeatState
{
    var char:Player;
    var text:FlxText;
    var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
    var floor:FlxTilemap;
    var levelName:String = "";
    var charName:String = "";
    var charCol:FlxColor = 0xFFFFFFFF;
	var stepEvents:Array<StepEvent> = [];
    var crt:CRT = new CRT();
    var vig:Vignette = new Vignette();

    public function new(str:String, charstr:String, charCol:FlxColor){
        super();
        this.levelName = str;
        this.charName = charstr;
        this.charCol = charCol;
    }

    override function create(){
        FlxG.sound.playMusic(Paths.music('freakyMenuFucked'));
        Conductor.changeBPM(150);
        map = new FlxOgmo3Loader(Paths.getLevelThing('levelData/' + levelName + '.ogmo'), Paths.getLevelThing('levelData/' + levelName + '.json'));

        floor = map.loadTilemap(Paths.getLevelThing('tilemaps/minigame_env.png'), "floors");
		floor.follow();
        floor.setTileProperties(0, NONE);
        floor.setTileProperties(1, NONE);
		add(floor);

		walls = map.loadTilemap(Paths.getLevelThing('tilemaps/minigame_env.png'), "walls");
		walls.follow();
		walls.setTileProperties(1, ANY);
		add(walls);

        char = new Player(0, 0, charName, charCol);
        map.loadEntities(placeEntities, "entities");
        add(char);

        text = new FlxText(0, 0, "", 12);
		text.scrollFactor.set(0, 0);
		text.setFormat(Paths.font("LilitaOne-Regular.ttf"), 35, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.alpha = 0;
		add(text);


        if (FlxG.save.data.shaders){
            vig.set_strength(40.0);
			vig.set_reach(1.0);
            FlxG.camera.filters = [new ShaderFilter(crt), new ShaderFilter(vig)];
        }
        super.create();
        createEvents();
        FlxG.camera.follow(char, TOPDOWN, 1);
    }

    function placeEntities(entity:EntityData){
        var x = entity.x;
        var y = entity.y;
        switch (entity.name){
            case "char": char.setPosition(x, y);
        }
    }

    override function update(elapsed:Float){
        Conductor.songPosition = FlxG.sound.music.time;
        text.screenCenter();
        super.update(elapsed);
        FlxG.collide(char, walls);
        if(FlxG.keys.justPressed.ENTER || FlxG.keys.justPressed.SPACE) endGame();
        crt.upd(elapsed);
    }

    function endGame() FlxG.switchState(new MainMenuState());
    function createEvents(){
        switch (levelName){
            case 'human_becomes_char':
                makeEvent(100, function(){FlxG.sound.play(Paths.getLevelThing('audio/HTC.ogg'));});	
                makeEvent(400, function(){
                    FlxTween.tween(FlxG.camera, {zoom: 2}, 2, {onComplete:function(twn:FlxTween){
                        char.alpha = 0;
                        walls.alpha = 0;
                        FlxG.camera.zoom = 1;
                        text.text = LangUtil.translate("GO TO SLEEP LITTLE ONE.");
                        text.alpha = 1;
                    }});
                });	
                makeEvent(450, function(){text.text = LangUtil.translate("THIS WILL BE OVER SOON.");});
                makeEvent(500, function(){endGame();});
        }
    }

    override function stepHit(){
        if(stepEvents != null){
			for(event in stepEvents){
				if(event != null){
					if(curStep == event.step){
						trace("Eventing " + event.step);
						event.callback();
						stepEvents.remove(event);
					}
				}
			}
		}
        super.stepHit();
    }
    function makeEvent(step:Int, callback:Void -> Void){stepEvents.push(new StepEvent(step, callback));}
    function multipleEvents(steps:Array<Int>, callback:Void -> Void){for(i in 0...steps.length) stepEvents.push(new StepEvent(steps[i], callback));}
}