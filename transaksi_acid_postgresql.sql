-- Transaksi dan ACID di PostgreSQL

--🔹 Atomicity, COMMIT, dan ROLLBACK

-- >> Atomicity menjamin bahwa semua langkah dalam transaksi berhasil bersama-sama atau dibatalkan seluruhnya.

-- 1. Buka Session A, Set Schema
-- Session A
SET search_path TO lab_simple;

-- 2. Jalankan transaksi
BEGIN;
INSERT INTO orders(id, customer, status) VALUES (1, 'Rina', 'NEW');
INSERT INTO order_items(order_id, sku, qty, price) VALUES (1, 'SKU-01', 2, 30000);
UPDATE stock SET qty = qty - 2 WHERE sku = 'SKU-01';
-- Note > COMMIT belum dijalankan

-- Session B tidak akan melihat perubahan:
-- 3. Di Session B, cek isi tabel:
-- Session B
SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM stock;

-- 4. Ke Session A, Jalankan
COMMIT;

-- 5. Ulangi SELECT di kedua sesi untuk melihat perubahan.

SELECT * FROM orders;
SELECT * FROM order_items;
SELECT * FROM stock;

-- 🔹 Demonstrasi ROLLBACK

-- >> Rollback membatalkan semua perubahan jika terjadi kesalahan.

-- 1. Session A, Jalankan
SET search_path TO lab_simple;
BEGIN;
INSERT INTO order_items(order_id, sku, qty, price)
VALUES ((SELECT max(id) FROM orders), 'SKU-02', 4, 250000);
UPDATE stock SET qty = qty - 1 WHERE sku='SKU-02';

-- 2. ROLLBACK digunakan (Membatalkan Transaksi)
ROLLBACK;

-- 3. Setelah rollback, tidak ada perubahan yang terlihat.

-- 🔹 Penggunaan SAVEPOINT

-- Savepoint memungkinkan rollback sebagian dalam transaksi.

-- Session A, Jalankan transaksi dengan savepoint
BEGIN;
UPDATE stock SET qty = qty - 1 WHERE sku='SKU-01' AND qty >= 1;
SAVEPOINT s1;
UPDATE stock SET qty = qty - 5 WHERE sku='SKU-01' AND qty >= 5;
ROLLBACK TO s1;
UPDATE stock SET qty = qty - 1 WHERE sku='SKU-01' AND qty >= 1;
COMMIT;

-- Hanya update pertama dan ketiga yang dijalankan. Update kedua dibatalkan.

-- 🔹 Isolation Level: READ COMMITTED

-- Setiap perintah melihat data terbaru yang sudah di-commit.

-- 1. Session A
BEGIN;
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT id, owner, balance FROM accounts ORDER BY id; -- Snapshot A1
-- Note > Jangan commit dulu

-- 2. Session B
BEGIN;
UPDATE accounts SET balance = balance + 50 WHERE id=2;
COMMIT;

-- 3. Session A
SELECT id, owner, balance FROM accounts ORDER BY id; -- Snapshot A2
COMMIT;

-- Snapshot A2 akan menunjukkan saldo yang sudah diperbarui.

--🔹 Isolation Level: REPEATABLE READ

-- Seluruh transaksi menggunakan snapshot yang konsisten.

-- 1. Session A
BEGIN;
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SELECT id, owner, balance FROM accounts ORDER BY id; -- Snapshot R1
-- Note > Jangan commit dulu

-- 2. Session B
BEGIN;
UPDATE accounts SET balance = balance + 20 WHERE id=1;
COMMIT;

-- 3. Session A
SELECT id, owner, balance FROM accounts ORDER BY id; -- Snapshot R2
COMMIT;

-- Snapshot R2 akan sama dengan R1, menunjukkan isolasi.

-- 🔹 Isolation Level: SERIALIZABLE

-- Menjamin transaksi berjalan seolah-olah dieksekusi satu per satu.

-- 1. Session A
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE accounts SET balance = balance + 5 WHERE id=1;
-- Note > Tunda COMMIT

-- 2. Session B
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE accounts SET balance = balance + 3 WHERE id=1;
COMMIT; -- Bisa berhasil atau gagal

-- 3. Session A
COMMIT; -- Bisa gagal dengan pesan "could not serialize access..."

-- Jika terjadi konflik, salah satu transaksi akan dibatalkan.
