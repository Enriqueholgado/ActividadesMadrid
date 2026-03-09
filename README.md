# Actividades Madrid

**Descubre la agenda cultural de tu ciudad en tiempo real**

![Screenshot](screenshot.png)

## Demo

Accede a la aplicación en directo aqui:
**[https://enriqueholgado.github.io/ActividadesMadrid/](https://enriqueholgado.github.io/ActividadesMadrid/)**

---

## Funcionalidades

### 🗺️ Mapa interactivo
- Marcadores agrupados con **Leaflet + MarkerCluster** para gestionar cientos de eventos sin saturar la vista
- **Búsqueda** por nombre de evento con pan automático al resultado
- **Filtros** por tipo de actividad y rango de fechas
- Botón **"Hoy"** para mostrar solo los eventos del día
- Botón **"Esta semana"** para ver los próximos 7 días de un vistazo
- Botón **"Cerca de mí"** que usa la Geolocation API para centrarse en tu posición y mostrar cuántos eventos tienes a menos de 2 km

### 📊 Panel de gráficos
- Estadísticas animadas con contador progresivo: total de eventos, barrio más activo, ratio de gratuidad
- **Gráfico de barras** de eventos por distrito
- **Gráfico de doughnut** con distribución por tipología (Chart.js)
- Filtro global por tipo de actividad que actualiza todos los gráficos en tiempo real

### 📋 Explorador de datos
- **Filtros jerárquicos**: tipo → distrito → barrio (el segundo y tercero se actualizan dinámicamente)
- **Tabla ordenable** haciendo clic en cualquier cabecera
- **Paginación** con salto directo a página
- **Búsqueda** en texto libre por título, tipo, distrito, barrio y ubicación
- **Exportar CSV** con BOM UTF-8 para apertura directa en Excel
- **Navegación por teclado**: flechas ↑↓ para moverte por las filas, Enter para abrir el detalle

### 🔍 Modal de detalle
- Información completa del evento: organizador, fechas, hora, precio, accesibilidad y fechas excluidas
- **Mini-mapa** integrado con Leaflet que muestra la ubicación exacta
- Botón **"Compartir"**: usa la Web Share API si está disponible, o copia el enlace al portapapeles como fallback

### ✨ UX y accesibilidad
- **Modo oscuro / claro** con persistencia en `localStorage`
- Diseño **responsive** con _hamburger menu_ para móvil
- **Toast notifications** para feedback inmediato al usuario
- Botón **scroll to top** que aparece al bajar la página
- **Banner de bienvenida** con el total de actividades disponibles, descartable y con estado guardado en `localStorage`
- **Service Worker** para funcionamiento offline básico (cachea recursos estáticos)

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
| **Leaflet.js** | Mapa interactivo y mini-mapa en modal |
| **Leaflet.markercluster** | Agrupación de marcadores |
| **Chart.js** | Gráficos de barras y doughnut |
| **HTML / CSS / JS vanilla** | Sin frameworks, sin bundler |
| **CartoDB Positron tiles** | Teselas del mapa (modo claro y oscuro) |
| **Inter (Google Fonts)** | Tipografía principal |

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

## Autor

**Enrique Holgado de Frutos**
[github.com/Enriqueholgado](https://github.com/Enriqueholgado)

---

## Licencia

MIT — libre para usar, modificar y distribuir.
