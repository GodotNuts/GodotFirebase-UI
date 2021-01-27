tool
extends PanelContainer
class_name FieldContainer


var texture : Texture = null setget set_texture
var expand : bool = false setget set_expand
var size : Vector2 = Vector2(32, 32) setget _set_size
var modulate_color : Color = Color.white setget set_texture_modulate

var text : String = "" setget set_text
var text_color : Color = Color.white setget set_text_color

var pressing : bool = false

func _get_property_list():
    return [
        {
            "class_name": "FieldContainer",
            "hint": PROPERTY_HINT_NONE,
            "usage": PROPERTY_USAGE_CATEGORY,
            "name": "FieldContainer",
            "type": TYPE_STRING
        },
        {
            "usage": PROPERTY_USAGE_GROUP,
            "name": "Icon",
            "type": TYPE_STRING
        },
        {
            "hint": PROPERTY_HINT_RESOURCE_TYPE,
            "usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
            "name": "texture",
            "hint_string": "Texture",
            "type": TYPE_OBJECT
        },
        {
            "usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
            "name": "modulate_color",
            "type": TYPE_COLOR
        },
        {
            "usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
            "name": "expand",
            "type": TYPE_BOOL
        },
        {
            "usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
            "name": "size",
            "type": TYPE_VECTOR2
        },
        {
            "usage": PROPERTY_USAGE_GROUP,
            "name": "Contents",
            "type": TYPE_STRING
        },
        {
            "usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
            "name": "text",
            "type": TYPE_STRING
        },
        {
            "usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE,
            "name": "text_color",
            "type": TYPE_COLOR
        },
        
    ]

func _set(property, value):
    match property:
        "texture": 
            set_texture(value)
            return true
        "expand": 
            set_expand(value)
            return true
        "size": 
            _set_size(value)
            return true
        "modulate_color": 
            set_texture_modulate(value)
            return true
        "text": 
            set_text(value)
            return true
        "text_color": 
            set_text_color(value)
            return true

func _ready():
    set_texture(texture)
    set_text(text)
    set_text_color(text_color)
    _set_size(size)
    set_texture_modulate(modulate_color)

func set_texture(_texture : Texture) -> void:
    texture = _texture
    if has_node("Container/Icon"):
        $Container/Icon.set_texture(texture)


func set_expand(_expand : bool):
    expand = _expand
    if has_node("Container/Icon"):
        $Container/Icon.expand = expand

func _set_size(_size : Vector2):
    size = _size
    if has_node("Container/Icon"):
        $Container/Icon.rect_min_size = size

func set_texture_modulate(_color : Color) -> void:
    modulate_color = _color
    if has_node("Container/Icon"):
        $Container/Icon.modulate = modulate_color

func set_text(_text : String) -> void:
    text = _text
    if has_node("Container/FieldEdit"):
        $Container/FieldEdit.set_text(text)


func set_text_color(_color : Color) -> void:
    text_color = _color
    if has_node("Container/FieldEdit"):
        $Container/FieldEdit.set("custom_colors/font_color", text_color)

func get_text() -> String:
    return $Container/FieldEdit.get_text()

