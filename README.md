sheila cantik
# 📱 BitCurious — Flutter Mobile App

**BitCurious** adalah aplikasi edukatif berbasis Flutter yang memperkenalkan **komponen elektronika dan IoT** secara interaktif.  
Aplikasi ini menampilkan berbagai **komponen, referensi proyek Islami, dan artikel** yang dapat diakses langsung dari UI modern dengan dukungan data JSON lokal.

---

## 🚀 Fitur Utama
- Splash Screen dengan desain elegan.  
- Daftar komponen elektronika berbasis JSON.  
- Halaman detail komponen dengan gambar dan deskripsi.  
- Referensi proyek Islami dengan popup alat & bahan.  
- Artikel Islami yang edukatif dan inspiratif.  
- Fitur “Saved Pages” untuk menyimpan komponen favorit.  

---

## 📂 Struktur Folder

```
BITCURIOUS/
├── android/
├── ios/
├── linux/
├── macos/
├── web/
├── windows/
│
├── assets/
│   ├── data/
│   │   ├── components.json
│   │   └── projects.json
│   ├── fonts/
│   └── images/
│
├── lib/
│   ├── pages/
│   │   ├── articles_pages.dart
│   │   ├── component_detail_pages.dart
│   │   ├── component_list_pages.dart
│   │   ├── home_pages.dart
│   │   ├── project_detail_page.dart
│   │   ├── project_references_pages.dart
│   │   ├── saved_pages.dart
│   │   ├── splash_pages.dart
│   │   └── notes.txt
│   └── main.dart
│
├── pubspec.yaml
├── pubspec.lock
├── analysis_options.yaml
└── .gitignore
```

---

## 🧠 Data JSON

Semua data komponen dan proyek disimpan di:
```
assets/data/
```

**Contoh `projects.json`:**
```json
[
  {
    "title": "Sensor Kelembaban Tanah Otomatis",
    "desc": "Proyek untuk mengukur kelembaban tanah menggunakan sensor YL-69.",
    "dalil": "QS. Al-Anbiya: 30",
    "alat_bahan": [
      "Sensor YL-69",
      "Arduino UNO",
      "Kabel Jumper",
      "Pompa Air Mini",
      "Power Supply"
    ]
  }
]
```

---

## 🛠️ Cara Menjalankan Proyek

1. Pastikan sudah menginstal **Flutter SDK**.  
2. Clone repositori ini:
   ```bash
   git clone https://github.com/username/bitcurious.git
   ```
3. Masuk ke folder proyek:
   ```bash
   cd bitcurious
   ```
4. Unduh dependency:
   ```bash
   flutter pub get
   ```
5. Jalankan aplikasi:
   ```bash
   flutter run
   ```

---

## 🎨 Desain dan Warna
- Warna utama: `#0B0C3A`  
- Warna sekunder: Putih dan abu-abu lembut  
- Ikon: Menggunakan `Icons` Flutter  
- Font: Disimpan di `assets/fonts/`

---

## 🧩 Catatan Teknis
- Data diambil dari file JSON lokal menggunakan `DefaultAssetBundle`.  
- Detail proyek ditampilkan lewat **popup dialog (`showDialog`)**.  
- Tanpa model/service terpisah (langsung dari JSON).  
- Menggunakan **StatefulWidget** agar UI lebih interaktif.  

---

## 👩‍💻 Developer
**Sheila Apriliani Putri**  
Program Studi Teknik Informatika — UIN Malang  
📧 230605110005@student.uin-malang.ac.id
Mobile Programming & Practicum (C)
Untuk Memenuhi Tugas Ujian Tengah Semester (UTS)

---

> “Teknologi adalah alat, niat baik adalah arah. Dengan keduanya, kita membangun masa depan yang bermanfaat.”
=======
# 📱 BitCurious — Aplikasi Mobile Edukasi Elektronika & IoT

**BitCurious** adalah aplikasi edukatif berbasis **Flutter** yang dirancang untuk membantu pengguna mengenal **komponen elektronika dan IoT** secara interaktif, terstruktur, dan tetap bernuansa Islami.  

