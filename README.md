# 📱 BitCurious — Aplikasi Mobile Edukasi Elektronika & IoT

**BitCurious** adalah aplikasi mobile edukatif berbasis **Flutter** yang dirancang untuk membantu pengguna mempelajari **komponen elektronika dan Internet of Things (IoT)** secara interaktif, terstruktur, dan relevan dengan perkembangan teknologi.  
Aplikasi ini juga mengintegrasikan **nilai-nilai keislaman** melalui referensi project Islami yang mengaitkan teknologi dengan kemaslahatan umat.

Project ini dikembangkan sebagai bagian dari **Ujian Akhir Semester (UAS) Praktikum Mobile Programming**.

---

## 🔗 Sumber Data & API

Aplikasi BitCurious menggunakan **RESTful API publik** sebagai sumber data utama, sehingga data yang ditampilkan bersifat **real-time** dan tidak menggunakan data statis (*hardcoded*).

### 📦 API Utama (Vercel JSON)
- **Komponen Elektronika & IoT**  
  https://bitcurious-json.vercel.app/components.json

- **Artikel Edukasi IoT**  
  https://bitcurious-json.vercel.app/articles.json

- **Project IoT Bernuansa Islami**  
  https://bitcurious-json.vercel.app/projects.json

- **Gambar Komponen**  
  https://bitcurious-json.vercel.app/assets/images/

### 🌐 API Tambahan
- **NewsAPI**  
  Digunakan untuk menampilkan berita teknologi dan IoT terkini secara real-time.

---

## 🚀 Fitur Utama

### 1️⃣ Splash Screen
- Halaman pembuka aplikasi dengan branding **BitCurious**
- Transisi awal sebelum masuk ke Home Screen

---

### 2️⃣ Home Page
- Sapaan personal (contoh: *Hello, Sheila!*)
- **Search Bar** untuk mencari:
  - Komponen
  - Artikel
  - Project Islami
- **Tab Navigation**:
  - Komponen
  - Artikel
  - Project Islami
  - Pinned
- **Bottom Navigation Bar**:
  - 🧩 Komponen
  - 📚 Artikel
  - ⚡ Project
  - 📌 Pinned
  - 📝 Notes
- **Drawer (Sidebar)**:
  - Profil pengguna
  - Home
  - Berita Teknologi (NewsAPI)
  - About Us

---

### 3️⃣ Kategori Komponen
Menampilkan pengelompokan komponen berdasarkan fungsi:
- Controllers & Processing Units
- Input & Sensing Devices
- Output & Actuation Devices
- Connectivity & Power Modules
- All (menampilkan semua komponen)

---

### 4️⃣ List Komponen
- Data diambil dari API `components.json`
- Menampilkan:
  - Gambar komponen
  - Nama komponen
  - Deskripsi singkat
  - Harga (format Rupiah)
- Tap item → Detail Komponen

---

### 5️⃣ Detail Komponen & Pinned
- Menampilkan:
  - Gambar komponen
  - Nama & kategori
  - Harga
  - Deskripsi lengkap (*Read More / Read Less*)
- **Fitur Pinned**:
  - Menyimpan komponen favorit
  - Menghapus dari pinned
  - Notifikasi menggunakan **SnackBar**

---

### 6️⃣ Pinned Components Page
- Menampilkan semua komponen yang telah di-*pin*
- Akses dari Bottom Navigation dan Drawer
- Tap item → Detail Komponen
- Unpin langsung dari daftar

---

### 7️⃣ Artikel Edukasi IoT
- Data dari `articles.json`
- Menampilkan:
  - Judul artikel
  - Ringkasan singkat
  - Sumber artikel
- Tap artikel → membuka link web asli menggunakan browser

---

### 8️⃣ Project Islami
- Referensi project IoT bernuansa Islami
- Setiap project memuat:
  - Judul
  - Deskripsi
  - Dalil Al-Qur’an atau Hadis
  - Daftar komponen
- Bertujuan mengintegrasikan teknologi dengan nilai ibadah dan kemaslahatan umat

---

### 9️⃣ Notes Page
- Fitur catatan pribadi untuk pengguna
- Digunakan untuk:
  - Ide project
  - Ringkasan materi
  - Catatan komponen penting
- Data disimpan secara lokal

---

### 🔟 Berita Teknologi (NewsAPI)
- Menampilkan berita teknologi & IoT terkini
- Diakses melalui Drawer Menu dan halaman News
- Tap berita → membuka artikel web asli

---

## 🛠 Teknologi yang Digunakan
- **Flutter**
- **Dart**
- **RESTful API**
- **HTTP Request & JSON Parsing**
- **NewsAPI**
- **Material Design**
- **Asynchronous Programming**

---

## 👩‍💻 Developer
**Sheila Apriliani Putri**  
230605110005 - Mahasiswa Teknik Informatika  
Praktikum Mobile Programming — UAS  

---

## 📌 Catatan
- Aplikasi bersifat edukatif dan non-komersial
- Koneksi internet diperlukan untuk fitur API
- Struktur project dibuat modular agar mudah dikembangkan

