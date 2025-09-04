package;
import openfl.utils.Assets as OpenFlAssets;
using StringTools;

// CODE FROM PSYCH ENGINE, OBV I EDITED IT FOR THIS MOD
class HealthIcon extends FlxSprite{
	public var isPlayer:Bool = false;
	private var char:String = '';

	public function new(char:String = 'bf', isPlayer:Bool = false){
		super();
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	private var iconOffsets:Array<Float> = [0, 0];
	public function changeIcon(char:String) {
		if(this.char != char) {
			var name:String = 'icons/icon-';
            switch (char){
				case 'lowmealt': name += 'lowme';
				case 'sakuraRage' | 'transform': name += 'sakuraRage';
				case 'bfshiz' | 'bf-atari': name += 'bf';
				case 'gf' | 'gfnospeaker': name += 'gf';
				default: name += char;
			}
			if (#if desktop !FileSystem.exists(Paths.image(name)) #else !Assets.exists(Paths.image(name)) #end) name = 'icons/icon-noexist';			

			var file:Dynamic = Paths.image(name);
			loadGraphic(file);
			loadGraphic(file, true, Math.floor(width / 3), Math.floor(height));
			iconOffsets[0] = (width - 150) / 3;
			iconOffsets[1] = (width - 150) / 3;
			updateHitbox();
			animation.add(char, [0, 1, 2], 0, false, isPlayer);
			animation.play(char);
			this.char = char;
			switch (char) {
				case 'maro' | 'bfSMBW': antialiasing = false;
				default: antialiasing = FlxG.save.data.antialias;
			}
		}
	}
	public function getCharacter():String return char;
	override function updateHitbox(){
		super.updateHitbox();
		offset.x = iconOffsets[0];
		offset.y = iconOffsets[1];
	}
}
