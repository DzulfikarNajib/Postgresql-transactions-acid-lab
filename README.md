# Postgresql-transactions-acid-lab
Praktikum Basis Data: PostgreSQL Transactions &amp; ACID properties. Includes setup script, multi-session demos, and isolation level experiments using DBeaver/pgAdmin.

_Praktikum Basis Data: Transaksi dan properti ACID di PostgreSQL. Termasuk skrip setup, eksperimen dua sesi, dan isolasi transaksi._

> Struktur Repository
> Setup
- transaksi_acid_setup.sql
> Experiment
- transaksi_acid_postgresql.sql


> Setup Database

File `transaksi_acid_setup.sql` berisi struktur dan data awal untuk schema `lab_simple` yang digunakan dalam praktikum ini.

> Cara Menjalankan:
1. Buka DBeaver atau pgAdmin.
2. Jalankan file `transaksi_acid_setup.sql` di SQL Console.
3. Pastikan schema `lab_simple` dan tabel berikut sudah tersedia:
   - `stock`
   - `orders`
   - `order_items`
   - `accounts`
4. Buka dua sesi SQL (Session A dan Session B).
5. Jalankan skrip eksperimen di folder `experiments/`:
   - *Atomicity*: `BEGIN`, `COMMIT`, `ROLLBACK`
   - *Savepoint*: rollback sebagian
   - *Isolation Levels*: `READ COMMITTED`, `REPEATABLE READ`, `SERIALIZABLE`
6. Amati hasil di kedua sesi.
7. Jawab pertanyaan praktikum di file `answers.md`.

> Hasil
- Memahami konsep *ACID* dalam transaksi basis data.
- Mempelajari perintah `BEGIN`, `COMMIT`, `ROLLBACK`, dan `SAVEPOINT`.
- Mengamati efek isolation level: **READ COMMITTED**, **REPEATABLE READ**, **SERIALIZABLE**.
- Melatih penggunaan multi-session untuk melihat efek isolasi.

> Referensi
- Modul Praktikum Basis Data IPB Semester Ganjil 2025/2026

> Kontributor
- Dzulfikar Najib (M0401241043) - IPB Statistika dan Sains Data
