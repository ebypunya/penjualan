<?php
	if(!isset($_SESSION['login_user'])){
		header('location: ../../login.php'); // Mengarahkan ke Home Page
	}

	if(isset($_SESSION['kategori']) AND $_SESSION['kategori'] <> 'TRUE')
	{
		echo"<div class='w3-container w3-red'><p>Dilarang mengakses file ini.</p></div>";
		die();
	}

	//link buat paging
	$linkaksi = 'med.php?mod=laporan';

	if(isset($_GET['act']))
	{
		$act = $_GET['act'];
		$linkaksi .= '&act='.$act;
	}
	else
	{
		$act = '';
	}

	switch ($act) {
		case 'stokbarang':
			echo"<div class='w3-container w3-small w3-pale-green w3-leftbar w3-border-green'>
				<h4 style='margin-bottom:0;padding-bottom:0;'>Laporan Stok Barang</h4>
				<p style='margin-top:0;padding-top:0;'><i>Laporan sisa stok seluruh barang</i></p>
			</div>";

			echo"<table style='margin-top:12px;'>
				<tr>
					<td>
						<form class='w3-tiny' action='' method='GET'>	
							<input type='hidden' name='mod' value='laporan'>
							<input type='hidden' name='act' value='stokbarang'>
							<div class='w3-row'>
								<div class='w3-col s1'>
									<label class='w3-label'>Search</label>
								</div>
								<div class='w3-col s2'>
									<select name='field' class='w3-select w3-padding'>
										<option value=''>- Pilih -</option>
										<option value='nama_barang'>NAMA BARANG</option>
										<option value='tgl_input'>TGL INPUT</option>
										<option value='harga_beli'>HARGA BELI</option>
										<option value='harga_jual'>HARGA JUAL</option>
										<option value='jml_stok'>JML STOK</option>
									</select>
								</div>
								<div class='w3-col s4'>
									<input type='text' name='cari' class='w3-input' placeholder='laporan'>
								</div>
								<div class='w3-col s1'>
									<button type='submit' class='w3-btn w3-tiny'><i class='fa fa-paper-plane'></i> GO</button>
								</div>
							</div>
						</form>
					</td>
					<td align='right'><a href='med.php?mod=laporan&act=stokbarang' class='w3-btn w3-dark-grey w3-small'><i class='fa fa-refresh'></i> Refresh</a>
					</td>
				</tr>
				
			</table>";

			echo"<div style='margin-top:12px;margin-bottom:12px;'>
			<table class='w3-table w3-striped w3-bordered w3-tiny w3-hoverable tbl'>
				<thead>
					<tr class='w3-yellow'>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th></th>
						<th colspan='4'><center>STOK</center></th>
						<th colspan='2'><center>RETUR</center></th>
						<th></th>
					</tr>
					<tr class='w3-yellow'>
						<th rowspan='2'>NO</th>
						<th rowspan='2'>KODE BARANG</th>
						<th rowspan='2'>NAMA BARANG</th>
						<th rowspan='2'>SATUAN</th>
						<th rowspan='2'>KATEGORI</th>
						<th>AWAL</th>
						<th>MASUK</th>
						<th>KELUAR</th>
						<th>TOTAL</th>
						<th>JUAL</th>
						<th>BELI</th>
						<th>SISA</th>
					</tr>
				</thead>
				<tbody>";

				$p      = new Paging;
				$batas  = 10;
			    if(isset($_GET['show']) && is_numeric($_GET['show']))
				{
					$batas = (int)$_GET['show'];
					$linkaksi .="&show=$_GET[show]";
				}

				$posisi = $p->cariPosisi($batas);

				$query = "SELECT * FROM tb_barang ";

				$q 	= "SELECT * FROM tb_barang";

				if(!empty($_GET['field']))
				{
					$hideinp = "<input type='hidden' name='field' value='$_GET[field]'>
								<input type='hidden' name='cari' value='$_GET[cari]'>";

					$linkaksi .= "&field=$_GET[field]&cari=$_GET[cari]";

					$query .= " WHERE $_GET[field] LIKE '%$_GET[cari]%'";
					$q .= " WHERE $_GET[field] LIKE '%$_GET[cari]%'";
				}

				$query .= " LIMIT $posisi, $batas";
				$q 	.= " ";
				

				$sql_kul = mysql_query($query);
				$fd_kul = mysql_num_rows($sql_kul);
				
				if($fd_kul > 0)
				{
					$no = $posisi + 1;
					while ($m = mysql_fetch_assoc($sql_kul)) {
						$stok_masuk = stok_masuk($m['kode_barang']);
						$stok_keluar = stok_keluar($m['kode_barang']);
						$total_stok = ($m['jml_stok'] + $stok_masuk) - $stok_keluar;

						$retur_jual = stok_retur_jual($m['kode_barang']);
						$retur_beli = stok_retur_beli($m['kode_barang']);

						$sisa = ($total_stok + $retur_jual) - $retur_beli;
						echo"<tr>
							<td>$no</td>
							<td>$m[kode_barang]</td>
							<td>$m[nama_barang]</td>
							<td>$m[satuan]</td>
							<td>".nama_kategori($m['kategori_id'])."</td>
							<td><center>$m[jml_stok]</center></td>
							<td><center>".$stok_masuk."</center></td>
							<td><center>".$stok_keluar."</center></td>
							<td><center>".$total_stok."</center></td>
							<td><center>".$retur_jual."</center></td>
							<td><center>".$retur_beli."</center></td>
							<td><center>".$sisa."</center></td>
						</tr>";
						$no++;
					}
	

					$jmldata = mysql_num_rows(mysql_query($q));

					$jmlhalaman  = $p->jumlahHalaman($jmldata, $batas);
		    		$linkHalaman = $p->navHalaman($_GET['halaman'], $jmlhalaman, $linkaksi);
				}
				else
				{
					echo"<tr>
						<td colspan='10'><div class='w3-center'><i>Data Barang Not Found.</i></div></td>
					</tr>";
				}
				

				echo"</tbody>

			</table></div>";

			echo"<div class='w3-row'>
				<div class='w3-col s1'>
					<form class='w3-tiny' action='' method='GET'>
						<input type='hidden' name='mod' value='laporan'>
						<input type='hidden' name='act' value='stokbarang'>";
						if(!empty($hideinp))
						{
							echo $hideinp;
						}
						echo"<select class='w3-select w3-border' name='show' onchange='submit()'>
							<option value=''>- Show -</option>";
							$i=10;
							while($i <= 100)
							{
								if(isset($_GET['show']) AND (int)$_GET['show'] == $i)
								{
									echo"<option value='$i' selected>$i</option>";	
								}
								else
								{
									echo"<option value='$i'>$i</option>";
								}

								$i+=10;
							}
						echo"</select>
					</form>
				</div>
				<div class='w3-col s11'>
					<ul class='w3-pagination w3-right w3-tiny'>
						$linkHalaman
					</ul>
				</div>
			</div>";
		break;
		case 'laplaris':
		echo "<br><center>10 Barang Paling Laris</center><br>";
		echo"<table class='w3-table w3-tiny w3-striped'>
		<tr><td>No.</td><td>Kode Produk</td><td>Nama Produk</td></tr>";
			$rlaris = mysql_query("SELECT * FROM barang_laris 
									ORDER BY jumlah DESC LIMIT 10");
			$no = 1;
			while ($b = mysql_fetch_assoc($rlaris)) {
				echo"<tr style='border-bottom:1px dashed #ccc;'>
					<td>$no.</td>
					<td>".strtoupper($b['kode_barang'])."</td>
					<td>".strtoupper($b['nama_barang'])."</td>
				</tr>";

				$no++;
			}

		
		echo"</table><br>";
		break;
		
		case "juallist":
			echo"<div class='w3-container w3-small w3-pale-green w3-leftbar w3-border-green'>
				<h4 style='margin-bottom:0;padding-bottom:0;'>Laporan Transaksi Penjualan</h4>
				<p style='margin-top:0;padding-top:0;'><i>Laporan Semua Transaksi Penjualan</i></p>
			</div>";

			flash('example_message');

			echo"<table style='margin-top:12px;'>
				<tr>
					<td>
						<form class='w3-tiny' action='' method='GET'>	
							<input type='hidden' name='mod' value='penjualan'>
							<input type='hidden' name='act' value='list'>
							<div class='w3-row'>
								<div class='w3-col s1'>
									<label class='w3-label'>Search</label>
								</div>
								<div class='w3-col s2'>
									<select name='field' class='w3-select w3-padding'>
										<option value=''>- Pilih -</option>
										<option value='no_transaksi'>Bulan</option>
										<option value='nama_pelanggan'>Tahun</option>
									</select>
								</div>
								<div class='w3-col s4'>
									<input type='text' name='cari' class='w3-input' placeholder='laporan'>
								</div>
								<div class='w3-col s1'>
									<button type='submit' class='w3-btn w3-tiny'><i class='fa fa-paper-plane'></i> GO</button>
								</div>
							</div>
						</form>
					</td>
					
					<td align='right'><a href='med.php?mod=penjualan&act=list' class='w3-btn w3-dark-grey w3-small'><i class='fa fa-refresh'></i> Export</a>
					</td>
				</tr>
				
			</table>";

			echo"<div style='margin-top:12px;margin-bottom:12px;'>
			<table class='w3-table w3-striped w3-bordered w3-tiny w3-hoverable tbl'>
				<thead>
					<tr class='w3-yellow'>
						<th>NO</th>
						<th>NO. TRANSAKSI</th>
						<th>KODE PEL.</th>
						<th>NAMA PELANGGAN</th>
						<th>TGL. TRANSAKSI</th>
						<th>PETUGAS</th>
						<th>TOTAL</th>
						
						
					</tr>
				</thead>
				<tbody>";

				$p      = new Paging;
				$batas  = 10;
			    if(isset($_GET['show']) && is_numeric($_GET['show']))
				{
					$batas = (int)$_GET['show'];
					$linkaksi .="&show=$_GET[show]";
				}

				$posisi = $p->cariPosisi($batas);

				$query = "SELECT * FROM tb_penjualan ";

				$q 	= "SELECT * FROM tb_penjualan";

				if(!empty($_GET['field']))
				{
					$hideinp = "<input type='hidden' name='field' value='$_GET[field]'>
								<input type='hidden' name='cari' value='$_GET[cari]'>";

					$linkaksi .= "&field=$_GET[field]&cari=$_GET[cari]";

					$query .= " WHERE $_GET[field] LIKE '%$_GET[cari]%'";
					$q .= " WHERE $_GET[field] LIKE '%$_GET[cari]%'";
				}

				$query .= " ORDER BY timestmp DESC LIMIT $posisi, $batas";
				$q 	.= " ORDER BY timestmp DESC";
				

				$sql_kul = mysql_query($query);
				$fd_kul = mysql_num_rows($sql_kul);

				if($fd_kul > 0)
				{
					$no = $posisi + 1;
					while ($m = mysql_fetch_assoc($sql_kul)) {
						echo"<tr>
							<td>$no</td>
							<td><a class='w3-text-blue w3-hover-text-red' href='med.php?mod=penjualan&act=printout&id=$m[no_transaksi]'>$m[no_transaksi]</a></td>
							<td>$m[email_pelanggan]</td>
							<td>$m[nama_pelanggan]</td>
							<td>$m[timestmp]</td>
							<td>".nama_petugas($m['petugas'])."</td>
							<td>".total_penjualan($m['no_transaksi'])."</td>
							
							
						</tr>";
						$no++;
					}
	

					$jmldata = mysql_num_rows(mysql_query($q));

					$jmlhalaman  = $p->jumlahHalaman($jmldata, $batas);
		    		$linkHalaman = $p->navHalaman($_GET['halaman'], $jmlhalaman, $linkaksi);
				}
				else
				{
					echo"<tr>
						<td colspan='8'><div class='w3-center'><i>Data Transaksi Not Found.</i></div></td>
					</tr>";
				}
				

				echo"</tbody>

			</table></div>";

			echo"<div class='w3-row'>
				<div class='w3-col s1'>
					<form class='w3-tiny' action='' method='GET'>
						<input type='hidden' name='mod' value='penjualan'>
						<input type='hidden' name='act' value='list'>";
						if(!empty($hideinp))
						{
							echo $hideinp;
						}
						echo"<select class='w3-select w3-border' name='show' onchange='submit()'>
							<option value=''>- Show -</option>";
							$i=10;
							while($i <= 100)
							{
								if(isset($_GET['show']) AND (int)$_GET['show'] == $i)
								{
									echo"<option value='$i' selected>$i</option>";	
								}
								else
								{
									echo"<option value='$i'>$i</option>";
								}

								$i+=10;
							}
						echo"</select>
					</form>
				</div>
				<div class='w3-col s11'>
					<ul class='w3-pagination w3-right w3-tiny'>
						$linkHalaman
					</ul>
				</div>
			</div>";
		break;
		
		case 'belilist':
		echo"<div class='w3-container w3-small w3-pale-green w3-leftbar w3-border-green'>
				<h4 style='margin-bottom:0;padding-bottom:0;'>Data Laporan Pembelian</h4>
				
			</div><table style='margin-top:12px;'>
				<tr>
					<td>
						<form class='w3-tiny' action='' method='GET'>	
							<input type='hidden' name='mod' value='pembelian'>
							<div class='w3-row'>
								<div class='w3-col s1'>
									<label class='w3-label'>Search</label>
								</div>
								<div class='w3-col s2'>
									<select name='field' class='w3-select w3-padding'>
										<option value=''>- Pilih -</option>
										<option value='no_faktur'>NO. FAKTUR</option>
										<option value='nama_toko'>NAMA TOKO</option>
									</select>
								</div>
								<div class='w3-col s4'>
									<input type='text' name='cari' class='w3-input' placeholder='cari ...'>
								</div>
								<div class='w3-col s1'>
									<button type='submit' class='w3-btn w3-tiny'><i class='fa fa-paper-plane'></i> GO</button>
								</div>
							</div>
						</form>
					</td>
					<td align='right'>
					<a href='med.php?mod=pembelian&act=form' class='w3-btn w3-small w3-blue'><i class='fa fa-file'></i> Export</a></td>
				</tr>
				
			</table>";

			echo"<div style='margin-top:12px;margin-bottom:12px;'>
			<table class='w3-table w3-striped w3-bordered w3-tiny w3-hoverable tbl'>
				<thead>
					<tr class='w3-yellow'>
						<th>NO</th>
						<th>NO. FAKTUR</th>
						<th>NAMA TOKO</th>
						<th>TANGGAL BELI</th>
						<th>NAMA KASIR</th>
						<th>PETUGAS</th>
						<th>TOTAL</th>
					
					</tr>
				</thead>
				<tbody>";

				$p      = new Paging;
				$batas  = 10;
			    if(isset($_GET['show']) && is_numeric($_GET['show']))
				{
					$batas = (int)$_GET['show'];
					$linkaksi .="&show=$_GET[show]";
				}

				$posisi = $p->cariPosisi($batas);

				$query = "SELECT * FROM tb_pembelian ";

				$q 	= "SELECT * FROM tb_pembelian";

				if(!empty($_GET['field']))
				{
					$hideinp = "<input type='hidden' name='field' value='$_GET[field]'>
								<input type='hidden' name='cari' value='$_GET[cari]'>";

					$linkaksi .= "&field=$_GET[field]&cari=$_GET[cari]";

					$query .= " WHERE $_GET[field] LIKE '%$_GET[cari]%'";
					$q .= " WHERE $_GET[field] LIKE '%$_GET[cari]%'";
				}

				$query .= " ORDER BY tgl_beli DESC LIMIT $posisi, $batas";
				$q 	.= " ORDER BY tgl_beli DESC";
				

				$sql_kul = mysql_query($query);
				$fd_kul = mysql_num_rows($sql_kul);

				if($fd_kul > 0)
				{
					$no = $posisi + 1;
					while ($m = mysql_fetch_assoc($sql_kul)) {
						echo"<tr>
						
							<td>$no</td>
							<td><a class='w3-text-blue w3-hover-text-red' href='med.php?mod=pembelian&act=detail&id=$m[no_faktur]'>$m[no_faktur]</a></td>
							<td>$m[nama_toko]</td>
							<td>$m[tgl_beli]</td>
							<td>$m[nama_kasir]</td>
							<td>".nama_petugas($m['petugas'])."</td>
							<td>".total_pembelian($m['no_faktur'])."</td>
							
						
						</tr>";
						$no++;
					}
	

					$jmldata = mysql_num_rows(mysql_query($q));

					$jmlhalaman  = $p->jumlahHalaman($jmldata, $batas);
		    		$linkHalaman = $p->navHalaman($_GET['halaman'], $jmlhalaman, $linkaksi);
				}
				else
				{
					echo"<tr>
						<td colspan='7'><div class='w3-center'><i>Data Pembelian Not Found.</i></div></td>
					</tr>";
				}
				

				echo"</tbody>

			</table></div>";

			echo"<div class='w3-row'>
				<div class='w3-col s1'>
					<form class='w3-tiny' action='' method='GET'>
						<input type='hidden' name='mod' value='pembelian'>";
						if(!empty($hideinp))
						{
							echo $hideinp;
						}
						echo"<select class='w3-select w3-border' name='show' onchange='submit()'>
							<option value=''>- Show -</option>";
							$i=10;
							while($i <= 100)
							{
								if(isset($_GET['show']) AND (int)$_GET['show'] == $i)
								{
									echo"<option value='$i' selected>$i</option>";	
								}
								else
								{
									echo"<option value='$i'>$i</option>";
								}

								$i+=10;
							}
						echo"</select>
					</form>
				</div>
				<div class='w3-col s11'>
					<ul class='w3-pagination w3-right w3-tiny'>
						$linkHalaman
					</ul>
				</div>
			</div>";
		break;

		case "form" :
			echo"<div class='w3-container w3-small w3-pale-green w3-leftbar w3-border-green'>
				<h4 style='margin-bottom:0;padding-bottom:0;'>Form Transaksi Pembelian</h4>
				<p style='margin-top:0;padding-top:0;'><i>Input Data Pembelian Barang</i></p>
			</div>";

			echo"<div class='w3-row-padding'>
				<div class='w3-col s3 w3-card'>
					Input Barang
					<div style='border-bottom:1px dashed #ccc;'></div><br>

					<div class='w3-card-2 w3-light-blue'>
						<form action='$aksi?mod=pembelian&act=add' method='POST' class='w3-container'>
							<input type='hidden' name='harga2' id='harga2'>
							<br><input type='text' name='barang' id='barang' placeholder='ketik nama barang ...' class='w3-input w3-tiny w3-border-0' required>

							<label class='w3-label w3-text-black'>Harga Beli (Rp):</label>
							<input type='text' name='harga' id='harga' class='w3-input w3-tiny w3-border-0' required>
							<p>
							<div class='w3-row'>
								<div class='w3-col s8'><label class='w3-label w3-text-black w3-right'>QTY:</label></div>
								<div class='w3-col s4'>
									<input type='text' name='qty' placeholder='0' id='qty' class='w3-input w3-tiny w3-border-0' required>
								</div>
							</div>
							</p>

							<p><button class='w3-btn w3-red' style='width:100%;' onclick=\"return confirm('Klik OK untuk melanjutkan');\"><i class='fa fa-cart-plus'></i> Tambah Barang</button></p>
						</form>
					</div>

					<br>
				</div>
				<div class='w3-col s9'>
					Data Pembelian
					<div style='border-bottom:1px dashed #ccc;'></div>";


					echo"<br><table class='w3-table w3-tiny w3-hoverable w3-bordered tbl'>
						<thead>
						<tr class='w3-blue'>
							<th>#</th>
							<th>KODE</th>
							<th>BARANG</th>
							<th>HARGA</th>
							<th colspan='2'>SUB TOTAL</th>
						</tr>
						</thead>

						<tbody>";

					$sql = mysql_query("SELECT a.*, b.nama_barang, b.satuan 
										FROM tb_detail_pembelian_tmp a LEFT JOIN tb_barang b 
										ON a.kode_barang = b.kode_barang
										WHERE a.petugas = '$_SESSION[login_id]' 
										ORDER BY timestmp ASC") or die(mysql_error());
					$total = 0;
					if(mysql_num_rows($sql) > 0)
					{
						$no = 1;
						while($p = mysql_fetch_assoc($sql))
						{
							$sub_total = $p['harga_beli'] * $p['qty'];
							$total = $total + $sub_total;
							echo"<tr>
								<td>$no</td>
								<td>$p[kode_barang]</td>
								<td>$p[nama_barang]</td>
								<td>Rp. ".number_format($p['harga_beli'],0)." X $p[qty] $p[satuan]</td>
								<td>Rp. ".number_format($sub_total)."</td>
								<td><a href='$aksi?mod=pembelian&act=batal&id=$p[kode_barang]' onclick=\"return confirm('Yakin ingin membatalkan?');\"><i class='fa fa-close w3-tiny w3-text-grey'></i></a></td>
							</tr>";

							$no++;
						}

					}
						
					else
					{
						echo"<tr>
							<td colspan='5'><i>Tidak ada pembelian</a><td>
						</tr>";
					}
					echo"</tbody>
						<tfoot>
						<tr class='w3-light-grey'>
							<td colspan='4'><b>TOTAL</td>
							<td colspan='2'>Rp. ".number_format($total)."</td>
						</tr>
						</tfoot>
					</table>

					<div class='w3-row-padding'>
						<div class='w3-col s7'>&nbsp;</div>
						<div class='w3-col s5'>
							<form action='$aksi?mod=pembelian&act=simpan' method='POST'>
								<input type='text' name='no_faktur' id='no_faktur' class='w3-input w3-tiny' placeholder='Nomor Faktur ...' required>

								<input type='text' name='supplier' id='supplier' class='w3-input w3-tiny' placeholder='ketik Nama Supplier ...' required>

								<label class='w3-label w3-tiny'>Tanggal Beli :</label>
								<input type='text' name='tglbeli' class='w3-input w3-tiny dp' value='".date('Y-m-d')."' required>

								<input type='text' name='kasir' id='kasir' class='w3-input w3-tiny' placeholder='Nama Kasir ...' required>

								<p><button class='w3-btn w3-right w3-tiny' onclick=\"return confirm('Klik OK untuk melanjutkan');\"><i class='fa fa-save'></i> Simpan Pembelian</button></p>
							</form>
						</div>
						
					</div>

				</div>
			</div>";
			break;

	}
?>