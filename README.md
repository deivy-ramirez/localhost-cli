 🚀 localhost CLI

Herramienta CLI para visualizar un dominio apuntando a una IP específica **sin modificar DNS ni usar `/etc/hosts`**.

Ideal para pruebas de migraciones, debugging web y validaciones rápidas en entornos restringidos (sin acceso root).


🔥 Características

- ✔ No requiere permisos `sudo`
- ✔ No modifica `/etc/hosts`
- ✔ Proxy HTTP/HTTPS local
- ✔ Reescritura básica de HTML para navegación
- ✔ Manejo de redirecciones (`Location`)
- ✔ Selección automática de puerto disponible
- ✔ Apertura automática del navegador
- ✔ Compatible con macOS y Linux


📦 Instalación

Método rápido (recomendado)

bash

curl -s https://raw.githubusercontent.com/deivy-ramirez/localhost-cli/main/install.sh | bash

🧪 Uso
🔹 Modo interactivo

localhost

Te pedirá:
  
Dominio:
IP destino:
Puerto (opcional):

🔹 Uso directo:

localhost dominio.com 1.2.3.4

o con puerto específico:

localhost dominio.com 1.2.3.4 8080

⚠️ Limitaciones

Esta herramienta es un proxy, por lo tanto:

❌ No reemplaza /etc/hosts
❌ No funciona perfectamente con:
Cloudflare
Apps SPA (React, Angular, Vue)
APIs externas
WebSockets
Cookies con dominio estricto

⚠️ Algunos sitios pueden tener:
- recursos que no cargan
- redirecciones parciales
- comportamiento distinto al real

🔧 ¿Cómo funciona?

- Levanta un servidor local (127.0.0.1)
- Intercepta las peticiones del navegador
- Reenvía al servidor destino usando el Host original
- Devuelve la respuesta al navegador
- Reescribe HTML básico para mantener navegación local

🧑‍💻 Autor 
*Deivy Steven Ramirez Molina*
