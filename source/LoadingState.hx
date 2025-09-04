package;

import lime.app.Promise;
import lime.app.Future;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
import flixel.addons.transition.FlxTransitionableState;
import lime.utils.Assets as LimeAssets;
import lime.utils.AssetLibrary;
import lime.utils.AssetManifest;
import haxe.io.Path;

class LoadingState extends MusicBeatState{
	inline static var MIN_TIME = 1.0;
	var target:FlxState;
	var stopMusic = false;
	var callbacks:MultiCallback;
	var categoryRandomizer:Int = FlxG.random.int(1, 3);
	var quoteRandomizer:Int = FlxG.random.int(0, 5);
	public static var invisible:Bool = false;
	var something:Array<String> = LangUtil.getSomething();
	var funfact:Array<String> = LangUtil.getFunFact();
	var protip:Array<String> = LangUtil.getProTip();
	var targetShit:Float = 0;

	function new(target:FlxState, stopMusic:Bool){
		super();
		this.target = target;
		this.stopMusic = stopMusic;
	}

	var facts:FlxSprite;
	var loadingSprite:FlxSprite = null;
	var factTXT:FlxText;
	var categoryTXT:FlxText;
	var specialLoading:FlxSprite = null;
	var DA_TIME:Int = 6;

	override function create(){
		loadingSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('loading/bg${FlxG.random.int(1, 5)}'));
		loadingSprite.antialiasing = FlxG.save.data.antialias;
		loadingSprite.screenCenter();	
		add(loadingSprite);	

		facts = new FlxSprite(0, 0);
		facts.makeGraphic(FlxG.width + 10, 300, FlxColor.BLACK);
		facts.screenCenter();
		facts.y += 300;
		facts.alpha = 0.7;
		facts.antialiasing = false;
		add(facts);

		factTXT = new FlxText(facts.x, facts.y + 50, 1100, 'insert something here lol');
        factTXT.setFormat(Paths.font("LilitaOne-Regular.ttf"), 35, FlxColor.WHITE, CENTER);
		factTXT.screenCenter(X);
		factTXT.antialiasing = FlxG.save.data.antialias;
        add(factTXT);

		categoryTXT = new FlxText(facts.x, factTXT.y - 50, 0, 'SOMETHING');
        categoryTXT.setFormat(Paths.font("LilitaOne-Regular.ttf"), 35, FlxColor.WHITE, CENTER);
	    categoryTXT.screenCenter(X);
		categoryTXT.antialiasing = FlxG.save.data.antialias;
        add(categoryTXT);

		switch (categoryRandomizer) {
			case 1:
                categoryTXT.text = 'SOMETHING';
				categoryTXT.color = FlxColor.RED;
				quoteRandomizer = FlxG.random.int(0, something.length - 1);
				factTXT.text = something[quoteRandomizer];
			case 2:
				categoryTXT.text = 'PRO TIP';
				categoryTXT.color = FlxColor.BLUE;
				quoteRandomizer = FlxG.random.int(0, protip.length - 1);
				factTXT.text = protip[quoteRandomizer];
			case 3:
				categoryTXT.text = 'FUN FACT';
				categoryTXT.color = FlxColor.YELLOW;	
				quoteRandomizer = FlxG.random.int(0, funfact.length - 1);
				factTXT.text = funfact[quoteRandomizer];
		}
		categoryTXT.text = LangUtil.translate(categoryTXT.text);
		
		switch (factTXT.text){
			case 'sticky':
				specialLoading = new FlxSprite().loadGraphic(Paths.codeShitImage('stickyloading'));
				specialLoading.scale.set(1.3, 0.1);
				specialLoading.screenCenter();
				specialLoading.y += 300;
				specialLoading.antialiasing = false;
				add(specialLoading);
		}
		categoryTXT.screenCenter(X);
		factTXT.screenCenter(X);

		if (invisible){
			FlxG.camera.alpha = 0;
			DA_TIME = 0;
			invisible = false;
		}
		
