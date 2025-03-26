# Demo de Migración en Caliente a Nutanix AHV 🚀

Este repositorio contiene un script que genera una página web personalizada en una VM con Rocky Linux, ideal para demostrar una **migración en caliente (live migration)** desde VMware a Nutanix AHV utilizando **Nutanix Move**, sin downtime perceptible.

---

## 🧩 ¿Qué hace el script?

- Pide al usuario:
  - Nombre del cliente
  - URL de un logo (.png o .jpg)
- Instala Apache y PHP
- Descarga el logo y lo guarda localmente
- Genera una página con:
  - Nombre del cliente
  - Logo en grande
  - Fuente Montserrat (Google Fonts)
  - Campo editable para IP que se guarda localmente (persistente entre reinicios o migraciones)

---

## ⚙️ Requisitos

- Sistema operativo: **Rocky Linux 9**
- Conectividad a Internet
- Acceso con `sudo`

---

## 🚀 Ejecución rápida desde GitHub

En tu VM Rocky Linux:

```bash
sudo curl -s https://raw.githubusercontent.com/hrincon1979/demo-migracion-ahv/refs/heads/main/generar_demo_web.sh -o demo.sh
sudo chmod +x demo.sh
sudo ./demo.sh
