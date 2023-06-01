shader_type canvas_item;

void fragment(){
	vec2 distortedUV = SCREEN_UV + texture(TEXTURE, UV).r * 0.05; // distorsion based on this texture's red value
	vec4 screenColor = texture(SCREEN_TEXTURE, distortedUV);
	COLOR = screenColor;
	
}