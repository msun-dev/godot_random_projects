# donker

Small project where i animated a model and made video out of it.

This model is the first one that i made using blockbench.

## Random things

### Point of origin:

1st thing: i misplaced point of origin in blockbench.

2nd thing: godot does not allow you to change it in editor.

So my idea was to make model a child of Node3D and center it inside of that node.

Worked perfectly I must say.

### Filtering in godot:

Godot filters textures when importing the model. Even if you specify in every "filter" setting that you don't need it, Godot still filters textures.

Because of this, model had some weird artifacts when out of nowhere random color splashes appeared on random model's faces.

The solution was to just upscale texture (from 256 to 512). Artifacts went away, but texture still looks blurry :(

## Links:

Video: https://youtu.be/hRmoSJuHYFI

Model (with download): https://skfb.ly/oLunM

Shaders used:

- https://godotshaders.com/shader/3d-pixelation-filter/
- https://godotshaders.com/shader/pixelated-starfield-with-parallax-scrolling-effect/
