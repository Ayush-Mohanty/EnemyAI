#  EnemyAI for Godot

A lightweight, plug-and-play **enemy AI system** for Godot 4.x projects.  
Designed to follow the player only when they are within the enemy's **line of sight** — great for stealth, combat, and patrol-based gameplay mechanics.

---

##  Features

-  **Line-of-Sight Detection** using RayCast
-  **Enemy follows player** only when visible
-  Modular scenes: drop into any project
-  Easy to configure, extend, or modify

---

##  How to Use

1. **Download or clone** this repository.
2. Open the project in **Godot 4.x**.
3. Drag and drop the `enemy.tscn` and `player.tscn` into your own scene or game level.
4. Make sure your player node is named `"Player"` or update the reference in `enemy_ai.gd`.
5. Hit **Play** — the enemy should detect and follow the player when in view!

---

##  Project Structure

EnemyAI/ ├── project.godot ├── scenes/ │ ├── player.tscn │ └── enemy.tscn ├── scripts/ │ ├── player.gd │ └── enemy_ai.gd └── assets/ └── (icons, placeholder sprites, etc.)

---

##  Customization

- Want stealth mechanics? Add a **field of view limit**.
- Want smarter enemies? Integrate **navigation agents** or **state machines**.
- Want ranged enemies? Add **raycast-based shooting** logic.

---

##  License

This project is open-source under the [MIT License](LICENSE).  
Feel free to use it in personal or commercial projects — just leave credit if possible!

---

##  Author

Made with ♥ by [Ayush Mohanty](https://github.com/Ayush-Mohanty)  
If you use this in a project or improve it, drop a ⭐ and share it back!

---

##  Preview 

https://github.com/user-attachments/assets/dc669364-77e8-49eb-a9fa-c0f2268cb180