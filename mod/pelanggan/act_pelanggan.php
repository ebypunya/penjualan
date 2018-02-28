<?php
	session_start();
	include"../../lib/conn.php";
	include"../../lib/all_function.php";


	if(!isset($_SESSION['login_user'])){
		header('location: ../../login.php'); // Mengarahkan ke Home Page
	}

	if(isset($_SESSION['pelanggan']) AND $_SESSION['pelanggan'] <> 'TRUE')
	{
		echo"<div class='w3-container w3-red'><p>Dilarang mengakses file ini.</p></div>";
		die();
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

	if($mod == "pelanggan" AND $act == "simpan")
	{
		//variable input
		$email_pelanggan = trim($_POST['emailp_pelanggan']);
		$nama_pelanggan= anti_inject($_POST['nama_pelanggan']);
		$nomor_telp= anti_inject($_POST['nomor_telp']);
		$alamat= anti_inject($_POST['alamat']);

		mysql_query("INSERT INTO tb_pelanggan(email_pelanggan, 
										nama_pelanggan, 
										nomor_telp, 
										alamat)
									VALUES ('$email_pelanggan', 
										'$nama_pelanggan', 
										'$nomor_telp', 
										'$alamat')") or die(mysql_error());
		flash('example_message', '<p>Berhasil menambah data biaya.</p>' );

		echo"<script>
			window.history.go(-2);
		</script>";
	}

	elseif ($mod == "pelanggan" AND $act == "edit") 
	{
		//variable input
		$email_pelanggan = trim($_POST['emailp_pelanggan']);
		$nama_pelanggan= anti_inject($_POST['nama_pelanggan']);
		$nomor_telp= anti_inject($_POST['nomor_telp']);
		$alamat= anti_inject($_POST['alamat']);

		mysql_query("UPDATE tb_pelanggan SET 
										nama_pelanggan= '$nama_pelanggan', 
										nomor_telp= '$nomor_telp', 
										alamat= '$alamat' 
					WHERE email_pelanggan = '$_POST[id]'") or die(mysql_error());

		flash('example_message', '<p>Berhasil mengubah data biaya.</p>');

		echo"<script>
			window.history.go(-2);
		</script>";
	}

	elseif ($mod == "pelanggan" AND $act == "hapus") 
	{
		mysql_query("DELETE FROM tb_pelanggan WHERE email_pelanggan = '$_GET[id]'") or die(mysql_error());
		flash('example_message', '<p>Berhasil menghapus data biaya kuliah.</p>' );
		echo"<script>
			window.history.back();
		</script>";	
	}

?>