Aplikasi ini menggabungkan:
- 📂 **Data lokal (JSON)** untuk komponen & project,
- 🌐 **API publik NewsAPI** untuk berita teknologi & IoT terkini.

Cocok sebagai:
- Media belajar komponen elektronika & IoT,
- Referensi tugas / praktikum,
- Project UAS Mobile Programming.  

---

## 🚀 Fitur Utama

### 1️⃣ Splash Screen Elegan
- Halaman pembuka dengan branding **BitCurious**.
- Memberi transisi lembut sebelum masuk ke Home.

### 2️⃣ Home Page Interaktif
- **Welcome section**: sapaan personal *“Hello, Sheila!”*.
- **Search berita**:
  - Terhubung ke **NewsAPI (API Publik)**.
  - Pengguna bisa mencari berita teknologi/IoT (mis: `esp32`, `sensor`, `AI`, dll).
- **Tab & Bottom Navigation**:
  - `Komponen` → daftar kategori komponen.
  - `Artikel` → artikel edukatif bernuansa Islami.
  - `Project Islami` → referensi project IoT islami.
  - `Pinned` → komponen favorit yang disimpan pengguna.

### 3️⃣ Kategori Komponen (Halaman Komponen)
- Menampilkan **kategori** berdasarkan key di `components.json`, misalnya:
  - `Controller & Processing Units`
  - `Input & Sensing Devices`
  - `Output & Actuation Devices`
  - `Connectivity & Power Modules`
- Tersedia kategori khusus **“All”** untuk melihat semua komponen.

### 4️⃣ List Komponen per Kategori
- Setelah kategori dipilih, pengguna diarahkan ke halaman **list komponen**:
  - Menampilkan **nama komponen, harga, deskripsi singkat**, dan gambar.
  - Data diambil dari `assets/data/components.json`.

### 5️⃣ Detail Komponen
- Halaman detail menampilkan:
  - Gambar komponen.
  - Deskripsi lengkap (dengan efek **Read more / Read less**).
  - Kategori dan harga.
  - Tombol **“Add to Pinned / Pinned”** untuk menyimpan atau menghapus dari favorit.
- Data pinned disimpan secara global melalui repository sederhana.

### 6️⃣ Pinned Components (Favorit)
- Halaman khusus yang menampilkan **daftar semua komponen yang dipinned** oleh pengguna.
- Bisa:
  - Tap item untuk membuka detail lagi.
  - Hapus dari pinned langsung dari list.

### 7️⃣ Artikel Islami & Edukasi
- Halaman **Artikel & Edukasi**:
  - Data berasal dari `assets/data/articles.json`.
  - Terdapat dialog **“Read More”** untuk membaca isi artikel lebih lengkap.
  - Artikel bernuansa edukasi & Islami, mendukung konsep teknologi yang bermanfaat.

### 8️⃣ Project References Bernuansa Islami
- Menggunakan `assets/data/projects.json`.
- Menampilkan:
  - Judul project,
  - Deskripsi singkat,
  - Dalil ayat / hadits terkait,
  - Alat & bahan dalam bentuk list.
- Detail project ditampilkan dalam halaman khusus / dialog yang rapi.

### 9️⃣ Berita Teknologi & IoT (NewsAPI)
- Menggunakan **API publik NewsAPI**:
  - Endpoint technology / query kata kunci.
  - Ditampilkan dalam halaman khusus `NewsPage`.
- Pengguna bisa:
  - Mencari berita terkait IoT, AI, elektronik, dsb.
  - Melihat ringkasan, sumber, tanggal publikasi.
  - Membuka detail berita dalam dialog dengan gambar (jika tersedia).

---

## 🧠 Sumber Data

### 1. Data Lokal (JSON)
Semua data lokal disimpan di:

```text
assets/data/
  ├── components.json   # Komponen elektronika & IoT (per kategori)
  ├── projects.json     # Project Islami (judul, deskripsi, dalil, alat_bahan)
  └── articles.json     # Artikel Islami / edukasi
>>>>>>> Stashed changes
