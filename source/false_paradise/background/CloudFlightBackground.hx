package false_paradise.background;

import false_paradise.shaders.CloudFlight;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

class CloudFlightBackground extends FlxSprite
{
	private var _shader:CloudFlight;

	override public function new(showShader:Bool)
	{
		super();
		makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
		if (showShader)
		{
			_shader = new CloudFlight(this);
			shader = _shader.shader;
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		if (_shader != null)
			_shader.update(elapsed);
	}
}
