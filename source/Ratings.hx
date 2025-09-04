class Ratings{
    public static function GenerateLetterRank(accuracy:Float){
        var ranking:String = "N/A";

        if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods == 0) ranking = "Perfect";
        else if (PlayState.misses == 0 && PlayState.bads == 0 && PlayState.shits == 0 && PlayState.goods >= 1) ranking = "Good FC";
        else if (PlayState.misses == 0) ranking = "FC";
        else if (PlayState.misses < 10) ranking = "Good Clear";
        else ranking = "Clear";

        if (accuracy == 0 || FlxG.save.data.botplay) ranking = "N/A";
        return LangUtil.translate(ranking);
    }
    
    public static function CalculateRating(noteDiff:Float, ?customSafeZone:Float):String{
        var customTimeScale = Conductor.timeScale;
        if (customSafeZone != null) customTimeScale = customSafeZone / 166;
	    if (FlxG.save.data.botplay) return "sick";
        if (noteDiff > 166 * customTimeScale) return "miss";
        if (noteDiff > 135 * customTimeScale) return "shit";
        else if (noteDiff > 90 * customTimeScale) return "bad";
        else if (noteDiff > 45 * customTimeScale) return "good";
        else if (noteDiff < -45 * customTimeScale) return "good";
        else if (noteDiff < -90 * customTimeScale) return "bad";
        else if (noteDiff < -135 * customTimeScale) return "shit";
        else if (noteDiff < -166 * customTimeScale) return "miss";
        return "sick";
    }

    public static function CalculateRanking(score:Int,accuracy:Float):String{
        var str:String = "";
        var scr:String = LangUtil.translate('Score');
        var acc:String = LangUtil.translate('Accuracy');
        str = scr + ": " + score +  " | " + LangUtil.translate('Misses') + ": " + PlayState.misses + " | " + acc + ": " + (FlxG.save.data.botplay ? "-" : CoolUtil.truncateFloat(accuracy, 2) + " %") + " | " + GenerateLetterRank(accuracy);
        return (!FlxG.save.data.botplay ? str : ""); 
    }
}