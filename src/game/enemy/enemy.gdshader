shader_type canvas_item;

float hard_light(float a, float b) {
	if (b < 0.5) {
		return 2.0f * a * b;
	} else {
		return 1.0f - 2.0f * (1.0f - a) * (1.0f - b);
	}
}

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform vec4 shade;
void fragment() {
	// Called for every pixel the material is visible on.
	vec4 new_color = COLOR;
	new_color.r = hard_light(shade.r, COLOR.r);
	new_color.g = hard_light(shade.g, COLOR.g);
	new_color.b = hard_light(shade.b, COLOR.b);

	COLOR = new_color;
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
