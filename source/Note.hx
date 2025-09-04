package;
import flixel.addons.effects.FlxSkewedSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxMath;
#if polymod
import polymod.format.ParseRules.TargetSignatureElement;
#end
import PlayState;
using StringTools;

class Note extends FlxSprite{
	public var strumTime:Float = 0;
	public var mustPress:Bool = false;
	public var noteData:Int = 0;
	public var canBeHit:Bool = false;
	public var tooLate:Bool = false;
	public var wasGoodHit:Bool = false;
	public var prevNote:Note;
	public var modifiedByLua:Bool = false;
	public var sustainLength:Float = 0;
	public var isSustainNote:Bool = false;
	public var noteScore:Float = 1;
	public var noteStyle:String = 'normal';
	public static var swagWidth:Float = 112;
	public var rating:String = "shit";

	public function new(strumTime:Float, noteData:Int, ?prevNote:Note, ?sustainNote:Bool = false, noteStyle:String = 'normal'){
		super();
		if (prevNote == null) prevNote = this;
		this.prevNote = prevNote;
		isSustainNote = sustainNote;
		this.noteStyle = noteStyle;
		x += 50;
		y -= 2000;
		this.strumTime = strumTime;
		if (this.strumTime < 0 ) this.strumTime = 0;
		this.noteData = noteData;

		#if mobile if(this.sustainLength > 100) this.sustainLength -= 100; #end

		var daStage:String = PlayState.curStage;
		switch (PlayState.SONG.noteStyle){		
			default:
				frames = Paths.getSparrowAtlas('NOTE_assets');
				animation.addByPrefix('greenScroll', 'green0');
				animation.addByPrefix('redScroll', 'red0');
				animation.addByPrefix('blueScroll', 'blue0');
				animation.addByPrefix('purpleScroll', 'purple0');
				animation.addByPrefix('purpleholdend', 'pruple end hold');
				animation.addByPrefix('greenholdend', 'green hold end');
				animation.addByPrefix('redholdend', 'red hold end');
				animation.addByPrefix('blueholdend', 'blue hold end');
				animation.addByPrefix('purplehold', 'purple hold piece');
				animation.addByPrefix('greenhold', 'green hold piece');
				animation.addByPrefix('redhold', 'red hold piece');
				animation.addByPrefix('bluehold', 'blue hold piece');
				setGraphicSize(Std.int(width * #if desktop 0.7 #else 0.75 #end));
				updateHitbox();
		}

		switch (noteData){
			case 0:
				x += swagWidth * 0;
				animation.play('purpleScroll');
			case 1:
				x += swagWidth * 1;
				animation.play('blueScroll');
			case 2:
				x += swagWidth * 2;
				animation.play('greenScroll');
			case 3:
				x += swagWidth * 3;
				animation.play('redScroll');
		}

		if (FlxG.save.data.downscroll && sustainNote){
			flipY = true;
			y += 150;
		}

		if (isSustainNote && prevNote != null){
			noteScore * 0.2;
			switch (noteData){
				case 2: animation.play('greenholdend');
				case 3: animation.play('redholdend');
				case 1: animation.play('blueholdend');
				case 0: animation.play('purpleholdend');
			}

			x += width / 2;
			updateHitbox();
			x -= width / 2;

			if (prevNote.isSustainNote){
				switch (prevNote.noteData){
					case 0: prevNote.animation.play('purplehold');
					case 1: prevNote.animation.play('bluehold');
					case 2: prevNote.animation.play('greenhold');
					case 3: prevNote.animation.play('redhold');
				}

				if (!FlxG.save.data.downscroll) prevNote.scale.y *= Conductor.stepCrochet / 100 * 1 + 1;
				else prevNote.scale.y *= Conductor.stepCrochet / 100 * 1 + 1;
				prevNote.updateHitbox();
			}
		}
		antialiasing = false;
	}

	override function update(elapsed:Float){
		super.update(elapsed);
		if (mustPress){
			if (isSustainNote){
				if (strumTime > Conductor.songPosition - (Conductor.safeZoneOffset * 1.5)&& strumTime < Conductor.songPosition + (Conductor.safeZoneOffset * 0.5)) canBeHit = true;
				else canBeHit = false;
			}else{
				if (strumTime > Conductor.songPosition - Conductor.safeZoneOffset&& strumTime < Conductor.songPosition + Conductor.safeZoneOffset) canBeHit = true;
				else canBeHit = false;
			}

			if (strumTime < Conductor.songPosition - Conductor.safeZoneOffset * Conductor.timeScale && !wasGoodHit) tooLate = true;
		}else{
			canBeHit = false;
			if (strumTime <= Conductor.songPosition) wasGoodHit = true;
		}

		if (tooLate) if (alpha > 0.3) alpha = 0.3;
	}
}