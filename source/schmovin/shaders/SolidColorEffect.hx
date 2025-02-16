package schmovin.shaders;

import flixel.system.FlxAssets.FlxShader;

class SolidColorEffect
{
	public var shader:SolidColorShader;

	public function new(r:Float, g:Float, b:Float, a:Float)
	{
		shader = new SolidColorShader();
		shader.rClr.value = [r];
		shader.gClr.value = [g];
		shader.bClr.value = [b];
		shader.aClr.value = [a];
	}
}

class SolidColorShader extends FlxShader
{
	@:glFragmentSource('
		#pragma header

		uniform float rClr  = 0.2;
		uniform float gClr  = 0.1;
		uniform float bClr  = 0.3;
		uniform float aClr  = 0;

		void main()
		{
			vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);
			gl_FragColor = vec4(rClr * color.a, gClr * color.a, bClr * color.a, aClr * color.a);
		}')
	public function new()
	{
		super();
	}
}
