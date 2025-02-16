#pragma header
#iChannel0 "https://c.tenor.com/dvEfclGj0PEAAAAS/gaming2-the-men.gif"

uniform vec2 resolution;
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
    vec2 uv = gl_FragCoord.xy / iResolution.xy;

    vec4 col = crt(iChannel0, uv, resolution) + vec4(scanLines(uv));

    gl_FragColor = col;
}