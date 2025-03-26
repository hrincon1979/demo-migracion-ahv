#!/bin/bash

# ========================
# Solicitar datos al usuario
# ========================
read -p "📝 Nombre del customer: " CLIENTE
read -p "🌐 URL del logo (formato .jpg/.png): " LOGO_URL

ARCHIVO_IP="/var/www/html/data.txt"

# ========================
# Instalar dependencias
# ========================
dnf install -y httpd php curl

systemctl enable httpd
systemctl start httpd

# ========================
# Descargar logo
# ========================
curl -s -o /var/www/html/logo.jpg "$LOGO_URL"
if [[ ! -f /var/www/html/logo.jpg ]]; then
  echo "❌ No se pudo descargar el logo. Verifica la URL."
  exit 1
fi

# ========================
# Crear archivo de IP persistente
# ========================
if [ ! -f "$ARCHIVO_IP" ]; then
  touch "$ARCHIVO_IP"
  chmod 666 "$ARCHIVO_IP"
fi

# ========================
# Crear index.php
# ========================
cat << EOF > /var/www/html/index.php
<!DOCTYPE html>
<html>
<head>
  <title>Demo de Migración</title>
  <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;700&display=swap" rel="stylesheet">
  <style>
    body {
      font-family: 'Montserrat', sans-serif;
      text-align: center;
      padding: 50px;
    }
    img {
      max-width: 80%;
      max-height: 400px;
      margin: 30px 0;
    }
    .ip-box {
      margin-top: 40px;
    }
    input[type="text"] {
      padding: 10px;
      font-size: 18px;
      width: 250px;
    }
    input[type="submit"] {
      padding: 10px 20px;
      font-size: 18px;
    }
  </style>
</head>
<body>
  <h1>Bienvenidos a la Demo de Migración</h1>
  <h2>Cliente: $CLIENTE</h2>
  <img src="logo.jpg" alt="Logo del Cliente" />
  
  <div class="ip-box">
    <h3>Dirección IP registrada:</h3>
    <form method="POST">
      <input type="text" name="ip" value="<?php echo file_get_contents('data.txt'); ?>" />
      <input type="submit" value="Actualizar IP" />
    </form>

    <?php
      if (\$_SERVER["REQUEST_METHOD"] == "POST") {
        \$nueva_ip = \$_POST["ip"];
        file_put_contents("data.txt", \$nueva_ip);
        echo "<p><strong>IP actualizada a:</strong> " . htmlspecialchars(\$nueva_ip) . "</p>";
      }
    ?>
  </div>
</body>
</html>
EOF

echo "✅ Página de demo generada correctamente para $CLIENTE"
echo "🌐 Accede a: http://<IP_DE_LA_VM> desde tu navegador"
