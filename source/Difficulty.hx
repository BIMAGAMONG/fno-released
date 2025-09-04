package;
import flixel.math.FlxMath;

class Difficulty{
    static var diff:Array<Array<Dynamic>> = [];
    public static function init(){
        diff = [[LangUtil.translate("NORMAL"), FlxColor.YELLOW, ''],
        [LangUtil.translate("OUTRAGEOUS"), 0xFF00FE9E, '-outrageous']];
    }
    public static function getDiff(i:Int) return diff[i][0];
    public static function getColor(i:Int) return diff[i][1];
    public static function getPrefix(i:Int) return diff[i][2];
    public static function wrap(sub:Int, c:Int) return FlxMath.wrap(sub + c, 0, diff.length - 1);
}