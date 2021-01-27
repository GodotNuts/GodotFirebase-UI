tool
extends Control

export (bool) var automatic_signup : bool = false setget set_automatic_signup

onready var email_field : FieldContainer = $Container/EmailField
onready var password_field : FieldContainer = $Container/PasswordField

var email : String
var password : String

signal logged(user_id)
signal signed(user_id)
signal error(message)

func _ready():
    if Engine.editor_hint:
        return
    Firebase.Auth.connect("login_failed", self, "_on_login_failed")
    Firebase.Auth.connect("login_succeeded", self, "_on_login_succeeded")
    Firebase.Auth.connect("signup_succeeded", self, "_on_signup_succeeded")

func verify_fields() -> bool:
    email = email_field.get_text()
    password = password_field.get_text()
    return not (email in [""," "] and password in [""," "])

func _on_EmailButton_pressed():
    if verify_fields():
        Firebase.Auth.login_with_email_and_password(email, password)
    else:
        printerr("Email and Password must be valid and non-empty.")

func _on_SignupButton_pressed():
    if verify_fields():
        Firebase.Auth.signup_with_email_and_password(email, password)
    else:
        printerr("Email and Password must be valid and non-empty.")

func _on_login_failed(code : int, message : String):
    printerr("ERROR %s: %s" % [str(code), message])
    match message:
        "EMAIL_NOT_FOUND":
            if automatic_signup:
                Firebase.Auth.signup_with_email_and_password(email, password)
        "EMAIL_EXISTS":
            pass
        "INVALID_PASSWORD":
            pass
    emit_signal("error", message)

func _on_login_succeeded(login : Dictionary):
    emit_signal("logged", login.localid)

func _on_signup_succeeded(signup : Dictionary):
    emit_signal("signed", signup.localid)

func set_automatic_signup(automatic : bool):
    automatic_signup = automatic
    if has_node("Container/ButtonsContainer/SignupButton"):
        $Container/ButtonsContainer/SignupButton.visible = not automatic_signup
        $Container/ButtonsContainer/Separator.visible = not automatic_signup
