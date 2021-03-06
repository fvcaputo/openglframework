#version 410

// Phong Illumination values
uniform vec4 ambient;
uniform vec4 diffuse;
uniform vec4 specular;
uniform float specExp;

// "in" values from vertex shader
in vec3 N;
in vec3 L;
in vec3 V;

// The position of the frag in light space
in vec4 posLightSpace;

// Shadow map for shadowing
uniform sampler2D shadowMap;

// out color
out vec4 fragColor;

float calculateShadow(vec4 posLightSpace, vec3 normal, vec3 lightDir) {
    // perspect divide, done automatically on gl_Position but not for this value
    vec3 projCoords = posLightSpace.xyz / posLightSpace.w; // normalize between [-1,1]
    projCoords = projCoords * 0.5 + 0.5; // normalize between [0,1] for the deapthmap

    float currentDepth = projCoords.z;
    float delta = max(0.05 * (1.0 - dot(normal, lightDir)), 0.005);

    float shadow = 0.0;
    vec2 texelSize = 1.0 / textureSize(shadowMap, 0);
    for(int x = -1; x <= 1; ++x) {
        for(int y = -1; y <= 1; ++y) {
            float closestDepth = texture(shadowMap, projCoords.xy + vec2(x,y) * texelSize).r;
            shadow += (currentDepth - delta > closestDepth) ? 1.0 : 0.0;
        }
    }

    //float closestDepth = texture(shadowMap, projCoords.xy).r;
    //float currentDepth = projCoords.z;
    return (shadow / 9);
}

void main () {
    vec3 nN = normalize(N);
    vec3 nL = normalize(L);
    vec3 nV = normalize(V);
    vec3 R = reflect(-nL,nN);

    vec4 ambientColor = ambient;
    vec4 diffuseColor = diffuse * max(dot(nN, nL), 0.0);
    vec4 specularColor = specular * pow(max(dot(R, nV),0.0),specExp);
    if(dot(nL, nN) < 0.0)
        specularColor = vec4(0.0,0.0,0.0,1.0);

    float shadow = calculateShadow(posLightSpace, nN, nL);

    fragColor = ambientColor + (1.0 - shadow) * (diffuseColor + specularColor);
    //fragColor = vec4(vec3(gl_FragCoord.z), 1.0);
}
