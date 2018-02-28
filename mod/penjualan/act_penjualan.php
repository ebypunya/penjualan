<link rel="stylesheet" type="text/css" href="../../css/pace.css">
<script src="../../js/pace.min.js"></script>
<?php
	date_default_timezone_set('Asia/Jakarta');
	session_start();
	include"../../lib/conn.php";
	include"../../lib/all_function.php";
	include"../../lib/fungsi_transaction.php";


	if(!isset($_SESSION['login_user'])){
		header('location: ../../login.php'); // Mengarahkan ke Home Page
	}

	if(isset($_GET['mod']) && isset($_GET['act']))
	{
		$mod = $_GET['mod'];
		$act = $_GET['act'];
	}
	else
	{
		$mod = "";
		$act = "";
	}

	if($mod == "penjualan" AND $act == "add")
	{
		$cek_barang = mysql_query("SELECT * FROM tb_barang 
								WHERE kode_barang = '$_GET[id]'") or die(mysql_error());

		if (mysql_num_rows($cek_barang) > 0) {
			$qty = 0;
			if(!empty($_GET['qty']) AND is_numeric($_GET['qty']))
			{
				$qty = $_GET['qty'];
			}

			$b = mysql_fetch_assoc($cek_barang);

			$cek_det_barang = mysql_query("SELECT * FROM tb_detail_penjualan_tmp 
										WHERE kode_barang = '$_GET[id]' 
										AND petugas = '$_SESSION[login_id]'") or die(mysql_error());
			if(mysql_num_rows($cek_det_barang) > 0)
			{
				mysql_query("UPDATE tb_detail_penjualan_tmp SET disc = disc+2
							WHERE kode_barang = '$_GET[id]' 
							AND petugas = '$_SESSION[login_id]'") or die(mysql_error());
			}
			else
			{
				mysql_query("INSERT INTO tb_detail_penjualan_tmp (kode_barang,
																	harga,
																	
																	qty,
																	petugas,
																	timestmp)
															VALUES('$_GET[id]',
																	'$b[harga_jual]',
																	$qty,
																	
																	'$_SESSION[login_id]',
																	NOW())") or die(mysql_error());
			}
				
				

			echo"<script>
				window.history.back();
			</script>";	
		}
		else
		{
			echo"Tidak barang!";
		}

	}

	elseif ($mod == "penjualan" AND $act == "batal") {
		mysql_query("DELETE FROM tb_detail_penjualan_tmp
					WHERE kode_barang = '$_GET[id]' 
					AND petugas = '$_SESSION[login_id]'") or die(mysql_error());

		echo"<script>
			window.history.back();
		</script>";	
	}

	elseif($mod == "penjualan" AND $act == "simpan")
	{
		$qtmp = mysql_query("SELECT * FROM tb_detail_penjualan_tmp 
							WHERE petugas = '$_SESSION[login_id]' 
							ORDER BY timestmp ASC");

		if (mysql_num_rows($qtmp) > 0) {
			$no_transaksi = no_kwitansi_auto(); //no transaksi automatis
			$total_bayar = $total;

			$tgl = date('Y-m-d');
			while($tmp = mysql_fetch_assoc($qtmp))
			{
				$chart[] = $tmp;

				//hitung total
				$harga_disc = $tmp['harga'] * $tmp['qty'];
				$sub_total = $harga_disc;

				$total_bayar =  $total_bayar + $sub_total ;
			}

			if ($_POST['potongan2'] > 0) {
				$total_bayar = $total_bayar - $_POST['potongan2'];
			}
			else
			{
				$total_bayar = $total_bayar;
			}
			
			//print_r($chart);
			$qpel = mysql_query("SELECT * FROM tb_pelanggan 
								WHERE email_pelanggan = '".anti_inject($_POST['nama'])."'");
			if(mysql_num_rows($qpel) > 0)
			{
				$p = mysql_fetch_assoc($qpel);
				$kode_pel = $p['email_pelanggan'];
				$nama_pelanggan = anti_inject($p['nama_pelanggan']);
			}
			else
			{
				$kode_pel = "";
				$nama_pelanggan = anti_inject($_POST['nama']);
			}
			//echo $nama_pelanggan;

			//apakah pembayaran sudah cukup
			if (($total_bayar != $qtybayar) OR ($_POST['status'] == "HUTANG")) {
				//start transaction
				start_transaction();

				//pembuatan header
				$qsimpanheader = mysql_query("INSERT INTO tb_penjualan(no_transaksi,
																		email_pelanggan, 
																		nama_pelanggan, 
																		tgl_transaksi, 
																		petugas, 
																		status,
																		
																		bayar,
																		
																		
																		potongan, 
																		timestmp)
																VALUES('$no_transaksi', 
																		'$kode_pel', 
																		'$nama_pelanggan',
																		'$tgl', 
																		'															
																		'$_SESSION[login_id]',
																		'$_POST[status]', 
																		 '$qtybayar',
																		$_POST[potongan2], 
																		NOW())");
				if (!$qsimpanheader) {
					rollback();
					flash('example_message', '<p>Transaksi Gagal.</p>', 'w3-red');
					echo"<script>
						window.history.back();
					</script>";	
				}
				else
				{
					foreach ($chart as $row) {
						$qsimpandetail = mysql_query("INSERT INTO tb_detail_penjualan(no_transaksi,
																						kode_barang,
																						
																						harga, 
																						qty, 
																						petugas, 
																						timestmp)
																				VALUES('$no_transaksi', 
																						'$row[kode_barang]', 
																						
																						'$row[harga]', 
																						$row[qty], 
																						$row[petugas], 
																						'$row[timestmp]')");
						if (!$qsimpandetail) {
							rollback();
							flash('example_message', '<p>Transaksi gagal.</p>', 'w3-red' );
							echo"<script>
								window.history.back();
							</script>";	
						}
					}
					commit();
					header("location:../../med.php?mod=penjualan&act=printout&id=".$no_transaksi);
				}
				//commit();
			}
			else {
				flash('example_message', '<p>Pembayaran tidak cukup!</p>', 'w3-yellow');
				echo"<script>
					window.history.back();
				</script>";	
			}

				
		}
		else
		{
			flash('example_message', '<p>Tidak ada barang yang di jual!</p>', 'w3-red');
			echo"<script>
				window.history.back();
			</script>";	
		}
	}

	elseif ($mod == "penjualan" AND $act == "hapus") {
		if(isset($_SESSION['hapuspenjualan']) AND $_SESSION['hapuspenjualan'] <> 'TRUE')
		{
			echo"<div class='w3-container w3-red'><p>Dilarang mengakses file ini.</p></div>";
			die();
		}
		else
		{
			mysql_query("DELETE FROM tb_penjualan WHERE no_transaksi = '$_GET[id]'") or die(mysql_error());
			flash('example_message', '<p>Berhasil menghapus data transaksi.</p>' );
			echo"<script>
				window.history.back();
			</script>";	
		}
			
	}



?>