shader_type canvas_item;
uniform float size = 0.0;
void fragment() {
	COLOR = vec4(COLOR.r,COLOR.g,COLOR.b,abs(UV.y-0.5)*2.0*size+abs(UV.x-0.5)*0.1*size*size);
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
