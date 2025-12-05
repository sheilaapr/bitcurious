# 📱 BitCurious — Aplikasi Mobile Edukasi Elektronika & IoT

**BitCurious** adalah aplikasi edukatif berbasis **Flutter** yang dirancang untuk membantu pengguna mengenal **komponen elektronika dan Internet of Things (IoT)** secara interaktif, terstruktur, dan tetap bernuansa Islami.

Aplikasi ini menggabungkan dua sumber data utama:

- 📂 **Data lokal (JSON)** → komponen elektronika/IoT, artikel edukatif, dan referensi project Islami  
- 🌐 **API publik NewsAPI** → berita teknologi & IoT terkini yang diambil langsung dari internet  

Proyek ini dikembangkan sebagai **tugas Ujian Akhir Semester (UAS) Praktikum Pemrograman Mobile**.

---

## 🚀 Fitur Utama

### 1️⃣ Splash Screen Elegan
- Halaman pembuka dengan branding **BitCurious**
- Memberikan transisi lembut sebelum masuk ke halaman utama (Home)

---

### 2️⃣ Home Page Interaktif
- **Welcome section** dengan sapaan personal, contoh: `Hello, Sheila!`
- **Search bar berita**:
  - Terhubung ke **NewsAPI (API publik)**
  - Bisa mencari berita teknologi/IoT (mis: `esp32`, `sensor`, `AI`, dll)
  - Mengarahkan ke halaman **Berita Teknologi & IoT**
- **Tab kecil di dalam konten putih**:
  - `Komponen`
  - `Artikel`
  - `Project Islami`
- **Bottom Navigation Bar (4 menu utama)**:
  - 🧩 `Komponen` → daftar kategori & list komponen  
  - 📚 `Artikel` → artikel edukatif dan Islami  
  - ⚡ `Project` → project references bernuansa Islami  
  - 📌 `Pinned` → daftar komponen favorit yang sudah disimpan pengguna  

- **Drawer (Sidebar)**:
  - Profil singkat pengguna
  - Menu **Home**
  - Menu **Berita Teknologi (API Publik NewsAPI)**
  - Menu **About Us**
  - Tombol **Logout** (placeholder)

---

### 3️⃣ Kategori Komponen (Components Categories Page)
- Menampilkan kategori komponen berdasarkan key di `components.json`, seperti:
  - `Controller & Processing Units`
  - `Input & Sensing Devices`
  - `Output & Actuation Devices`
  - `Connectivity & Power Modules`
- Tersedia kategori khusus **“All”** untuk menampilkan semua komponen

---

### 4️⃣ List Komponen per Kategori
- Setelah kategori dipilih, pengguna diarahkan ke halaman list komponen:
  - Menampilkan **gambar, nama, harga, dan deskripsi singkat**
  - Data diambil dari `assets/data/components.json`
- Tap salah satu komponen → masuk ke halaman **detail komponen**

---

### 5️⃣ Detail Komponen + Fitur Pinned
- Halaman detail komponen memuat:
  - Gambar komponen resolusi lokal
  - Nama & kategori
  - Harga (format rupiah)
  - Deskripsi lengkap dengan efek **Read more / Read less**
- Tombol **“Add to Pinned / Pinned”**:
  - Menyimpan komponen ke daftar favorit menggunakan `PinnedRepository`
  - Menampilkan `SnackBar` ketika komponen ditambahkan atau dihapus dari pinned
- Status pinned tersinkron dengan:
  - Tombol di halaman detail
  - List di halaman **Pinned Components**
  - Menu **Pinned** di Bottom Navigation

---

### 6️⃣ Pinned Components Page (akses dari Bottom Nav & Drawer)
- Halaman khusus untuk melihat semua komponen yang sudah di-pin
- Fitur:
  - Tap item → membuka kembali detail komponen (dengan tombol pinned sinkron)
  - Tombol pin merah di list → menghapus komponen dari pinned
- Data disimpan secara global di `PinnedRepository` sehingga:
  - Pinned tetap konsisten meskipun pengguna berpindah halaman
  - Halaman ini bisa dibuka dari:
    - Bottom Navigation (`Pinned`)
    - Menu `Pinned Components` (jika ditambahkan di drawer)

---

### 7️⃣ Artikel Islami & Edukasi
- Menggunakan data lokal dari:

  ```text
  assets/data/articles.json
