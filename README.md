# Postgresql-transactions-acid-lab
Praktikum Basis Data: PostgreSQL Transactions &amp; ACID properties. Includes setup script, multi-session demos, and isolation level experiments using DBeaver/pgAdmin.

_Praktikum Basis Data: Transaksi dan properti ACID di PostgreSQL. Termasuk skrip setup, eksperimen dua sesi, dan isolasi transaksi._

> Struktur Repository
> Setup
- transaksi_acid_setup.sql
> Experiment


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
