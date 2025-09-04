package;

class Highscore{
	#if (haxe >= "4.0.0")
	public static var songScores:Map<String, Int> = new Map();
	public static var songAccs:Map<String, Dynamic> = new Map();
	#else
	public static var songScores:Map<String, Int> = new Map<String, Int>();
	public static var songAccs:Map<String, Dynamic> = new Map<String, Dynamic>();
	#end

	public static function formatSong(song:String, diff:Int):String{
		var da:String = song;
		if(diff <= 2) da += Difficulty.getPrefix(diff);
		else{
			switch(diff){
				case 3: da += '-erect';
			}
		}
		return da;
	}
	
	public static function load():Void{
		if (FlxG.save.data.songScores != null) songScores = FlxG.save.data.songScores;
		if (FlxG.save.data.songAccs != null) songAccs = FlxG.save.data.songAccs;
	}

	/* -------------------------------- SAVING SCORE --------------------------------*/
	public static function saveScore(song:String, score:Int = 0, ?diff:Int = 0):Void{
		var daSong:String = formatSong(song, diff);
		if(!FlxG.save.data.botplay){
			if (songScores.exists(daSong)){if (songScores.get(daSong) < score) setScore(daSong, score);}
			else setScore(daSong, score);
		}else trace('Botplay detected. Score saving is disabled.');
	}
	
	static function setScore(song:String, score:Int):Void{
		songScores.set(song, score);
		FlxG.save.data.songScores = songScores;
		FlxG.save.flush();
	}

	public static function getScore(song:String, diff:Int):Int{
		if (!songScores.exists(formatSong(song, diff))) setScore(formatSong(song, diff), 0);
		return songScores.get(formatSong(song, diff));
	}

	/* --------------------------------- SAVING ACCURACY ---------------------------------*/
	public static function saveAccs(song:String, acc:Float, ?diff:Int = 0):Void{
		var daSong:String = formatSong(song, diff);
		if(!FlxG.save.data.botplay){
			if (songAccs.exists(daSong)){if (songAccs.get(daSong) < acc) setAccs(daSong, acc);}
			else setAccs(daSong, acc);
		}else trace('Botplay detected. Score saving is disabled.');	
	}

	static function setAccs(song:String, acc:Float):Void{
		songAccs.set(song, acc);
		FlxG.save.data.songAccs = songAccs;
		FlxG.save.flush();
	}

	public static function getAccs(song:String, diff:Int):Int{
		if (!songAccs.exists(formatSong(song, diff))) setAccs(formatSong(song, diff), 0);
		return songAccs.get(formatSong(song, diff));
	}
}