package;

import flixel.FlxSprite;
import flixel.math.FlxMath;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;

	public var noAaChars:Array<String> = [
		'dave-angey',
		'bambi-3d',
		'bf-pixel',
		'gf-pixel',
		'bambi-unfair',
		'expunged',
		'nofriend',
		'dave-festival-3d'
	];
	var char:String;
	var state:String;
	public var isPlayer:Bool;
	
	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	public function changeIcon(char:String)
	{
		if (this.char != char)
		{
			if (char != "none")
				loadGraphic(Paths.image('ui/iconGrid/' + char, 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "DaveOld")
				loadGraphic(Paths.image('icons/OldDave', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "Dave3D")
				loadGraphic(Paths.image('icons/3dDave', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "OldDave3D")
				loadGraphic(Paths.image('icons/3DOldDave', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "DaveDead")
				loadGraphic(Paths.image('icons/OldDave', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "BambiAethos")
				loadGraphic(Paths.image('icons/3dDave', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "ExpungedAethos")
				loadGraphic(Paths.image('icons/Expunged', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "OldExpunged")
				loadGraphic(Paths.image('icons/Oldpunged', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "MarcelloBambi")
				loadGraphic(Paths.image('icons/Marcello', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));
			if (char != "OGDave")
				loadGraphic(Paths.image('icons/DaveOG', 'preload'), true, 150, 150);
			else
				loadGraphic(Paths.image('blank', 'shared'));

			if (char != "none")
			{
				antialiasing = !noAaChars.contains(char);
				animation.add(char, [0, 1], 0, false, isPlayer);
				animation.play(char);
			}
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		offset.set(Std.int(FlxMath.bound(width - 150, 0)), Std.int(FlxMath.bound(height - 150, 0)));

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}
	public function changeState(charState:String)
	{
		switch (charState)
		{
			case 'normal':
				animation.curAnim.curFrame = 0;
			case 'losing':
				animation.curAnim.curFrame = 1;
		}
		state = charState;
	}
	public function getState()
	{
		return state;
	}
	public function getChar():String
	{
		return char;
	}
}
