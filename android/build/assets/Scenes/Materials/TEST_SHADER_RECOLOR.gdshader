shader_type canvas_item;

// uniform shows a slider on the material interface so that you can see changes in real time
uniform float scale : hint_range(0.1, 10) = 2.0; 
uniform vec4 color : hint_color;
uniform float flashState : hint_range(0,1) = 0.5;

void fragment(){
	vec4 pixelColor = texture(TEXTURE, UV); //multiply UV * scale to scale the picture!
	float brightness = (pixelColor.r + pixelColor.g + pixelColor.b) / 3.0;
	vec4 greyScale = vec4(brightness, brightness, brightness, pixelColor.a);
	COLOR = pixelColor; // this assigns to each pixel its original color from the imported image
	// COLOR = greyScale * color; // RECOLORING: This turns image into greyscale and recolors it
	// COLOR = mix(pixelColor, color, flashState); // FLASHING ANIMATION
	// COLOR.a *= pixelColor.a; // FLASHING ANIMATION: Alpha Channel
	
	//SWIZZELING
	//COLOR.rgb = COLOR.gbr; //recolor!
	

}