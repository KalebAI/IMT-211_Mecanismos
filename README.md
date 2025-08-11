<<<<<<< HEAD
# IMT-211_Mecanismos
Repositorio de la asignatura de mecanismos
=======
# IMT-211 · Mecanismos — Entorno de Trabajo (Windows & Ubuntu 24.04)

Repositorio listo para **clonar y ejecutar** que configura un entorno reproducible con **Miniconda** / **Conda** para la asignatura **IMT‑211 Mecanismos**.

Incluye scripts para **Windows (PowerShell)** y **Ubuntu 24.04 (Bash)** que:
- Detectan o instalan Miniconda automáticamente.
- Crean/actualizan el entorno `imt-211` desde `environment.yml`.
- Inician Jupyter Lab para trabajar con los notebooks de la materia.

> **Requisitos mínimos**: conexión a Internet y permisos para instalar software en el equipo.

---

## 🚀 Uso rápido

### Windows 10/11 (PowerShell)

1. Abre **PowerShell** como *usuario normal* (no es necesario administrador).
2. Ejecuta:
   ```powershell
   .\scripts\windows\setup_env.ps1
   ```
3. Cuando termine, inicia Jupyter:
   ```powershell
   .\scripts\windows\launch_jupyter.ps1
   ```

> Si *PowerShell* bloquea la ejecución de scripts, ejecuta temporalmente:
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
> ```

### Ubuntu 24.04 (Bash)
