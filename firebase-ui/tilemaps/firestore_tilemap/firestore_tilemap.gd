class_name FirestoreTileMap
extends TileMap

# This node ensures that the tilemap is up-to-date with the latest
# data stored in your Firestore instance, defined by the appropriate path
# that is exported below

export (String) onready var CollectionName
export (String) onready var DocumentId
export (String) onready var MapName
export (bool) onready var CreateNew
export (bool) onready var Update

func _ready() -> void:
    Firebase.Auth.connect("login_succeeded", self, "on_firebase_login_succeeded")
    Firebase.Auth.connect("signup_succeeded", self, "on_firebase_login_succeeded")
    
func on_firebase_login_succeeded(login_info) -> void:
    if CollectionName:
        var coll = Firebase.Firestore.collection(CollectionName)
        if not coll.is_connected("error", self, "on_error"):
            coll.connect("error", self, "_on_error")
        if not CreateNew and not Update:
            coll.connect("get_document", self, "_on_document_received", [], CONNECT_ONESHOT)
            coll.get(DocumentId)
        else:
            coll.connect("update_document", self, "_on_document_received", [], CONNECT_ONESHOT)
            _serialize_data(coll, DocumentId)
            
func _serialize_data(coll, doc_name = ""):
    var cells_by_id = get_used_cells()
    var cell_map = { }
    for cell in cells_by_id:
        cell_map[var2str(cell)] = get_cellv(cell)
    if CreateNew:
        coll.add("", {"MapName" : MapName, "Cells": JSON.print(cell_map) })
    elif Update:        
        coll.update(doc_name, {"MapName" : MapName, "Cells": cell_map })
        
func _on_document_received(document) -> void:
    MapName = document.doc_fields["MapName"]
    clear()
    DocumentId = document.doc_name
    print(DocumentId)
    var cells = JSON.parse(document.doc_fields["Cells"]).result
    for cell in cells.keys():
        set_cellv(str2var(cell), cells[cell])
        
    update_bitmask_region()
    update_dirty_quadrants()
        
func _on_error(code, status, message):
    print(str(code) + " " + str(status) + " " + message)