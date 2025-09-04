package flixel.system.ui;

#if FLX_SOUND_SYSTEM
import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;

@:allow(flixel.system.frontEnds.SoundFrontEnd)
class FlxSoundTray extends Sprite{
	public var active:Bool;
	var _bg:Bitmap;
	var backBar:Bitmap;
	var _timer:Float;
	var _bars:Array<Bitmap>;
	var _minWidth:Int = 80;
	var _defaultScale:Float = 0.7;
	public var volumeUpSound:FlxSoundAsset = Paths.sound("soundtray/VolUp");
	public var volumeDownSound:FlxSoundAsset = Paths.sound("soundtray/VolDown");
	public var volumeMaxSound:FlxSoundAsset = Paths.sound("blocked");
	public var silent:Bool = false;
	var alphaTarget:Float = 0;
	@:keep
	public function new(){
		super();
		visible = false;
		scaleX = _defaultScale;
		scaleY = _defaultScale;

		_bg = new Bitmap(Assets.getBitmapData(Paths.image("soundtray/volumebox")));
		screenCenter();
		addChild(_bg);

		backBar = new Bitmap(Assets.getBitmapData(Paths.image("soundtray/bars_10")));
		backBar.alpha = 0.5;
		screenCenter();
		addChild(backBar);

		_bars = new Array();
		var tmp:Bitmap;
		for (i in 0...10){
			tmp = new Bitmap(Assets.getBitmapData(Paths.image("soundtray/bars_" + (i + 1))));
			addChild(tmp);
			_bars.push(tmp);
		}
		updateSize();
		y = -height;
		visible = false;
	}

	public function update(MS:Float):Void{
		alpha = smoothLerpPrecision(alpha, alphaTarget, MS / 1000, 0.307);
		if (_timer > 0) _timer -= (MS / 1000);
		else if (y > -height){
			alphaTarget = 0.0;
			y -= (MS / 1000) * height * 0.5;
			if (y <= -height){
				visible = false;
				active = false;
				FlxG.save.data.mute = FlxG.sound.muted;
				FlxG.save.data.volume = FlxG.sound.volume;
				FlxG.save.flush();
			}
		}
	}
	
	public function showAnim(volume:Float, ?sound:FlxSoundAsset, duration = 1.0){
		alphaTarget = 1.0;
		var globalVolume:Int = Math.round(FlxG.sound.volume * 10);
		if (sound != null){
			if (globalVolume == 10) sound = volumeMaxSound;
			FlxG.sound.play(FlxG.assets.getSoundAddExt(sound));
		}
		_timer = duration;
		y = 0;
		visible = true;
		active = true;
		final numBars = Math.round(volume * 10);
		for (i in 0..._bars.length) _bars[i].alpha = i < numBars ? 1.0 : 0.0;
		updateSize();
	}
	
	public function show(up:Bool = false):Void{
		if (up) showIncrement();
		else showDecrement();
	}
	
	function showIncrement():Void{
		final volume = FlxG.sound.muted ? 0 : FlxG.sound.volume;
		showAnim(volume, silent ? null : volumeUpSound);
	}
	
	function showDecrement():Void{
		final volume = FlxG.sound.muted ? 0 : FlxG.sound.volume;
		showAnim(volume, silent ? null : volumeDownSound);
	}
	
	public function screenCenter():Void{
		scaleX = _defaultScale;
		scaleY = _defaultScale;
		x = (0.5 * (Lib.current.stage.stageWidth - _bg.width * _defaultScale) - FlxG.game.x);
	}
	
	function updateSize(){
		for (i in 0..._bars.length){
			_bars[i].x = (_bg.width / 2) - (_bars[i].width / 2);
			_bars[i].y = 17;
		}
		backBar.x = _bars[0].x;
		backBar.y = 17;
		screenCenter();
	}

	public static function smoothLerpPrecision(base:Float, target:Float, deltaTime:Float, duration:Float, precision:Float = 1 / 100):Float{
    	if (deltaTime == 0) return base;
    	if (base == target) return target;
    	return lerp(target, base, Math.pow(precision, deltaTime / duration));
  	}

	public static function lerp(base:Float, target:Float, alpha:Float):Float{
    	if (alpha == 0) return base;
    	if (alpha == 1) return target;
    	return base + alpha * (target - base);
  	}
}
#end