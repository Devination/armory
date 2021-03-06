// Exclusive to volumetric light for now
#version 450

#include "compiled.inc"

uniform sampler2D tex;
uniform vec2 dir;
uniform vec2 screenSize;

in vec2 texCoord;
out vec4 fragColor;

const float weight[10] = float[] (0.132572, 0.125472, 0.106373, 0.08078, 0.05495, 0.033482, 0.018275, 0.008934, 0.003912, 0.001535);

float normpdf(float x, float sigma) {
	return 0.39894 * exp(-0.5 * x * x / (sigma * sigma)) / sigma;
}

float normpdf3(vec3 v, float sigma) {
	return 0.39894 * exp(-0.5 * dot(v, v) / (sigma * sigma)) / sigma;
}

void main() {
	vec2 step = (dir / screenSize.xy);
	vec3 colf = texture(tex, texCoord).rgb * weight[0];

	float col;
	float res;
	float sumfactor = 0.0;
	float factor;
	float f = 1.0 / normpdf(0.0, 1.0);

	col = texture(tex, texCoord + step).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[1];
	sumfactor += factor;
	res = factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[1];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord + step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[2];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[2];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord + step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[3];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[3];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord + step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[4];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[4];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord + step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[5];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[5];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord + step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[6];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[6];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord + step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[7];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[7];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord + step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[8];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[8];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord + step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[9];
	sumfactor += factor;
	res += factor * col;

	col = texture(tex, texCoord - step * 1.5).r;
	factor = normpdf3(col - colf, 1.0) * f * weight[9];
	sumfactor += factor;
	res += factor * col;

	res /= sumfactor;
	fragColor = vec4(volumAirColor * res, 1.0);
}
