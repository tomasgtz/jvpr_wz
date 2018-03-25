<?php

cors();
define( 'API_ACCESS_KEY', 'AIzaSyBherwZbWKLAG1ZpIQvo1NbIyZjuoFYJ6o' );

function cors() {
    // Allow from any origin
    if (isset($_SERVER['HTTP_ORIGIN'])) {
        header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Max-Age: 86400');    // cache for 1 day
    }
    // Access-Control headers are received during OPTIONS requests
    if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
            header("Access-Control-Allow-Methods: GET, POST, OPTIONS");         
        if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
            header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
        exit(0);
    }
}
//incluir el archivo principal
//include("Slim/Slim.php");
include("vendor/autoload.php");

//registran la instancia de slim
//\Slim\Slim::registerAutoloader();
//aplicacion 
$app = new \Slim\Slim();

//routing 
//accediendo VIA URL
//http:///www.google.com/
//localhost/apirest/index.php/ => "Hola mundo ...."

$app->post(
		'/Authentication',function() use ($app){

			$allPostVars = $app->request->post();
			$req = $app->request();
			$email_p = $req->post('email_p');
			$password_p = $req->post('password_p');
			
				//almaceno de el parámetro al servicio
				//conexion con base de datos
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						$data = $cn->query("call uspGet_LoggedUser  ('$email_p', '$password_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

//////////////////////////////////////////////////////////////////////////////////////////

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Campaigns',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$idcompany_p = $req->post('idcompany_p');
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Campaigns('$idcompany_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$name_p = $req->post('name_p');
			$description_p = $req->post('description_p');
			$userup_p = $req->post('userup_p');
			$userupdate_p = $req->post('userupdate_p');
			$dimension_p = $req->post('dimension_p');
			$company_p = $req->post('company_p');
                        $download_p = $req->post('download_p');

			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewCampaign('$name_p','$description_p','$userup_p','$userupdate_p','$dimension_p','$company_p', '$download_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$name_p = $req->post('name_p');
			$description_p = $req->post('description_p');
			$userupdate_p = $req->post('userupdate_p');
			$dimension_p = $req->post('dimension_p');
			$company_p = $req->post('company_p');
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Campaign('$name_p','$description_p','$userupdate_p','$dimension_p','$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);


$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UUserPhoto',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$userid = $req->post('userid');
			$photo = $req->post('photo');
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_UserPhoto('$userid','$photo');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UUserLogo',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$userid = $req->post('userid');
			$photo = $req->post('photo');
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_UserLogo('$userid','$photo');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/ISaveImageOnBank',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$image = $req->post('image');
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_SaveImageOnBank('$image');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GImageBank',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_ImageBank();")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/StatusCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('company_p');
			$status_p = $req->post('status_p');
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_StatusCampaign('$campaign_p','$status_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Company',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Company();")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/SelectedCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_SelectedCompany('$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$name_p = $req->post('name_p');
			$address_p = $req->post('address_p');
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewCompany('$name_p','$address_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$name_p = $req->post('name_p');
			$address_p = $req->post('address_p');
			$company_p = $req->post('company_p');
			$industry_p = $req->post('industry_p');
			$noemployees_p = $req->post('noemployees_p');
			$webpage_p = $req->post('webpage_p');
			$pc_p = $req->post('pc_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Company('$name_p','$address_p','$company_p', '$industry_p', '$noemployees_p', '$pc_p', '$webpage_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/StatusCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$status_p = $req->post('status_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_StatusCompany('$company_p','$status_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Company_TextConfig',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Company_TextConfig('$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCompany_TextConfig',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$textconfig_p = $req->post('textconfig_p');
			$array = json_decode( $textconfig_p, true );

			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						foreach($array as $item) {
							$textnew = $item['text_config']; 
							$data = $cn->query("call uspIns_NewCompany_TextConfig('$company_p','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCompany_Palette',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$color_p = $req->post('color_p');
			$array = json_decode( $color_p, true );

			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						foreach($array as $item) {
							$textnew = $item['color']; 
							$data = $cn->query("call uspIns_NewCompany_Palette('$company_p','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UCompany_TextConfig',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$textconfig_p = $req->post('textconfig_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_UCompany_TextConfig('$company_p','$textconfig_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/StatusCompany_TextConfig',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$status_p = $req->post('status_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_StatusCompany_TextConfig('$company_p','$status_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Company_Pack',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Company_Pack('$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCompany_Pack',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$image_p = $req->post('image_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewCompany_Pack('$company_p','$image_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UCompany_Pack',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$image_p = $req->post('image_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Company_Pack('$company_p','$image_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/StatusCompany_Pack',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$status_p = $req->post('status_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_StatusCompany_Pack('$company_p','$status_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Company_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Company_Subscription('$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCompany_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$subscription_p = $req->post('subscription_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewCompany_Subscription('$company_p','$subscription_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UCompany_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Company_Subscription('$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/StatusCompany_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$status_p = $req->post('status_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_StatusCompany_Subscription('$company_p','$status_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Design',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Design('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewDesign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$user_p = $req->post('user_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewDesign('$campaign_p','$user_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UDesign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Design('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/StatusDesign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$status_p = $req->post('status_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_StatusDesign('$campaign_p','$status_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Ct_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Ct_Subscription();")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/SelectedCt_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$subs_p = $req->post('subs_p');
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_SelectedCt_Subscription('$subs_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCt_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$description_p = $req->post('description_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewCt_Subscription('$description_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UCt_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$description_p = $req->post('description_p');
			$subs_p = $req->post('subs_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Ct_Subscription('$description_p'.'$subs_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Ct_Dimensions',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Ct_Dimensions('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCt_Dimensions',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$height_p = $req->post('height_p');
			$width_p = $req->post('width_p');



				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewCt_Dimensions('$campaign_p','$height_p','$width_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UCt_Dimensions',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$height_p = $req->post('height_p');
			$width_p = $req->post('width_p');
			$description_p = $req->post('description_p');	



				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Ct_Dimensions('$campaign_p','$height_p','$width_p','$description_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Det_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');



				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Det_Subscription('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewDet_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$subs_p = $req->post('subs_p');
			$price_p = $req->post('price_p');
			$individualusercost_p = $req->post('individualusercost_p');
			$image_p = $req->post('image_p');
			$firstplus_p = $req->post('firstplus_p');
			$secplus_p = $req->post('secplus_p');
			$thirdplus_p = $req->post('thirdplus_p');
			$frthplus_p = $req->post('frthplus_p');
			$fifthplus_p = $req->post('fifthplus_p');
			$sixthplus_p = $req->post('sixthplus_p');
			$sevnplus_p = $req->post('sevnplus_p');



				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewDet_Subscription('$subs_p','$price_p','$individualusercost_p','$image_p','$firstplus_p','$secplus_p','$thirdplus_p','$frthplus_p','$fifthplus_p','$sixthplus_p','$sevnplus_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UDet_Subscription',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$subs_p = $req->post('subs_p');
			$price_p = $req->post('price_p');
			$individualusercost_p = $req->post('individualusercost_p');
			$image_p = $req->post('image_p');
			$firstplus_p = $req->post('firstplus_p');
			$secplus_p = $req->post('secplus_p');
			$thirdplus_p = $req->post('thirdplus_p');
			$frthplus_p = $req->post('frthplus_p');
			$fifthplus_p = $req->post('fifthplus_p');
			$sixthplus_p = $req->post('sixthplus_p');
			$sevnplus_p = $req->post('sevnplus_p');



				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Det_Subscription('$subs_p','$price_p','$individualusercost_p','$image_p','$firstplus_p','$secplus_p','$thirdplus_p','$frthplus_p','$fifthplus_p','$sixthplus_p','$sevnplus_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Control_Historic',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Control_Historic('$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewControl_Historic',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$user_p = $req->post('user_p');
			$description_p = $req->post('description_p');
			


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewControl_Historic('$user_p','$description_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UControl_Historic',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$user_p = $req->post('user_p');
			$description_p = $req->post('description_p');
			$company_p = $req->post('company_p');
			


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_Control_Historic('$user_p','$description_p','$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/StatusControl_Historic',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$user_p = $req->post('user_p');
			$description_p = $req->post('description_p');
			$company_p = $req->post('company_p');
			


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_StatusControl_Historic('$user_p','$description_p','$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/General_Messages',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_General_Messages('$company_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UGeneral_Messages',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$idgmessage_p = $req->post('idgmessage_p');
			$userup_p = $req->post('userup_p');
			$usersend_p = $req->post('usersend_p');
			$userreceive_p = $req->post('userreceive_p');
			$focusgroup_p = $req->post('focusgroup_p');
			$message_p = $req->post('message_p');			


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_General_Messages('$company_p','$idgmessage_p','$userup_p','$usersend_p','$userreceive_p','$focusgroup_p','$message_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/StatusGeneral_Messages',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$status_p = $req->post('status_p');			


				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_StatusGeneral_Messages('$company_p','$status_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UUser',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$name_p = $req->post('name_p');
			$password_p = $req->post('password_p');
			$mobilephone_p = $req->post('mobilephone_p');
			$homephone_p = $req->post('homephone_p');
			$iduser_p = $req->post('iduser_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_User('$name_p','$password_p','$mobilephone_p', '$homephone_p', '$iduser_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GUserCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$idcompany_p = $req->post('idcompany_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_UsersCompany('$idcompany_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UUserFreeCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$userArray = $req->post('user');
			$userArray = json_decode($userArray, true );

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						foreach($userArray as $item) {
							$textnew = $item['id_user']; 
							$value 	 = $item['free_campaign']; 
							$data = $cn->query("call uspUpd_UserFreeCampaign('$value', '$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GTextsCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$idcompany_p = $req->post('idcompany_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_TextCompany('$idcompany_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GPaletteCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$idcompany_p = $req->post('idcompany_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_PaletteCompany('$idcompany_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GFontsCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$idcompany_p = $req->post('idcompany_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Company_Fonts('$idcompany_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GPackCompany',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$idcompany_p = $req->post('idcompany_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Company_Pack('$idcompany_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);


$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GMaterials',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_Materials();")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GPaletteCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_CampaignPalette('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GTextsCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_CampaignTexts('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GMaterialsCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_CampaignMaterial('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GPackCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_CampaignPack('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GPackIdentity',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_IdentityImages('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/GFontsCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$host_p = $req->post('host_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_CampaignFonts('$campaign_p','$host_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

//Deletes Campaign Features



$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/DPaletteCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspDel_CampaignPalette('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/DTextsCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspDel_CampaignTexts('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/DMaterialsCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspDel_CampaignMaterial('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/DPackCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspDel_CampaignPack('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/DFontsCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspDel_CampaignFonts('$campaign_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

// Campaign Insert services features




$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/IPaletteCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$color_p = $req->post('color_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_CampaignPalette('$campaign_p','$color_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/IMaterialCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$material_p = $req->post('material_p');
			$download_p = $req->post('download_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_CampaignMaterial('$campaign_p','$material_p', '$download_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);


$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/ITextCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$text_p = $req->post('text_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_CampaignTexts('$campaign_p','$text_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);


$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/IFontCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$font_p = $req->post('font_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_CampaignFonts('$campaign_p','$font_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/IPackCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$campaign_p = $req->post('campaign_p');
			$pack_p = $req->post('pack_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_CampaignPack('$campaign_p','$pack_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewMaterial',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$description_p = $req->post('description_p');
			$width_p = $req->post('width_p');
			$height_p = $req->post('height_p');
			$thumbnail_p = $req->post('thumbnail_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_Material('$description_p','$width_p','$height_p','$thumbnail_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UpdMaterial',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$description_p = $req->post('description_p');
			$width_p = $req->post('width_p');
			$height_p = $req->post('height_p');
			$thumbnail_p = $req->post('thumbnail_p');
			$material_p = $req->post('material_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_Material('$description_p','$width_p','$height_p','$thumbnail_p','$material_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/UpdMaterialStatus',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$status_p = $req->post('status_p');
			$material_p = $req->post('material_p');

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_Material('$status_p','$material_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);


$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/AllUsersAdmin',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_AllUsersAdmin();")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/AllCompaniesAdmin',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_AllCompaniesSubs();")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/CountSubscriptions',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS

				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspGet_CountSubscriptions();")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewUser',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$username_p = $req->post('username_p');
			$company_p = $req->post('company_p');
			$name_p = $req->post('name_p');
			$password_p = $req->post('password_p');
			$homephone_p = $req->post('homephone_p');
			$mobilephone_p = $req->post('mobilephone_p');
			$to   = $name_p;
			$from = 'notificaciones@wizad.mx';
			$headers = "From: " . strip_tags($from) . "\r\n";
			$headers .= "Reply-To: ". strip_tags($from) . "\r\n";
			$headers .= "CC: alanbarreraf@hotmail.com, notificaciones@wizad.mx, jesusvicente@gmail.com \r\n";
			$headers .= "MIME-Version: 1.0\r\n";
			$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
			$message =  '<html>
							<head>
								<title>Wizad</title>
							</head>
							<body>
								<h1>Ya eres parte de WIZAD, tus datos son los siguientes:</h1>
								<table cellspacing="0" style="border: 2px dashed #FB4314; width: 300px; height: 200px;">
									<tr>
										<th>Usuario:</th><td>  '.$name_p.'  </td>
									</tr>
									<tr style="background-color: #e0e0e0;">
										<th>Contrase&ntilde;a:</th><td>  '.$password_p.'   </td>
									</tr>
									<tr>
										<th>Sitio Web:</th><td><a href="http://empresas.wizad.mx">empresas.wizad.mx</a></td>
									</tr>
								</table>
							</body>
						</html>';
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						$data = $cn->query("call uspGet_UserExist('$name_p');")->fetchAll(PDO::FETCH_ASSOC);
						$jsonresult = json_encode($data[0]);
						$jsond = json_decode($jsonresult, true);
						$name = $jsond['name'];
						$test = 0;
						
						if ( $name == null ){
							$data = $cn->query("call uspIns_NewUser('$company_p','$name_p','$password_p','$homephone_p','$mobilephone_p', '$username_p');")->fetchAll(PDO::FETCH_ASSOC);
						
							mail($to, "Wizad - Registrate", $message, $headers);
							echo json_encode($data);
						}else{
							$data = "Ya existe";
							echo json_encode($data);
						}
						
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/Comentario',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$nombrec = $req->post('nombrec');
			$correoc = $req->post('correoc');
			$companiac = $req->post('companiac');
			$telc = $req->post('telc');
			$comentariosc = $req->post('comentariosc');
			$wizademail = "contacto@wizad.mx";
			
			$to   = $wizademail;
			$from = 'notificaciones@wizad.mx';
			$headers = "From: " . strip_tags($from) . "\r\n";
			$headers .= "Reply-To: ". strip_tags($from) . "\r\n";
			$headers .= "CC: alanbarreraf@hotmail.com, notificaciones@wizad.mx, contacto@wizad.mx\r\n";
			$headers .= "MIME-Version: 1.0\r\n";
			$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
			$message =  '<html>
							<head>
								<title>Wizad</title>
							</head>
							<body>
								<h1>Recibiste un comentario de:</h1>
								<h3>'.$nombrec.'<h3><br/>
								<h3>Correo: '.$correoc.'<h3><br/>
								<h3>Negocio: '.$companiac.'<h3><br/>
								<h3>Telefono: '.$telc.'<h3><br/>
								<h3>Comentarios: '.$comentariosc.'<h3><br/>
							</body>
						</html>';
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						$data = $cn->query("call uspGet_UserExist('$name_p');")->fetchAll(PDO::FETCH_ASSOC);
						$jsonresult = json_encode($data[0]);
						$jsond = json_decode($jsonresult, true);
						$name = $jsond['name'];
						$test = 0;
						
						if ( $name == null ){
							$data = $cn->query("call uspIns_NewUser('$company_p','$name_p','$password_p','$homephone_p','$mobilephone_p', '$username_p');")->fetchAll(PDO::FETCH_ASSOC);
						
							mail($to, "Wizad - Comentario", $message, $headers);
							echo json_encode($data);
						}else{
							$data = "Ya existe";
							echo json_encode($data);
						}
						
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewUserLanding',function() use ($app){
		
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			$company_p = $req->post('company_p');
			$name_p = $req->post('name_p');
			$password_p = $req->post('password_p');
			$homephone_p = $req->post('homephone_p');
			$mobilephone_p = $req->post('mobilephone_p');
			 
			// $company_p = $arraydata->company_p;
			// $name_p = $arraydata->name_p;
			// $password_p = $arraydata->password_p;
			// $homephone_p =$arraydata->homephone_p;
			// $mobilephone_p = $arraydata->mobilephone_p;
			
			
			$to   = $name_p;
			$from = 'sistema@wizad.com';
			$headers = "From: " . strip_tags($from) . "\r\n";
			$headers .= "Reply-To: ". strip_tags($from) . "\r\n";
			$headers .= "CC: alanbarreraf@hotmail.com\r\n";
			$headers .= "MIME-Version: 1.0\r\n";
			$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
			$message =  '<html>
							<head>
								<title>Wizad</title>
							</head>
							<body>
								<h1>Ya eres parte de WIZAD, tus datos son los siguientes:</h1>
								<table cellspacing="0" style="border: 2px dashed #FB4314; width: 300px; height: 200px;">
									<tr>
										<th>Usuario:</th><td>  '.$name_p.'  </td>
									</tr>
									<tr style="background-color: #e0e0e0;">
										<th>Contrase&ntilde;a:</th><td>  '.$password_p.'   </td>
									</tr>
									<tr>
										<th>Sitio Web:</th><td><a href="http://www.empresas.wizad.mx">http://www.empresas.wizad.mx</a></td>
									</tr>
								</table>
							</body>
						</html>';
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						$data = $cn->query("call uspGet_UserExist('$name_p');")->fetchAll(PDO::FETCH_ASSOC);
						$jsonresult = json_encode($data[0]);
						$jsond = json_decode($jsonresult, true);
						$name = $jsond['name'];
						$test = 0;
						
						if ( $name == null ){
							$data = $cn->query("call uspIns_NewUser('$company_p','$name_p','$password_p','$homephone_p','$mobilephone_p');")->fetchAll(PDO::FETCH_ASSOC);
						
							mail($to, "Wizad - Registrate", $message, $headers);
							// $test2 = json_decode($xx, true);
							$data = "Usuario registrado exitosamente, se envió tu contraseña por correo. ¡Ya puedes iniciar en nuestra plataforma!";
							echo json_encode($data);
						}else{
							$data = "Este usuario ya se encuentra registrado.";
							echo json_encode($data);
						}
						
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/RecoverPassword',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			//CAMBIAR PARAMETROS
			$password_p = $req->post('password_p');
			$email_p = $req->post('email_p');
			
			$to   = $email_p;
			$from = 'sistema@wizad.com';
			$headers = "From: " . strip_tags($from) . "\r\n";
			$headers .= "Reply-To: ". strip_tags($from) . "\r\n";
			$headers .= "CC: alanbarreraf@hotmail.com\r\n";
			$headers .= "MIME-Version: 1.0\r\n";
			$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
			$message =  '<html>
							<head>
								<title>Wizad</title>
							</head>
							<body>
								<h1>Nueva contrase&ntilde;a para acceder:</h1>
								<table cellspacing="0" style="border: 2px dashed #FB4314; width: 300px; height: 200px;">
									<tr>
										<th>Usuario:</th><td>  '.$email_p.'  </td>
									</tr>
									<tr style="background-color: #e0e0e0;">
										<th>Contrase&ntilde;a:</th><td>  '.$password_p.'   </td>
									</tr>
									<tr>
										<th>Sitio Web:</th><td><a href="http://www.wizadqa.mbledteq.com">www.wizadqa.mbledteq.com</a></td>
									</tr>
								</table>
							</body>
						</html>';
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspUpd_UserPassword('$password_p','$email_p');")->fetchAll(PDO::FETCH_ASSOC);
						
						
						
						mail($to, "Wizad - Nueva clave", $message, $headers);
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/SaveNewCampaign',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$description_c = $req->post('description_c');
			$title_c = $req->post('title_c');
			$autorization_c = $req->post('autorization_c');
			$company_p = $req->post('company_p');
			$segment_c = $req->post('segment_c');
			$city_c = $req->post('city_c');
			$age_c = $req->post('age_c');
                        
			
			// foreach($array as $item) {
				// $textnew = $item['color']; 
				// $data = $cn->query("call uspIns_NewCompany_Palette('$company_p','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
			// }
			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						//CAMBIAR PROCEDIMIENTO
						$data = $cn->query("call uspIns_NewCampaign('$title_c','$description_c',0,0,1,'$company_p','$segment_c','$city_c','$age_c', '$autorization_c');")->fetchAll(PDO::FETCH_ASSOC);
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/SaveCampaignConfig',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaignid = $req->post('campaignid');
			$textconfig_p = $req->post('textconfig_p');
			$textarray = json_decode($textconfig_p, true );
			$palette_p = $req->post('palette_p');
			$palettearray = json_decode( $palette_p, true );
			$material_p = $req->post('material_p');
			$materialarray = json_decode( $material_p, true );
			$image_p = $req->post('image_p');
			$imagearray = json_decode( $image_p, true );
			$font_p = $req->post('font_p');
			$fontarray = json_decode( $font_p, true );
			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						foreach($textarray as $item) {
							$textnew = $item['text_config']; 
							$data = $cn->query("call uspIns_CampaignTexts('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($palettearray as $item) {
							$textnew = $item['color']; 
							$data = $cn->query("call uspIns_CampaignPalette('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($materialarray as $item) {
							$textnew = $item['id_material']; 
							$data = $cn->query("call uspIns_CampaignMaterial('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($imagearray as $item) {
							$textnew = $item['pack']; 
							$data = $cn->query("call uspIns_CampaignPack('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($fontarray as $item) {
							$textnew = $item['font']; 
							$data = $cn->query("call uspIns_CampaignFonts('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/SaveCampaignUpdate',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaignid = $req->post('campaignid');
			$newTextArray = $req->post('newTextArray');
			$newTextArray = json_decode($newTextArray, true );
			$newPaletteArray = $req->post('newPaletteArray');
			$newPaletteArray = json_decode( $newPaletteArray, true );
			$newMaterialArray = $req->post('newMaterialArray');
			$newMaterialArray = json_decode( $newMaterialArray, true );
			$newPackArray = $req->post('newPackArray');
			$newPackArray = json_decode( $newPackArray, true );
			$newFontArray = $req->post('newFontArray');
			$newFontArray = json_decode( $newFontArray, true );
			$delTextArray = $req->post('delTextArray');
			$delTextArray = json_decode($delTextArray, true );
			$delPaletteArray = $req->post('delPaletteArray');
			$delPaletteArray = json_decode( $delPaletteArray, true );
			$delMaterialArray = $req->post('delMaterialArray');
			$delMaterialArray = json_decode( $delMaterialArray, true );
			$delPackArray = $req->post('delPackArray');
			$delPackArray = json_decode( $delPackArray, true );
			$delFontArray = $req->post('delFontArray');
			$delFontArray = json_decode( $delFontArray, true );
			$autorization = $req->post('autorization');
                        $name         = $req->post('name');
                        $description  = $req->post('description');
                        $userupdate   = $req->post('userupdate');
                       

			
			//NO MOVER
			
			//Replace the below connection parameters to fit your environment
			$dbms = 'mysql';
			$host = 'localhost'; 
			$db = 'wizadadm_wizad';
			$user = 'wizadadm_mrkt';
			$pass = 'Decaene09!';
			$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


			$cn=new PDO($dsn, $user, $pass);
			$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
			try
			{

				$data = $cn->query("call uspUpd_Campaign('$name', '$description', '$userupdate', '$campaignid', '$autorization' );");

				//New items to campaign update
				if(is_array($newTextArray) && count($newTextArray) > 0) {
					foreach($newTextArray as $item) {
						$textnew = $item['text']; 
						$data = $cn->query("call uspIns_CampaignTexts('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}
				}

				if(is_array($newPaletteArray) && count($newPaletteArray) > 0) {
					foreach($newPaletteArray as $item) {
						$textnew = $item['color']; 
						$data = $cn->query("call uspIns_CampaignPalette('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}
				}

				if(is_array($newMaterialArray) && count($newMaterialArray) > 0) {
					foreach($newMaterialArray as $item) {
						$textnew = $item['id_material']; 
						$data = $cn->query("call uspIns_CampaignMaterial('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}
				}

				if(is_array($newPackArray) && count($newPackArray) > 0) {
					foreach($newPackArray as $item) {
						$textnew = $item['image']; 
						$data = $cn->query("call uspIns_CampaignPack('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}
				}

				if(is_array($newFontArray) && count($newFontArray) > 0) {
					foreach($newFontArray as $item) {
						$textnew = $item['font']; 
						$data = $cn->query("call uspIns_CampaignFonts('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}
				}						
				//Drop items to campaign update	


				if(is_array($delTextArray) && count($delTextArray) > 0) {
					foreach($delTextArray as $item) {
						$textnew = $item['id_cgtext']; 
						$data = $cn->query("call uspDel_CampaignTexts('$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}
				}

				if(is_array($delPaletteArray) && count($delPaletteArray) > 0) {
					foreach($delPaletteArray as $item) {
						$textnew = $item['id_cgpalette']; 
						$data = $cn->query("call uspDel_CampaignPalette('$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}
				}

				if(is_array($delMaterialArray) && count($delMaterialArray) > 0) {
					foreach($delMaterialArray as $item) {
						$textnew = $item['id_material']; 
						$data = $cn->query("call uspDel_CampaignMaterial('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}

				}

				if(is_array($delPackArray) && count($delPackArray) > 0) {
					foreach($delPackArray as $item) {
						$textnew = $item['id_cgpack']; 
						$data = $cn->query("call uspDel_CampaignPack('$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}
				}

				if(is_array($delFontArray) && count($delFontArray) > 0) {
					foreach($delFontArray as $item) {
						$textnew = $item['id_cgfont']; 
						$data = $cn->query("call uspDel_CampaignFonts('$textnew');")->fetchAll(PDO::FETCH_ASSOC);
					}

				}
				$data = null;
				$data[] = array('returnMessage' => "SUCCESS");	
				echo json_encode($data);
			}
			
			catch(PDOException $e) {
					echo "Error: ".$e->getMessage();
			}			
				
					
		}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/SaveCompanyUpdate',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$company_p = $req->post('company_p');
			$newTextArray = $req->post('newTextArray');
			$newTextArray = json_decode($newTextArray, true );
			$newPaletteArray = $req->post('newPaletteArray');
			$newPaletteArray = json_decode( $newPaletteArray, true );
			$newMaterialArray = $req->post('newMaterialArray');
			$newMaterialArray = json_decode( $newMaterialArray, true );
			$newPackArray = $req->post('newPackArray');
			$newPackArray = json_decode( $newPackArray, true );
			$newFontArray = $req->post('newFontArray');
			$newFontArray = json_decode( $newFontArray, true );
			$delTextArray = $req->post('delTextArray');
			$delTextArray = json_decode($delTextArray, true );
			$delPaletteArray = $req->post('delPaletteArray');
			$delPaletteArray = json_decode( $delPaletteArray, true );
			$delMaterialArray = $req->post('delMaterialArray');
			$delMaterialArray = json_decode( $delMaterialArray, true );
			$delPackArray = $req->post('delPackArray');
			$delPackArray = json_decode( $delPackArray, true );
			$delFontArray = $req->post('delFontArray');
			$delFontArray = json_decode( $delFontArray, true );
			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
					//New items to campaign update
						foreach($newTextArray as $item) {
							$textnew = $item['text']; 
							$data = $cn->query("call uspIns_NewCompany_TextConfig('$company_p','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($newPaletteArray as $item) {
							$textnew = $item['color']; 
							$data = $cn->query("call uspIns_NewCompany_Palette('$company_p','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($newPackArray as $item) {
							$textnew = $item['image']; 
							$data = $cn->query("call uspIns_NewCompany_Pack('$company_p','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($newFontArray as $item) {
							$textnew = $item['font']; 
							$data = $cn->query("call uspIns_NewCompany_Font('$company_p','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						
					//Drop items to campaign update	
						foreach($delTextArray as $item) {
							$textnew = $item['id_config']; 
							$data = $cn->query("call uspDel_Company_Text('$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($delPaletteArray as $item) {
							$textnew = $item['id_palette']; 
							$data = $cn->query("call uspDel_Company_Palette('$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($delPackArray as $item) {
							$textnew = $item['id_pack']; 
							$data = $cn->query("call uspDel_Company_Pack('$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						foreach($delFontArray as $item) {
							$textnew = $item['id_font']; 
							$data = $cn->query("call uspDel_Company_Font('$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCampaign_TextConfig',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaignid = $req->post('campaignid');
			$textconfig_p = $req->post('textconfig_p');
			$array = json_decode( $textconfig_p, true );

			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						foreach($array as $item) {
							$textnew = $item['text_config']; 
							$data = $cn->query("call uspIns_CampaignTexts('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		//CAMBIAR NOMBRE DEL SERVICIO
		'/NewCampaign_Palette',function() use ($app){
		
			//NO MOVER
			$allPostVars = $app->request->post();
			$req = $app->request();
			
			
			//CAMBIAR PARAMETROS
			$campaignid = $req->post('campaignid');
			$color_p = $req->post('color_p');
			$array = json_decode( $color_p, true );

			
			
				//NO MOVER
				
				//Replace the below connection parameters to fit your environment
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db";


				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				try
				{
						foreach($array as $item) {
							$textnew = $item['color']; 
							$data = $cn->query("call uspIns_CampaignPalette('$campaignid','$textnew');")->fetchAll(PDO::FETCH_ASSOC);
						}
						
						
						echo json_encode($data);
				}
				
				catch(PDOException $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/NewCampaign_Pack',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db";

				$campaignid 	= $req->post('campaignid');
				$baseimage 		= $req->post('baseimage');
				$imagename 		= 'wizadImages/a.jpg';
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{							
									
					
								list($type, $baseimage) = explode(';', $data);
								list(, $baseimage)      = explode(',', $data);
								$baseimage = base64_decode($baseimage);
								file_put_contents($imagename, $baseimage);
							
							
							
						$callBack  = $cn->query("CALL uspIns_CampaignPack ('$campaignid','$imagename')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($imagename);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/GCities',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";

				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{						
						$callBack  = $cn->query("CALL uspGet_Cities ()")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/GAges',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";

				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{							
								
						$callBack  = $cn->query("CALL uspGet_Ages ()")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/GSegments',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspGet_Segments ()")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/IAdminInbox',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
				$name_c 	= $req->post('name_c');
				$message_c 	= $req->post('message_c');
				$company_c 	= $req->post('company_c');
				$email_c 	= $req->post('email_c');
				$phone_c 	= $req->post('phone_c');
				
						
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspIns_Inbox ('$name_c', '$message_c', '$company_c', '$email_c', '$phone_c' )")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/GAdmin_Inbox',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspGet_Inbox()")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/UInbox',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$idinbox_c 	= $req->post('idinbox_c');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspUpd_Inbox ('$idinbox_c')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/AddHistory',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$user_p 		= $req->post('user_p');
				$message_p 		= $req->post('message_p');
				$campaign_p 	= $req->post('campaign_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspIns_AddHistory ('$user_p','$message_p','$campaign_p')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/DUser',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$user_p 		= $req->post('user_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspDel_User ('$user_p')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/UUserStatus',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$user_p 		= $req->post('user_p');
				$status_p 		= $req->post('status_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspUpd_UserStatus ('$status_p','$user_p')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/UCompanyStatus',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$company_p 		= $req->post('company_p');
				$status_p 		= $req->post('status_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspUpd_CompanyStatus ('$status_p','$company_p')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/UMaterialStatus',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$idmaterial_p	= $req->post('idmaterial_p');
				$status_p 		= $req->post('status_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspUpd_MaterialStatus ('$idmaterial_p','$status_p')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/IMaterial',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$description_p	= $req->post('description_p');
				$width_p 		= $req->post('width_p');
				$height_p 		= $req->post('height_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspIns_NewMaterial ('$description_p','$width_p','$height_p')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);



$app->post(
		'/UFreeMaterial',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$idmaterial_p	= $req->post('idmaterial_p');
				$free_p 		= $req->post('free_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspUpd_FreeMaterial ('$idmaterial_p','$free_p')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);


$app->post(
		'/DCampaign',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				$campaign_p	= $req->post('campaign_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspDel_Campaign ('$campaign_p')")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/GFonts',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspGet_Fonts ()")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/NewVisit',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
						
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspIns_NewVisit ()")->fetchAll(PDO::FETCH_ASSOC);
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/DashboardCount',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
				$array = array();
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspGet_UserCounts ()")->fetchAll(PDO::FETCH_ASSOC);
						array_push($array, $callBack);
						$callBack  = $cn->query("CALL uspGet_VisitCount ()")->fetchAll(PDO::FETCH_ASSOC);
						array_push($array, $callBack);
						$callBack  = $cn->query("CALL uspGet_CampaignCount ()")->fetchAll(PDO::FETCH_ASSOC);
						array_push($array, $callBack);
						$callBack  = $cn->query("CALL uspGet_FreeUsers ()")->fetchAll(PDO::FETCH_ASSOC);
						array_push($array, $callBack);
						
						echo json_encode($array);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/GetHistory',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
				$array = array();
				$idcompany_p	= $req->post('idcompany_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspGet_HistoryGeneral ('$idcompany_p')")->fetchAll(PDO::FETCH_ASSOC);
						array_push($array, $callBack);
						$callBack  = $cn->query("CALL uspGet_HistoryCampaign ('$idcompany_p')")->fetchAll(PDO::FETCH_ASSOC);
						array_push($array, $callBack);
						
						echo json_encode($array);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/GetAllSubscriptions',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
				$array = array();
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspGet_AllSubscriptions ()")->fetchAll(PDO::FETCH_ASSOC);
						
						
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/GHistoryCompany',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
				$idcompany_p 		= $req->post('idcompany_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspGet_HistoryCompany ('$idcompany_p')")->fetchAll(PDO::FETCH_ASSOC);
						
						
						echo json_encode($callBack);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);

$app->post(
		'/ICompanyNAdminUser',function() use ($app){
						
			$allPostVars = $app->request->post();
			$req = $app->request();
					
			$nameusernoemail 		= $req->post('nameusernoemail_p');
			$name_p 		= $req->post('name_p');
			$address_p 		= $req->post('address_p');
			$logo_p 		= $req->post('logo_p');
			$city_p 		= $req->post('city_p');
			$nameuser_p 	= $req->post('nameuser_p');
			$password_p 	= $req->post('password_p');
			$homephone_p 	= $req->post('homephone_p');
			$mobilephone_p 	= $req->post('mobilephone_p');
			$employees_p 	= $req->post('employees_p');
			$industry_p 	= $req->post('industry_p');
			$webpage_p 		= $req->post('webpage_p');
			$pc_p	 		= $req->post('pc_p');
			$subs_p	 		= $req->post('subs_p');
			$storage_p	 	= $req->post('storage_p');
			$freq_p			= $req->post('freq_p');
			
			$to   = $nameuser_p;
			$from = 'sistema@wizad.com';
			$headers = "From: " . strip_tags($from) . "\r\n";
			$headers .= "Reply-To: ". strip_tags($from) . "\r\n";
			$headers .= "CC: alanbarreraf@hotmail.com\r\n";
			$headers .= "MIME-Version: 1.0\r\n";
			$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
			$message =  '<html>
							<head>
								<title>Wizad</title>
							</head>
							<body>
								<h1>Nueva contrase&ntilde;a para acceder:</h1>
								<table cellspacing="0" style="border: 2px dashed #FB4314; width: 300px; height: 200px;">
									<tr>
										<th>Usuario:</th><td>  '.$nameuser_p.'  </td>
									</tr>
									<tr style="background-color: #e0e0e0;">
										<th>Contrase&ntilde;a:</th><td>  '.$password_p.'   </td>
									</tr>
									<tr>
										<th>Sitio Web:</th><td><a href="http://www.wizadqa.mbledteq.com">www.wizadqa.mbledteq.com</a></td>
									</tr>
								</table>
							</body>
						</html>';
			
			$dbms = 'mysql';
			$host = 'localhost'; 
			$db = 'wizadadm_wizad';
			$user = 'wizadadm_mrkt';
			$pass = 'Decaene09!';
			$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
			
			$cn=new PDO($dsn, $user, $pass);
			$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
			
			try
			{					
					$callBack  = $cn->query("CALL uspIns_NewCompany ('$name_p','$address_p','$logo_p','$city_p','$employees_p','$industry_p','$webpage_p', '$pc_p', '$storage_p')")->fetchAll(PDO::FETCH_ASSOC);
					$callBack  = $cn->query("CALL uspGet_NewCompanyID ()")->fetchAll(PDO::FETCH_ASSOC);
					$jsonresult = json_encode($callBack[0]);
					$jsond = json_decode($jsonresult, true);
					$id_company = $jsond['id_company'];
					
					if ( $id_company > 0 ){
						$data = $cn->query("call uspIns_CompanySubscription('$id_company','$subs_p', '$freq_p');")->fetchAll(PDO::FETCH_ASSOC);
						$data = $cn->query("call uspIns_NewAdminUser('$id_company','$nameuser_p','$password_p','$homephone_p','$mobilephone_p', '$nameusernoemail');")->fetchAll(PDO::FETCH_ASSOC);
					
						mail($to, "Wizad - Inicia", $message, $headers);
						echo json_encode($data);
					}else{
						echo json_encode($id_company);
					}
					
			}
			
			catch(Exception $e) {
					echo $e->getMessage();
			}			
			
				
		}
);

$app->post(
		'/NotifyAdministratorFreeCampaign',function() use ($app){
						
			$allPostVars = $app->request->post();
			$req = $app->request();
					
			$idcompany_p 	= $req->post('idcompany_p');
			$user_p 		= $req->post('user_p');
			
			$from = 'sistema@wizad.com';
			$headers = "From: " . strip_tags($from) . "\r\n";
			$headers .= "Reply-To: ". strip_tags($from) . "\r\n";
			$headers .= "CC: alanbarreraf@hotmail.com\r\n";
			$headers .= "MIME-Version: 1.0\r\n";
			$headers .= "Content-Type: text/html; charset=ISO-8859-1\r\n";
			
			
			$dbms = 'mysql';
			$host = 'localhost'; 
			$db = 'wizadadm_wizad';
			$user = 'wizadadm_mrkt';
			$pass = 'Decaene09!';
			$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
			
			$cn=new PDO($dsn, $user, $pass);
			$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
			
			try
			{					
					$callBack  = $cn->query("CALL uspGet_CompanyAdministrator ('$idcompany_p')")->fetchAll(PDO::FETCH_ASSOC);
					$jsonresult = json_encode($callBack[0]);
					$jsond = json_decode($jsonresult, true);
					$to = $jsond['name'];
					
					$message =  '<html>
							<head>
								<title>Wizad</title>
							</head>
							<body>
								<h1>Campa&ntilde;a Libre</h1>
								<table cellspacing="0" style="border: 2px dashed #FB4314; width: 300px; height: 200px;">
									<tr>
										<th>El usuario empez&oacute; una campa&ntilde;a libre:</th><td>  '.$user_p.'  </td>
									</tr>
									<tr>
										<th>Sitio Web:</th><td><a href="http://www.wizadqa.mbledteq.com">www.wizadqa.mbledteq.com</a></td>
									</tr>
								</table>
							</body>
						</html>';
					
					mail($to, "Wizad - NOTIFICACION", $message, $headers);
					echo json_encode($callBack);
					
			}
			
			catch(Exception $e) {
					echo $e->getMessage();
			}			
			
				
		}
);


$app->post(
		'/GetDownloadPermission',function() use ($app){
						
				$allPostVars = $app->request->post();
				$req = $app->request();
				$array = array();
				$idcompany_p	= $req->post('idcompany_p');
				
				$dbms = 'mysql';
				$host = 'localhost'; 
				$db = 'wizadadm_wizad';
				$user = 'wizadadm_mrkt';
				$pass = 'Decaene09!';
				$dsn = "$dbms:host=$host;dbname=$db;charset=utf8";
				
				$cn=new PDO($dsn, $user, $pass);
				$cn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
				
				try
				{					
						$callBack  = $cn->query("CALL uspGet_CampaignDownloadPermission ('$idcampaign_p')")->fetchAll(PDO::FETCH_ASSOC);
						array_push($array, $callBack);
						
						echo json_encode($array);
				}
				
				catch(Exception $e) {
						echo $e->getMessage();
				}			
				
					
			}
);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//inicializamos la aplicacion(API)
$app->run();