extends Node

# Variables del control de notificaciones
@onready var notificationPanel: PanelContainer = $NotificationPanelContainer
@onready var notificationTitle: Label = $NotificationPanelContainer/MarginContainer/HBoxContainer/VBoxContainer/TitleLabel
@onready var notificationMessage: Label = $NotificationPanelContainer/MarginContainer/HBoxContainer/VBoxContainer/MessageLabel
var notificationQueue: Array = []
var isNotificationShowing := false
var activeNotification: Dictionary = {}
const NOTIFICATION_MARGIN := 5.0


# ─── API PÚBLICA ─────────────────────────────────────────────────────────────
func add_notification(data: Dictionary) -> void:
	var currentNotificationData := str(data.get("title", "")) + str(data.get("message", ""))
	var avtiveNotificationData := str(activeNotification.get("title", "")) + str(activeNotification.get("message", ""))
	if currentNotificationData == avtiveNotificationData: return
	if notificationQueue.any(func(n): return str(n.get("title","")) + str(n.get("message","")) == currentNotificationData): return
	notificationQueue.push_back(data)
	process_notification_queue()

func process_notification_queue() -> void:
	if isNotificationShowing or notificationQueue.is_empty(): return
	isNotificationShowing = true
	
	var data: Dictionary = notificationQueue.pop_front()
	activeNotification = data
	notificationTitle.text = data.get("title", "")
	notificationMessage.text = data.get("message", "")
	
	# Esperar dos frames para que el panel calcule su tamaño final (autowrap incluido)
	await get_tree().process_frame
	await get_tree().process_frame

	var panelWidth: float = notificationPanel.size.x

	# Slide IN
	var tween_in := create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tween_in.tween_property(notificationPanel, "offset_right", -NOTIFICATION_MARGIN, 0.45)
	tween_in.parallel().tween_property(notificationPanel, "offset_left", -NOTIFICATION_MARGIN - panelWidth, 0.45)
	await tween_in.finished

	# Mantener visible
	await get_tree().create_timer(data.get("duration", 2.0)).timeout

	# Slide OUT
	var tween_out := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween_out.tween_property(notificationPanel, "offset_right", NOTIFICATION_MARGIN + panelWidth, 0.35)
	tween_out.parallel().tween_property(notificationPanel, "offset_left", NOTIFICATION_MARGIN, 0.35)
	await tween_out.finished

	isNotificationShowing = false
	activeNotification = {}
	process_notification_queue()