		initSongsManifest().onComplete(function (lib){
			callbacks = new MultiCallback(onLoad);
			var introComplete = callbacks.add("introComplete");
			checkLoadSong(getSongPath());
			if (PlayState.SONG.needsVoices) checkLoadSong(getVocalPath());
			checkLibrary("shared");			
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			new FlxTimer().start(MIN_TIME + DA_TIME, function(_){
				for(spr in [categoryTXT, factTXT, specialLoading, loadingSprite, facts]){
					if(spr != null){
            			spr.destroy();
           				remove(spr);
           				spr = null;
					}
				} 
				introComplete();
			});
		});
	}
	
	function checkLoadSong(path:String){
		if (!Assets.cache.hasSound(path)){
			var library = Assets.getLibrary("songs");
			final symbolPath = path.split(":").pop();
			var callback = callbacks.add("song:" + path);
			Assets.loadSound(path).onComplete(function (_) { callback(); });
		}
	}
	
	function checkLibrary(library:String){
		if (Assets.getLibrary(library) == null){
			@:privateAccess
			if (!LimeAssets.libraryPaths.exists(library)) throw "Missing library: " + library;
			var callback = callbacks.add("library:" + library);
			Assets.loadLibrary(library).onComplete(function (_) { callback(); });
		}
	}
	
	override function update(elapsed:Float){
		super.update(elapsed);
		if(callbacks != null) targetShit = FlxMath.remapToRange(callbacks.numRemaining / callbacks.length, 1, 0, 0, 1);
	}
	
	function onLoad(){
		if (stopMusic && FlxG.sound.music != null) FlxG.sound.music.stop();
		FlxG.switchState(target);
	}
	
	static function getSongPath() return Paths.inst(PlayState.SONG.song);
	static function getVocalPath() return Paths.voices(PlayState.SONG.song);
	inline static public function loadAndSwitchState(target:FlxState, stopMusic = false){
		FlxTransitionableState.skipNextTransIn = true;
		FlxTransitionableState.skipNextTransOut = true;
		FlxG.switchState(getNextState(target, stopMusic));
	}
	
	static function getNextState(target:FlxState, stopMusic = false):FlxState{
		Paths.setCurrentLevel("week" + PlayState.storyWeek);
		var loaded = isSoundLoaded(getSongPath()) && (!PlayState.SONG.needsVoices || isSoundLoaded(getVocalPath())) && isLibraryLoaded("shared");
		if (!loaded) return new LoadingState(target, stopMusic);
		if (stopMusic && FlxG.sound.music != null) FlxG.sound.music.stop();
		return target;
	}
	
	static function isSoundLoaded(path:String):Bool return Assets.cache.hasSound(path);
	static function isLibraryLoaded(library:String):Bool return Assets.getLibrary(library) != null;
	override function destroy(){
		super.destroy();
		callbacks = null;
	}
	
	static function initSongsManifest(){
		var id = "songs";
		var promise = new Promise<AssetLibrary>();
		var library = LimeAssets.getLibrary(id);
		if (library != null) return Future.withValue(library);

		var path = id;
		var rootPath = null;
		@:privateAccess
		var libraryPaths = LimeAssets.libraryPaths;
		if (libraryPaths.exists(id)){
			path = libraryPaths[id];
			rootPath = Path.directory(path);
		}else{
			if (StringTools.endsWith(path, ".bundle")){
				rootPath = path;
				path += "/library.json";
			}else rootPath = Path.directory(path);
			@:privateAccess
			path = LimeAssets.__cacheBreak(path);
		}

		AssetManifest.loadFromFile(path, rootPath).onComplete(function(manifest){
			if (manifest == null){
				promise.error("Cannot parse asset manifest for library \"" + id + "\"");
				return;
			}
			var library = AssetLibrary.fromManifest(manifest);
			if (library == null){
				promise.error("Cannot open library \"" + id + "\"");
			}else{
				@:privateAccess
				LimeAssets.libraries.set(id, library);
				library.onChange.add(LimeAssets.onChange.dispatch);
				promise.completeWith(Future.withValue(library));
			}
		}).onError(function(_){promise.error("There is no asset library with an ID of \"" + id + "\"");});
		return promise.future;
	}
}

class MultiCallback{
	public var callback:Void->Void;
	public var logId:String = null;
	public var length(default, null) = 0;
	public var numRemaining(default, null) = 0;
	var unfired = new Map<String, Void->Void>();
	var fired = new Array<String>();
	
	public function new (callback:Void->Void, logId:String = null){
		this.callback = callback;
		this.logId = logId;
	}
	
	public function add(id = "untitled"){
		id = '$length:$id';
		length++;
		numRemaining++;
		var func:Void->Void = null;
		func = function (){
			if (unfired.exists(id)){
				unfired.remove(id);
				fired.push(id);
				numRemaining--;

				if (logId != null) log('fired $id, $numRemaining remaining');
				if (numRemaining == 0){
					if (logId != null) log('all callbacks fired');
					callback();
				}
			}
			else log('already fired $id');
		}
		unfired[id] = func;
		return func;
	}
	
	inline function log(msg):Void{
		if (logId != null) trace('$logId: $msg');
	}
	public function getFired() return fired.copy();
	public function getUnfired() return [for (id in unfired.keys()) id];
}