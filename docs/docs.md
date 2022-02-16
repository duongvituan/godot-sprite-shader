
## SShaderContainer
Inherits: Node < Object

### Description

This node will contain all the SShaders you want to use for the Sprite. So you need to create it first.

You need to set the **node_path** to the Sprite you want to use. By default it will auto find the (Sprite, ViewportContainer, RectTexture) in your tree scene, but you need check it. if the node path is wrong, you need to update it.

One SShaderContainer can contain multiple SShader, but you can only active 1 SShader at a time, ex: SSOneColor has been activated, if you active SShaderOutline then SSOneColor will auto inactive.

### Properties
```python
export(NodePath) var node_path
```

```python
signal start_shader(ezShader)
signal cancel_shader(ezShader)
signal change_to_other_shader(new_shader, old_shader)
signal finished_shader(ezShader)
```
You can use signal to catch events: When Sprite start use shader, when sprite finished run animation shader ...

example code:
```python
...
onready var ss_container := $SShaderContainer
onready var transform_freeze := $SShaderContainer/SSTransfromFreeze
onready var transform_burn := $SShaderContainer/SSTransfromBurn
...

func _ready():
    ss_container.connect("cancel_shader", self, "_on_cancel_shader")
    ss_container.connect("finished_shader", self, "_on_finished_shader")
...

func _on_cancel_shader(ez_shader):
    if ez_shader == transform_freeze:
        animation_player.play("Idle")

func _on_finished_shader(ez_shader):
    if ez_shader == transform_freeze:
        status = STATUS.Normal
        animation_player.play("Idle")
```


## SShader

Inherits: Node < Object

### Description

SShader is the node that holds the Shader file. You don't need config the noise texture for the shader, everything is already config, you just drag and drop the type shader you want to use and change param it.

### Properties
```python
var ease_func_value = null
var time_func = null
```

You can use ease func to SShader [link](https://raw.githubusercontent.com/godotengine/godot-docs/3.3/img/ease_cheatsheet.png)
ex:
```python
$Char2/SShaderContainer/SSDissolveDust.ease_func_value = 0.1
```

or

```python
const custom_curve = preload("res://demo/list_demo/time_func/custom_curve.tres")
...
$Char2/SShaderContainer/SSDissolveDust.time_func = custom_curve
```

### Methods
```python
func play(duration: float, inactive_when_finished: bool = false)
func play_repeat(duration: float, repeat: int, inactive_when_finished: bool = false, delay_each_repeat: float = 0.0)
func play_repeat_forever(duration: float, delay_each_repeat: float = 0.0)

func play_reverse(duration: float, inactive_when_finished: bool = false)
func play_reverse_repeat(duration: float, repeat: int, inactive_when_finished: bool = false, delay_each_repeat: float = 0.0)
func play_reverse_repeat_forever(duration: float, delay_each_repeat: float = 0.0)
```

### How does function "play" do in SShader ?

Pseudocode:
- Set is_active variable = true.
- Wait for a duration time.
- Final: set is_active is true or false based on parameter inactive_when_finished.

example **hit effect**:
```
    $SShaderContainer/SSOneColor.play(0.1, true)
```

![Hit Effect](https://github.com/duongvituan/godot-sprite-shader/blob/master/preview_image/hit_effect.gif)


## SShaderInterval

Inherits: SShader < Node < Object

### Description

SShaderInterval is SShader but it has property **process_value**. 
You need update process_value to do animation (you can use play func or use AnimationPlayer...)


### Properties
```python
var process_value: float
```

### How does function "play" do in SShaderInterval ?

Pseudocode:
- Set is_active variable = true.
- Update process_value variable from 0 to 1 in duration time.
- Final: set is_active is true or false based on parameter inactive_when_finished.

example:
```
    $SShaderContainer/SSDisovelFlash.play(0.1)
```
