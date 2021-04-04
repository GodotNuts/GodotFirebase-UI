tool
extends Control

onready var token_field : FieldContainer = $Container/TokenField

var token : String

signal logging()
signal signed(signup)
signal error(message)

func _connect() -> void:
    Firebase.Auth.connect("login_failed", self, "_on_login_failed")
    Firebase.Auth.connect("login_succeeded", self, "_on_login_succeeded")

func _disconnect() -> void:
    Firebase.Auth.disconnect("login_failed", self, "_on_login_failed")
    Firebase.Auth.disconnect("login_succeeded", self, "_on_login_succeeded")

func _ready():
    pass

func verify_fields() -> bool:
    token = token_field.get_text()
    return not (token in [""," "])

func _on_GoogleButton_pressed() -> void:
    if verify_fields():
        _connect()
        emit_signal("logging")
        Firebase.Auth.login_with_oauth(token)
    else:
        printerr("ERROR invalid_login: a token must be use to login.")

func _on_login_failed(code, message):
    printerr("ERROR %s: %s" % [code, message])
    emit_signal("error", message)
    _disconnect()

func _on_login_succeeded(login : Dictionary):
    emit_signal("logged", login)
    _disconnect()

func _clean():
    token = ""
    token_field.set_text(token)
