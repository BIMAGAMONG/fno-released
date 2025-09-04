package;
import flixel.FlxSubState;
import lime.app.Application;
import options.*;

class OutdatedSubState extends MusicBeatState{
	var leftState:Bool = false;
	var lang:FlxText;
	var txt:FlxText;

	override function create(){
		super.create();
		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('week54prototype', 'shared'));
		bg.scale.x *= 1.55;
		bg.scale.y *= 1.55;
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.antialias;
		bg.alpha = 0.8;
		add(bg);
		
		txt = new FlxText(0, 0, FlxG.width, "",32);
		txt.setFormat(Paths.font("LilitaOne-Regular.ttf"), 30, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		txt.borderSize = 3;
		txt.screenCenter();
		txt.y += 50;
		add(txt);

		lang = new FlxText(0, 0, FlxG.width, "" , 32);
		lang.setFormat(Paths.font("LilitaOne-Regular.ttf"), 40, FlxColor.WHITE, CENTER, OUTLINE, FlxColor.BLACK);
		lang.borderSize = 3;
		lang.screenCenter();
		lang.y -= 100;
		add(lang);
	}

	override function update(elapsed:Float){
		if(!leftState){
			if (FlxG.keys.justPressed.ENTER) pressed(false);
			if (FlxG.keys.justPressed.CONTROL) pressed(true);
			if(FlxG.keys.justPressed.SPACE) chng();
		}
		super.update(elapsed);
		lang.text = LangUtil.translate('Language') + ': ' + KadeEngineData.languages[FlxG.save.data.lang].toUpperCase() + ' (${LangUtil.translate('SPACE')})';
		txt.text = getGreeting();
	}

	function pressed(b:Bool){
		leftState = true;
		FlxG.sound.play(Paths.sound('confirmMenu'));
		FlxG.save.data.secTime = false;
		FlxG.save.flush();
		if(b) FlxG.switchState(new OutrageOptions());
		else FlxG.switchState(new MainMenuState());
	}

	function getGreeting(){
		var s:String = switch(LangUtil.curLang){
			case 'eng': 'Thanks for playing! It is recommended open the options menu first to set up eveything!\n\nCTRL - Options\nENTER - Ignore';
			case 'esp': "¡Gracias por jugar! Se recomienda abrir primero el menú de opciones para configurar todo.\n\nCTRL - Opciones\nENTRAR - Ignorar";
            case 'ita': "Grazie per aver giocato! Si consiglia di aprire prima il menu delle opzioni per impostare tutto!\n\nCTRL - Opzioni\nINVIO - Ignora";
            case 'rus': "Спасибо за Игру! Рекомендуется открыть настройки перед игрой для подготовки.\n\nCTRL - Настройки\nВВОД - Пропустить";
            case 'ptbr': "Obrigado por jogar! E recomendado abrir o menu de opções pra ajustar tudo!\n\nCTRL - Opções\nENTER - Ignorar";
			default: "haxe shut up with the error";
		}
		return s;
	}

	function chng(){
		FlxG.sound.play(Paths.sound('scrollMenu'));
		FlxG.save.data.lang += 1;
		if (FlxG.save.data.lang > KadeEngineData.languages.length - 1) FlxG.save.data.lang = 0;
		LangUtil.curLang = KadeEngineData.languages[FlxG.save.data.lang];
		txt.screenCenter(X);
		lang.screenCenter(X);
	}
}
