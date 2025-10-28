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

## 👩‍💻 Pengembang
**Sheila Apriliani Putri**  
Program Studi Teknik Informatika — UIN Malang  
📧 sheila@example.com  

---

> “Teknologi adalah alat, niat baik adalah arah. Dengan keduanya, kita membangun masa depan yang bermanfaat.”
