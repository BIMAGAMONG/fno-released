package options;
import flixel.FlxSubState;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import openfl.Lib;
import flash.system.System;
using StringTools;

class ClearSaveData extends MusicBeatSubstate{
    var blackBox:FlxSprite;
    var infoText:FlxText;
    var block:Bool = true;
    #if mobile
    var deny:FlxSprite;
    var accept:FlxSprite;
    #end

    public function new() super();
    override function create(){
        blackBox = new FlxSprite(0,0).makeGraphic(FlxG.width,FlxG.height,FlxColor.BLACK);
        blackBox.antialiasing = false;
        blackBox.alpha = 0;
        add(blackBox);

        infoText = new FlxText(-10, 580, 1280, getWarn(), 70);
		infoText.setFormat(Paths.font("LilitaOne-Regular.ttf"), 30, FlxColor.WHITE, FlxTextAlign.CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		infoText.borderSize = 2;
        infoText.alpha = 0;
        infoText.screenCenter();
        infoText.antialiasing = true;
        add(infoText);

        FlxTween.tween(infoText, {alpha: 1}, 1.2, {ease: FlxEase.expoInOut, onComplete: function(twn:FlxTween){block = false;}});
        FlxTween.tween(blackBox, {alpha: 0.7}, 1, {ease: FlxEase.expoInOut});
        #if mobile
        var daY:Float = infoText.y + infoText.height + 10;
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
            FlxTween.tween(it, {alpha: 0.5}, 1);
        }
        #end
        super.create();
    }

    function getWarn(){
        var s:String = switch(LangUtil.curLang){
            case 'eng': "Are you sure?\nAll of your progress will be wiped (except GameJolt achievements), this includes:\n- Anything you've unlocked so far\n- Your best score and accuracy for each song\n- Currency (Coins and Gems)\n- Your settings" #if desktop + "\n\nENTER - Reset save data (Game will close)\nESC - Exit (Keep your save data)"#end;
            case 'esp': "¿Estas seguro?\nSe borrara todo tu progreso (excepto los logros de GameJolt), Esto incluye:\n- Todo lo que hayas desbloqueado hasta ahora\n- Tu mejor puntuacion y exactitud en cada cancion\n- Moneda (monedas y gemas)\n- Tu configuracion" #if desktop + "\n\nENTRAR - Eliminar datos guardados (el juego se cerrara)\nESC - Salir (conservar tus datos guardados)"#end;
            case 'ita': "Sei sicuro?\nTutti i tuoi progressi saranno cancellati (eccetto i trofei di GameJolt), questo include:\n- Tutto cio che hai sbloccato fino ad adesso\n- Il tuo punteggio e la tua precisone migliori per ogni canzone\n- La valuta (Monete e Gemme)\n- Le tue impostazione" #if desktop + "\n\nINVIO - per resettare i dati (Il gioco si chiudera)\nESC - Esci (Mantieni i tuoi dati)"#end;
            case 'rus': "Вы уверены?\nВесь ваш прогресс будет стёрт (кроме достижений GameJolt), включая:\n- Все, что вы разблокировали на данный момент\n- Ваш лучший счет и точность для каждой песни\n- Валюта (монеты и гемы)\n- Ваши настройки" #if desktop + "\n\nENTER - Сбросить данные сохранения (игра закроется)\nESC - Выход (сохранить данные сохранения)"#end;
            case 'ptbr': "Você tem certeza?\nTodo o seu progresso será perdido (exceto as conquistas do GameJolt), isso inclui:\n- Tudo que você já desbloqueou até agora\n- A sua melhor pontuação e precisão pra cada música\n- Dinheiro (Moedas e Gemas)\n- Suas configurações" #if desktop + "\n\nENTER - Resetar dados do save (Jogo vai fechar)\nESC - Sair (Manter seus dados do save)"#end;
            default: "haxe, shut up";
        }
        return s;
    }

    override function update(elapsed:Float){
        if (!block){
            #if desktop
            if (FlxG.keys.justPressed.ENTER) picked(true);
            else if (FlxG.keys.justPressed.ESCAPE) picked(false);
            #else
            touch = FlxG.touches.getFirst();
            if(touch != null && touch.justPressed){
                if(touch.overlaps(accept)) picked(true);
                else if(touch.overlaps(deny)) picked(false);
            }
            #end
        }
        super.update(elapsed);
    }
    
    function picked(accepted:Bool){
        if(accepted){
            FlxG.save.erase();
            System.exit(0);
        }else{
            FlxG.sound.play(Paths.sound('cancelMenu'));
            FlxTween.tween(infoText, {alpha: 0}, 1.2, {ease: FlxEase.expoInOut, onComplete: function(twn:FlxTween){close();}});
            for(it in [blackBox #if mobile , deny, accept #end]) FlxTween.tween(it, {alpha: 0}, 1, {ease: FlxEase.expoInOut});
        }
    }
}