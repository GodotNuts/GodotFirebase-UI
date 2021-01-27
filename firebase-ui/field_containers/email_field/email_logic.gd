extends Node






func _on_FieldEdit_focus_exited():
    var email : String = get_parent().get_text()
    if not email in [""," "]:
        if not "@" in email:
            printerr("EmailField does not contain a proper email adress.")

