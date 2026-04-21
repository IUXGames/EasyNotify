# EasyNotify for Godot 4 🔔

[![Godot 4](https://img.shields.io/badge/Godot-4.x-478cbf?logo=godotengine&logoColor=white)](https://godotengine.org/)
[![Version](https://img.shields.io/badge/version-0.1.0-5aafff)](./plugin.cfg)

EasyNotify is a lightweight notification addon for **Godot 4** that gives you a ready-to-use on-screen toast system with minimal setup.

It works as an autoloaded scene singleton, so you can trigger notifications from anywhere in your project with a single call. The addon includes:

- ✅ A queue-based notification flow
- ✅ Duplicate/spam prevention logic
- ✅ Smooth slide-in / slide-out tweens
- ✅ Simple API for title, message, and duration

---

## ✨ Features

- **Global access** through an autoload singleton (`EasyNotify`)
- **Notification queue** to avoid visual overlap
- **Duplicate filtering** for active and queued notifications
- **Responsive text layout** with wrapped labels
- **Animated transitions** for polished UI feedback

---

## 📦 Basic Setup (Godot 4)

### 1) Place the addon in your project

Make sure your project contains this structure:

```text
res://addons/easynotify/
  plugin.cfg
  plugin.gd
  easynotify.tscn
  easynotify.gd
```

> If you cloned this repository, copy or keep the addon files under `res://addons/easynotify/`.

### 2) Enable the plugin

In Godot:

1. Open **Project > Project Settings...**
2. Go to the **Plugins** tab
3. Find **EasyNotify**
4. Click **Enable**

When enabled, the plugin automatically registers the autoload singleton:

- Name: `EasyNotify`
- Scene: `res://addons/easynotify/easynotify.tscn`

---

## 🚀 Basic Usage

Call `add_notification()` from any script:

```gdscript
EasyNotify.add_notification({
	"title": "Success",
	"message": "Your game data was saved correctly.",
	"duration": 2.0
})
```

### Supported fields

- `title` (`String`) - Notification title
- `message` (`String`) - Main message body
- `duration` (`float`, optional) - Time in seconds before hiding (default: `2.0`)

---

## ⚙️ How It Works

EasyNotify internally uses:

1. **A queue (`notificationQueue`)** to store incoming notifications.
2. **An active state (`isNotificationShowing`)** so only one notification is shown at a time.
3. **Duplicate checks** to avoid pushing the same title+message repeatedly.
4. **Tween animations**:
   - Slide **in** from the right
   - Wait for `duration`
   - Slide **out** to the right

After one notification ends, the next item in the queue is processed automatically.

---

## 🧩 Included Components

- `plugin.gd`  
  Registers/removes the autoload singleton when the plugin is enabled/disabled.

- `easynotify.tscn`  
  UI scene containing:
  - `PanelContainer`
  - icon (`TextureRect`)
  - title and message labels

- `easynotify.gd`  
  Core logic for queueing, deduplication, and animation flow.

---

## 🛠️ Notes

- Designed for **Godot 4**.
- Default layout places notifications near the top-right corner.
- You can freely customize the scene theme, icon, spacing, and animations.

---

## 📄 License

MIT License © 2026 | IUX Games, Isaackiux.
