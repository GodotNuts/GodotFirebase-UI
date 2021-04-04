tool
extends CustomBaseButton


func _pressed() -> void:
    Firebase.Auth.get_google_auth()

func _released() -> void:
    pass
