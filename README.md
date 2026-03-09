# Actividades Madrid

**Descubre la agenda cultural de tu ciudad en tiempo real**

![Screenshot](screenshot.png)

## Demo

Accede a la aplicación en directo:
**[https://enriqueholgado.github.io/ActividadesMadrid/](https://enriqueholgado.github.io/ActividadesMadrid/)**

---

## Funcionalidades

### 🗺️ Mapa interactivo
- Marcadores agrupados con **Leaflet + MarkerCluster** para gestionar cientos de eventos sin saturar la vista
- **Búsqueda** por nombre de evento con pan automático al resultado
- **Filtros** por tipo de actividad y rango de fechas (desde hoy por defecto)
- Botón **"Hoy"** para mostrar solo los eventos del día
- Botón **"Esta semana"** para ver los próximos 7 días de un vistazo
- Botón **"Cerca de mí"** que usa la Geolocation API para centrarse en tu posición y mostrar cuántos eventos tienes a menos de 2 km
- **Mapa de calor** (heatmap) para visualizar zonas con mayor concentración de eventos
- **Planificar ruta** entre hasta 5 eventos con distancia estimada a pie
- Botón **"Sorpréndeme"** que te lleva a un evento aleatorio con animación de confetti

### 📊 Panel de gráficos
- Estadísticas animadas con contador progresivo: total de eventos, barrio más activo, eventos gratuitos
- **Gráfico de barras** de eventos por distrito
- **Gráfico de doughnut** con distribución por tipología (Chart.js)
- Filtro global por tipo de actividad que actualiza todos los gráficos en tiempo real

### 📋 Explorador de datos
- **Filtros jerárquicos**: tipo → distrito → barrio (se actualizan dinámicamente)
- **Filtro por precio** con pills modernos: Todos / Gratuito / De pago
- **Tabla ordenable** haciendo clic en cualquier cabecera
- **Paginación** con salto directo a página
- **Búsqueda** en texto libre por título, tipo, distrito, barrio y ubicación
- **Exportar CSV** con BOM UTF-8 para apertura directa en Excel
- **Navegación por teclado**: flechas ↑↓ para moverte por las filas, Enter para abrir el detalle

### 📅 Vista Agenda semanal
- Calendario visual con vista por semana (Lun–Dom)
- Navegación entre semanas con flechas y botón "Hoy"
- Filtro por tipo de actividad
- Chips de eventos con indicador de color por tipo y badge de gratuidad
- Clic en cualquier evento abre el modal de detalle

### 🔍 Modal de detalle
- Información completa del evento: organizador, fechas, hora, precio, accesibilidad y fechas excluidas
- **Mini-mapa** integrado con Leaflet que muestra la ubicación exacta
- **Eventos similares**: hasta 3 eventos del mismo tipo o barrio
- Botón **"Compartir"**: usa la Web Share API si está disponible, o copia el enlace al portapapeles
- Botón **"Añadir al calendario"**: genera y descarga un fichero `.ics` compatible con Google Calendar, Apple Calendar, Outlook, etc.

### ❤️ Favoritos
- Marca eventos como favoritos con el botón de corazón (desde la tabla o el modal)
- **Pestaña Favoritos** dedicada con vista de tarjetas
- Persistencia en `localStorage` entre sesiones

### ✨ UX y accesibilidad
- **Modo oscuro / claro** con persistencia en `localStorage`
- Diseño **responsive** con _hamburger menu_ para móvil
- **Toast notifications** para feedback inmediato al usuario
- Botón **scroll to top** que aparece al bajar la página
- **Banner de bienvenida** descartable con el total de actividades disponibles
- **Service Worker** para funcionamiento offline básico (cachea recursos estáticos)
- **Deep linking**: los filtros se guardan en la URL (`#tab=mapa&tipo=Danza&desde=...`) para poder compartir búsquedas

### 🧩 Widget embebible
- Código `<iframe>` listo para copiar desde la pestaña "Sobre esta aplicación"
- Permite a cualquier web incrustar el dashboard de actividades

---

## Fuente de datos

Los datos provienen de la **API abierta del Ayuntamiento de Madrid**:

- Portal: [datos.madrid.es](https://datos.madrid.es/portal/site/egob)
- Endpoint: [Agenda de eventos culturales – próximos 100 días](https://datos.madrid.es/egob/catalogo/206974-0-agenda-eventos-culturales-100.json)

Los datos se cargan en tiempo real en cada visita, sin intermediario.

---

## Tecnologías

| Tecnología | Uso |
|---|---|
| **Leaflet.js** | Mapa interactivo, mini-mapa en modal, mapa de calor |
| **Leaflet.markercluster** | Agrupación de marcadores |
| **Leaflet.heat** | Capa de mapa de calor |
| **Chart.js** | Gráficos de barras y doughnut |
| **HTML / CSS / JS vanilla** | Sin frameworks, sin bundler — un solo archivo |
| **CartoDB Positron tiles** | Teselas del mapa (modo claro y oscuro vía CSS filter) |
| **Inter (Google Fonts)** | Tipografía principal |
| **Web Share API** | Compartir eventos en dispositivos compatibles |
| **Geolocation API** | Función "Cerca de mí" |

---

## Despliegue en GitHub Pages

1. Haz fork del repositorio o súbelo a tu cuenta de GitHub
2. Ve a **Settings → Pages**
3. En _Source_, selecciona la rama `main` y la carpeta `/ (root)`
4. Guarda. En unos segundos tendrás la URL `https://<usuario>.github.io/<repositorio>/`

No se necesita ningún paso de compilación.

---

## Desarrollo local

Solo necesitas servir los ficheros estáticos. Elige la opción que prefieras:

```bash
# Con Node.js
npx serve .

# Con Python 3
python -m http.server

# Con Python 2
python -m SimpleHTTPServer
```

Abre `http://localhost:3000` (o el puerto que indique el comando) en tu navegador.

---

## Estructura del proyecto

```
ActividadesMadrid/
├── index.html    # Toda la app (~4800 líneas: HTML + CSS + JS)
├── README.md     # Este archivo
├── .gitignore
└── img/
    ├── logo_madrid_dark.png
    ├── logo-ayto-madrid-300x216.png
    └── firma_madrid_blanco.png
```

---

## Autor

**Enrique Holgado de Frutos**
[github.com/Enriqueholgado](https://github.com/Enriqueholgado)

---

## Licencia

MIT — libre para usar, modificar y distribuir.
