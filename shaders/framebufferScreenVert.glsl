#version 410

// in values
in vec2 vPosition;
in vec2 vTexCoord;

// out values
out vec2 uvTexCoord;

int main() {
    gl_Position = vec4(vPosition.x, vPosition.y, 0.0, 0.0);
    uvTexCoord = vTexCoord;
}