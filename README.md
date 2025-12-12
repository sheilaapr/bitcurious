# 📱 BitCurious — Aplikasi Mobile Edukasi Elektronika & IoT

**BitCurious** adalah aplikasi edukatif berbasis **Flutter** yang dirancang untuk membantu pengguna mengenal **komponen elektronika dan Internet of Things (IoT)** secara interaktif, terstruktur, dan tetap bernuansa Islami.

Aplikasi ini menggabungkan dua sumber data utama:

- 📂 **Data lokal (JSON)** → komponen elektronika/IoT, artikel edukatif, dan referensi project Islami  
- 🌐 **API publik (NewsAPI)** → berita teknologi & IoT terkini yang diambil langsung dari internet  

Proyek ini dikembangkan sebagai **tugas Ujian Akhir Semester (UAS) Praktikum Pemrograman Mobile**.

---

## 🚀 Fitur Utama

### 1️⃣ Splash Screen
- Halaman pembuka dengan branding **BitCurious**
- Memberikan transisi sebelum masuk ke halaman utama (Home)

---

### 2️⃣ Home Page
- Welcome section dengan sapaan personal (contoh: `Hello, Sheila!`)
- **Search bar berita**:
  - Terhubung ke **NewsAPI**
  - Mendukung pencarian berita teknologi & IoT (`esp32`, `sensor`, `AI`, dll)
- Tab konten:
  - `Komponen`
  - `Artikel`
  - `Project Islami`
- **Bottom Navigation Bar**:
  - 🧩 Komponen
  - 📚 Artikel
  - ⚡ Project
  - 📌 Pinned

- **Drawer (Sidebar)**:
  - Profil pengguna
  - Home
  - Berita Teknologi (API Publik)
  - About Us
  - Logout (placeholder)

---

### 3️⃣ Kategori Komponen
- Menampilkan kategori dari `components.json`, seperti:
  - Controller & Processing Units
  - Input & Sensing Devices
  - Output & Actuation Devices
  - Connectivity & Power Modules
- Tersedia kategori **All** untuk menampilkan semua komponen

---

### 4️⃣ List Komponen
- Data diambil dari `assets/data/components.json`
- Menampilkan:
  - Gambar
  - Nama komponen
  - Harga
  - Deskripsi singkat
- Tap item → halaman detail komponen

---

### 5️⃣ Detail Komponen & Pinned
- Informasi detail:
  - Gambar komponen
  - Nama & kategori
  - Harga (format Rupiah)
  - Deskripsi lengkap (Read more / Read less)
- Fitur **Pinned**:
  - Tambah/hapus komponen favorit
  - Menggunakan `PinnedRepository`
  - Notifikasi `SnackBar`

---

### 6️⃣ Pinned Components Page
- Menampilkan semua komponen yang sudah di-pin
- Akses dari:
  - Bottom Navigation
  - Drawer
- Fitur:
  - Tap item → detail komponen
  - Unpin langsung dari list
- Data pinned bersifat global dan konsisten antar halaman

---

### 7️⃣ Artikel Islami & Edukasi
- Menggunakan data lokal dari:
  - `assets/data/articles.json`
- Menyajikan artikel edukatif dan bernuansa Islami

---

### 8️⃣ Project Islami
- Referensi project IoT dan elektronika bernuansa Islami
- Data lokal berbasis JSON
- Ditujukan sebagai inspirasi pembelajaran dan pengembangan

---

## 🛠 Teknologi yang Digunakan
- **Flutter**
- **Dart**
- **REST API (NewsAPI)**
- **Local JSON Assets**
- **Material Design**

---

## 👩‍💻 Developer
**Sheila Apriliani Putri**  
Praktikum Pemrograman Mobile — UAS

---

## 📌 Catatan
- Aplikasi ini bersifat edukatif
- Beberapa fitur seperti logout masih berupa placeholder
- Koneksi internet diperlukan untuk fitur berita (API)

