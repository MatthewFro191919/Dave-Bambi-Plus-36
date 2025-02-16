package false_paradise.shaders;

import flixel.FlxG;
import flixel.system.FlxAssets.FlxShader;

class FalseParadiseGlitchy
{
	public var shader(default, null):FalseParadiseGlitchyShader = new FalseParadiseGlitchyShader();

	public var time = 0.0;
	public var chromaticAberration = 0.01;

	public function update()
	{
		shader.iTime.value = [time];
		shader.chromaticAberration.value = [chromaticAberration];

		time += FlxG.elapsed;
	}

	public function new():Void
	{
		update();
	}
}

class FalseParadiseGlitchyShader extends FlxShader
{
	@:glFragmentSource("
    #pragma header
    uniform float chromaticAberration;
    uniform float iTime;

    float rand(vec2 n) { 
        return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
    }

    float noise(vec2 p){
        vec2 ip = floor(p);
        vec2 u = fract(p);
        u = u*u*(3.0-2.0*u);
        
        float res = mix(
            mix(rand(ip),rand(ip+vec2(1.0,0.0)),u.x),
            mix(rand(ip+vec2(0.0,1.0)),rand(ip+vec2(1.0,1.0)),u.x),u.y);
        return res*res;
    }

    void main()
    {
        vec2 uv = openfl_TextureCoordv;

        float time = iTime * 20.;
        float noise = noise(vec2(time) + uv * 5.) * chromaticAberration * 100.;
        vec2 rDir = vec2(chromaticAberration * noise, 0);
        vec2 gDir = vec2(-chromaticAberration * noise, 0);
        vec2 bDir = vec2(0, chromaticAberration * noise);
        float colR = texture2D(bitmap, uv + rDir).r;
        float colG = texture2D(bitmap, uv + gDir).g;
        float colB = texture2D(bitmap, uv + bDir).b;
        float colA = texture2D(bitmap, uv + rDir).a;

        gl_FragColor = vec4(colR, colG, colB, colA);
    }
    ")
	public function new()
	{
		super();
	}
}
