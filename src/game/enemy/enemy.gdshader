shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform sampler2D palette;
void fragment() {
	if (abs(COLOR.a - 0.0) > 0.0001) {
		int index = int((COLOR.r * 255.0));
		ivec2 coords = ivec2(index, 0);
		COLOR = texelFetch(palette, coords, 0);
	}
	// Called for every pixel the material is visible on.
	// vec4 new_color = COLOR;
	// new_color.r = hard_light(shade.r, COLOR.r);
	// new_color.g = hard_light(shade.g, COLOR.g);
	// new_color.b = hard_light(shade.b, COLOR.b);

	// COLOR = new_color;
}


//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
