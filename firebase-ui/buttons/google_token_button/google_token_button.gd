tool
extends CustomBaseButton

func _pressed() -> void:
    pass

func _released() -> void:
    Firebase.Auth.get_google_auth()
