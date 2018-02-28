-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: 28 Feb 2018 pada 10.12
-- Versi Server: 10.1.25-MariaDB
-- PHP Version: 5.6.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pmc1`
--

-- --------------------------------------------------------

--
-- Stand-in structure for view `barang_laris`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `barang_laris` (
`kode_barang` varchar(30)
,`nama_barang` varchar(50)
,`jumlah` bigint(21)
,`satuan` varchar(10)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `menu`
--

CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL,
  `nama_menu` varchar(50) NOT NULL,
  `posisi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `menu`
--

INSERT INTO `menu` (`id_menu`, `nama_menu`, `posisi`) VALUES
(4, 'Barang', 2),
(5, 'Master', 1),
(6, 'Transaksi', 3),
(7, 'Laporan', 5),
(8, 'Retur Barang', 4);

-- --------------------------------------------------------

--
-- Struktur dari tabel `modul`
--

CREATE TABLE `modul` (
  `id_modul` int(11) NOT NULL,
  `id_menu` int(11) NOT NULL,
  `nama_modul` varchar(150) NOT NULL,
  `link_menu` text NOT NULL,
  `posisi` int(11) NOT NULL,
  `icon_menu` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `modul`
--

INSERT INTO `modul` (`id_modul`, `id_menu`, `nama_modul`, `link_menu`, `posisi`, `icon_menu`) VALUES
(6, 4, 'Kategori Barang', 'med.php?mod=kategori', 1, 'fa fa-folder-open'),
(7, 4, 'Data Barang', 'med.php?mod=barang', 2, 'fa fa-cubes'),
(8, 5, 'Data Pelanggan', 'med.php?mod=pelanggan', 1, 'fa fa-group'),
(9, 5, 'Data Supplier', 'med.php?mod=supplier', 2, 'fa fa-user'),
(10, 6, 'Transaksi Penjualan', 'med.php?mod=penjualan', 1, 'fa fa-shopping-cart'),
(11, 6, 'Data Transaksi Penjualan', 'med.php?mod=penjualan&act=list', 2, 'fa fa-book'),
(12, 6, 'Data Transaksi Pembelian', 'med.php?mod=pembelian', 3, 'fa fa-truck'),
(13, 7, 'Laporan Stok Barang', 'med.php?mod=laporan&act=stokbarang', 1, 'fa fa-line-chart'),
(14, 7, 'Laporan Barang Terlaris', 'med.php?mod=laporan&act=laplaris', 2, 'fa fa-pie-chart'),
(15, 7, 'Laporan Transaksi Pembelian', 'med.php?mod=laporan&act=belilist', 3, 'fa fa-print'),
(16, 7, 'Laporan Transaksi Penjualan', 'med.php?mod=laporan&act=juallist', 4, 'fa fa-print'),
(17, 8, 'Retur Penjualan', 'med.php?mod=returpenjualan', 1, 'fa fa-cart-arrow-down'),
(18, 8, 'Retur Pembelian', 'med.php?mod=returpembelian', 2, 'fa fa-cart-arrow-down');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_barang`
--

CREATE TABLE `tb_barang` (
  `kode_barang` varchar(30) NOT NULL,
  `nama_barang` varchar(50) NOT NULL,
  `harga_beli` int(50) NOT NULL,
  `harga_jual` int(50) NOT NULL,
  `kategori_id` char(5) NOT NULL,
  `jml_stok` int(11) NOT NULL,
  `satuan` varchar(10) NOT NULL,
  `kode_supplier` varchar(10) NOT NULL,
  `deskripsi` varchar(300) NOT NULL,
  `tgl_input` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_barang`
--

INSERT INTO `tb_barang` (`kode_barang`, `nama_barang`, `harga_beli`, `harga_jual`, `kategori_id`, `jml_stok`, `satuan`, `kode_supplier`, `deskripsi`, `tgl_input`) VALUES
('BOSCH02', 'Mesin Bor BOSCH 02', 250000, 300000, 'P001', 49, 'unit', 'BSCH', 'BOR kayu', '2018-01-02'),
('BSCH01', 'Mesin Bor BOSCH 01', 1000000, 3000000, 'P001', 20, 'unit', 'BSCH', 'Mesin Bor Besi', '2018-01-01'),
('DRML01', 'Dremel Dry', 250000, 350000, 'P001', 10, 'unit', 'DRML', 'Mesin Pengering', '2018-01-18'),
('DRML2', 'Dremel 3000 ', 2000000, 2350000, 'P001', 1, 'unit', 'BSCH', 'Mesin Bor Tuner', '2018-02-28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_detail_pembelian`
--

CREATE TABLE `tb_detail_pembelian` (
  `no_faktur` varchar(30) NOT NULL,
  `kode_barang` varchar(30) NOT NULL,
  `harga_beli` double(10,2) NOT NULL,
  `qty` int(4) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_detail_pembelian`
--

INSERT INTO `tb_detail_pembelian` (`no_faktur`, `kode_barang`, `harga_beli`, `qty`, `petugas`, `timestmp`) VALUES
('bc123', 'BSCH01', 950000.00, 4, 1, '2018-02-28 14:14:13'),
('CG552', 'BSCH01', 2500000.00, 1, 1, '2018-02-28 15:34:12'),
('PA1234', 'BSCH01', 900000.00, 3, 1, '2018-02-28 14:07:45'),
('PA12342', 'BOSCH02', 200000.00, 3, 1, '2018-02-28 14:08:25'),
('PA1245', 'BOSCH02', 200000.00, 4, 1, '2018-02-28 14:10:07'),
('TR001', 'AD00001', 56000.00, 10, 1, '2016-08-03 22:29:09'),
('TR001', 'AD00006', 132000.00, 10, 1, '2016-08-03 22:29:09'),
('TR002', 'AD00001', 55000.00, 2, 1, '2016-08-03 22:35:02'),
('TR002', 'AD00008', 148000.00, 15, 1, '2016-08-03 22:35:02');

--
-- Trigger `tb_detail_pembelian`
--
DELIMITER $$
CREATE TRIGGER `after_insert_tmp_beli` AFTER INSERT ON `tb_detail_pembelian` FOR EACH ROW BEGIN
	DELETE FROM tb_detail_pembelian_tmp 
	WHERE kode_barang = NEW.kode_barang 
	AND petugas = NEW.petugas;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_detail_pembelian_tmp`
--

CREATE TABLE `tb_detail_pembelian_tmp` (
  `kode_barang` varchar(30) NOT NULL,
  `harga_beli` double(10,2) NOT NULL,
  `qty` int(4) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_detail_penjualan`
--

CREATE TABLE `tb_detail_penjualan` (
  `no_transaksi` varchar(30) NOT NULL,
  `kode_barang` varchar(30) NOT NULL,
  `qty` int(4) NOT NULL,
  `harga` double(10,2) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_detail_penjualan`
--

INSERT INTO `tb_detail_penjualan` (`no_transaksi`, `kode_barang`, `qty`, `harga`, `petugas`, `timestmp`) VALUES
('28021800011', 'BOSCH02', 3, 300000.00, 1, '2018-02-28 13:55:10'),
('28021800012', 'BOSCH02', 0, 300000.00, 1, '2018-02-28 15:17:23'),
('28021800013', 'BOSCH02', 1, 300000.00, 1, '2018-02-28 15:26:00'),
('CA03081600001', 'BOSCH02', 1, 300000.00, 1, '2016-08-03 21:07:14'),
('CA03081600002', 'AD00001', 1, 150000.00, 1, '2016-08-03 21:13:05'),
('CA03081600002', 'AD00003', 1, 150000.00, 1, '2016-08-03 21:13:06'),
('CA03081600002', 'AD00004', 1, 150000.00, 1, '2016-08-03 21:13:07'),
('CA03081600002', 'AD00005', 1, 150000.00, 1, '2016-08-03 21:13:09');

--
-- Trigger `tb_detail_penjualan`
--
DELIMITER $$
CREATE TRIGGER `after_insert_delete_tmp` AFTER INSERT ON `tb_detail_penjualan` FOR EACH ROW BEGIN
	DELETE FROM tb_detail_penjualan_tmp 
	WHERE kode_barang = NEW.kode_barang 
	AND petugas = NEW.petugas;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_detail_penjualan_tmp`
--

CREATE TABLE `tb_detail_penjualan_tmp` (
  `kode_barang` varchar(50) NOT NULL,
  `harga` double(10,2) NOT NULL,
  `disc` double(10,2) NOT NULL,
  `qty` int(4) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_kategori_barang`
--

CREATE TABLE `tb_kategori_barang` (
  `kategori_id` char(5) NOT NULL,
  `nama_kategori` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_kategori_barang`
--

INSERT INTO `tb_kategori_barang` (`kategori_id`, `nama_kategori`) VALUES
('P001', 'Perkakas Mesin');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_log`
--

CREATE TABLE `tb_log` (
  `id_log` int(11) NOT NULL,
  `deskripsi` text NOT NULL,
  `timestmp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_log`
--

INSERT INTO `tb_log` (`id_log`, `deskripsi`, `timestmp`) VALUES
(26, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>CA03081600001', '2016-08-03 21:07:25'),
(27, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>CA03081600002', '2016-08-03 21:13:24'),
(28, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>CA04081600001', '2016-08-04 13:33:06'),
(29, '<span class=\'w3-text-red\'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :CA04081600001', '2016-08-04 13:34:36'),
(30, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>28021800011', '2018-02-28 13:58:20'),
(31, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>28021800012', '2018-02-28 15:18:26'),
(32, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>28021800013', '2018-02-28 15:28:04'),
(33, '<span class=\'w3-text-red\'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :28021800012', '2018-02-28 15:29:38'),
(34, '<span class=\'w3-text-red\'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :CA28021800010', '2018-02-28 15:29:49'),
(35, '<span class=\'w3-text-red\'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :CA28021800008', '2018-02-28 15:29:56'),
(36, '<span class=\'w3-text-red\'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :CA28021800009', '2018-02-28 15:30:00'),
(37, '<span class=\'w3-text-red\'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :CA28021800007', '2018-02-28 15:31:18'),
(38, '<span class=\'w3-text-red\'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :CA28021800003', '2018-02-28 15:36:24');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pelanggan`
--

CREATE TABLE `tb_pelanggan` (
  `email_pelanggan` varchar(50) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `nomor_telp` varchar(50) NOT NULL,
  `alamat` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_pelanggan`
--

INSERT INTO `tb_pelanggan` (`email_pelanggan`, `nama_pelanggan`, `nomor_telp`, `alamat`) VALUES
('ebypunya@gmail.com', 'febri', '082115802500', 'jalan perak no 20, bandung'),
('ekafitrinh@gmail.com', 'eka fitri', '0888888888', 'jalan ahmad yani'),
('vicka.rachma@yahoo.com', 'vicka', '08112255445', 'jalan kiaracondong');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_pembelian`
--

CREATE TABLE `tb_pembelian` (
  `no_faktur` varchar(30) NOT NULL,
  `kode_supplier` varchar(10) NOT NULL,
  `nama_toko` varchar(50) NOT NULL,
  `tgl_beli` date NOT NULL,
  `nama_kasir` varchar(50) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_pembelian`
--

INSERT INTO `tb_pembelian` (`no_faktur`, `kode_supplier`, `nama_toko`, `tgl_beli`, `nama_kasir`, `petugas`, `timestmp`) VALUES
('bc123', 'BSCH', 'BOSCH', '2018-02-28', 'Rudi', 1, '2018-02-28 14:14:13'),
('CG552', 'UAP', 'PT. UAP AIR', '2018-02-28', 'Eka', 1, '2018-02-28 15:34:12'),
('PA1234', 'BSCH', 'BOSCH', '2018-02-28', 'Rudi', 1, '2018-02-28 14:07:45'),
('PA12342', 'BSCH', 'BOSCH', '2018-02-28', 'Rudi', 1, '2018-02-28 14:08:25'),
('PA1245', 'BSCH', 'BOSCH', '2018-02-28', 'Rudi', 1, '2018-02-28 14:10:07');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_penjualan`
--

CREATE TABLE `tb_penjualan` (
  `no_transaksi` varchar(30) NOT NULL,
  `email_pelanggan` varchar(20) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `tgl_transaksi` date NOT NULL,
  `petugas` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  `bayar` double(10,2) NOT NULL,
  `potongan` double(10,2) NOT NULL,
  `timestmp` datetime NOT NULL,
  `alamat` varchar(60) NOT NULL,
  `kota` varchar(30) NOT NULL,
  `tlp` varchar(20) NOT NULL,
  `kurir` int(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_penjualan`
--

INSERT INTO `tb_penjualan` (`no_transaksi`, `email_pelanggan`, `nama_pelanggan`, `tgl_transaksi`, `petugas`, `status`, `bayar`, `potongan`, `timestmp`, `alamat`, `kota`, `tlp`, `kurir`) VALUES
('28021800011', 'ebypunya@gmail.com', 'febri', '2018-02-28', 1, 'TOKO', 920000.00, 0.00, '2018-02-28 13:58:20', 'jalan perak no 20', 'Bandung', '082115802500', 20000),
('28021800013', '', 'Bapak Roni', '2018-02-28', 1, 'TOKO', 300000.00, 5000.00, '2018-02-28 15:28:04', 'Cicadas', 'Bandung', '022-225135', 0),
('CA03081600001', 'P0001', 'ADE INDRA SAPUTRA', '2016-08-03', 1, 'LUNAS', 150000.00, 20000.00, '2016-08-03 21:07:25', '0', '0', '0', 0),
('CA03081600002', 'P0002', 'JAYA MOTOR', '2016-08-03', 1, 'LUNAS', 600000.00, 0.00, '2016-08-03 21:13:24', '0', '0', '0', 0),
('CA28021800001', 'P0002', 'JAYA MOTOR', '2018-02-28', 1, 'LUNAS', 750000.00, 0.00, '2018-02-28 05:20:02', '0', '0', '0', 0),
('CA28021800002', 'P0001', 'ADE INDRA SAPUTRA', '2018-02-28', 1, 'LUNAS', 150000.00, 0.00, '2018-02-28 10:37:15', '0', '0', '0', 0),
('CA28021800004', 'P0001', 'ADE INDRA SAPUTRA', '2018-02-28', 1, 'LUNAS', 150000.00, 0.00, '2018-02-28 11:12:52', 'jalan perak no 20', 'Bandung', '2147483647', 0),
('CA28021800005', 'P0002', 'JAYA MOTOR', '2018-02-28', 1, 'TOKO', 150000.00, 0.00, '2018-02-28 11:15:17', 'jalan perak no 20', 'Bandung', '082115802500', 0),
('CA28021800006', 'P0001', 'ADE INDRA SAPUTRA', '2018-02-28', 1, 'TOKO', 145000.00, 5000.00, '2018-02-28 11:29:02', 'jalan perak no 20', 'Bandung', '082115802500', 0);

--
-- Trigger `tb_penjualan`
--
DELIMITER $$
CREATE TRIGGER `after_delete_penjualan` AFTER DELETE ON `tb_penjualan` FOR EACH ROW BEGIN
	INSERT INTO tb_log(deskripsi, timestmp) 
	VALUES(CONCAT("<span class='w3-text-red'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :", OLD.no_transaksi), NOW());
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_insert_penjualan` AFTER INSERT ON `tb_penjualan` FOR EACH ROW BEGIN
	INSERT INTO tb_log(deskripsi, timestmp) 
	VALUES(CONCAT("<span class='w3-text-green'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>", NEW.no_transaksi), NOW());
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_retur_pembelian`
--

CREATE TABLE `tb_retur_pembelian` (
  `no_faktur` varchar(30) NOT NULL,
  `kode_barang` varchar(30) NOT NULL,
  `harga_beli` double(10,2) NOT NULL,
  `qty` int(4) NOT NULL,
  `petugas` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `timestmp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_retur_pembelian`
--

INSERT INTO `tb_retur_pembelian` (`no_faktur`, `kode_barang`, `harga_beli`, `qty`, `petugas`, `keterangan`, `timestmp`) VALUES
('PA1234', 'BSCH01', 900000.00, 1, 1, 'cacad', '2018-02-28 14:17:33');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_retur_penjualan`
--

CREATE TABLE `tb_retur_penjualan` (
  `no_transaksi` varchar(30) NOT NULL,
  `kode_barang` varchar(30) NOT NULL,
  `qty` int(4) NOT NULL,
  `harga` double(10,2) NOT NULL,
  `disc` double(5,2) NOT NULL,
  `petugas` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `timestmp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_retur_penjualan`
--

INSERT INTO `tb_retur_penjualan` (`no_transaksi`, `kode_barang`, `qty`, `harga`, `disc`, `petugas`, `keterangan`, `timestmp`) VALUES
('28021800011', 'BOSCH02', 1, 300000.00, 0.00, 1, 'cacad', '2018-02-28 14:26:28');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_satuan_barang`
--

CREATE TABLE `tb_satuan_barang` (
  `id_satuan` int(11) NOT NULL,
  `nama_satuan` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_satuan_barang`
--

INSERT INTO `tb_satuan_barang` (`id_satuan`, `nama_satuan`) VALUES
(18, 'PCS'),
(19, 'UNIT');

-- --------------------------------------------------------

--
-- Struktur dari tabel `tb_supplier`
--

CREATE TABLE `tb_supplier` (
  `kode_supplier` varchar(10) NOT NULL,
  `nama_toko` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `tb_supplier`
--

INSERT INTO `tb_supplier` (`kode_supplier`, `nama_toko`, `alamat`, `telepon`, `email`) VALUES
('BSCH', 'BOSCH', 'jalan jakarta no 40', '0823111110', 'bosch@gmail.com'),
('DRML', 'Dremel', 'jalan tubagus no 70', '08211111', 'dremel@gmail.com'),
('UAP', 'PT. UAP AIR', 'Jalan Suniaraja', '022-2055213', 'uapair@supply.com');

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE `user` (
  `id_user` int(11) NOT NULL,
  `nama_lengkap` varchar(45) NOT NULL,
  `usernm` varchar(20) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `level` varchar(20) NOT NULL,
  `last_login` datetime NOT NULL,
  `akses_master` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id_user`, `nama_lengkap`, `usernm`, `passwd`, `level`, `last_login`, `akses_master`) VALUES
(1, 'ADMINISTRATOR', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', '2018-02-28 15:01:41', ''),
(2, 'UDIN', 'udin', '6bec9c852847242e384a4d5ac0962ba0', 'user', '2016-08-02 12:46:58', 'pelanggan, supplier'),
(3, 'EKA', 'EKA', '79ee82b17dfb837b1be94a6827fa395a', 'admin', '2016-07-31 15:57:33', ''),
(4, 'Yeti Uye', 'uyeyeti', 'e99a18c428cb38d5f260853678922e03', 'user', '0000-00-00 00:00:00', '');

-- --------------------------------------------------------

--
-- Struktur untuk view `barang_laris`
--
DROP TABLE IF EXISTS `barang_laris`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `barang_laris`  AS  select `a`.`kode_barang` AS `kode_barang`,`a`.`nama_barang` AS `nama_barang`,count(`a`.`kode_barang`) AS `jumlah`,`a`.`satuan` AS `satuan` from (`tb_barang` `a` join `tb_detail_penjualan` `b`) where (`a`.`kode_barang` = `b`.`kode_barang`) group by `a`.`kode_barang` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indexes for table `modul`
--
ALTER TABLE `modul`
  ADD PRIMARY KEY (`id_modul`);

--
-- Indexes for table `tb_barang`
--
ALTER TABLE `tb_barang`
  ADD PRIMARY KEY (`kode_barang`),
  ADD KEY `FK_tb_produk_tb_kategori_produk` (`kategori_id`),
  ADD KEY `kategori_id` (`kategori_id`),
  ADD KEY `kategori_id_2` (`kategori_id`),
  ADD KEY `kategori_id_3` (`kategori_id`),
  ADD KEY `kode_supplier` (`kode_supplier`);

--
-- Indexes for table `tb_detail_pembelian`
--
ALTER TABLE `tb_detail_pembelian`
  ADD PRIMARY KEY (`no_faktur`,`kode_barang`),
  ADD KEY `FK_tb_detailbeli_tb_produk` (`kode_barang`);

--
-- Indexes for table `tb_detail_pembelian_tmp`
--
ALTER TABLE `tb_detail_pembelian_tmp`
  ADD PRIMARY KEY (`kode_barang`);

--
-- Indexes for table `tb_detail_penjualan`
--
ALTER TABLE `tb_detail_penjualan`
  ADD PRIMARY KEY (`no_transaksi`,`kode_barang`),
  ADD KEY `FK_tb_detailproduk_tb_produk` (`kode_barang`);

--
-- Indexes for table `tb_detail_penjualan_tmp`
--
ALTER TABLE `tb_detail_penjualan_tmp`
  ADD PRIMARY KEY (`petugas`,`kode_barang`);

--
-- Indexes for table `tb_kategori_barang`
--
ALTER TABLE `tb_kategori_barang`
  ADD PRIMARY KEY (`kategori_id`);

--
-- Indexes for table `tb_log`
--
ALTER TABLE `tb_log`
  ADD PRIMARY KEY (`id_log`);

--
-- Indexes for table `tb_pelanggan`
--
ALTER TABLE `tb_pelanggan`
  ADD PRIMARY KEY (`email_pelanggan`);

--
-- Indexes for table `tb_pembelian`
--
ALTER TABLE `tb_pembelian`
  ADD PRIMARY KEY (`no_faktur`);

--
-- Indexes for table `tb_penjualan`
--
ALTER TABLE `tb_penjualan`
  ADD PRIMARY KEY (`no_transaksi`);

--
-- Indexes for table `tb_retur_pembelian`
--
ALTER TABLE `tb_retur_pembelian`
  ADD PRIMARY KEY (`no_faktur`,`kode_barang`),
  ADD KEY `FK_tb_detailbeli_tb_produk` (`kode_barang`);

--
-- Indexes for table `tb_retur_penjualan`
--
ALTER TABLE `tb_retur_penjualan`
  ADD PRIMARY KEY (`kode_barang`,`no_transaksi`);

--
-- Indexes for table `tb_satuan_barang`
--
ALTER TABLE `tb_satuan_barang`
  ADD PRIMARY KEY (`id_satuan`);

--
-- Indexes for table `tb_supplier`
--
ALTER TABLE `tb_supplier`
  ADD PRIMARY KEY (`kode_supplier`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `modul`
--
ALTER TABLE `modul`
  MODIFY `id_modul` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;
--
-- AUTO_INCREMENT for table `tb_log`
--
ALTER TABLE `tb_log`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;
--
-- AUTO_INCREMENT for table `tb_satuan_barang`
--
ALTER TABLE `tb_satuan_barang`
  MODIFY `id_satuan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
