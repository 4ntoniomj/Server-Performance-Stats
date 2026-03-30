https://roadmap.sh/projects/server-stats

---

# Bash System Monitor 🚀

A lightweight, real-time system monitoring tool written in Bash for Linux environments. This script provides a quick, color-coded overview of critical system resources, high-consumption processes, and security logs directly from your terminal.

---

## 📋 Features

* **CPU Usage:** Real-time calculation with visual color alerts (Blue for normal, Red for high usage).
* **RAM Management:** Instant visualization of current memory consumption percentage.
* **Disk Status:** Lists partitions and mount points with critical threshold highlighting (90%+).
* **Top Processes:** Automatically identifies the top 5 processes consuming the most CPU and RAM.
* **Security Audit:** Reports failed login attempts (`su` and `SSH`) from the current boot session.
* **Session Info:** Displays currently logged-in users and system load using the `w` command.

---

## 🛠️ Requirements

The script relies on standard Linux utilities. Ensure you have the following installed (pre-installed on most distributions):
* `top` / `free` / `df` / `ps`
* `journalctl` (requires privileges to read system logs)
* `awk` / `sed` / `grep`

---

## 🚀 Installation & Usage

1.  **Clone or download the script:**
    ```bash
    git clone [https://github.com/4ntoniomj/Server-Performance-Stats](https://github.com/4ntoniomj/Server-Performance-Stats)
    cd repo-name
    ```

2.  **Grant execution permissions:**
    ```bash
    chmod +x server-stats.sh
    ```

3.  **Run the script:**
    To view failed login attempts via `journalctl`, it is recommended to run the script with `sudo`:
    ```bash
    sudo ./server-stats.sh
    ```

---

## 🎨 Color Coding

The script uses a logic-based color scheme for better readability:
* **Blue:** Normal/Stable resource levels.
* **Red:** Critical levels (Usage > 90%) or security failures.
* **Green/Turquoise:** General information and section separators.

---

## ⚠️ Technical Notes

* **Signal Handling:** Includes a `ctrl_c` function to perform automated cleanup of temporary logs in `/tmp/` if the user interrupts execution via `Ctrl+C`.
* **Temporary Files:** Uses dynamic naming (`/tmp/${0}.log`) to prevent conflicts when processing disk information.

---

## 🛠️ Analytical Review & Roadmap

* **Localization Sensitivity:** Current `sed` logic for CPU may vary by locale. Future updates should include `LC_NUMERIC=C` for global compatibility.
* **Dynamic Thresholds:** Move the 90% threshold to a global variable for easier configuration.
* **Efficiency:** Optimize the `while read` loop for disk status to reduce redundant `head/tail` calls.

---
**Developed for system administration and security monitoring purposes.**
