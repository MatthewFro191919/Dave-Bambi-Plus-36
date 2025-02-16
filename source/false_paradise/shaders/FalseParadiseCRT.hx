package false_paradise.shaders;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxShader;

class FalseParadiseCRT
{
	public var shader(default, null):FalseParadiseCRTShader = new FalseParadiseCRTShader();

	public var time = 0.0;
	public var resolutionX:Float = 200;
	public var resolutionY:Float = 90;

	public function update()
	{
		shader.resolution.value = [resolutionX, resolutionY];
		shader.iTime.value = [time];
		time += FlxG.elapsed;
	}

	public function new():Void
	{
		update();
	}
}

class FalseParadiseCRTShader extends FlxShader
{
	@:glFragmentSource("
    #pragma header
    // \"CRT\" Shader by 4mbr0s3 2

    uniform vec2 resolution;
    uniform float iTime;
    vec4 crt(sampler2D s, vec2 uv, vec2 res) 
    {
        vec2 outUV = uv;
        outUV *= res;
        outUV = floor(outUV);
        outUV.x += tan(uv.y * 4. + iTime);
        outUV /= res;
        vec2 line = mix(fract(uv * res), vec2(1.), 0.8);
        vec4 outCol = texture2D(s, outUV);
        return vec4(outCol.rgb * line.y, outCol.a);
    }

    float scanLines(vec2 uv) {
        return sin(uv.y * 10. + iTime * 5.) * 0.2 + 0.3;
    }

    void main()
    {
        vec2 uv = openfl_TextureCoordv;

        vec4 col = crt(bitmap, uv, resolution) + vec4(scanLines(uv));

        gl_FragColor = col;
    }
    ")
	public function new()
	{
		super();
	}
}
