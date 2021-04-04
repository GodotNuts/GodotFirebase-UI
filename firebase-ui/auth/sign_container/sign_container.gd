tool
extends Control

export (bool) var automatic_signup : bool = true setget set_automatic_signup
export (bool) var anonymous_signup : bool = false setget set_anonymous_signup

onready var email_field : FieldContainer = $Container/EmailField
onready var password_field : FieldContainer = $Container/PasswordField

var email : String
var password : String

signal logging()
signal logged(login)
signal signed(signup)
signal error(message)

func _ready():
    pass

func _connect() -> void:
    Firebase.Auth.connect("login_failed", self, "_on_login_failed")
    Firebase.Auth.connect("login_succeeded", self, "_on_login_succeeded")
    Firebase.Auth.connect("signup_succeeded", self, "_on_signup_succeeded")

func _disconnect() -> void:
    Firebase.Auth.disconnect("login_failed", self, "_on_login_failed")
    Firebase.Auth.disconnect("login_succeeded", self, "_on_login_succeeded")
    Firebase.Auth.disconnect("signup_succeeded", self, "_on_signup_succeeded")    

func verify_fields() -> bool:
    email = email_field.get_text()
    password = password_field.get_text()
    return not (email in [""," "] and password in [""," "])

func set_automatic_signup(automatic : bool):
    automatic_signup = automatic
    if has_node("Container/ButtonsContainer/SignupButton"):
        $Container/ButtonsContainer/SignupButton.visible = not automatic_signup
        $Container/ButtonsContainer/Separator.visible = false if (automatic_signup and not anonymous_signup) else true

func set_anonymous_signup(anonymous : bool):
    anonymous_signup = anonymous
    if has_node("Container/ButtonsContainer/AnonymousButton"):
        $Container/ButtonsContainer/AnonymousButton.visible = anonymous_signup
        $Container/ButtonsContainer/Separator.visible = false if (automatic_signup and not anonymous_signup) else true

func _on_EmailButton_pressed():
    if verify_fields():
        _connect()
        emit_signal("logging")
        Firebase.Auth.login_with_email_and_password(email, password)
    else:
        print("Email and Password must be valid and non-empty.")

func _on_SignupButton_pressed():
    _connect()
    if verify_fields():
        emit_signal("logging")
        Firebase.Auth.signup_with_email_and_password(email, password)
    else:
        print("Email and Password must be valid and non-empty.")


func _on_AnonymousButton_pressed():
    _connect()
    Firebase.Auth.login_anonymous()

func _on_login_failed(code, message):
    print("ERROR %s: %s" % [code, message])
    match message:
        "EMAIL_NOT_FOUND":
            if automatic_signup:
                Firebase.Auth.signup_with_email_and_password(email, password)
                return
        "EMAIL_EXISTS":
            pass
        "INVALID_PASSWORD":
            pass
    emit_signal("error", message)
    _disconnect()

func _on_login_succeeded(login : Dictionary):
    emit_signal("logged", login)
    _disconnect()

func _on_signup_succeeded(signup : Dictionary):
    emit_signal("signed", signup)
    _disconnect()
