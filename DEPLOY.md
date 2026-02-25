# 🚀 Cómo subir Cerlita a GitHub y verla online

## Opción 1: GitHub Pages (Recomendado - Gratis)

### Pasos:

1. **Sube el código a GitHub:**
   ```bash
   cd /workspaces/literate-palm-tree
   git add .
   git commit -m "Cerlita v1.0 - Mensajería Nostr"
   git push -u origin main
   ```

2. **Activa GitHub Pages:**
   - Ve a tu repositorio en GitHub
   - Click en **Settings** → **Pages**
   - En **Source**, selecciona: **GitHub Actions**
   - Click **Save**

3. **Espera el deploy:**
   - Ve a la pestaña **Actions**
   - Espera a que el workflow "Deploy to GitHub Pages" termine
   - ¡Listo! Tu app estará en: `https://TU-USUARIO.github.io/NOMBRE-REPO/`

---

## Opción 2: Netlify Drop (Más rápido - Sin configurar Actions)

1. **Descarga el build web:**
   ```bash
   cd /workspaces/literate-palm-tree
   zip -r build-web.zip build/web/
   ```

2. **Sube a Netlify:**
   - Ve a https://app.netlify.com/drop
   - Arrastra la carpeta `build/web` o el ZIP
   - ¡Listo! Te dará una URL pública instantánea

---

## Opción 3: Vercel (También gratis)

1. **Instala Vercel CLI:**
   ```bash
   npm i -g vercel
   ```

2. **Deploy:**
   ```bash
   cd /workspaces/literate-palm-tree/build/web
   vercel --prod
   ```

---

## Opción 4: Firebase Hosting

1. **Instala Firebase CLI:**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login y init:**
   ```bash
   firebase login
   firebase init hosting
   ```

3. **Deploy:**
   ```bash
   firebase deploy
   ```

---

## 📱 Para Android APK

El APK se genera automáticamente con GitHub Actions:

1. **Sube el código** (ver Opción 1, paso 1)
2. **Ve a Actions** en GitHub
3. **Selecciona** "Build Cerlita APK"
4. **Descarga** el artifact `cerlita-release-apk`

---

## 🔗 URLs de ejemplo

Una vez desplegado, tu app estará en:

- **GitHub Pages**: `https://usuario.github.io/cerlita/`
- **Netlify**: `https://random-name.netlify.app`
- **Vercel**: `https://cerlita.vercel.app`

---

## ⚡ Quick Start (5 minutos)

```bash
# 1. Commit
cd /workspaces/literate-palm-tree
git add .
git commit -m "Initial commit"

# 2. Push
git remote add origin https://github.com/TU-USUARIO/cerlita.git
git push -u origin main

# 3. Espera 2-3 minutos y ve a:
# https://TU-USUARIO.github.io/cerlita/
```

---

## 🎯 ¿Problemas?

### El build falla en GitHub Actions:
- Verifica que el nombre del repo sea en minúsculas
- Revisa los logs en la pestaña Actions

### La página muestra 404:
- Espera 2-3 minutos después del deploy
- Asegúrate de que GitHub Pages esté activado

### La app no carga:
- Abre la consola del navegador (F12)
- Revisa si hay errores de JavaScript

---

**¡Listo! Tu app Cerlita estará online en minutos 🎉**
