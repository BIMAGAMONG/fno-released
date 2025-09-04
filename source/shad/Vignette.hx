package shad;
class Vignette extends FlxShader
{
    public var strength(get, set):Float;
    public var reach(get, set):Float;
    @:glFragmentSource('
        #pragma header
        
        uniform float uStrength;
        uniform float uReach;
        
        void main(){
            vec2 uv = openfl_TextureCoordv;
            
            uv *= 1.0 - uv.yx;// uv *= vec2(1.0, 1.0) - uv.yx;
            
            float vignette = uv.x*uv.y * uStrength;
            vignette = pow(vignette, uReach);
            
            vec4 color = texture2D(bitmap, openfl_TextureCoordv);
            color.rgb *= vignette;
            
            gl_FragColor = color;
        }
    ')
    
    public function new(strength = 15.0, reach = 0.25){
      super();
      this.strength = strength;
      this.reach = reach;
    }
    
    inline function get_strength() return this.uStrength.value[0];
    inline public function set_strength(value:Float){
      this.uStrength.value = [value];
      return value;
    }
    
    inline function get_reach() return this.uReach.value[0];
    inline public function set_reach(value:Float){
      this.uReach.value = [value];
      return value;
    }
}