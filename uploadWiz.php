<?php
$ds = DIRECTORY_SEPARATOR;
$storeFolder = 'uploads/wizads';
$filename = date('YmdHis').'-'.rand(0,10000).'.wiz';

if (!empty($_FILES)) {
    
	try {
		$tempFile = $_FILES['wizFile']['tmp_name'];
		$targetPath = dirname( __FILE__ ) . $ds. $storeFolder . $ds;
		$targetFile =  $targetPath . $filename;

		move_uploaded_file($tempFile, $targetFile);
		
		echo json_encode(array(
						'success' => array(
							'msg' => "Archivo Wiz cargado exitosamente",
							'file' => $filename,
						)
					));
	
	} catch(Exception $e) {
		
		echo json_encode(array(
			'error' => array(
				'msg' => $e->getMessage(),
				'code' => $e->getCode(),
			),
		));

	}
}
?> 