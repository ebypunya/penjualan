-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.6.26 - MySQL Community Server (GPL)
-- Server OS:                    Win32
-- HeidiSQL Version:             9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Dumping structure for view db_tokosp.barang_laris
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `barang_laris` (
	`kode_barang` VARCHAR(30) NOT NULL COLLATE 'latin1_swedish_ci',
	`nama_barang` VARCHAR(50) NOT NULL COLLATE 'latin1_swedish_ci',
	`jumlah` BIGINT(21) NOT NULL,
	`satuan` VARCHAR(10) NOT NULL COLLATE 'latin1_swedish_ci'
) ENGINE=MyISAM;


-- Dumping structure for table db_tokosp.menu
CREATE TABLE IF NOT EXISTS `menu` (
  `id_menu` int(11) NOT NULL AUTO_INCREMENT,
  `nama_menu` varchar(50) NOT NULL,
  `posisi` int(11) NOT NULL,
  PRIMARY KEY (`id_menu`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.menu: ~2 rows (approximately)
DELETE FROM `menu`;
/*!40000 ALTER TABLE `menu` DISABLE KEYS */;
INSERT INTO `menu` (`id_menu`, `nama_menu`, `posisi`) VALUES
	(4, 'Barang', 2),
	(5, 'Master', 1),
	(6, 'Transaksi', 3),
	(7, 'Laporan', 5),
	(8, 'Retur Barang', 4);
/*!40000 ALTER TABLE `menu` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.modul
CREATE TABLE IF NOT EXISTS `modul` (
  `id_modul` int(11) NOT NULL AUTO_INCREMENT,
  `id_menu` int(11) NOT NULL,
  `nama_modul` varchar(150) NOT NULL,
  `link_menu` text NOT NULL,
  `posisi` int(11) NOT NULL,
  `icon_menu` varchar(150) NOT NULL,
  PRIMARY KEY (`id_modul`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.modul: ~12 rows (approximately)
DELETE FROM `modul`;
/*!40000 ALTER TABLE `modul` DISABLE KEYS */;
INSERT INTO `modul` (`id_modul`, `id_menu`, `nama_modul`, `link_menu`, `posisi`, `icon_menu`) VALUES
	(6, 4, 'Kategori Barang', 'med.php?mod=kategori', 1, 'fa fa-folder-open'),
	(7, 4, 'Data Barang', 'med.php?mod=barang', 2, 'fa fa-cubes'),
	(8, 5, 'Data Pelanggan', 'med.php?mod=pelanggan', 1, 'fa fa-group'),
	(9, 5, 'Data Supplier', 'med.php?mod=supplier', 2, 'fa fa-user'),
	(10, 6, 'Transaksi Penjualan', 'med.php?mod=penjualan', 1, 'fa fa-shopping-cart'),
	(11, 6, 'Data Transaksi Penjualan', 'med.php?mod=penjualan&act=list', 2, 'fa fa-book'),
	(12, 6, 'Data Transaksi Pembelian', 'med.php?mod=pembelian', 3, 'fa fa-truck'),
	(13, 7, 'Laporan Stok Barang', 'med.php?mod=laporan&act=stokbarang', 1, 'fa fa-line-chart'),
	(14, 7, 'Laporan Barang Terlaris', 'med.php?mod=laplaris', 2, 'fa fa-pie-chart'),
	(15, 7, 'Laporan Transaksi Pembelian', 'med.php?mod=lappemblian', 3, 'fa fa-print'),
	(16, 7, 'Laporan Transaksi Penjualan', 'med.php?mod=lappenjualan', 4, 'fa fa-print'),
	(17, 8, 'Retur Penjualan', 'med.php?mod=returpenjualan', 1, 'fa fa-cart-arrow-down'),
	(18, 8, 'Retur Pembelian', 'med.php?mod=returpembelian', 2, 'fa fa-cart-arrow-down');
/*!40000 ALTER TABLE `modul` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_barang
	CREATE TABLE IF NOT EXISTS `tb_barang` (
	  `kode_barang` varchar(30) NOT NULL,
	  `nama_barang` varchar(50) NOT NULL,
	  `deskripsi` text NOT NULL,
	  `tgl_input` date NOT NULL,
	  `harga_beli` double(10,2) NOT NULL,
	  `harga_jual` double(10,2) NOT NULL,
	  `kategori_id` char(5) NOT NULL,
	  `jml_stok` int(11) NOT NULL,
	  `satuan` varchar(10) NOT NULL,
	  PRIMARY KEY (`kode_barang`),
	  KEY `FK_tb_produk_tb_kategori_produk` (`kategori_id`),
	  CONSTRAINT `FK_tb_produk_tb_kategori_produk` FOREIGN KEY (`kategori_id`) REFERENCES `tb_kategori_barang` (`kategori_id`) ON UPDATE CASCADE
	) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_barang: ~11 rows (approximately)
DELETE FROM `tb_barang`;
/*!40000 ALTER TABLE `tb_barang` DISABLE KEYS */;
INSERT INTO `tb_barang` (`kode_barang`, `nama_barang`, `deskripsi`, `tgl_input`, `harga_beli`, `harga_jual`, `kategori_id`, `jml_stok`, `satuan`) VALUES
	('AD00001', 'ADAPTOR ACER KW', '-', '2016-07-25', 55000.00, 150000.00, 'C002', 10, 'UNIT'),
	('AD00003', 'ADAPTOR ACER MINI ORI', '-', '2016-07-28', 55000.00, 150000.00, 'C002', 10, 'UNIT'),
	('AD00004', 'ADAPTOR ASUS KW', '-', '2016-07-28', 55000.00, 150000.00, 'C002', 10, 'UNIT'),
	('AD00005', 'ADAPTOR ASUS MINI', '-', '2016-07-28', 57000.00, 150000.00, 'C002', 10, 'UNIT'),
	('AD00006', 'ADAPTOR ASUS ORI', '-', '2016-07-28', 130000.00, 360000.00, 'C002', 10, 'UNIT'),
	('AD00007', 'ADAPTOR ASUS ORI PETAK', '-', '2016-07-28', 185000.00, 40000.00, 'C002', 10, 'UNIT'),
	('AD00008', 'ADAPTOR ASUS ORI EPC19V-1.75A', '-', '2016-07-28', 148000.00, 350000.00, 'C002', 10, 'UNIT'),
	('AD00009', 'ADAPTOR HP JARUM KW', '-', '2016-07-28', 57000.00, 150000.00, 'C002', 10, 'UNIT'),
	('AD00010', 'ADAPTOR HP MINI ORI', '-', '2016-07-28', 135000.00, 375000.00, 'C002', 10, 'UNIT'),
	('AD00011', 'ADAPTOR HP JARUM ORI', '-', '2016-07-28', 145000.00, 390000.00, 'C002', 10, 'UNIT');
/*!40000 ALTER TABLE `tb_barang` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_detail_pembelian
CREATE TABLE IF NOT EXISTS `tb_detail_pembelian` (
  `no_faktur` varchar(30) NOT NULL,
  `kode_barang` varchar(30) NOT NULL,
  `harga_beli` double(10,2) NOT NULL,
  `qty` int(4) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`no_faktur`,`kode_barang`),
  KEY `FK_tb_detailbeli_tb_produk` (`kode_barang`),
  CONSTRAINT `FK_tb_detail_pembelian_tb_barang` FOREIGN KEY (`kode_barang`) REFERENCES `tb_barang` (`kode_barang`),
  CONSTRAINT `FK_tb_detail_pembelian_tb_pembelian` FOREIGN KEY (`no_faktur`) REFERENCES `tb_pembelian` (`no_faktur`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_detail_pembelian: ~4 rows (approximately)
DELETE FROM `tb_detail_pembelian`;
/*!40000 ALTER TABLE `tb_detail_pembelian` DISABLE KEYS */;
INSERT INTO `tb_detail_pembelian` (`no_faktur`, `kode_barang`, `harga_beli`, `qty`, `petugas`, `timestmp`) VALUES
	('TR001', 'AD00001', 56000.00, 10, 1, '2016-08-03 22:29:09'),
	('TR001', 'AD00006', 132000.00, 10, 1, '2016-08-03 22:29:09'),
	('TR002', 'AD00001', 55000.00, 2, 1, '2016-08-03 22:35:02'),
	('TR002', 'AD00008', 148000.00, 15, 1, '2016-08-03 22:35:02');
/*!40000 ALTER TABLE `tb_detail_pembelian` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_detail_pembelian_tmp
CREATE TABLE IF NOT EXISTS `tb_detail_pembelian_tmp` (
  `kode_barang` varchar(30) NOT NULL,
  `harga_beli` double(10,2) NOT NULL,
  `qty` int(4) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`kode_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_detail_pembelian_tmp: ~0 rows (approximately)
DELETE FROM `tb_detail_pembelian_tmp`;
/*!40000 ALTER TABLE `tb_detail_pembelian_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_detail_pembelian_tmp` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_detail_penjualan
CREATE TABLE IF NOT EXISTS `tb_detail_penjualan` (
  `no_transaksi` varchar(30) NOT NULL,
  `kode_barang` varchar(30) NOT NULL,
  `qty` int(4) NOT NULL,
  `harga` double(10,2) NOT NULL,
  `disc` double(5,2) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`no_transaksi`,`kode_barang`),
  KEY `FK_tb_detailproduk_tb_produk` (`kode_barang`),
  CONSTRAINT `FK_tb_detail_penjualan_tb_barang` FOREIGN KEY (`kode_barang`) REFERENCES `tb_barang` (`kode_barang`),
  CONSTRAINT `FK_tb_detailproduk_tb_pembayaran` FOREIGN KEY (`no_transaksi`) REFERENCES `tb_penjualan` (`no_transaksi`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_detail_penjualan: ~5 rows (approximately)
DELETE FROM `tb_detail_penjualan`;
/*!40000 ALTER TABLE `tb_detail_penjualan` DISABLE KEYS */;
INSERT INTO `tb_detail_penjualan` (`no_transaksi`, `kode_barang`, `qty`, `harga`, `disc`, `petugas`, `timestmp`) VALUES
	('CA03081600001', 'AD00001', 1, 150000.00, 0.00, 1, '2016-08-03 21:07:14'),
	('CA03081600002', 'AD00001', 1, 150000.00, 0.00, 1, '2016-08-03 21:13:05'),
	('CA03081600002', 'AD00003', 1, 150000.00, 0.00, 1, '2016-08-03 21:13:06'),
	('CA03081600002', 'AD00004', 1, 150000.00, 0.00, 1, '2016-08-03 21:13:07'),
	('CA03081600002', 'AD00005', 1, 150000.00, 0.00, 1, '2016-08-03 21:13:09');
/*!40000 ALTER TABLE `tb_detail_penjualan` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_detail_penjualan_tmp
CREATE TABLE IF NOT EXISTS `tb_detail_penjualan_tmp` (
  `kode_barang` varchar(50) NOT NULL,
  `harga` double(10,2) NOT NULL,
  `disc` double(10,2) NOT NULL,
  `qty` int(4) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`petugas`,`kode_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_detail_penjualan_tmp: ~0 rows (approximately)
DELETE FROM `tb_detail_penjualan_tmp`;
/*!40000 ALTER TABLE `tb_detail_penjualan_tmp` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_detail_penjualan_tmp` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_kategori_barang
CREATE TABLE IF NOT EXISTS `tb_kategori_barang` (
  `kategori_id` char(5) NOT NULL,
  `nama_kategori` varchar(50) NOT NULL,
  PRIMARY KEY (`kategori_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_kategori_barang: ~2 rows (approximately)
DELETE FROM `tb_kategori_barang`;
/*!40000 ALTER TABLE `tb_kategori_barang` DISABLE KEYS */;
INSERT INTO `tb_kategori_barang` (`kategori_id`, `nama_kategori`) VALUES
	('C001', 'LAPTOP'),
	('C002', 'ADAPTOR'),
	('C003', 'JASA SERVICE');
/*!40000 ALTER TABLE `tb_kategori_barang` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_log
CREATE TABLE IF NOT EXISTS `tb_log` (
  `id_log` int(11) NOT NULL AUTO_INCREMENT,
  `deskripsi` text NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`id_log`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_log: ~4 rows (approximately)
DELETE FROM `tb_log`;
/*!40000 ALTER TABLE `tb_log` DISABLE KEYS */;
INSERT INTO `tb_log` (`id_log`, `deskripsi`, `timestmp`) VALUES
	(26, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>CA03081600001', '2016-08-03 21:07:25'),
	(27, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>CA03081600002', '2016-08-03 21:13:24'),
	(28, '<span class=\'w3-text-green\'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>CA04081600001', '2016-08-04 13:33:06'),
	(29, '<span class=\'w3-text-red\'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :CA04081600001', '2016-08-04 13:34:36');
/*!40000 ALTER TABLE `tb_log` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_pelanggan
CREATE TABLE IF NOT EXISTS `tb_pelanggan` (
  `kode_pelanggan` varchar(20) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `nomor_telp` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  PRIMARY KEY (`kode_pelanggan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_pelanggan: ~0 rows (approximately)
DELETE FROM `tb_pelanggan`;
/*!40000 ALTER TABLE `tb_pelanggan` DISABLE KEYS */;
INSERT INTO `tb_pelanggan` (`kode_pelanggan`, `nama_pelanggan`, `nomor_telp`, `alamat`) VALUES
	('P0001', 'ADE INDRA SAPUTRA', '085227281672', 'JL. TP. SRIWIJAYA PERUM. VILLA MELATI ASRI NO. 42'),
	('P0002', 'JAYA MOTOR', '', 'SIMPANG TELKOM');
/*!40000 ALTER TABLE `tb_pelanggan` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_pembelian
CREATE TABLE IF NOT EXISTS `tb_pembelian` (
  `no_faktur` varchar(30) NOT NULL,
  `kode_supplier` varchar(10) NOT NULL,
  `nama_toko` varchar(50) NOT NULL,
  `tgl_beli` date NOT NULL,
  `nama_kasir` varchar(50) NOT NULL,
  `petugas` int(11) NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`no_faktur`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_pembelian: ~1 rows (approximately)
DELETE FROM `tb_pembelian`;
/*!40000 ALTER TABLE `tb_pembelian` DISABLE KEYS */;
INSERT INTO `tb_pembelian` (`no_faktur`, `kode_supplier`, `nama_toko`, `tgl_beli`, `nama_kasir`, `petugas`, `timestmp`) VALUES
	('TR001', 'S0001', 'ELEVEN', '2016-08-03', 'BUJANG', 1, '2016-08-03 22:29:09'),
	('TR002', 'S0002', 'TIGER ONE', '2016-08-03', 'MAT LENO', 1, '2016-08-03 22:35:02');
/*!40000 ALTER TABLE `tb_pembelian` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_penjualan
CREATE TABLE IF NOT EXISTS `tb_penjualan` (
  `no_transaksi` varchar(30) NOT NULL,
  `kode_pelanggan` varchar(20) NOT NULL,
  `nama_pelanggan` varchar(50) NOT NULL,
  `tgl_transaksi` date NOT NULL,
  `petugas` int(11) NOT NULL,
  `status` varchar(10) NOT NULL,
  `bayar` double(10,2) NOT NULL,
  `potongan` double(10,2) NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`no_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_penjualan: ~2 rows (approximately)
DELETE FROM `tb_penjualan`;
/*!40000 ALTER TABLE `tb_penjualan` DISABLE KEYS */;
INSERT INTO `tb_penjualan` (`no_transaksi`, `kode_pelanggan`, `nama_pelanggan`, `tgl_transaksi`, `petugas`, `status`, `bayar`, `potongan`, `timestmp`) VALUES
	('CA03081600001', 'P0001', 'ADE INDRA SAPUTRA', '2016-08-03', 1, 'LUNAS', 150000.00, 20000.00, '2016-08-03 21:07:25'),
	('CA03081600002', 'P0002', 'JAYA MOTOR', '2016-08-03', 1, 'LUNAS', 600000.00, 0.00, '2016-08-03 21:13:24');
/*!40000 ALTER TABLE `tb_penjualan` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_retur_pembelian
CREATE TABLE IF NOT EXISTS `tb_retur_pembelian` (
  `no_faktur` varchar(30) NOT NULL,
  `kode_barang` varchar(30) NOT NULL,
  `harga_beli` double(10,2) NOT NULL,
  `qty` int(4) NOT NULL,
  `petugas` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`no_faktur`,`kode_barang`),
  KEY `FK_tb_detailbeli_tb_produk` (`kode_barang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_retur_pembelian: ~0 rows (approximately)
DELETE FROM `tb_retur_pembelian`;
/*!40000 ALTER TABLE `tb_retur_pembelian` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_retur_pembelian` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_retur_penjualan
CREATE TABLE IF NOT EXISTS `tb_retur_penjualan` (
  `no_transaksi` varchar(30) NOT NULL,
  `kode_barang` varchar(30) NOT NULL,
  `qty` int(4) NOT NULL,
  `harga` double(10,2) NOT NULL,
  `disc` double(5,2) NOT NULL,
  `petugas` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `timestmp` datetime NOT NULL,
  PRIMARY KEY (`kode_barang`,`no_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_retur_penjualan: ~1 rows (approximately)
DELETE FROM `tb_retur_penjualan`;
/*!40000 ALTER TABLE `tb_retur_penjualan` DISABLE KEYS */;
/*!40000 ALTER TABLE `tb_retur_penjualan` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_satuan_barang
CREATE TABLE IF NOT EXISTS `tb_satuan_barang` (
  `id_satuan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_satuan` varchar(10) NOT NULL,
  PRIMARY KEY (`id_satuan`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_satuan_barang: ~1 rows (approximately)
DELETE FROM `tb_satuan_barang`;
/*!40000 ALTER TABLE `tb_satuan_barang` DISABLE KEYS */;
INSERT INTO `tb_satuan_barang` (`id_satuan`, `nama_satuan`) VALUES
	(18, 'PCS'),
	(19, 'UNIT');
/*!40000 ALTER TABLE `tb_satuan_barang` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.tb_supplier
CREATE TABLE IF NOT EXISTS `tb_supplier` (
  `kode_supplier` varchar(10) NOT NULL,
  `nama_toko` varchar(50) NOT NULL,
  `alamat` text NOT NULL,
  `telepon` varchar(15) NOT NULL,
  `email` varchar(50) NOT NULL,
  PRIMARY KEY (`kode_supplier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table db_tokosp.tb_supplier: ~1 rows (approximately)
DELETE FROM `tb_supplier`;
/*!40000 ALTER TABLE `tb_supplier` DISABLE KEYS */;
INSERT INTO `tb_supplier` (`kode_supplier`, `nama_toko`, `alamat`, `telepon`, `email`) VALUES
	('S0001', 'ELEVEN', 'JAMBI', '888', '-'),
	('S0002', 'TIGER ONE', 'JAMBI', '888', '-');
/*!40000 ALTER TABLE `tb_supplier` ENABLE KEYS */;


-- Dumping structure for table db_tokosp.user
CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `nama_lengkap` varchar(45) NOT NULL,
  `usernm` varchar(20) NOT NULL,
  `passwd` varchar(50) NOT NULL,
  `level` varchar(20) NOT NULL,
  `last_login` datetime NOT NULL,
  `akses_master` text NOT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Dumping data for table db_tokosp.user: ~2 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id_user`, `nama_lengkap`, `usernm`, `passwd`, `level`, `last_login`, `akses_master`) VALUES
	(1, 'ADMINISTRATOR', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin', '2016-08-09 21:52:41', ''),
	(2, 'CACA', 'caca', 'd2104a400c7f629a197f33bb33fe80c0', 'user', '2016-08-02 12:46:58', 'pelanggan, supplier'),
	(3, 'AGUS', 'agus', 'fdf169558242ee051cca1479770ebac3', 'admin', '2016-07-31 15:57:33', '');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;


-- Dumping structure for trigger db_tokosp.after_delete_penjualan
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_delete_penjualan` AFTER DELETE ON `tb_penjualan` FOR EACH ROW BEGIN
	INSERT INTO tb_log(deskripsi, timestmp) 
	VALUES(CONCAT("<span class='w3-text-red'>Transaksi penjualan telah di hapus dengan nomor transaksi</span> :", OLD.no_transaksi), NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Dumping structure for trigger db_tokosp.after_insert_delete_tmp
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_insert_delete_tmp` AFTER INSERT ON `tb_detail_penjualan` FOR EACH ROW BEGIN
	DELETE FROM tb_detail_penjualan_tmp 
	WHERE kode_barang = NEW.kode_barang 
	AND petugas = NEW.petugas;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Dumping structure for trigger db_tokosp.after_insert_penjualan
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_insert_penjualan` AFTER INSERT ON `tb_penjualan` FOR EACH ROW BEGIN
	INSERT INTO tb_log(deskripsi, timestmp) 
	VALUES(CONCAT("<span class='w3-text-green'>Berhasil melakukan transaksi penjualan dengan nomor transaksi : </span>", NEW.no_transaksi), NOW());
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Dumping structure for trigger db_tokosp.after_insert_tmp_beli
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_insert_tmp_beli` AFTER INSERT ON `tb_detail_pembelian` FOR EACH ROW BEGIN
	DELETE FROM tb_detail_pembelian_tmp 
	WHERE kode_barang = NEW.kode_barang 
	AND petugas = NEW.petugas;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;


-- Dumping structure for view db_tokosp.barang_laris
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `barang_laris`;
CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` VIEW `barang_laris` AS SELECT a.kode_barang, a.nama_barang, COUNT(a.kode_barang) AS jumlah, a.satuan FROM tb_barang a , tb_detail_penjualan b
WHERE a.kode_barang = b.kode_barang
GROUP BY a.kode_barang ;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
