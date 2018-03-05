-- phpMyAdmin SQL Dump
-- version 4.7.3
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 27-01-2018 a las 15:07:38
-- Versión del servidor: 5.5.58-cll
-- Versión de PHP: 5.6.30

CREATE DATABASE vemacu_wizad;
use vemacu_wizad;

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `mbledteq_wizad`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE PROCEDURE `uspDel_Campaign` (IN `idcampaign_p` INT(9))  NO SQL
BEGIN


	Delete From Campaign_Fonts
	Where fk_campaign = idcampaign_p;

	Delete From Campaign_Material
	Where fk_campaign = idcampaign_p;

	Delete From Campaign_Pack
	Where fk_campaign = idcampaign_p;

	Delete From Campaign_Palette
	Where fk_campaign = idcampaign_p;

	Delete From Campaign_Texts
	Where fk_campaign = idcampaign_p;

	Delete From Campaign
	Where id_campaign = idcampaign_p;

	SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspDel_CampaignFonts` (IN `id_cgfont_c` INT(9))  NO SQL
BEGIN


	DELETE FROM Campaign_Fonts WHERE id_cgfont = id_cgfont_c;

	SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspDel_CampaignMaterial` (IN `campaign_c` INT(9), IN `idmaterial_c` INT(9))  NO SQL
BEGIN

	DELETE FROM Campaign_Material WHERE fk_campaign = campaign_c and fk_material = idmaterial_c;
	SELECT 'SUCCESS' AS returnMessage;
END$$

CREATE PROCEDURE `uspDel_CampaignPack` (IN `idcgpack_c` INT(9))  NO SQL
BEGIN

	DELETE FROM Campaign_Pack WHERE id_cgpack = idcgpack_c;
	SELECT 'SUCCESS' AS returnMessage;
END$$

CREATE PROCEDURE `uspDel_CampaignPalette` (IN `id_cgpalette_c` INT(9))  NO SQL
BEGIN


	DELETE FROM Campaign_Palette WHERE id_cgpalette = id_cgpalette_c;
	SELECT 'SUCCESS' AS returnMessage;
    END$$

CREATE PROCEDURE `uspDel_CampaignTexts` (IN `idcgtext_c` INT(9))  NO SQL
BEGIN

	DELETE FROM Campaign_Texts WHERE id_cgtext = idcgtext_c;
	SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspDel_Company_Font` (IN `idfont_c` INT(9))  NO SQL
BEGIN

	DELETE FROM Company_Fonts WHERE id_font = idfont_c;

	SELECT "SUCCESS" as returnMessage;


END$$

CREATE PROCEDURE `uspDel_Company_Pack` (IN `idpack_c` INT(9))  NO SQL
BEGIN

	DELETE FROM Company_Pack  WHERE id_pack = idpack_c;

	SELECT "SUCCESS" as returnMessage;

END$$

CREATE PROCEDURE `uspDel_Company_Palette` (IN `idpalette_c` INT(9))  NO SQL
BEGIN

	DELETE FROM Company_Palette WHERE id_palette = idpalette_c;

	SELECT "SUCCESS" as returnMessage;

END$$

CREATE PROCEDURE `uspDel_Company_Text` (IN `idconfig_c` INT(9))  NO SQL
BEGIN

	DELETE FROM Company_TextConfig WHERE id_config = idconfig_c;

	SELECT "SUCCESS" as returnMessage;

END$$

CREATE PROCEDURE `uspDel_User` (IN `iduser_p` INT(9))  NO SQL
BEGIN


	DELETE FROM User WHERE id_user = iduser_p;

	SELECT 'SUCCESS' as returnMessage;


END$$

CREATE PROCEDURE `uspGet_Ages` ()  NO SQL
BEGIN

SELECT id_age, rangee
FROM Ct_Age;

END$$

CREATE PROCEDURE `uspGet_AllCompaniesSubs` ()  NO SQL
BEGIN

	SELECT  C.id_company,
			C.name,
			C.industry,
			C.web_page,
			C.date_up,
			description,
			C.no_employees,
			C.storage,
			C.address,
			fk_contract,
			CS.date_up AS subs_contract,
			"" as contract_status,
			CASE 
				WHEN fk_contract = 1
				THEN DATEDIFF(DATE_ADD(CS.date_up, INTERVAL 6 MONTH),NOW())
				ELSE DATEDIFF(DATE_ADD(CS.date_up, INTERVAL 12 MONTH),NOW())
			END AS days_left,
			C.status
			
			

	FROM	Company C

	INNER JOIN Company_Subscription CS
	on C.id_company = CS.fk_company

	INNER JOIN Ct_Subscription CtS
	ON id_subs = CS.fk_subscription;


	

		
END$$

CREATE PROCEDURE `uspGet_AllSubscriptions` ()  NO SQL
BEGIN

SELECT id_subs, description,users, storage
FROM Ct_Subscription;


END$$

CREATE PROCEDURE `uspGet_AllUsersAdmin` ()  NO SQL
BEGIN

	SELECT  U.id_user,
			U.date_up,
			U.name,
			U.status,
			CASE when U.status = 1 then 'Activo'
				 when U.status = 2 then 'Inactivo'
			END AS statusdesc,
			C.name as empresa,
			CtS.description
			

	FROM	User U

	INNER JOIN Company C
	on U.fk_company = C.id_company

	INNER JOIN Company_Subscription CS
	on C.id_company = CS.fk_company

	INNER JOIN Ct_Subscription CtS
	ON id_subs = CS.fk_subscription;


	

		
END$$

CREATE PROCEDURE `uspGet_CampaignCount` ()  NO SQL
BEGIN

	SELECT COUNT(id_campaign) AS Campaigns FROM Campaign WHERE status = 1;

END$$

CREATE PROCEDURE `uspGet_CampaignFonts` (IN `campaign_c` INT(9))  NO SQL
BEGIN


	SELECT id_cgfont, date_up, date_update, fk_campaign, status, font,
				CONCAT('http://wizadqa.mbledteq.com/uploads/', font) as url
FROM Campaign_Fonts 
WHERE status = 1 AND fk_campaign = campaign_c;


END$$

CREATE PROCEDURE `uspGet_CampaignMaterial` (IN `campaign_c` INT(9))  NO SQL
BEGIN

SELECT CM.id_cgmaterial, CM.date_up, CM.date_update, CM.fk_campaign, 
CM.status, CM.fk_material, CM.download, M.id_material, M.description, 
M.width, M.height, M.status, M.thumbnail , M.multiplier, M.width_small, M.height_small, M.width_multiplier, M.height_multiplier

FROM Campaign_Material CM 

INNER JOIN Ct_Material M 
ON CM.fk_material = M.id_material 

WHERE CM.status = 1 and fk_campaign = campaign_c
AND M.status = 1;


END$$

CREATE PROCEDURE `uspGet_CampaignMaterialMosaico` (IN `campaign_c` INT(9))  NO SQL
BEGIN


SELECT * FROM 
Campaign_Material CM
INNER JOIN Ct_Material CTM
ON CTM.id_material = CM.fk_material
WHERE CM.fk_campaign = idcampaign_c
AND CTM.status = 1;


END$$

CREATE PROCEDURE `uspGet_CampaignPack` (IN `campaign_c` INT(9))  NO SQL
BEGIN

SELECT CP.id_cgpack, CP.date_up, 
CP.date_update, CP.fk_campaign, CP.status, CP.image

FROM Campaign_Pack CP


WHERE CP.status = 1 AND CP.fk_campaign = campaign_c;

END$$

CREATE PROCEDURE `uspGet_CampaignPalette` (IN `campaign_c` INT(9))  NO SQL
BEGIN


SELECT id_cgpalette, date_up, date_update, fk_campaign, status, color 
FROM Campaign_Palette WHERE status = 1 
AND fk_campaign  = campaign_c;

END$$

CREATE PROCEDURE `uspGet_Campaigns` (IN `idcompany_p` INT(9))  NO SQL
BEGIN

	SELECT  C.id_campaign,
            C.name as campaign_name,
            C.description,
            C.date_up,
            C.date_update,
            C.fk_dimension,
            C.fk_company,
			CA.rangee,
			CA.id_age,
			CC.name,
			CC.id_city,
			CS.id_segment,
			CS.description as segment_description,
            status

	FROM	Campaign C

	LEFT JOIN Ct_Age CA
	ON CA.id_age = C.fk_age

	LEFT JOIN Ct_City CC
	ON CC.id_city = C.fk_city
	
	LEFT JOIN Ct_Segment CS
	ON CS.id_segment = C.fk_segment

	WHERE	fk_company = idcompany_p

	ORDER BY C.date_up DESC;


END$$

CREATE PROCEDURE `uspGet_CampaignTexts` (IN `campaign_c` INT(9))  NO SQL
BEGIN

	SELECT id_cgtext, date_up, date_update, fk_campaign, status, text 
FROM Campaign_Texts 
WHERE status = 1 AND fk_campaign = campaign_c;


END$$

CREATE PROCEDURE `uspGet_Cities` ()  NO SQL
BEGIN

SELECT id_city,name

FROM Ct_City;

END$$

CREATE PROCEDURE `uspGet_Company` ()  NO SQL
BEGIN 

	SELECT 	id_company,
			name,
			address,
			date_up,				
			date_update,
			status,
			logo

	From 	Company;

END$$

CREATE PROCEDURE `uspGet_CompanyAdministrator` (IN `idcompany_p` INT(9))  NO SQL
BEGIN


Select U.name from User U
Inner Join Company C
On U.fk_company = C.id_company

where C.id_company = idcompany_p and type = 2
limit 1;



END$$

CREATE PROCEDURE `uspGet_Company_Fonts` (IN `idcompany_p` INT(9))  NO SQL
BEGIN


	SELECT id_font, fk_company, font, date_up, date_update, status

	FROM Company_Fonts

	where fk_company = idcompany_p;

END$$

CREATE PROCEDURE `uspGet_Company_Pack` (IN `company_p` INT(9))  NO SQL
BEGIN

	SELECT	id_pack,
			fk_company,
			image,
			date_up,
			date_update,
			status
	
	FROM 	Company_Pack
	
	WHERE 	fk_company = company_p;

END$$

CREATE PROCEDURE `uspGet_Company_Subscription` (IN `company_p` INT(9))  NO SQL
BEGIN

	SELECT	id_pack,
			fk_company,
			fk_subscription,
			date_up,
			date_update,
			status

	FROM Company
	
	WHERE fk_company = company_p;
END$$

CREATE PROCEDURE `uspGet_Company_TextConfig` (IN `company_p` INT(9))  NO SQL
BEGIN

	SELECT 	id_config.
			fk_company,
			text_config,
			date_up,
			date_update,
			status

	FROM	Company
	
	Where fk_company = company_p;

END$$

CREATE PROCEDURE `uspGet_Control_Historic` (IN `company_p` INT(9))  NO SQL
BEGIN

	SELECT	id_historic,
		fk_user,
		date_up,
		description,
		status
	FROM Company
	WHERE id_company = company_p;

END$$

CREATE PROCEDURE `uspGet_CountSubscriptions` ()  NO SQL
BEGIN

SELECT	 fk_subscription 
FROM	 Company_Subscription;

END$$

CREATE PROCEDURE `uspGet_Ct_Dimensions` (IN `campaign` INT(9))  NO SQL
BEGIN

	SELECT	id_dimension,
			description,
			height,
			width,
			status
	
	FROM	Campaign
	
	WHERE id_campaign = campaign_p;

END$$

CREATE PROCEDURE `uspGet_Ct_Subscription` ()  NO SQL
BEGIN

	SELECT 	id_subs,
			description

	FROM	Company;

END$$

CREATE PROCEDURE `uspGet_Design` (IN `campaign_p` INT(9))  NO SQL
BEGIN

	SELECT id_design,
			fk_user,
			fk_campaign,
			date_up,
			date_update,
			status
	
	FROM 	Campaign
	
	WHERE fk_campaign = campaign_p;


END$$

CREATE PROCEDURE `uspGet_Det_Subscription` (IN `campaign_p` INT(9))  NO SQL
BEGIN

	SELECT	id_detsubs,
			fk_subs,
			price,
			individual_user_cost,
			image,
			first_plus,
			sec_plus,
			third_plus,
			frth_plus,
			fifth_plus,
			sixth_plus,
			sevn_plus
	
	FROM Campaign

	WHERE id_campaign = campaign_p;

END$$

CREATE PROCEDURE `uspGet_Fonts` ()  NO SQL
BEGIN

	SELECT DISTINCT font FROM Campaign_Fonts
	UNION
	SELECT DISTINCT font FROM Company_Fonts;

END$$

CREATE PROCEDURE `uspGet_FreeUsers` ()  NO SQL
BEGIN

	select count(id_user) AS FreeUsers from User where fk_company = 4;

END$$

CREATE PROCEDURE `uspGet_General_Messages` (IN `company_p` INT(9))  NO SQL
BEGIN

	SELECT  id_gmessage,
			user_up,
			date_up,
			user_send,
			user_receive,
			focus_group,
			message,
			status

	FROM Company
	WHERE id_company = company_p;

END$$

CREATE PROCEDURE `uspGet_HistoryCampaign` (IN `idcompany_p` INT)  NO SQL
BEGIN

	SELECT 

    AH.id_history   ,	
    U.name	 		,
    AH.message 		,
    AH.fk_campaign  ,	
    AH.date_up  	,
	C.name AS campaign_name,
	id_campaign

	FROM Admin_History AH
    
    INNER JOIN User U
    ON U.id_user = AH.fk_user
	
	INNER JOIN Campaign C
	ON C.id_campaign = AH.fk_campaign
    
    WHERE U.fk_company = idcompany_p AND fk_campaign > 0

	ORDER BY AH.date_up DESC;


END$$

CREATE PROCEDURE `uspGet_HistoryCompany` (IN `idcompany_p` INT(9))  NO SQL
BEGIN

	SELECT 

    AH.id_history   ,	
    U.name	 		,
    AH.message 		,
    AH.fk_campaign  ,	
    AH.date_up  	

	FROM Admin_History AH
    
    INNER JOIN User U
    ON U.id_user = AH.fk_user
    
    WHERE U.fk_company = idcompany_p AND fk_campaign = 0

	ORDER BY AH.date_up DESC;


END$$

CREATE PROCEDURE `uspGet_HistoryGeneral` (IN `idcompany_p` INT(9))  NO SQL
BEGIN

	SELECT 

    AH.id_history   ,	
    U.name	 		,
    AH.message 		,
    AH.fk_campaign  ,	
    AH.date_up  	

	FROM Admin_History AH
    
    INNER JOIN User U
    ON U.id_user = AH.fk_user
    
    WHERE U.fk_company = idcompany_p AND fk_campaign = 0

	ORDER BY AH.date_up DESC;


END$$

CREATE PROCEDURE `uspGet_IdentityImages` (IN `campaignid_c` INT(9))  NO SQL
BEGIN

SELECT CP.image

FROM Company_Pack CP

INNER JOIN Campaign C 
ON C.fk_company = CP.fk_company


where C.id_campaign = campaignid_c;


END$$

CREATE PROCEDURE `uspGet_ImageBank` ()  NO SQL
BEGIN

SELECT id_bank, image FROM Image_Bank;

END$$

CREATE PROCEDURE `uspGet_Inbox` ()  NO SQL
BEGIN


SELECT name, date_up, message, status, company_name, email, phone
			FROM Admin_Inbox;

END$$

CREATE PROCEDURE `uspGet_LoggedUser` (IN `email_p` TEXT, IN `password_p` TEXT)  NO SQL
BEGIN

	SELECT 
			U.date_up,
			U.date_update,
			U.fk_company,
			U.home_phone,
			U.id_user,
			U.image,
			U.mobile_phone,
			U.name,
			U.password,
			U.status,
			CASE 
			WHEN U.type = 1 THEN 'Administrador Wizad'
			WHEN U.type = 2 THEN 'Administrador Empresa'
			WHEN U.type = 3 THEN 'Diseñador'
			WHEN U.type = 4 THEN 'Diseñador'
			END AS type,
			U.type as typenum,
			C.address,
			C.logo,
			C.name as company_name,
			C.status as company_status,
			C.date_update as company_update,
			C.pc,
			C.city,
			C.web_page,
			C.industry,
			C.no_employees,
			S.description as subs_description,
			C.id_company,
			U.free_campaign,
			CASE 
				WHEN fk_contract = 1
				THEN DATEDIFF(DATE_ADD(CS.date_up, INTERVAL 6 MONTH),NOW())
				ELSE DATEDIFF(DATE_ADD(CS.date_up, INTERVAL 12 MONTH),NOW())
			END AS days_left,
			U.namenoemail AS UserName
			

	FROM
			User U

	INNER
	JOIN	Company C
	ON		U.fk_company = C.id_company
	INNER
	JOIN	Company_Subscription CS
	ON		CS.fk_company = C.id_company
	INNER
	JOIN	Ct_Subscription S
	ON		CS.fk_subscription = S.id_subs

	WHERE
			U.name = email_p
	AND		U.password = password_p 
	AND		U.status = 1
	AND		C.status = 1;


END$$

CREATE PROCEDURE `uspGet_Materials` ()  NO SQL
BEGIN

SELECT M.id_material, M.description, 
M.width, M.height, M.status, M.thumbnail , M.multiplier, M.width_small, M.height_small, M.width_multiplier, M.height_multiplier

FROM Ct_Material M ;


END$$

CREATE PROCEDURE `uspGet_NewCompanyID` ()  NO SQL
BEGIN

SELECT MAX(id_company) AS id_company From Company;

END$$

CREATE PROCEDURE `uspGet_PaletteCompany` (IN `idcompany_p` INT(9))  NO SQL
BEGIN

	SELECT  id_palette,
			color,
			status

	FROM	Company_Palette

	WHERE	fk_company = idcompany_p;

	

		
END$$

CREATE PROCEDURE `uspGet_Segments` ()  NO SQL
BEGIN

SELECT id_segment, description
FROM Ct_Segment;

END$$

CREATE PROCEDURE `uspGet_SelectedCompany` (IN `company_p` INT(9))  NO SQL
BEGIN
	
	SELECT 	id_company,
			name,
			address,
			date_up,
			date_update,
			status,
			logo

	FROM 	Company
	
	WHERE 	company_p = id_company;
END$$

CREATE PROCEDURE `uspGet_SelectedCt_Subscription` (IN `subs_p` INT(9))  NO SQL
BEGIN

	SELECT  id_subs,
			description
	From Company
	
	WHERE id_subs = sub_p;
END$$

CREATE PROCEDURE `uspGet_TextCompany` (IN `idcompany_p` INT(9))  NO SQL
BEGIN

	SELECT  id_config,
			text_config as text,
			status

	FROM	Company_TextConfig

	WHERE	fk_company = idcompany_p;

	

		
END$$

CREATE PROCEDURE `uspGet_UserCounts` ()  NO SQL
BEGIN

	SELECT COUNT(id_user) AS Users 	  FROM User WHERE status = 1;

END$$

CREATE PROCEDURE `uspGet_UserExist` (IN `name_p` TEXT)  NO SQL
BEGIN

	SELECT name , 1 FROM User
	WHERE name = name_p;

END$$

CREATE PROCEDURE `uspGet_UsersCompany` (IN `idcompany_p` INT(9))  NO SQL
BEGIN

	SELECT  id_user,
			date_up,
			name,
			status,
			CASE when status = 1 then 'Activo'
				 when status = 2 then 'Inactivo'
			END AS statusdesc,
			free_campaign,
			mobile_phone,
			type

	FROM	User

	WHERE	fk_company = idcompany_p;

	

		
END$$

CREATE PROCEDURE `uspGet_VisitCount` ()  NO SQL
BEGIN

	SELECT COUNT(id_visit) AS Visits	  FROM Admin_Visits;

END$$

CREATE PROCEDURE `uspIns_AddHistory` (IN `user_p` INT(9), IN `message_p` TEXT, IN `campaign_p` INT(9))  NO SQL
BEGIN


	INSERT INTO Admin_History (fk_user, message, fk_campaign, date_up)
	SELECT user_p,message_p,campaign_p,Now();


	SELECT "SUCCESS" AS returnMessage;


END$$

CREATE PROCEDURE `uspIns_CampaignFonts` (IN `campaign_c` INT(9), IN `font_c` TEXT)  NO SQL
BEGIN

INSERT INTO Campaign_Fonts ( date_up, date_update, fk_campaign, status, font )
SELECT NOW(), NOW(), campaign_c, 1, font_c;


SELECT 'SUCCESS' AS returnMessage;
END$$

CREATE PROCEDURE `uspIns_CampaignMaterial` (IN `campaign_c` INT(9), IN `material_c` INT(9))  NO SQL
BEGIN


	INSERT INTO Campaign_Material (date_up, date_update, 
                                   fk_campaign, status, fk_material, download) 
SELECT NOW(), NOW(), campaign_c, 1, material_c,0;


	SELECT 'SUCCESS' AS returnMessage;
END$$

CREATE PROCEDURE `uspIns_CampaignPack` (IN `campaign_c` INT(9), IN `image_c` TEXT)  NO SQL
BEGIN

INSERT INTO Campaign_Pack (date_up, date_update, fk_campaign, status, image ) 

SELECT NOW(), NOW(), campaign_c, 1, image_c;


SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_CampaignPalette` (IN `campaign_c` INT(9), IN `color_c` TEXT)  NO SQL
BEGIN

	INSERT INTO Campaign_Palette ( date_up, date_update, fk_campaign, 
                                  status, color ) 
SELECT NOW(), NOW(), campaign_c, 1, color_c;


SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_CampaignTexts` (IN `campaign_c` INT(9), IN `text_c` TEXT)  NO SQL
BEGIN

INSERT INTO Campaign_Texts ( date_up, date_update, fk_campaign, status, text ) 
SELECT NOW(), NOW(), campaign_c, 1, text_c;

SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_CompanySubscription` (IN `company_p` INT(9), IN `subscription_p` INT(9), IN `freq_p` INT(9))  NO SQL
BEGIN

	INSERT INTO Company_Subscription
	(fk_company, fk_subscription, date_up, date_update, status, fk_contract)

	SELECT company_p, subscription_p, NOW(), NOW(), 1, freq_p;

	SELECT "SUCCESS" AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_Inbox` (IN `name_c` TEXT, IN `message_c` TEXT, IN `company_c` TEXT, IN `email_c` TEXT, IN `phone_c` TEXT)  NO SQL
BEGIN

INSERT INTO Admin_Inbox(name, date_up, message, status, company_name, email, phone) 
			SELECT name_c, Now(), message_c, 1, company_c, email_c, phone_c;
			
			SELECT 'SUCCESS' as returnMessage;

END$$

CREATE PROCEDURE `uspIns_NewAdminUser` (IN `company_p` INT(9), IN `name_p` TEXT, IN `password_p` TEXT, IN `homephone_p` INT(9), IN `mobilephone_p` INT(9), IN `nameusernoemail_p` TEXT)  NO SQL
BEGIN



    INSERT INTO User
	(fk_company, name, password,home_phone, mobile_phone, date_up, date_update, type, status, namenoemail)

	SELECT company_p, name_p, password_p, homephone_p, mobilephone_p, now(), now(), 2, 1, nameusernoemail_p;


	SELECT 'SUCCESS' as returnMessage;



END$$

CREATE PROCEDURE `uspIns_NewCampaign` (IN `name_p` TEXT, IN `description_p` TEXT, IN `userup_p` INT(9), IN `userupdate_p` INT(9), IN `dimension_p` INT(9), IN `company_p` INT(9), IN `segment_c` INT(9), IN `city_c` INT(9), IN `age_c` INT(9))  NO SQL
BEGIN


	INSERT INTO Campaign

			(name,
             description,
             date_up,
             date_update,
             fk_dimension,
             fk_company,
             fk_segment,
             fk_city,
             fk_age,
             status)

	SELECT	name_p,
			description_p,
            Now(),
            Now(),
            1,
            company_p,
			segment_c,
			city_c,
			age_c,
            1;

	SELECT LAST_INSERT_ID() AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_NewComany_Pack` (IN `company_p` INT(9), IN `image_p` TEXT)  NO SQL
BEGIN

	INSERT INTO Company
			(fk_company,
             image,	
             date_up,
             date_update,
             status)

	SELECT	company_p,
			image_p,
			Now(),
			Noe(),
			1;

END$$

CREATE PROCEDURE `uspIns_NewCompany` (IN `name_p` TEXT, IN `address_p` TEXT, IN `logo_p` TEXT, IN `city_p` INT(9), IN `employees_p` INT(9), IN `industry_p` TEXT, IN `webpage_p` TEXT, IN `pc_p` INT(9), IN `storage_p` INT(9))  NO SQL
BEGIN
	
	INSERT INTO Company
			(name,
             address,
             date_up,
             date_update,
             city,
             status,
             logo,
             no_employees,
             industry,
             web_page,
             pc,
             storage)

	SELECT 	name_p,
			address_p,
			Now(),
			Now(),
			city_p,
			1,
			logo_p,
            employees_p,
			industry_p,
			webpage_p,
			pc_p,
			storage_p;

	SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_NewCompany_Font` (IN `companyid_p` INT(9), IN `font_p` TEXT)  NO SQL
BEGIN

INSERT INTO Company_Fonts( fk_company, font, date_up, date_update, status) 
SELECT companyid_p, font_p, now(), now(),1;

SELECT "SUCCESS" AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_NewCompany_Pack` (IN `idcompany_p` INT(9), IN `image_p` TEXT)  NO SQL
BEGIN


INSERT INTO Company_Pack(fk_company, image, status, date_up, date_update) 

SELECT idcompany_p, image_p, 1, now(), now();


SELECT "SUCCESS" as returnMessage;


END$$

CREATE PROCEDURE `uspIns_NewCompany_Palette` (IN `idcompany_p` INT(9), IN `color_p` TEXT)  NO SQL
BEGIN

		INSERT INTO Company_Palette
				(fk_company,
                 color,
                 date_up,
                 date_update,
                 status)
		
		SELECT	idcompany_p,
				color_p,
				Now(),
				Now(),
				1;

		SELECT 'SUCCESS' as returnMessage;

END$$

CREATE PROCEDURE `uspIns_NewCompany_Subscription` (IN `company_p` INT(9), IN `subscription_p` INT(9))  NO SQL
BEGIN

	INSERT INTO Company
			(fk_company,
			fk_subscription,
			date_up,
			date_update,
			status)
	SELECT
			company_p,
			suscription_p,
			Now(),
			Now(),
			1;

END$$

CREATE PROCEDURE `uspIns_NewCompany_TextConfig` (IN `company_p` INT(9), IN `textconfig_p` TEXT)  NO SQL
BEGIN

		INSERT INTO Company_TextConfig
				(fk_company,
                 text_config,
                 date_up,
                 date_update,
                 status)
		
		SELECT	company_p,
				textconfig_p,
				Now(),
				Now(),
				1;

		SELECT 'SUCCESS' as returnMessage;

END$$

CREATE PROCEDURE `uspIns_NewControl_Historic` (IN `user_p` INT(9), IN `description_p` TEXT)  NO SQL
BEGIN

	INSERT INTO Company
			(fk_user,
			date_up,
			description,
			status)
	SELECT	user_p,
			Now(),
			description_p,
			1;
END$$

CREATE PROCEDURE `uspIns_NewCt_Dimensions` (IN `description_p` TEXT, IN `height_p` INT(9), IN `width_p` INT(9))  NO SQL
BEGIN

	INSERT INTO	Campaign
			(description,
            height,
            width,
            status)

	SELECT description_p,
			height_p,
			width_p,
			1;
END$$

CREATE PROCEDURE `uspIns_NewCt_Subscription` (IN `description_p` TEXT)  NO SQL
BEGIN

	INSERT INTO Company
			(description)
	SELECT	description_p;

END$$

CREATE PROCEDURE `uspIns_NewDesign` (IN `campaign_p` INT(9), IN `user_p` INT(9))  NO SQL
BEGIN
	
	INSERT INTO Campaign
			(fk_user,
			fk_campaign,
			date_up,
			date_update,
			status)
	SELECT	user_p,
			campaign_p,
			Now(),
			Now(),
			1;

END$$

CREATE PROCEDURE `uspIns_NewDet_Subscription` (IN `subs_p` INT(9), IN `price_p` INT(9), IN `individualusercost_p` INT(9), IN `image_p` TEXT, IN `firstplus_p` TEXT, IN `secplus_p` TEXT, IN `thirdplus_p` TEXT, IN `frthplus_p` TEXT, IN `fifthplus_p` TEXT, IN `sixthplus_p` TEXT, IN `sevnplus_p` TEXT)  NO SQL
BEGIN

	INSERT INTO Campaign
			(fk_subs,
			price,
			individual_user_cost,
			image,
			first_plus,
			sec_plus,
			third_plus,
			frth_plus,
			fifth_plus,
			sixth_plus,
			sevn_plus)

	SELECT	subs_p,
			price_p,
			individualusercost_p,	
			image_p,
			firstplus_p,
			secplus_p,
			thirdplus_p,
			frthplus_p,
			fifthplus_p,
			sixthplus_p,
			sevnplus_p

	FROM	Campaign
	
	WHERE 	fk_subs = subs_p;

END$$

CREATE PROCEDURE `uspIns_NewGeneral_Messages` (IN `idgmessage_p` INT(9), IN `userup_p` INT(9), IN `usersend_p` INT(9), IN `userreceive_p` INT(9), IN `focusgroup_p` INT(9), IN `message_p` TEXT)  NO SQL
BEGIN

	INSERT INTO Company
			(id_gmessage,
			user_up,
			date_up,
			user_send,
			user_receive,
			focus_group,
			message,
            status)

	SELECT	idgmessage_p,
			userup_p,
			Now(),
			usersend_p,
			focusgroup_p,
			message_p,
			1;
END$$

CREATE PROCEDURE `uspIns_NewMaterial` (IN `description_p` TEXT, IN `width_p` TEXT, IN `height_p` TEXT)  NO SQL
BEGIN


INSERT INTO Ct_Material
(description, 
 width, 
 height, 
 thumbnail, 
 free, 
 status) 

SELECT description_p, width_p, height_p, 'NewMaterial.png', 0, 0;


SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_NewUser` (IN `company_p` INT(9), IN `name_p` TEXT, IN `password_p` TEXT, IN `homephone_p` INT(9), IN `mobilephone_p` INT(9), IN `username_p` TEXT)  NO SQL
BEGIN


    INSERT INTO User
	(fk_company, name, password,home_phone, mobile_phone, date_up, date_update, type, status, namenoemail)

	SELECT company_p, name_p, password_p, homephone_p, mobilephone_p, now(), now(), 3, 1, username_p;


	SELECT 'SUCCESS' as returnMessage;

END$$

CREATE PROCEDURE `uspIns_NewVisit` ()  NO SQL
BEGIN

	INSERT INTO Admin_Visits (date_up, value)

	SELECT NOW(), 1;


	SELECT "SUCCESS" AS returnMessage;

END$$

CREATE PROCEDURE `uspIns_SaveImageOnBank` (IN `image` TEXT)  NO SQL
BEGIN

INSERT INTO Image_Bank (image)
Select image;

SELECT "SUCCESS" as returnMessage;


END$$

CREATE PROCEDURE `uspUpd_Campaign` (IN `name_p` TEXT, IN `description_p` TEXT, IN `userupdate_p` INT(9), IN `dimension_p` INT(9), IN `campaign_p` INT(9))  NO SQL
BEGIN

	UPDATE Campaign

		SET name = name_p,
			description = description_p,
			user_update = userupdate_p,
			dimension = dimension_p,
			date_update = Now()

	WHERE id_campaign = campaign_p;


END$$

CREATE PROCEDURE `uspUpd_Company` (IN `name_p` TEXT, IN `address_p` TEXT, IN `company_p` INT(9), IN `industry_p` TEXT, IN `noemployees_p` INT(9), IN `pc_p` INT(9), IN `webpage_p` TEXT)  NO SQL
BEGIN
	
	UPDATE Company
		
		SET name=name_p,
			address=address_p,
			date_update=now(),
			industry = industry_p,
			no_employees = noemployees_p,
			pc = pc_p,
			web_page = webpage_p
			
	WHERE	id_company=company_p;

	SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspUpd_CompanyStatus` (IN `status_p` INT(9), IN `idcompany_p` INT(9))  NO SQL
BEGIN

	UPDATE Company
	SET status = status_p
	WHERE id_company = idcompany_p;

	SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspUpd_Company_Pack` (IN `company_p` INT(9), IN `image_p` TEXT)  NO SQL
BEGIN

	UPDATE Company
		
		SET image = image_p,
			date_update = Now()

	WHERE id_company = company_p;

END$$

CREATE PROCEDURE `uspUpd_Company_Subscription` (IN `company_p` INT(9))  NO SQL
BEGIN

	UPDATE Company
		
		SET date_update = Now()
	
	WHERE id_company = company_p;

END$$

CREATE PROCEDURE `uspUpd_Company_TextConfig` (IN `company_p` INT(9), IN `textconfig_p` TEXT)  NO SQL
BEGIN

	UPDATE Company
		SET text_config = textconfig_p,
			date_update = Now()
	
	WHERE 	id_company = company_p;

END$$

CREATE PROCEDURE `uspUpd_Control_Historic` (IN `user_p` INT(9), IN `description_p` TEXT, IN `company_p` INT(9))  NO SQL
BEGIN 

	UPDATE Company
		SET fk_user = user_p,
			description = description_p
	WHERE id_company = company_p;

END$$

CREATE PROCEDURE `uspUpd_Ct_Dimensions` (IN `description_p` TEXT, IN `height_p` INT(9), IN `width_p` INT(9), IN `campaign` INT(9))  NO SQL
BEGIN

	UPDATE Campaign
	
		SET description = description_p,
			height = height_p,
			width = width_p
	WHERE id_campaign = campaign;
	
END$$

CREATE PROCEDURE `uspUpd_Ct_Subscription` (IN `description_p` TEXT, IN `subs_p` INT(9))  NO SQL
BEGIN

	UPDATE Company
		SET description = description_p
	WHERE id_subs = subs_p;
END$$

CREATE PROCEDURE `uspUpd_Design` (IN `campaign_p` INT(9))  NO SQL
BEGIN

	UPDATE Campaign
		SET date_update = Now()
	WHERE id_campaign = campaign_p;

END$$

CREATE PROCEDURE `uspUpd_Det_Subscription` (IN `subs_p` INT(9), IN `price_p` INT(9), IN `individualusercost_p` INT(9), IN `image_p` TEXT, IN `firstplus_p` TEXT, IN `secplus_p` TEXT, IN `thirdplus_p` TEXT, IN `frthplus_p` TEXT, IN `fifthplus_p` TEXT, IN `sixthplus_p` TEXT, IN `sevnplus_p` TEXT)  NO SQL
BEGIN

	UPDATE Campaign

		SET price = price_p,
			individual_user_cost = individualusercost_p,
			image = image_p,
			first_plus = firstplus_p,
			sec_plus = secplus_p,
			third_plus = thirdplus_p,
			frth_plus = frthplus_p,
			fifth_plus = fifthplus_p,
			sixth_plus = sixthplus_p,
			sevn_plus = sevnplus_p

	WHERE id_campaign = campaign_p;
	

END$$

CREATE PROCEDURE `uspUpd_FreeMaterial` (IN `idmaterial_p` INT(9), IN `free_p` INT(9))  NO SQL
BEGIN
    
    UPDATE Ct_Material
    
    SET free = free_p
    
    WHERE id_material = idmaterial_p;

	SELECT 'SUCCESS' AS returnMessage;


END$$

CREATE PROCEDURE `uspUpd_General_Messages` (IN `company_p` INT(9), IN `idgmessage_p` INT(9), IN `userup_p` INT(9), IN `usersend` INT(9), IN `userreceive_p` INT(9), IN `focusgroup_p` INT(9), IN `message_p` TEXT)  NO SQL
BEGIN

	UPDATE Company 
		SET id_gmessage = idgmessage_p,
			user_up = userup_p,
			user_send = usersend,
			user_receive = userreceive_p,
			focus_group = focusgroup_p,
			message = message_p

	WHERE id_company = company_p;

END$$

CREATE PROCEDURE `uspUpd_Inbox` (IN `idinbox_c` INT(9))  NO SQL
BEGIN

	UPDATE Admin_Inbox
			SET status = 2
			WHERE id_inbox = idinbox_c;

END$$

CREATE PROCEDURE `uspUpd_MaterialStatus` (IN `idmaterial_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN

    UPDATE Ct_Material
    
    SET status = status_p
    
    WHERE id_material = idmaterial_p;

	SELECT 'SUCCESS' AS returnMessage;

END$$

CREATE PROCEDURE `uspUpd_StatusCampaign` (IN `campaign_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN

	IF (status_p = 1)
	THEN
        UPDATE Campaign
            SET status = 1
        WHERE id_campaign = campaign_p;
	ELSE
		UPDATE Campaign
            SET status = 2
        WHERE id_campaign = campaign_p;
	END IF;


END$$

CREATE PROCEDURE `uspUpd_StatusCompany` (IN `company_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN

	IF (status_p = 1)
	THEN
		UPDATE Company
			SET status = 1
		WHERE id_company = company_p;
	ELSE
		UPDATE COmpany
			SET status = 2
		WHERE id_company = company_p;
	END IF;

END$$

CREATE PROCEDURE `uspUpd_StatusCompany_Pack` (IN `company_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN

	IF (status_p = 1)
	THEN
		UPDATE Company
			SET status = 1
		WHERE id_company = company_p;
	ELSE
		UPDATE Company
			SET status = 2
		WHERE id_company = company_p;
	END IF;

END$$

CREATE PROCEDURE `uspUpd_StatusCompany_Subscription` (IN `company_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN

	IF (ststaus_p = 1)
	THEN
		UPDATE Company
			SET status = 1
		WHERE id_company = company_p;
	ELSE
		UPDATE Company
			SET status = 2
		WHERE id_company = company_p;
	END IF;
END$$

CREATE PROCEDURE `uspUpd_StatusCompany_TextConfig` (IN `company_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN

	IF (status_p = 1)
	THEN
		UPDATE Company
			SET status = 1
		WHERE id_company = company_p;
	ELSE
		UPDATE Company
			SET status = 2
		WHERE id_company = company_p;
	END IF;

END$$

CREATE PROCEDURE `uspUpd_StatusControl_Historic` (IN `company_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN
	IF (status_p = 1)
	THEN
		UPDATE Company
			SET status = 1
		WHERE id_company = company_p;
	ELSE
		UPDATE Company
			SET status = 2
		WHERE id_company = company_p;
	END IF;


END$$

CREATE PROCEDURE `uspUpd_StatusCt_Dimensions` (IN `campaign_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN

	IF (status_p = 1)
	THEN
		UPDATE Campaign
			SET status = 1
		WHERE id_campaign = campaign_p;
	ELSE
		UPDATE Campaign
			SET status = 2
		WHERE id_campaign = campaign_p;
	END IF;
END$$

CREATE PROCEDURE `uspUpd_StatusDesign` (IN `campaign_p` INT(9))  NO SQL
BEGIN

	IF (status_p = 1)
	THEN
		UPDATE Campaign
			SET status = 1
		WHERE id_campaign = campaign_p;
	ELSE
		UPDATE Campaign
			SET status = 1
		WHERE id_campaign = campaign_p;
	END IF;
END$$

CREATE PROCEDURE `uspUpd_StatusGeneral_Messages` (IN `company_p` INT(9), IN `status_p` INT(9))  NO SQL
BEGIN

	IF (status_p = 1)
	THEN
		UPDATE Company
			SET status = 1
		WHERE id_company = company_p;
	ELSE
		UPDATE Company
			SET status = 1
		WHERE id_company = company_p;
	END IF;
END$$

CREATE PROCEDURE `uspUpd_User` (IN `name_p` TEXT, IN `password_p` TEXT, IN `mobilephone_p` INT(13), IN `homephone_p` INT(13), IN `iduser_p` INT(9))  NO SQL
BEGIN

	UPDATE  User
	
	SET
			name = name_p,
			password = password_p,
			date_update = now(),
			home_phone = homephone_p,
			mobile_phone = mobilephone_p

	WHERE	id_user =  iduser_p;
		
	SELECT 'SUCCESS' AS returnMessage;
END$$

CREATE PROCEDURE `uspUpd_UserFreeCampaign` (IN `freecamp_p` INT(9), IN `userid_p` INT(9))  NO SQL
BEGIN

UPDATE User SET free_campaign = freecamp_p
WHERE id_user = userid_p;

SELECT 'SUCCESS' AS returnMessage;


END$$

CREATE PROCEDURE `uspUpd_UserLogo` (IN `iduser_p` INT(9), IN `logo_p` TEXT)  NO SQL
BEGIN

	UPDATE Company
    SET logo = logo_p
    WHERE id_company = (SELECT fk_company from 
                        User WHERE id_user = iduser_p);
                        
    SELECT "SUCCESS" AS returnMessage;

END$$

CREATE PROCEDURE `uspUpd_UserPassword` (IN `password_p` TEXT, IN `email_p` TEXT)  NO SQL
BEGIN

	UPDATE  User
	
	SET
			password = password_p

	WHERE	name =  email_p;
		
	SELECT 'SUCCESS' AS returnMessage;
END$$

CREATE PROCEDURE `uspUpd_UserPhoto` (IN `iduser_p` INT(9), IN `photo` TEXT)  NO SQL
BEGIN

	UPDATE  User
	
	SET
			image = photo

	WHERE	id_user =  iduser_p;
		
	SELECT 'SUCCESS' AS returnMessage;
END$$

CREATE PROCEDURE `uspUpd_UserStatus` (IN `status_p` INT(9), IN `iduser_p` INT(9))  NO SQL
BEGIN

		UPDATE 	User
		SET		status = status_p
		WHERE 	id_user = iduser_p;


		SELECT 'SUCCESS' AS returnMessage;


END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Admin_History`
--

CREATE TABLE `Admin_History` (
  `id_history` int(9) NOT NULL,
  `fk_user` int(9) NOT NULL,
  `message` text NOT NULL,
  `fk_campaign` int(9) NOT NULL,
  `date_up` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Admin_History`
--

INSERT INTO `Admin_History` (`id_history`, `fk_user`, `message`, `fk_campaign`, `date_up`) VALUES
(2438, 1, 'Inició sesión', 0, '2017-11-08 21:05:17'),
(2437, 1, 'Inició sesión', 0, '2017-11-08 18:15:06'),
(2436, 1, 'Inició sesión', 0, '2017-11-08 18:03:56'),
(2435, 1, 'Inició sesión', 0, '2017-11-08 17:42:13'),
(2434, 1, 'Inició sesión', 0, '2017-11-08 17:39:44'),
(2433, 1, 'Inició sesión', 0, '2017-11-08 17:22:58'),
(2432, 96, 'Inició sesión', 0, '2017-11-08 17:21:01'),
(2431, 1, 'Inició sesión', 0, '2017-11-08 17:20:49'),
(2430, 1, 'Inició sesión', 0, '2017-11-08 17:19:23'),
(2429, 1, 'Inició sesión', 0, '2017-11-08 17:18:04'),
(2428, 1, 'Inició sesión', 0, '2017-11-08 17:15:07'),
(2427, 1, 'Inició sesión', 0, '2017-11-08 17:11:15'),
(2426, 1, 'Inició sesión', 0, '2017-11-08 17:08:28'),
(2425, 1, 'Inició sesión', 0, '2017-11-08 17:03:09'),
(2424, 1, 'Inició sesión', 0, '2017-11-08 16:50:28'),
(2423, 1, 'Inició sesión', 0, '2017-11-08 15:48:40'),
(2422, 1, 'Inició sesión', 0, '2017-11-08 14:52:00'),
(2421, 96, 'Inició sesión', 0, '2017-11-08 14:00:11'),
(2420, 1, 'Inició sesión', 0, '2017-11-08 13:42:45'),
(2419, 1, 'Inició sesión', 0, '2017-11-08 13:32:39'),
(2418, 1, 'Inició sesión', 0, '2017-11-08 13:23:34'),
(2417, 1, 'Inició sesión', 0, '2017-11-08 13:19:49'),
(2416, 1, 'Inició sesión', 0, '2017-11-08 13:12:39'),
(2415, 1, 'Inició sesión', 0, '2017-11-08 13:11:27'),
(2414, 1, 'Inició sesión', 0, '2017-11-08 13:03:39'),
(2413, 1, 'Inició sesión', 0, '2017-11-08 13:02:35'),
(2412, 1, 'Inició sesión', 0, '2017-11-07 11:58:16'),
(2411, 2, 'Inició sesión', 0, '2017-11-07 11:56:41'),
(2410, 96, 'Inició sesión', 0, '2017-10-31 14:49:28'),
(2409, 96, 'Inició sesión', 0, '2017-10-26 15:56:41'),
(2408, 96, 'Inició sesión', 0, '2017-10-26 09:33:46'),
(2407, 96, 'Inició sesión', 0, '2017-10-12 19:11:43'),
(2406, 96, 'Inició sesión', 0, '2017-10-12 18:55:20'),
(2405, 96, 'Inició sesión', 0, '2017-10-12 18:22:00'),
(2404, 96, 'Inició sesión', 0, '2017-10-12 17:52:47'),
(2403, 100, 'Inició sesión', 0, '2017-10-06 14:36:45'),
(2402, 96, 'Inició sesión', 0, '2017-10-06 11:58:31'),
(2401, 2, 'Inició sesión', 0, '2017-10-06 11:53:37'),
(2400, 1, 'Inició sesión', 0, '2017-09-27 10:20:01'),
(2399, 96, 'Inició sesión', 0, '2017-09-26 22:23:02'),
(2398, 96, 'Inició sesión', 0, '2017-09-25 09:34:37'),
(2397, 1, 'Inició sesión', 0, '2017-09-21 12:55:06'),
(2396, 96, 'Inició sesión', 0, '2017-09-12 20:02:19'),
(2395, 158, 'Inició sesión', 0, '2017-09-06 18:06:06'),
(2394, 96, 'Inició sesión', 0, '2017-09-05 14:38:03'),
(2393, 1, 'Inició sesión', 0, '2017-08-18 00:46:07'),
(2392, 96, 'Inició sesión', 0, '2017-07-14 12:25:08'),
(2391, 98, 'Inició sesión', 0, '2017-07-14 12:24:54'),
(2390, 2, 'Inició sesión', 0, '2017-07-14 12:20:23'),
(2389, 96, 'Inició sesión', 0, '2017-07-12 17:49:05'),
(2388, 96, 'Inició sesión', 0, '2017-07-12 17:23:01'),
(2387, 98, 'Inicio campaña libre', 0, '2017-07-12 17:22:35'),
(2386, 98, 'Inició sesión', 0, '2017-07-12 17:22:26'),
(2385, 96, 'Inició sesión', 0, '2017-07-12 17:21:48'),
(2384, 2, 'Inició sesión', 0, '2017-07-12 17:21:00'),
(2383, 100, 'Inició sesión', 0, '2017-07-12 16:16:56'),
(2382, 100, 'Inició sesión', 0, '2017-07-10 17:03:39'),
(2381, 96, 'Inició sesión', 0, '2017-07-07 17:06:27'),
(2380, 96, 'Inició sesión', 0, '2017-07-07 16:58:30'),
(2379, 2, 'Inició sesión', 0, '2017-07-07 16:57:13'),
(2378, 100, 'Inició sesión', 0, '2017-06-29 20:07:32'),
(2377, 100, 'Inició sesión', 0, '2017-06-29 20:06:43'),
(2376, 100, 'Inició sesión', 0, '2017-06-29 20:02:34'),
(2375, 100, 'Inició sesión', 0, '2017-06-29 20:02:33'),
(2374, 100, 'Inició sesión', 0, '2017-06-29 20:01:42'),
(2373, 100, 'Inició sesión', 0, '2017-06-29 20:01:16'),
(2372, 100, 'Inició sesión', 0, '2017-06-29 19:51:37'),
(2371, 100, 'Inició sesión', 0, '2017-06-29 19:50:00'),
(2370, 100, 'Inició sesión', 0, '2017-06-29 19:49:10'),
(2369, 96, 'Inició sesión', 0, '2017-06-29 19:47:49'),
(2368, 100, 'Inició sesión', 0, '2017-06-29 19:46:44'),
(2367, 1, 'Inició sesión', 0, '2017-06-29 19:45:46'),
(2366, 1, 'Inició sesión', 0, '2017-06-29 19:43:23'),
(2365, 100, 'Inició sesión', 0, '2017-06-29 19:40:42'),
(2364, 100, 'Inició sesión', 0, '2017-06-29 19:39:35'),
(2363, 100, 'Inició sesión', 0, '2017-06-29 19:37:40'),
(2362, 100, 'Inició sesión', 0, '2017-06-29 19:34:03'),
(2361, 100, 'Inició sesión', 0, '2017-06-29 19:29:50'),
(2360, 100, 'Inició sesión', 0, '2017-06-29 19:28:43'),
(2359, 1, 'Inició sesión', 0, '2017-06-29 19:26:50'),
(2358, 96, 'Inició sesión', 0, '2017-06-29 19:24:58'),
(2357, 1, 'Inició sesión', 0, '2017-06-23 18:19:53'),
(2356, 96, 'Inició sesión', 0, '2017-06-23 17:40:00'),
(2355, 96, 'Inició sesión', 0, '2017-06-23 17:38:04'),
(2354, 96, 'Inició sesión', 0, '2017-06-23 17:37:36'),
(2353, 100, 'Inició sesión', 0, '2017-06-23 17:36:16'),
(2352, 100, 'Inició sesión', 0, '2017-06-23 17:33:24'),
(2351, 96, 'Inició sesión', 0, '2017-06-23 17:12:17'),
(2350, 2, 'Inició sesión', 0, '2017-06-23 17:04:11'),
(2349, 100, 'Inició sesión', 0, '2017-06-23 16:46:38'),
(2348, 2, 'Inició sesión', 0, '2017-06-23 16:32:56'),
(2347, 96, 'Inició sesión', 0, '2017-06-23 16:30:33'),
(2346, 100, 'Inició sesión', 0, '2017-06-22 17:58:40'),
(2345, 96, 'Inició sesión', 0, '2017-06-22 17:57:59'),
(2344, 98, 'Inició sesión', 0, '2017-06-22 17:51:35'),
(2343, 96, 'Inició sesión', 0, '2017-06-22 17:50:27'),
(2342, 2, 'Inició sesión', 0, '2017-06-22 17:44:21'),
(2341, 96, 'Inició sesión', 0, '2017-06-22 17:43:53'),
(2340, 100, 'Inició sesión', 0, '2017-06-22 17:42:52'),
(2339, 96, 'Inició sesión', 0, '2017-06-22 17:41:45'),
(2338, 2, 'Inició sesión', 0, '2017-06-22 17:41:22'),
(2337, 96, 'Inició sesión', 0, '2017-06-21 20:37:41'),
(2336, 100, 'Inició sesión', 0, '2017-06-21 20:34:33'),
(2335, 100, 'Inició sesión', 0, '2017-06-21 20:31:10'),
(2334, 98, 'Inició sesión', 0, '2017-06-21 20:30:24'),
(2333, 100, 'Inició sesión', 0, '2017-06-21 20:26:34'),
(2332, 96, 'Inició sesión', 0, '2017-06-21 20:24:31'),
(2331, 96, 'Inició sesión', 0, '2017-06-21 20:24:26'),
(2330, 96, 'Inició sesión', 0, '2017-06-21 20:23:46'),
(2329, 2, 'Inició sesión', 0, '2017-06-21 20:23:08'),
(2328, 96, 'Inició sesión', 0, '2017-06-21 20:22:44'),
(2327, 96, 'Inició sesión', 0, '2017-06-21 20:21:37'),
(2326, 96, 'Inició sesión', 0, '2017-06-21 20:19:32'),
(2325, 100, 'Inició sesión', 0, '2017-06-21 20:18:11'),
(2324, 100, 'Inició sesión', 0, '2017-06-21 20:16:18'),
(2323, 100, 'Inició sesión', 0, '2017-06-21 20:15:48'),
(2322, 26, 'Inició sesión', 0, '2017-06-21 20:15:30'),
(2321, 26, 'Inició sesión', 0, '2017-06-21 20:15:00'),
(2320, 100, 'Inició sesión', 0, '2017-06-21 20:15:00'),
(2319, 26, 'Inició sesión', 0, '2017-06-21 20:14:27'),
(2318, 26, 'Inició sesión', 0, '2017-06-21 20:13:16'),
(2317, 100, 'Inició sesión', 0, '2017-06-21 20:12:31'),
(2316, 1, 'Inició sesión', 0, '2017-06-21 20:12:19'),
(2315, 100, 'Inició sesión', 0, '2017-06-21 20:11:58'),
(2314, 1, 'Inició sesión', 0, '2017-06-21 19:44:26'),
(2313, 1, 'Inició sesión', 0, '2017-06-21 16:08:54'),
(2312, 1, 'Inició sesión', 0, '2017-06-21 16:02:45'),
(2311, 98, 'Inicio campaña libre', 0, '2017-06-19 10:25:06'),
(2310, 98, 'Inició sesión', 0, '2017-06-19 10:24:58'),
(2309, 98, 'Inició sesión', 0, '2017-06-12 19:59:41'),
(2308, 100, 'Inició sesión', 0, '2017-06-12 19:48:46'),
(2307, 96, 'Inició sesión', 0, '2017-06-12 19:47:58'),
(2306, 96, 'Inició sesión', 0, '2017-06-10 12:43:21'),
(2305, 98, 'Inicio campaña libre', 0, '2017-06-10 12:42:29'),
(2304, 98, 'Inició sesión', 0, '2017-06-10 12:42:20'),
(2303, 96, 'Inició sesión', 0, '2017-06-10 12:41:47'),
(2302, 100, 'Inició sesión', 0, '2017-06-10 12:40:38'),
(2301, 96, 'Inició sesión', 0, '2017-06-10 12:39:01'),
(2300, 100, 'Inició sesión', 0, '2017-06-09 16:29:42'),
(2299, 100, 'Inició sesión', 0, '2017-06-09 11:06:13'),
(2298, 96, 'Inició sesión', 0, '2017-06-09 11:04:44'),
(2297, 1, 'Inició sesión', 0, '2017-06-09 10:49:44'),
(2296, 2, 'Inició sesión', 0, '2017-06-09 10:48:16'),
(2295, 1, 'Inició sesión', 0, '2017-06-09 10:47:58'),
(2294, 96, 'Inició sesión', 0, '2017-06-08 21:31:25'),
(2293, 96, 'Inició sesión', 0, '2017-06-08 21:24:59'),
(2292, 100, 'Inició sesión', 0, '2017-06-08 20:59:37'),
(2291, 100, 'Inició sesión', 0, '2017-06-07 16:29:07'),
(2290, 100, 'Inició sesión', 0, '2017-06-07 16:18:34'),
(2289, 1, 'Inició sesión', 0, '2017-06-05 19:24:39'),
(2288, 1, 'Inició sesión', 0, '2017-06-04 20:12:31'),
(2287, 150, 'Inició sesión', 0, '2017-06-01 19:42:07'),
(2286, 147, 'Inició sesión', 0, '2017-06-01 19:41:41'),
(2285, 1, 'Inició sesión', 0, '2017-06-01 19:33:37'),
(2284, 1, 'Inició sesión', 0, '2017-06-01 19:27:12'),
(2283, 1, 'Inició sesión', 0, '2017-06-01 19:14:21'),
(2282, 1, 'Inició sesión', 0, '2017-06-01 19:13:17'),
(2281, 1, 'Inició sesión', 0, '2017-06-01 18:48:09'),
(2280, 1, 'Inició sesión', 0, '2017-06-01 18:35:45'),
(2279, 1, 'Inició sesión', 0, '2017-06-01 18:34:57'),
(2278, 1, 'Inició sesión', 0, '2017-06-01 18:24:38'),
(2277, 1, 'Inició sesión', 0, '2017-06-01 18:24:06'),
(2276, 1, 'Inició sesión', 0, '2017-06-01 18:18:43'),
(2275, 1, 'Inició sesión', 0, '2017-06-01 01:43:11'),
(2274, 1, 'Inició sesión', 0, '2017-06-01 01:41:55'),
(2273, 1, 'Inició sesión', 0, '2017-06-01 01:40:03'),
(2272, 1, 'Inició sesión', 0, '2017-06-01 01:28:39'),
(2271, 1, 'Inició sesión', 0, '2017-06-01 01:23:13'),
(2270, 1, 'Inició sesión', 0, '2017-06-01 00:12:46'),
(2269, 1, 'Inició sesión', 0, '2017-06-01 00:09:43'),
(2268, 1, 'Inició sesión', 0, '2017-05-31 22:26:14'),
(2267, 100, 'Inició sesión', 0, '2017-05-26 11:01:48'),
(2266, 100, 'Inició sesión', 0, '2017-05-26 11:01:10'),
(2265, 100, 'Inició sesión', 0, '2017-05-26 10:57:36'),
(2264, 100, 'Inició sesión', 0, '2017-05-26 10:55:21'),
(2263, 100, 'Inició sesión', 0, '2017-05-26 10:17:00'),
(2262, 2, 'Inició sesión', 0, '2017-05-26 10:15:23'),
(2261, 98, 'Inició sesión', 0, '2017-05-26 10:11:32'),
(2260, 96, 'Inició sesión', 0, '2017-05-26 10:05:46'),
(2259, 100, 'Inició sesión', 0, '2017-05-26 10:03:27'),
(2258, 100, 'Inició sesión', 0, '2017-05-26 10:02:19'),
(2257, 96, 'Inició sesión', 0, '2017-05-24 16:32:06'),
(2256, 96, 'Inició sesión', 0, '2017-05-22 16:02:33'),
(2255, 96, 'Inició sesión', 0, '2017-05-22 16:01:57'),
(2254, 1, 'Inició sesión', 0, '2017-05-21 14:37:24'),
(2253, 1, 'Inició sesión', 0, '2017-05-21 14:35:42'),
(2252, 1, 'Inició sesión', 0, '2017-05-21 14:16:50'),
(2251, 1, 'Inició sesión', 0, '2017-05-21 14:15:50'),
(2250, 1, 'Inició sesión', 0, '2017-05-21 14:10:29'),
(2249, 100, 'Inició sesión', 0, '2017-05-13 23:14:31'),
(2248, 96, 'Inició sesión', 0, '2017-05-13 23:14:13'),
(2247, 96, 'Inició sesión', 0, '2017-05-13 23:08:19'),
(2246, 100, 'Inició sesión', 0, '2017-05-13 23:04:52'),
(2245, 2, 'Inició sesión', 0, '2017-05-13 22:32:28'),
(2244, 96, 'Inició sesión', 0, '2017-05-12 21:29:23'),
(2243, 100, 'Inició sesión', 0, '2017-05-12 21:26:45'),
(2242, 1, 'Inició sesión', 0, '2017-05-12 01:05:48'),
(2241, 1, 'Inició sesión', 0, '2017-05-12 01:02:30'),
(2240, 1, 'Inició sesión', 0, '2017-05-12 01:01:12'),
(2239, 1, 'Inició sesión', 0, '2017-05-12 00:57:23'),
(2238, 98, 'Inicio campaña libre', 0, '2017-05-12 00:56:48'),
(2237, 98, 'Inició sesión', 0, '2017-05-12 00:56:45'),
(2236, 100, 'Inició sesión', 0, '2017-05-12 00:56:37'),
(2235, 1, 'Inició sesión', 0, '2017-05-12 00:56:22'),
(2234, 1, 'Inició sesión', 0, '2017-05-12 00:55:18'),
(2233, 1, 'Inició sesión', 0, '2017-05-12 00:35:30'),
(2232, 2, 'Inició sesión', 0, '2017-05-12 00:35:24'),
(2231, 100, 'Inició sesión', 0, '2017-05-12 00:35:20'),
(2230, 100, 'Inició sesión', 0, '2017-05-12 00:34:37'),
(2229, 100, 'Inició sesión', 0, '2017-05-12 00:33:26'),
(2228, 100, 'Inició sesión', 0, '2017-05-12 00:28:55'),
(2227, 100, 'Inició sesión', 0, '2017-05-12 00:24:02'),
(2226, 120, 'Inició sesión', 0, '2017-05-11 23:59:53'),
(2225, 96, 'Inició sesión', 0, '2017-05-11 21:07:17'),
(2224, 1, 'Inició sesión', 0, '2017-05-11 21:06:44'),
(2223, 1, 'Inició sesión', 0, '2017-05-04 19:34:17'),
(2222, 1, 'Inicio campaña libre', 0, '2017-05-02 23:44:36'),
(2221, 1, 'Inició sesión', 0, '2017-05-02 23:42:26'),
(2220, 2, 'Inició sesión', 0, '2017-05-02 23:37:54'),
(2219, 2, 'Inició sesión', 0, '2017-04-28 17:52:45'),
(2218, 100, 'Inició sesión', 0, '2017-04-27 12:55:16'),
(2217, 2, 'Inició sesión', 0, '2017-04-27 12:32:38'),
(2216, 100, 'Inició sesión', 0, '2017-04-27 12:29:35'),
(2215, 96, 'Inició sesión', 0, '2017-04-27 12:26:31'),
(2214, 98, 'Inició sesión', 0, '2017-04-27 12:09:19'),
(2213, 96, 'Inició sesión', 0, '2017-04-27 10:28:42'),
(2212, 2, 'Inició sesión', 0, '2017-04-27 10:28:08'),
(2211, 96, 'Inició sesión', 0, '2017-04-27 10:27:21'),
(2210, 96, 'Inició sesión', 0, '2017-04-27 10:23:19'),
(2209, 2, 'Inició sesión', 0, '2017-04-27 10:16:12'),
(2208, 98, 'Inició sesión', 0, '2017-04-26 21:27:17'),
(2207, 100, 'Inició sesión', 0, '2017-04-26 21:26:47'),
(2206, 96, 'Inició sesión', 0, '2017-04-26 21:11:10'),
(2205, 1, 'Inició sesión', 0, '2017-04-26 01:42:57'),
(2204, 1, 'Inició sesión', 0, '2017-04-26 01:41:57'),
(2203, 1, 'Inició sesión', 0, '2017-04-26 01:38:01'),
(2202, 1, 'Inició sesión', 0, '2017-04-26 01:34:25'),
(2201, 1, 'Inició sesión', 0, '2017-04-26 01:03:56'),
(2200, 1, 'Inició sesión', 0, '2017-04-26 01:02:32'),
(2199, 1, 'Inició sesión', 0, '2017-04-26 00:50:31'),
(2198, 1, 'Inició sesión', 0, '2017-04-26 00:21:07'),
(2197, 1, 'Inició sesión', 0, '2017-04-26 00:17:16'),
(2196, 1, 'Inició sesión', 0, '2017-04-25 22:14:25'),
(2195, 96, 'Inició sesión', 0, '2017-04-25 22:05:44'),
(2194, 1, 'Inició sesión', 0, '2017-04-25 22:05:28'),
(2193, 2, 'Inició sesión', 0, '2017-04-25 22:04:33'),
(2192, 1, 'Inició sesión', 0, '2017-04-25 22:03:57'),
(2191, 1, 'Inicio campaña libre', 0, '2017-04-25 21:45:56'),
(2190, 1, 'Inició sesión', 0, '2017-04-25 21:45:52'),
(2189, 96, 'Inicio campaña libre', 0, '2017-04-25 21:39:02'),
(2188, 96, 'Inició sesión', 0, '2017-04-25 21:38:50'),
(2187, 96, 'Inicio campaña libre', 0, '2017-04-25 21:37:17'),
(2186, 96, 'Inició sesión', 0, '2017-04-25 21:37:08'),
(2185, 98, 'Inicio campaña libre', 0, '2017-04-25 21:36:42'),
(2184, 98, 'Inició sesión', 0, '2017-04-25 21:36:31'),
(2183, 100, 'Inició sesión', 0, '2017-04-25 21:30:33'),
(2182, 96, 'Inició sesión', 0, '2017-04-25 21:26:29'),
(2181, 1, 'Inició sesión', 0, '2017-04-25 11:36:58'),
(2180, 1, 'Inició sesión', 0, '2017-04-25 11:35:51'),
(2179, 1, 'Inició sesión', 0, '2017-04-25 11:34:42'),
(2178, 1, 'Inició sesión', 0, '2017-04-25 11:29:00'),
(2177, 1, 'Inició sesión', 0, '2017-04-25 11:28:29'),
(2176, 1, 'Inició sesión', 0, '2017-04-25 11:25:03'),
(2175, 1, 'Inició sesión', 0, '2017-04-25 11:18:48'),
(2174, 1, 'Inició sesión', 0, '2017-04-25 11:15:44'),
(2173, 1, 'Inició sesión', 0, '2017-04-25 11:13:54'),
(2172, 1, 'Inició sesión', 0, '2017-04-25 11:11:14'),
(2171, 1, 'Inició sesión', 0, '2017-04-25 11:10:02'),
(2170, 1, 'Inició sesión', 0, '2017-04-25 11:07:14'),
(2169, 1, 'Inició sesión', 0, '2017-04-25 10:56:13'),
(2168, 1, 'Inicio campaña libre', 0, '2017-04-25 01:36:57'),
(2167, 1, 'Inició sesión', 0, '2017-04-25 01:36:52'),
(2166, 1, 'Inicio campaña libre', 0, '2017-04-25 01:35:08'),
(2165, 1, 'Inició sesión', 0, '2017-04-25 01:35:02'),
(2164, 1, 'Inicio campaña libre', 0, '2017-04-25 01:32:59'),
(2163, 1, 'Inició sesión', 0, '2017-04-25 01:32:55'),
(2162, 1, 'Inicio campaña libre', 0, '2017-04-25 01:30:56'),
(2161, 1, 'Inició sesión', 0, '2017-04-25 01:30:51'),
(2160, 1, 'Inicio campaña libre', 0, '2017-04-25 01:29:37'),
(2159, 1, 'Inició sesión', 0, '2017-04-25 01:29:31'),
(2158, 1, 'Inicio campaña libre', 0, '2017-04-25 01:22:33'),
(2157, 1, 'Inició sesión', 0, '2017-04-25 01:22:28'),
(2156, 1, 'Inicio campaña libre', 0, '2017-04-25 01:21:55'),
(2155, 1, 'Inicio campaña libre', 0, '2017-04-25 01:21:04'),
(2154, 1, 'Inició sesión', 0, '2017-04-25 01:21:00'),
(2153, 1, 'Inició sesión', 0, '2017-04-25 01:15:04'),
(2152, 1, 'Inicio campaña libre', 0, '2017-04-25 01:13:23'),
(2151, 1, 'Inició sesión', 0, '2017-04-25 01:13:07'),
(2150, 1, 'Inicio campaña libre', 0, '2017-04-25 01:08:27'),
(2149, 1, 'Inició sesión', 0, '2017-04-25 01:06:55'),
(2148, 1, 'Inicio campaña libre', 0, '2017-04-25 00:57:23'),
(2147, 1, 'Inicio campaña libre', 0, '2017-04-25 00:43:42'),
(2146, 1, 'Inició sesión', 0, '2017-04-25 00:43:35'),
(2145, 1, 'Inició sesión', 0, '2017-04-25 00:43:06'),
(2144, 2, 'Inició sesión', 0, '2017-04-25 00:17:27'),
(2143, 2, 'Inició sesión', 0, '2017-04-25 00:14:18'),
(2142, 2, 'Inició sesión', 0, '2017-04-25 00:11:01'),
(2141, 2, 'Inició sesión', 0, '2017-04-25 00:04:24'),
(2140, 2, 'Inició sesión', 0, '2017-04-25 00:01:47'),
(2139, 2, 'Inició sesión', 0, '2017-04-24 23:56:47'),
(2138, 2, 'Inició sesión', 0, '2017-04-24 23:56:25'),
(2137, 2, 'Inició sesión', 0, '2017-04-24 23:41:28'),
(2136, 2, 'Inició sesión', 0, '2017-04-24 23:33:51'),
(2135, 2, 'Inició sesión', 0, '2017-04-24 23:33:50'),
(2134, 2, 'Inició sesión', 0, '2017-04-24 23:33:50'),
(2133, 2, 'Inició sesión', 0, '2017-04-24 23:33:22'),
(2132, 2, 'Inició sesión', 0, '2017-04-24 23:32:24'),
(2131, 2, 'Inició sesión', 0, '2017-04-24 23:07:21'),
(2130, 2, 'Inició sesión', 0, '2017-04-24 22:45:45'),
(2129, 2, 'Inició sesión', 0, '2017-04-24 22:40:54'),
(2128, 2, 'Inició sesión', 0, '2017-04-24 22:30:54'),
(2127, 2, 'Inició sesión', 0, '2017-04-24 22:28:59'),
(2126, 2, 'Inició sesión', 0, '2017-04-24 21:35:42'),
(2125, 2, 'Inició sesión', 0, '2017-04-24 21:27:05'),
(2124, 1, 'Inició sesión', 0, '2017-04-24 21:26:58'),
(2123, 98, 'Inició sesión', 0, '2017-04-21 00:14:35'),
(2122, 96, 'Inició sesión', 0, '2017-04-21 00:08:40'),
(2121, 96, 'Inició sesión', 0, '2017-04-21 00:06:51'),
(2120, 100, 'Inició sesión', 0, '2017-04-21 00:02:20'),
(2119, 98, 'Inicio campaña libre', 0, '2017-04-20 23:35:08'),
(2118, 98, 'Inició sesión', 0, '2017-04-20 23:34:34'),
(2117, 96, 'Inicio campaña libre', 0, '2017-04-20 23:33:39'),
(2116, 96, 'Inicio campaña libre', 0, '2017-04-20 23:33:01'),
(2115, 96, 'Inició sesión', 0, '2017-04-20 23:32:43'),
(2114, 96, 'Inició sesión', 0, '2017-04-20 23:20:49'),
(2113, 2, 'Inició sesión', 0, '2017-04-20 23:18:58'),
(2112, 100, 'Inició sesión', 0, '2017-04-20 23:12:25'),
(2111, 100, 'Inició sesión', 0, '2017-04-20 22:58:36'),
(2110, 100, 'Inició sesión', 0, '2017-04-20 22:57:22'),
(2109, 1, 'Inició sesión', 0, '2017-04-19 23:34:27'),
(2108, 1, 'Inició sesión', 0, '2017-04-19 23:26:53'),
(2107, 1, 'Inició sesión', 0, '2017-04-19 23:21:04'),
(2106, 1, 'Inició sesión', 0, '2017-04-19 23:08:12'),
(2105, 1, 'Inició sesión', 0, '2017-04-19 23:06:14'),
(2104, 1, 'Inició sesión', 0, '2017-04-19 23:03:52'),
(2103, 1, 'Inició sesión', 0, '2017-04-19 22:58:02'),
(2102, 1, 'Inició sesión', 0, '2017-04-19 22:22:34'),
(2101, 1, 'Inició sesión', 0, '2017-04-19 22:12:03'),
(2100, 100, 'Inició sesión', 0, '2017-04-07 12:48:07'),
(2099, 96, 'Inició sesión', 0, '2017-04-04 12:58:15'),
(2098, 96, 'Inicio campaña libre', 0, '2017-04-04 10:45:58'),
(2097, 96, 'Inició sesión', 0, '2017-04-04 10:45:47'),
(2096, 100, 'Inició sesión', 0, '2017-04-03 20:46:51'),
(2095, 100, 'Inició sesión', 0, '2017-04-01 17:37:05'),
(2094, 96, 'Inició sesión', 0, '2017-03-31 10:39:34'),
(2093, 100, 'Inició sesión', 0, '2017-03-31 10:36:34'),
(2092, 100, 'Inició sesión', 0, '2017-03-30 18:14:01'),
(2091, 96, 'Inició sesión', 0, '2017-03-30 18:10:06'),
(2090, 100, 'Inició sesión', 0, '2017-03-30 18:07:12'),
(2089, 100, 'Inició sesión', 0, '2017-03-29 20:42:57'),
(2088, 100, 'Inició sesión', 0, '2017-03-29 20:35:21'),
(2087, 1, 'Inicio campaña libre', 0, '2017-03-29 19:45:04'),
(2086, 1, 'Inicio campaña libre', 0, '2017-03-29 19:44:49'),
(2085, 1, 'Inició sesión', 0, '2017-03-29 19:44:34'),
(2084, 100, 'Inició sesión', 0, '2017-03-29 17:29:39'),
(2083, 2, 'Inició sesión', 0, '2017-03-27 15:27:37'),
(2082, 100, 'Inició sesión', 0, '2017-03-27 15:26:01'),
(2081, 100, 'Inició sesión', 0, '2017-03-27 15:17:36'),
(2080, 100, 'Inició sesión', 0, '2017-03-27 12:42:18'),
(2079, 1, 'Inició sesión', 0, '2017-03-21 22:17:12'),
(2078, 1, 'Inicio campaña libre', 0, '2017-03-21 21:22:03'),
(2077, 1, 'Inició sesión', 0, '2017-03-21 21:21:59'),
(2076, 1, 'Inicio campaña libre', 0, '2017-03-21 21:18:56'),
(2075, 1, 'Inició sesión', 0, '2017-03-21 21:18:52'),
(2074, 1, 'Inicio campaña libre', 0, '2017-03-21 21:17:25'),
(2073, 1, 'Inició sesión', 0, '2017-03-21 21:17:20'),
(2072, 1, 'Inicio campaña libre', 0, '2017-03-21 21:16:38'),
(2071, 1, 'Inició sesión', 0, '2017-03-21 21:16:35'),
(2070, 1, 'Inicio campaña libre', 0, '2017-03-21 21:15:20'),
(2069, 1, 'Inició sesión', 0, '2017-03-21 21:15:16'),
(2068, 1, 'Inicio campaña libre', 0, '2017-03-21 21:13:23'),
(2067, 1, 'Inició sesión', 0, '2017-03-21 21:13:19'),
(2066, 1, 'Inicio campaña libre', 0, '2017-03-21 21:10:19'),
(2065, 1, 'Inició sesión', 0, '2017-03-21 21:09:41'),
(2064, 1, 'Inició sesión', 0, '2017-03-21 21:07:50'),
(2063, 1, 'Inició sesión', 0, '2017-03-21 21:07:16'),
(2062, 1, 'Inicio campaña libre', 0, '2017-03-21 20:57:21'),
(2061, 1, 'Inició sesión', 0, '2017-03-21 20:57:16'),
(2060, 1, 'Inicio campaña libre', 0, '2017-03-21 20:55:36'),
(2059, 1, 'Inició sesión', 0, '2017-03-21 20:53:52'),
(2058, 1, 'Inicio campaña libre', 0, '2017-03-21 19:51:23'),
(2057, 1, 'Inició sesión', 0, '2017-03-21 19:51:08'),
(2056, 96, 'Inició sesión', 0, '2017-03-21 19:02:10'),
(2055, 100, 'Inició sesión', 0, '2017-03-21 16:23:52'),
(2054, 2, 'Inició sesión', 0, '2017-03-17 09:34:19'),
(2053, 100, 'Inició sesión', 0, '2017-03-17 09:00:29'),
(2052, 96, 'Inicio campaña libre', 0, '2017-03-17 08:02:21'),
(2051, 96, 'Inició sesión', 0, '2017-03-17 08:02:17'),
(2050, 1, 'Inicio campaña libre', 0, '2017-03-17 07:48:00'),
(2049, 1, 'Inició sesión', 0, '2017-03-17 07:44:42'),
(2048, 1, 'Inicio campaña libre', 0, '2017-03-17 01:46:23'),
(2047, 1, 'Inició sesión', 0, '2017-03-17 01:46:19'),
(2046, 1, 'Inicio campaña libre', 0, '2017-03-17 01:45:46'),
(2045, 1, 'Inició sesión', 0, '2017-03-17 01:45:42'),
(2044, 1, 'Inicio campaña libre', 0, '2017-03-17 01:42:31'),
(2043, 1, 'Inició sesión', 0, '2017-03-17 01:42:27'),
(2042, 1, 'Inicio campaña libre', 0, '2017-03-17 01:40:39'),
(2041, 1, 'Inició sesión', 0, '2017-03-17 01:40:36'),
(2040, 1, 'Inicio campaña libre', 0, '2017-03-17 01:40:00'),
(2039, 1, 'Inició sesión', 0, '2017-03-17 01:39:55'),
(2038, 1, 'Inicio campaña libre', 0, '2017-03-17 01:35:46'),
(2037, 1, 'Inició sesión', 0, '2017-03-17 01:35:41'),
(2036, 1, 'Inicio campaña libre', 0, '2017-03-17 01:34:27'),
(2035, 1, 'Inició sesión', 0, '2017-03-17 01:34:23'),
(2034, 1, 'Inicio campaña libre', 0, '2017-03-17 01:33:12'),
(2033, 1, 'Inició sesión', 0, '2017-03-17 01:33:08'),
(2032, 1, 'Inicio campaña libre', 0, '2017-03-17 01:31:53'),
(2031, 1, 'Inició sesión', 0, '2017-03-17 01:31:49'),
(2030, 1, 'Inicio campaña libre', 0, '2017-03-17 01:30:49'),
(2029, 1, 'Inició sesión', 0, '2017-03-17 01:30:45'),
(2028, 1, 'Inicio campaña libre', 0, '2017-03-17 01:29:44'),
(2027, 1, 'Inició sesión', 0, '2017-03-17 01:29:39'),
(2026, 1, 'Inicio campaña libre', 0, '2017-03-17 01:28:25'),
(2025, 1, 'Inició sesión', 0, '2017-03-17 01:28:21'),
(2024, 1, 'Inicio campaña libre', 0, '2017-03-17 01:26:56'),
(2023, 1, 'Inició sesión', 0, '2017-03-17 01:26:51'),
(2022, 1, 'Inicio campaña libre', 0, '2017-03-17 01:25:08'),
(2021, 1, 'Inició sesión', 0, '2017-03-17 01:25:04'),
(2020, 1, 'Inicio campaña libre', 0, '2017-03-17 01:21:00'),
(2019, 1, 'Inició sesión', 0, '2017-03-17 01:20:55'),
(2018, 1, 'Inicio campaña libre', 0, '2017-03-17 01:18:20'),
(2017, 1, 'Inició sesión', 0, '2017-03-17 01:18:16'),
(2016, 1, 'Inicio campaña libre', 0, '2017-03-17 00:57:45'),
(2015, 1, 'Inició sesión', 0, '2017-03-17 00:54:51'),
(2014, 1, 'Inicio campaña libre', 0, '2017-03-17 00:53:30'),
(2013, 1, 'Inició sesión', 0, '2017-03-17 00:53:25'),
(2012, 1, 'Inicio campaña libre', 0, '2017-03-17 00:52:42'),
(2011, 1, 'Inició sesión', 0, '2017-03-17 00:52:36'),
(2010, 1, 'Inicio campaña libre', 0, '2017-03-17 00:49:21'),
(2009, 1, 'Inició sesión', 0, '2017-03-17 00:49:17'),
(2008, 1, 'Inicio campaña libre', 0, '2017-03-17 00:47:09'),
(2007, 1, 'Inició sesión', 0, '2017-03-17 00:47:01'),
(2006, 1, 'Inicio campaña libre', 0, '2017-03-17 00:45:51'),
(2005, 1, 'Inició sesión', 0, '2017-03-17 00:45:48'),
(2004, 1, 'Inicio campaña libre', 0, '2017-03-17 00:43:41'),
(2003, 1, 'Inició sesión', 0, '2017-03-17 00:43:36'),
(2002, 1, 'Inicio campaña libre', 0, '2017-03-17 00:41:58'),
(2001, 1, 'Inició sesión', 0, '2017-03-17 00:41:52'),
(2000, 1, 'Inicio campaña libre', 0, '2017-03-17 00:39:11'),
(1999, 1, 'Inició sesión', 0, '2017-03-17 00:39:07'),
(1998, 1, 'Inicio campaña libre', 0, '2017-03-17 00:37:02'),
(1997, 1, 'Inició sesión', 0, '2017-03-17 00:36:59'),
(1996, 1, 'Inició sesión', 0, '2017-03-17 00:35:31'),
(1995, 1, 'Inicio campaña libre', 0, '2017-03-17 00:33:43'),
(1994, 1, 'Inició sesión', 0, '2017-03-17 00:33:39'),
(1993, 1, 'Inició sesión', 0, '2017-03-17 00:33:16'),
(1992, 1, 'Inició sesión', 0, '2017-03-17 00:32:17'),
(1991, 1, 'Inicio campaña libre', 0, '2017-03-17 00:13:45'),
(1990, 1, 'Inició sesión', 0, '2017-03-17 00:13:42'),
(1989, 1, 'Inicio campaña libre', 0, '2017-03-17 00:12:49'),
(1988, 1, 'Inició sesión', 0, '2017-03-17 00:12:46'),
(1987, 1, 'Inicio campaña libre', 0, '2017-03-16 23:39:00'),
(1986, 1, 'Inició sesión', 0, '2017-03-16 23:38:54'),
(1985, 1, 'Inicio campaña libre', 0, '2017-03-16 23:38:31'),
(1984, 1, 'Inicio campaña libre', 0, '2017-03-16 23:38:23'),
(1983, 1, 'Inició sesión', 0, '2017-03-16 23:38:16'),
(1982, 26, 'Inició sesión', 0, '2017-03-16 20:38:37'),
(1981, 1, 'Inicio campaña libre', 0, '2017-03-16 20:35:00'),
(1980, 1, 'Inició sesión', 0, '2017-03-16 20:34:56'),
(1979, 1, 'Inicio campaña libre', 0, '2017-03-16 20:34:18'),
(1978, 1, 'Inició sesión', 0, '2017-03-16 20:30:28'),
(1977, 1, 'Inició sesión', 0, '2017-03-16 20:28:42'),
(1976, 1, 'Inicio campaña libre', 0, '2017-03-16 20:27:59'),
(1975, 1, 'Inició sesión', 0, '2017-03-16 20:27:34'),
(1974, 1, 'Inició sesión', 0, '2017-03-16 14:48:27'),
(1973, 96, 'Inició sesión', 0, '2017-03-16 00:29:25'),
(1972, 96, 'Inició sesión', 0, '2017-03-16 00:27:29'),
(1971, 96, 'Inició sesión', 0, '2017-03-16 00:26:58'),
(1970, 1, 'Inicio campaña libre', 0, '2017-03-16 00:26:03'),
(1969, 1, 'Inició sesión', 0, '2017-03-16 00:25:55'),
(1968, 1, 'Inicio campaña libre', 0, '2017-03-16 00:24:59'),
(1967, 1, 'Inició sesión', 0, '2017-03-16 00:24:44'),
(1966, 1, 'Inició sesión', 0, '2017-03-15 23:52:05'),
(1965, 96, 'Inicio campaña libre', 0, '2017-03-15 23:22:16'),
(1964, 96, 'Inició sesión', 0, '2017-03-15 23:22:12'),
(1963, 96, 'Inicio campaña libre', 0, '2017-03-15 22:56:36'),
(1962, 96, 'Inició sesión', 0, '2017-03-15 20:22:21'),
(1961, 96, 'Inicio campaña libre', 0, '2017-03-14 00:12:42'),
(1960, 96, 'Inició sesión', 0, '2017-03-14 00:12:35'),
(1959, 2, 'Inició sesión', 0, '2017-03-14 00:09:39'),
(1958, 2, 'Inició sesión', 0, '2017-03-14 00:05:41'),
(1957, 2, 'Inició sesión', 0, '2017-03-14 00:03:41'),
(1956, 2, 'Inició sesión', 0, '2017-03-13 23:44:56'),
(1955, 2, 'Inició sesión', 0, '2017-03-13 23:29:07'),
(1954, 96, 'Inicio campaña libre', 0, '2017-03-13 23:27:17'),
(1953, 96, 'Inició sesión', 0, '2017-03-13 23:27:12'),
(1952, 96, 'Inicio campaña libre', 0, '2017-03-13 23:22:18'),
(1951, 96, 'Inició sesión', 0, '2017-03-13 23:22:13'),
(1950, 96, 'Inicio campaña libre', 0, '2017-03-13 23:21:50'),
(1949, 96, 'Inició sesión', 0, '2017-03-13 23:21:45'),
(1948, 96, 'Inicio campaña libre', 0, '2017-03-13 23:16:29'),
(1947, 96, 'Inició sesión', 0, '2017-03-13 23:16:25'),
(1946, 96, 'Inicio campaña libre', 0, '2017-03-13 23:14:43'),
(1945, 96, 'Inició sesión', 0, '2017-03-13 23:14:40'),
(1944, 96, 'Inicio campaña libre', 0, '2017-03-13 23:09:57'),
(1943, 96, 'Inició sesión', 0, '2017-03-13 23:09:51'),
(1942, 96, 'Inicio campaña libre', 0, '2017-03-13 22:54:26'),
(1941, 96, 'Inició sesión', 0, '2017-03-13 22:54:21'),
(1940, 96, 'Inicio campaña libre', 0, '2017-03-13 22:50:44'),
(1939, 96, 'Inició sesión', 0, '2017-03-13 22:50:26'),
(1938, 96, 'Inicio campaña libre', 0, '2017-03-13 22:49:37'),
(1937, 96, 'Inició sesión', 0, '2017-03-13 22:48:57'),
(1936, 96, 'Inicio campaña libre', 0, '2017-03-13 22:47:56'),
(1935, 96, 'Inició sesión', 0, '2017-03-13 22:47:51'),
(1934, 96, 'Inició sesión', 0, '2017-03-13 22:47:05'),
(1933, 96, 'Inicio campaña libre', 0, '2017-03-13 22:44:22'),
(1932, 96, 'Inició sesión', 0, '2017-03-13 22:44:12'),
(1931, 96, 'Inicio campaña libre', 0, '2017-03-13 22:37:14'),
(1930, 96, 'Inició sesión', 0, '2017-03-13 22:37:08'),
(1929, 96, 'Inicio campaña libre', 0, '2017-03-13 22:33:26'),
(1928, 96, 'Inició sesión', 0, '2017-03-13 22:33:20'),
(1927, 96, 'Inicio campaña libre', 0, '2017-03-13 22:32:33'),
(1926, 96, 'Inició sesión', 0, '2017-03-13 22:32:27'),
(1925, 96, 'Inicio campaña libre', 0, '2017-03-13 22:27:03'),
(1924, 96, 'Inició sesión', 0, '2017-03-13 22:26:53'),
(1923, 96, 'Inicio campaña libre', 0, '2017-03-13 22:14:17'),
(1922, 96, 'Inició sesión', 0, '2017-03-13 22:14:00'),
(1921, 96, 'Inicio campaña libre', 0, '2017-03-13 21:48:10'),
(1920, 96, 'Inició sesión', 0, '2017-03-13 21:48:04'),
(1919, 96, 'Inicio campaña libre', 0, '2017-03-13 21:42:41'),
(1918, 96, 'Inició sesión', 0, '2017-03-13 21:41:55'),
(1917, 96, 'Inicio campaña libre', 0, '2017-03-13 19:06:25'),
(1916, 96, 'Inició sesión', 0, '2017-03-13 19:06:19'),
(1915, 96, 'Inicio campaña libre', 0, '2017-03-13 19:04:48'),
(1914, 96, 'Inició sesión', 0, '2017-03-13 19:04:42'),
(1913, 96, 'Inicio campaña libre', 0, '2017-03-13 19:00:05'),
(1912, 96, 'Inició sesión', 0, '2017-03-13 18:59:58'),
(1911, 96, 'Inicio campaña libre', 0, '2017-03-13 18:59:28'),
(1910, 96, 'Inició sesión', 0, '2017-03-13 18:59:23'),
(1909, 96, 'Inicio campaña libre', 0, '2017-03-13 18:57:49'),
(1908, 96, 'Inició sesión', 0, '2017-03-13 18:57:46'),
(1907, 96, 'Inició sesión', 0, '2017-03-13 18:57:45'),
(1906, 96, 'Inicio campaña libre', 0, '2017-03-13 18:56:20'),
(1905, 96, 'Inició sesión', 0, '2017-03-13 18:56:12'),
(1904, 96, 'Inicio campaña libre', 0, '2017-03-13 18:54:11'),
(1903, 96, 'Inició sesión', 0, '2017-03-13 18:54:05'),
(1902, 96, 'Inicio campaña libre', 0, '2017-03-13 18:53:43'),
(1901, 96, 'Inició sesión', 0, '2017-03-13 18:53:37'),
(1900, 96, 'Inicio campaña libre', 0, '2017-03-13 18:52:49'),
(1899, 96, 'Inició sesión', 0, '2017-03-13 18:52:43'),
(1898, 96, 'Inicio campaña libre', 0, '2017-03-13 18:51:25'),
(1897, 96, 'Inició sesión', 0, '2017-03-13 18:51:20'),
(1896, 96, 'Inicio campaña libre', 0, '2017-03-13 18:49:47'),
(1895, 96, 'Inició sesión', 0, '2017-03-13 18:49:41'),
(1894, 96, 'Inicio campaña libre', 0, '2017-03-13 18:44:57'),
(1893, 96, 'Inició sesión', 0, '2017-03-13 18:44:50'),
(1892, 96, 'Inicio campaña libre', 0, '2017-03-13 18:39:05'),
(1891, 96, 'Inició sesión', 0, '2017-03-13 18:32:24'),
(1890, 1, 'Inició sesión', 0, '2017-03-07 15:41:58'),
(1889, 1, 'Inició sesión', 0, '2017-03-07 15:41:58'),
(1888, 1, 'Inició sesión', 0, '2017-03-07 15:40:44'),
(1887, 96, 'Inició sesión', 0, '2017-03-05 23:15:48'),
(1886, 96, 'Inició sesión', 0, '2017-03-05 18:10:39'),
(1885, 108, 'Inició sesión', 0, '2017-03-02 21:13:39'),
(1884, 100, 'Inició sesión', 0, '2017-03-02 20:59:21'),
(1883, 100, 'Inició sesión', 0, '2017-03-02 20:57:23'),
(1882, 2, 'Inició sesión', 0, '2017-03-02 20:56:49'),
(1881, 98, 'Inició sesión', 0, '2017-03-02 20:55:13'),
(1880, 100, 'Inició sesión', 0, '2017-03-02 20:50:04'),
(1879, 100, 'Inició sesión', 0, '2017-03-02 20:50:04'),
(1878, 100, 'Inició sesión', 0, '2017-03-02 20:50:01'),
(1877, 96, 'Inicio campaña libre', 0, '2017-03-02 20:49:29'),
(1876, 96, 'Inició sesión', 0, '2017-03-02 20:49:00'),
(1875, 96, 'Inició sesión', 0, '2017-03-02 20:48:59'),
(1874, 96, 'Inicio campaña libre', 0, '2017-03-02 20:47:14'),
(1873, 96, 'Inició sesión', 0, '2017-03-02 20:46:40'),
(1872, 96, 'Inicio campaña libre', 0, '2017-03-02 20:38:47'),
(1871, 96, 'Inició sesión', 0, '2017-03-02 20:38:42'),
(1870, 96, 'Inicio campaña libre', 0, '2017-03-02 20:37:28'),
(1869, 96, 'Inició sesión', 0, '2017-03-02 20:37:09'),
(1868, 96, 'Inició sesión', 0, '2017-03-02 20:37:08'),
(1867, 2, 'Inició sesión', 0, '2017-03-02 20:36:38'),
(1866, 100, 'Inició sesión', 0, '2017-03-02 19:42:46'),
(1865, 96, 'Inicio campaña libre', 0, '2017-03-02 19:42:21'),
(1864, 96, 'Inició sesión', 0, '2017-03-02 19:42:11'),
(1863, 96, 'Inicio campaña libre', 0, '2017-03-02 17:57:14'),
(1862, 96, 'Inició sesión', 0, '2017-03-02 17:54:09'),
(1861, 26, 'Inició sesión', 0, '2017-03-02 17:50:34'),
(1860, 26, 'Inició sesión', 0, '2017-03-02 17:47:54'),
(1859, 26, 'Inició sesión', 0, '2017-03-02 17:39:44'),
(1858, 26, 'Inició sesión', 0, '2017-03-02 17:37:47'),
(1857, 26, 'Inició sesión', 0, '2017-03-02 17:23:45'),
(1856, 96, 'Inicio campaña libre', 0, '2017-03-02 17:23:18'),
(1855, 96, 'Inició sesión', 0, '2017-03-02 17:23:15'),
(1854, 2, 'Inició sesión', 0, '2017-03-02 17:22:57'),
(1853, 26, 'Inició sesión', 0, '2017-03-02 17:22:42'),
(1852, 96, 'Inicio campaña libre', 0, '2017-03-02 17:09:13'),
(1851, 96, 'Inicio campaña libre', 0, '2017-03-02 16:53:01'),
(1850, 96, 'Inició sesión', 0, '2017-03-02 16:48:34'),
(1849, 2, 'Inició sesión', 0, '2017-03-02 16:48:21'),
(1848, 2, 'Inició sesión', 0, '2017-03-02 16:48:08'),
(1847, 2, 'Inició sesión', 0, '2017-03-02 16:47:37'),
(1846, 96, 'Inicio campaña libre', 0, '2017-03-02 15:35:24'),
(1845, 96, 'Inició sesión', 0, '2017-03-02 15:35:04'),
(1844, 96, 'Inicio campaña libre', 0, '2017-03-02 15:34:05'),
(1843, 96, 'Inició sesión', 0, '2017-03-02 15:34:02'),
(1842, 96, 'Inicio campaña libre', 0, '2017-03-02 15:23:52'),
(1841, 96, 'Inició sesión', 0, '2017-03-02 15:23:41'),
(1840, 96, 'Inicio campaña libre', 0, '2017-03-02 14:37:27'),
(1839, 96, 'Inició sesión', 0, '2017-03-02 14:37:23'),
(1838, 96, 'Inicio campaña libre', 0, '2017-03-02 14:31:16'),
(1837, 96, 'Inició sesión', 0, '2017-03-02 14:31:13'),
(1836, 96, 'Inicio campaña libre', 0, '2017-03-02 14:25:26'),
(1835, 96, 'Inició sesión', 0, '2017-03-02 14:25:22'),
(1834, 96, 'Inicio campaña libre', 0, '2017-03-02 14:24:21'),
(1833, 96, 'Inició sesión', 0, '2017-03-02 14:24:18'),
(1832, 96, 'Inicio campaña libre', 0, '2017-03-02 14:14:50'),
(1831, 96, 'Inició sesión', 0, '2017-03-02 14:14:47'),
(1830, 96, 'Inicio campaña libre', 0, '2017-03-02 14:12:55'),
(1829, 96, 'Inició sesión', 0, '2017-03-02 14:12:37'),
(1828, 96, 'Inicio campaña libre', 0, '2017-03-02 13:58:34'),
(1827, 96, 'Inició sesión', 0, '2017-03-02 13:56:59'),
(1826, 96, 'Inicio campaña libre', 0, '2017-03-02 11:56:24'),
(1825, 96, 'Inició sesión', 0, '2017-03-02 11:56:18'),
(1824, 96, 'Inicio campaña libre', 0, '2017-03-02 11:51:32'),
(1823, 96, 'Inició sesión', 0, '2017-03-02 11:51:29'),
(1822, 96, 'Inició sesión', 0, '2017-03-02 11:48:45'),
(1821, 96, 'Inicio campaña libre', 0, '2017-03-02 11:21:00'),
(1820, 96, 'Inició sesión', 0, '2017-03-02 11:20:54'),
(1819, 96, 'Inicio campaña libre', 0, '2017-03-02 09:54:02'),
(1818, 96, 'Inició sesión', 0, '2017-03-02 09:53:49'),
(1817, 100, 'Inició sesión', 0, '2017-03-02 09:44:18'),
(1816, 96, 'Inicio campaña libre', 0, '2017-03-02 01:21:45'),
(1815, 96, 'Inició sesión', 0, '2017-03-02 01:21:23'),
(1814, 96, 'Inicio campaña libre', 0, '2017-03-02 01:20:45'),
(1813, 96, 'Inicio campaña libre', 0, '2017-03-02 01:20:26'),
(1812, 96, 'Inicio campaña libre', 0, '2017-03-02 01:17:20'),
(1811, 96, 'Inició sesión', 0, '2017-03-02 01:17:12'),
(1810, 96, 'Inicio campaña libre', 0, '2017-03-02 01:16:39'),
(1809, 96, 'Inicio campaña libre', 0, '2017-03-02 01:15:04'),
(1808, 96, 'Inició sesión', 0, '2017-03-02 01:14:57'),
(1807, 96, 'Inicio campaña libre', 0, '2017-03-02 01:11:27'),
(1806, 96, 'Inició sesión', 0, '2017-03-02 01:11:20'),
(1805, 96, 'Inició sesión', 0, '2017-03-02 00:59:00'),
(1804, 96, 'Inició sesión', 0, '2017-03-02 00:57:31'),
(1803, 96, 'Inició sesión', 0, '2017-03-02 00:56:49'),
(1802, 96, 'Inicio campaña libre', 0, '2017-03-02 00:50:35'),
(1801, 96, 'Inició sesión', 0, '2017-03-02 00:50:24'),
(1800, 96, 'Inició sesión', 0, '2017-03-02 00:45:25'),
(1799, 2, 'Inició sesión', 0, '2017-03-02 00:37:38'),
(1798, 2, 'Inició sesión', 0, '2017-03-02 00:35:27'),
(1797, 2, 'Inició sesión', 0, '2017-03-02 00:30:27'),
(1796, 102, 'Inició sesión', 0, '2017-03-02 00:29:28'),
(1795, 2, 'Inició sesión', 0, '2017-03-02 00:29:12'),
(1794, 2, 'Inició sesión', 0, '2017-03-02 00:27:16'),
(1793, 2, 'Inició sesión', 0, '2017-03-02 00:26:23'),
(1792, 2, 'Inició sesión', 0, '2017-03-02 00:12:16'),
(1791, 96, 'Inicio campaña libre', 0, '2017-03-02 00:06:20'),
(1790, 96, 'Inició sesión', 0, '2017-03-02 00:06:17'),
(1789, 96, 'Inicio campaña libre', 0, '2017-03-02 00:03:39'),
(1788, 96, 'Inició sesión', 0, '2017-03-02 00:03:33'),
(1787, 96, 'Inicio campaña libre', 0, '2017-03-02 00:00:32'),
(1786, 96, 'Inició sesión', 0, '2017-03-02 00:00:00'),
(1785, 96, 'Inicio campaña libre', 0, '2017-03-01 23:55:21'),
(1784, 96, 'Inicio campaña libre', 0, '2017-03-01 23:48:00'),
(1783, 96, 'Inició sesión', 0, '2017-03-01 23:47:53'),
(1782, 96, 'Inicio campaña libre', 0, '2017-03-01 23:32:00'),
(1781, 96, 'Inicio campaña libre', 0, '2017-03-01 23:26:43'),
(1780, 96, 'Inicio campaña libre', 0, '2017-03-01 23:25:43'),
(1779, 96, 'Inició sesión', 0, '2017-03-01 23:25:40'),
(1778, 96, 'Inicio campaña libre', 0, '2017-03-01 23:16:43'),
(1777, 96, 'Inició sesión', 0, '2017-03-01 23:16:38'),
(1776, 96, 'Inicio campaña libre', 0, '2017-03-01 23:15:53'),
(1775, 96, 'Inició sesión', 0, '2017-03-01 23:15:48'),
(1774, 96, 'Inicio campaña libre', 0, '2017-03-01 23:11:54'),
(1773, 96, 'Inició sesión', 0, '2017-03-01 23:11:51'),
(1772, 96, 'Inicio campaña libre', 0, '2017-03-01 22:50:07'),
(1771, 96, 'Inició sesión', 0, '2017-03-01 22:50:02'),
(1770, 96, 'Inicio campaña libre', 0, '2017-03-01 22:42:55'),
(1769, 96, 'Inició sesión', 0, '2017-03-01 22:42:48'),
(1768, 96, 'Inicio campaña libre', 0, '2017-03-01 22:38:56'),
(1767, 96, 'Inició sesión', 0, '2017-03-01 22:38:48'),
(1766, 96, 'Inicio campaña libre', 0, '2017-03-01 22:37:18'),
(1765, 96, 'Inició sesión', 0, '2017-03-01 22:37:14'),
(1764, 96, 'Inicio campaña libre', 0, '2017-03-01 22:25:54'),
(1763, 96, 'Inicio campaña libre', 0, '2017-03-01 22:20:35'),
(1762, 96, 'Inició sesión', 0, '2017-03-01 22:20:25'),
(1761, 96, 'Inicio campaña libre', 0, '2017-03-01 21:12:47'),
(1760, 96, 'Inició sesión', 0, '2017-03-01 21:12:36'),
(1759, 96, 'Inicio campaña libre', 0, '2017-03-01 20:57:00'),
(1758, 96, 'Inició sesión', 0, '2017-03-01 20:56:56'),
(1757, 96, 'Inicio campaña libre', 0, '2017-03-01 20:52:22'),
(1756, 96, 'Inició sesión', 0, '2017-03-01 20:52:12'),
(1755, 96, 'Inicio campaña libre', 0, '2017-03-01 20:47:34'),
(1754, 96, 'Inició sesión', 0, '2017-03-01 20:47:15'),
(1753, 96, 'Inicio campaña libre', 0, '2017-03-01 20:25:01'),
(1752, 96, 'Inició sesión', 0, '2017-03-01 20:18:21'),
(1751, 96, 'Inició sesión', 0, '2017-03-01 19:23:23'),
(1750, 96, 'Inició sesión', 0, '2017-03-01 19:22:43'),
(1749, 96, 'Inició sesión', 0, '2017-03-01 19:22:12'),
(1748, 96, 'Inició sesión', 0, '2017-03-01 19:21:42'),
(1747, 96, 'Inició sesión', 0, '2017-03-01 19:21:19'),
(1746, 96, 'Inició sesión', 0, '2017-03-01 19:20:48'),
(1745, 96, 'Inició sesión', 0, '2017-03-01 19:19:40'),
(1744, 96, 'Inició sesión', 0, '2017-03-01 19:19:05'),
(1743, 2, 'Inició sesión', 0, '2017-03-01 19:14:34'),
(1742, 98, 'Inició sesión', 0, '2017-03-01 18:47:20'),
(1741, 96, 'Inició sesión', 0, '2017-03-01 18:44:51'),
(1740, 26, 'Inició sesión', 0, '2017-03-01 18:44:12'),
(1739, 96, 'Inició sesión', 0, '2017-03-01 18:42:38'),
(1738, 96, 'Inició sesión', 0, '2017-03-01 18:39:14'),
(1737, 96, 'Inició sesión', 0, '2017-03-01 01:42:31'),
(1736, 96, 'Inició sesión', 0, '2017-03-01 01:40:03'),
(1735, 96, 'Inició sesión', 0, '2017-03-01 01:38:18'),
(1734, 96, 'Inició sesión', 0, '2017-03-01 01:36:29'),
(1733, 96, 'Inició sesión', 0, '2017-03-01 01:28:56'),
(1732, 96, 'Inició sesión', 0, '2017-03-01 01:20:14'),
(1731, 96, 'Inició sesión', 0, '2017-03-01 01:02:48'),
(1730, 96, 'Inició sesión', 0, '2017-03-01 00:58:51'),
(1729, 96, 'Inició sesión', 0, '2017-03-01 00:53:11'),
(1728, 96, 'Inició sesión', 0, '2017-03-01 00:42:24'),
(1727, 96, 'Inició sesión', 0, '2017-03-01 00:33:44'),
(1726, 96, 'Inició sesión', 0, '2017-03-01 00:29:12'),
(1725, 96, 'Inició sesión', 0, '2017-03-01 00:26:09'),
(1724, 96, 'Inició sesión', 0, '2017-03-01 00:22:15'),
(1723, 96, 'Inició sesión', 0, '2017-03-01 00:18:52'),
(1722, 96, 'Inició sesión', 0, '2017-03-01 00:01:08'),
(1721, 96, 'Inició sesión', 0, '2017-02-28 23:56:38'),
(1720, 96, 'Inició sesión', 0, '2017-02-28 23:52:15'),
(1719, 96, 'Inició sesión', 0, '2017-02-28 23:50:25'),
(1718, 96, 'Inició sesión', 0, '2017-02-28 23:41:43'),
(1717, 96, 'Inició sesión', 0, '2017-02-28 23:40:06'),
(1716, 96, 'Inició sesión', 0, '2017-02-28 23:38:16'),
(1715, 96, 'Inició sesión', 0, '2017-02-28 23:23:31'),
(1714, 96, 'Inició sesión', 0, '2017-02-28 23:16:59'),
(1713, 96, 'Inició sesión', 0, '2017-02-28 23:13:04'),
(1712, 96, 'Inició sesión', 0, '2017-02-28 23:12:03'),
(1711, 96, 'Inició sesión', 0, '2017-02-28 23:10:26'),
(1710, 96, 'Inició sesión', 0, '2017-02-28 23:07:38'),
(1709, 96, 'Inició sesión', 0, '2017-02-28 22:07:21'),
(1708, 96, 'Inició sesión', 0, '2017-02-28 22:06:14'),
(1707, 96, 'Inició sesión', 0, '2017-02-28 22:04:55'),
(1706, 96, 'Inició sesión', 0, '2017-02-28 21:59:58'),
(1705, 96, 'Inició sesión', 0, '2017-02-28 21:52:58'),
(1704, 96, 'Inició sesión', 0, '2017-02-28 21:51:19'),
(1703, 96, 'Inició sesión', 0, '2017-02-28 21:43:26'),
(1702, 96, 'Inició sesión', 0, '2017-02-28 21:42:50'),
(1701, 96, 'Inició sesión', 0, '2017-02-28 21:08:45'),
(1700, 96, 'Inició sesión', 0, '2017-02-28 21:06:27'),
(1699, 96, 'Inició sesión', 0, '2017-02-28 21:04:59'),
(1698, 96, 'Inició sesión', 0, '2017-02-28 21:01:15'),
(1697, 96, 'Inició sesión', 0, '2017-02-28 20:57:33'),
(1696, 96, 'Inicio campaña libre', 0, '2017-02-28 20:56:53'),
(1695, 96, 'Inició sesión', 0, '2017-02-28 20:56:39'),
(1694, 96, 'Inició sesión', 0, '2017-02-28 20:40:16'),
(1693, 96, 'Inició sesión', 0, '2017-02-28 20:38:57'),
(1692, 96, 'Inició sesión', 0, '2017-02-28 20:36:51'),
(1691, 96, 'Inició sesión', 0, '2017-02-28 20:35:20'),
(1690, 96, 'Inició sesión', 0, '2017-02-28 20:34:13'),
(1689, 96, 'Inició sesión', 0, '2017-02-28 20:29:48'),
(1688, 96, 'Inició sesión', 0, '2017-02-28 02:00:16'),
(1687, 96, 'Inició sesión', 0, '2017-02-28 01:55:02'),
(1686, 96, 'Inició sesión', 0, '2017-02-28 01:53:37'),
(1685, 96, 'Inició sesión', 0, '2017-02-28 01:52:31'),
(1684, 96, 'Inició sesión', 0, '2017-02-28 01:48:26'),
(1683, 96, 'Inició sesión', 0, '2017-02-28 01:45:58'),
(1682, 96, 'Inició sesión', 0, '2017-02-28 01:44:02'),
(1681, 96, 'Inició sesión', 0, '2017-02-28 01:43:12'),
(1680, 96, 'Inició sesión', 0, '2017-02-28 01:42:31'),
(1679, 96, 'Inició sesión', 0, '2017-02-28 01:38:16'),
(1678, 96, 'Inició sesión', 0, '2017-02-28 01:37:35'),
(1677, 96, 'Inició sesión', 0, '2017-02-28 01:36:24'),
(1676, 96, 'Inició sesión', 0, '2017-02-28 01:34:12'),
(1675, 2, 'Inició sesión', 0, '2017-02-28 01:31:20'),
(1674, 96, 'Inició sesión', 0, '2017-02-28 01:30:40'),
(1673, 96, 'Inició sesión', 0, '2017-02-28 01:28:12'),
(1672, 96, 'Inició sesión', 0, '2017-02-28 01:27:02'),
(1671, 96, 'Inició sesión', 0, '2017-02-28 01:24:35'),
(1670, 96, 'Inició sesión', 0, '2017-02-28 01:10:25'),
(1669, 2, 'Inició sesión', 0, '2017-02-28 01:09:01'),
(1668, 2, 'Inició sesión', 0, '2017-02-28 00:54:44'),
(1667, 2, 'Inició sesión', 0, '2017-02-28 00:43:47'),
(1666, 2, 'Inició sesión', 0, '2017-02-28 00:35:50'),
(1665, 2, 'Inició sesión', 0, '2017-02-28 00:34:46'),
(1664, 2, 'Inició sesión', 0, '2017-02-28 00:23:10'),
(1663, 2, 'Inició sesión', 0, '2017-02-28 00:23:04'),
(1662, 2, 'Inició sesión', 0, '2017-02-28 00:22:16'),
(1621, 96, 'Inició sesión', 0, '2017-02-27 18:41:04'),
(1622, 96, 'Inicio campaña libre', 0, '2017-02-27 18:41:08'),
(1623, 96, 'Inicio campaña libre', 0, '2017-02-27 18:41:37'),
(1624, 96, 'Inició sesión', 0, '2017-02-27 18:45:07'),
(1625, 96, 'Inicio campaña libre', 0, '2017-02-27 18:45:11'),
(1626, 96, 'Inició sesión', 0, '2017-02-27 18:58:02'),
(1627, 96, 'Inicio campaña libre', 0, '2017-02-27 18:58:09'),
(1628, 96, 'Inició sesión', 0, '2017-02-27 19:42:34'),
(1629, 96, 'Inicio campaña libre', 0, '2017-02-27 19:42:38'),
(1630, 96, 'Inició sesión', 0, '2017-02-27 19:43:52'),
(1631, 96, 'Inicio campaña libre', 0, '2017-02-27 19:43:56'),
(1632, 96, 'Inició sesión', 0, '2017-02-27 20:05:25'),
(1633, 96, 'Inicio campaña libre', 0, '2017-02-27 20:07:46'),
(1634, 96, 'Inició sesión', 0, '2017-02-27 20:24:27'),
(1635, 96, 'Inicio campaña libre', 0, '2017-02-27 20:24:31'),
(1636, 96, 'Inició sesión', 0, '2017-02-27 20:33:40'),
(1637, 96, 'Inició sesión', 0, '2017-02-27 20:34:36'),
(1638, 96, 'Inició sesión', 0, '2017-02-27 20:36:38'),
(1639, 96, 'Inició sesión', 0, '2017-02-27 20:37:45'),
(1640, 96, 'Inicio campaña libre', 0, '2017-02-27 20:38:15'),
(1641, 96, 'Inició sesión', 0, '2017-02-27 20:46:48'),
(1642, 96, 'Inicio campaña libre', 0, '2017-02-27 20:46:53'),
(1643, 96, 'Inició sesión', 0, '2017-02-27 20:53:24'),
(1644, 96, 'Inicio campaña libre', 0, '2017-02-27 20:53:34'),
(1645, 96, 'Inició sesión', 0, '2017-02-27 20:57:19'),
(1646, 96, 'Inicio campaña libre', 0, '2017-02-27 20:57:22'),
(1647, 96, 'Inició sesión', 0, '2017-02-27 21:01:34'),
(1648, 96, 'Inicio campaña libre', 0, '2017-02-27 21:01:37'),
(1649, 96, 'Inició sesión', 0, '2017-02-27 21:06:46'),
(1650, 96, 'Inicio campaña libre', 0, '2017-02-27 21:06:51'),
(1651, 96, 'Inició sesión', 0, '2017-02-27 21:08:49'),
(1652, 96, 'Inició sesión', 0, '2017-02-27 21:10:13'),
(1653, 96, 'Inicio campaña libre', 0, '2017-02-27 21:10:16'),
(1654, 96, 'Inició sesión', 0, '2017-02-27 21:11:36'),
(1655, 96, 'Inicio campaña libre', 0, '2017-02-27 21:11:42'),
(1656, 96, 'Inició sesión', 0, '2017-02-27 23:34:20'),
(1657, 96, 'Inicio campaña libre', 0, '2017-02-27 23:35:16'),
(1658, 96, 'Inició sesión', 0, '2017-02-28 00:02:42'),
(1659, 2, 'Inició sesión', 0, '2017-02-28 00:04:07'),
(1660, 96, 'Inició sesión', 0, '2017-02-28 00:11:53'),
(1661, 2, 'Inició sesión', 0, '2017-02-28 00:12:31'),
(2439, 150, 'Inició sesión', 0, '2017-11-20 08:13:20'),
(2440, 150, 'Inició sesión', 0, '2017-11-20 08:23:32'),
(2441, 150, 'Inició sesión', 0, '2017-11-22 09:06:12'),
(2442, 150, 'Inició sesión', 0, '2017-11-22 09:59:26'),
(2443, 150, 'Inició sesión', 0, '2017-11-23 08:57:41'),
(2444, 150, 'Inició sesión', 0, '2017-11-23 09:05:36'),
(2445, 150, 'Inició sesión', 0, '2017-11-23 10:23:26'),
(2446, 96, 'Inició sesión', 0, '2017-11-23 19:29:00'),
(2447, 98, 'Inició sesión', 0, '2017-11-23 19:44:38'),
(2448, 2, 'Inició sesión', 0, '2017-11-23 19:45:51'),
(2449, 96, 'Inició sesión', 0, '2017-11-23 19:51:14'),
(2450, 150, 'Inició sesión', 0, '2017-11-24 08:25:06'),
(2451, 96, 'Inició sesión', 0, '2017-11-24 08:37:34'),
(2452, 1, 'Inició sesión', 0, '2017-11-26 21:32:31'),
(2453, 1, 'Inició sesión', 0, '2018-01-19 14:37:14'),
(2454, 96, 'Inició sesión', 0, '2018-01-19 15:49:22'),
(2455, 100, 'Inició sesión', 0, '2018-01-19 15:50:23'),
(2456, 1, 'Inició sesión', 0, '2018-01-27 14:53:53'),
(2457, 1, 'Inició sesión', 0, '2018-01-27 15:03:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Admin_Inbox`
--

CREATE TABLE `Admin_Inbox` (
  `id_inbox` int(9) NOT NULL,
  `name` text NOT NULL,
  `date_up` text NOT NULL,
  `message` text NOT NULL,
  `status` int(1) NOT NULL COMMENT '1- Opened, 2- Closed',
  `company_name` text,
  `email` text NOT NULL,
  `phone` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Admin_Inbox`
--

INSERT INTO `Admin_Inbox` (`id_inbox`, `name`, `date_up`, `message`, `status`, `company_name`, `email`, `phone`) VALUES
(1, 'Santiago Ordaz', '2017-01-04 23:30:17', '¿Existe algún plan de financiamiento?', 1, 'Compañía test', 'sordaz@test.com', '812691'),
(2, 'Penelope Díaz', '2017-01-04 23:30:17', '¿Cuál es la diferencia entre la subscripción oro contra la platinum?', 1, 'Compañía test', 'pdiaz@test.com', '15152125');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Admin_Visits`
--

CREATE TABLE `Admin_Visits` (
  `id_visit` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `value` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Admin_Visits`
--

INSERT INTO `Admin_Visits` (`id_visit`, `date_up`, `value`) VALUES
(1, '2017-01-04 18:28:16', 1),
(2, '2017-01-04 18:29:51', 1),
(3, '2017-01-04 18:29:51', 1),
(4, '2017-01-04 18:33:30', 1),
(5, '2017-01-04 18:34:34', 1),
(6, '2017-01-04 18:35:51', 1),
(7, '2017-01-04 18:44:10', 1),
(8, '2017-01-04 18:44:33', 1),
(9, '2017-01-04 19:09:39', 1),
(10, '2017-01-04 19:17:27', 1),
(11, '2017-01-04 19:18:41', 1),
(12, '2017-01-04 19:19:50', 1),
(13, '2017-01-04 19:23:04', 1),
(14, '2017-01-04 19:23:20', 1),
(15, '2017-01-04 19:23:29', 1),
(16, '2017-01-04 19:25:52', 1),
(17, '2017-01-04 19:26:24', 1),
(18, '2017-01-04 19:27:17', 1),
(19, '2017-01-04 19:29:18', 1),
(20, '2017-01-04 19:29:59', 1),
(21, '2017-01-04 19:31:27', 1),
(22, '2017-01-04 19:31:48', 1),
(23, '2017-01-04 19:33:14', 1),
(24, '2017-01-04 19:39:25', 1),
(25, '2017-01-04 19:40:07', 1),
(26, '2017-01-04 19:40:38', 1),
(27, '2017-01-04 19:41:23', 1),
(28, '2017-01-04 19:42:15', 1),
(29, '2017-01-04 19:46:15', 1),
(30, '2017-01-04 19:49:10', 1),
(31, '2017-01-04 19:50:20', 1),
(32, '2017-01-04 19:54:29', 1),
(33, '2017-01-04 19:55:28', 1),
(34, '2017-01-04 20:25:50', 1),
(35, '2017-01-04 20:26:41', 1),
(36, '2017-01-04 20:29:01', 1),
(37, '2017-01-04 20:29:21', 1),
(38, '2017-01-04 20:29:44', 1),
(39, '2017-01-04 20:30:29', 1),
(40, '2017-01-04 20:31:20', 1),
(41, '2017-01-04 20:31:38', 1),
(42, '2017-01-04 20:32:06', 1),
(43, '2017-01-04 20:35:13', 1),
(44, '2017-01-04 20:40:22', 1),
(45, '2017-01-04 20:40:31', 1),
(46, '2017-01-04 21:09:33', 1),
(47, '2017-01-04 21:11:29', 1),
(48, '2017-01-04 21:15:09', 1),
(49, '2017-01-04 21:16:40', 1),
(50, '2017-01-04 21:17:27', 1),
(51, '2017-01-04 21:19:45', 1),
(52, '2017-01-04 21:20:15', 1),
(53, '2017-01-04 21:22:06', 1),
(54, '2017-01-04 22:02:29', 1),
(55, '2017-01-04 22:04:50', 1),
(56, '2017-01-04 22:08:00', 1),
(57, '2017-01-04 22:08:25', 1),
(58, '2017-01-04 22:12:46', 1),
(59, '2017-01-04 22:13:39', 1),
(60, '2017-01-04 22:28:01', 1),
(61, '2017-01-04 22:44:03', 1),
(62, '2017-01-04 22:46:40', 1),
(63, '2017-01-04 22:47:51', 1),
(64, '2017-01-04 22:54:25', 1),
(65, '2017-01-04 22:57:43', 1),
(66, '2017-01-04 22:57:45', 1),
(67, '2017-01-04 23:01:16', 1),
(68, '2017-01-04 23:12:23', 1),
(69, '2017-01-04 23:12:52', 1),
(70, '2017-01-04 23:30:34', 1),
(71, '2017-01-04 23:32:13', 1),
(72, '2017-01-04 23:33:17', 1),
(73, '2017-01-04 23:38:15', 1),
(74, '2017-01-04 23:40:57', 1),
(75, '2017-01-04 23:51:51', 1),
(76, '2017-01-04 23:54:54', 1),
(77, '2017-01-04 23:56:49', 1),
(78, '2017-01-05 00:03:50', 1),
(79, '2017-01-05 00:08:50', 1),
(80, '2017-01-05 00:10:06', 1),
(81, '2017-01-05 00:11:00', 1),
(82, '2017-01-05 00:11:57', 1),
(83, '2017-01-05 00:13:16', 1),
(84, '2017-01-05 00:16:23', 1),
(85, '2017-01-05 00:38:20', 1),
(86, '2017-01-05 00:39:21', 1),
(87, '2017-01-05 12:32:28', 1),
(88, '2017-01-05 18:23:08', 1),
(89, '2017-01-05 18:25:56', 1),
(90, '2017-01-05 18:26:45', 1),
(91, '2017-01-05 18:28:07', 1),
(92, '2017-01-05 18:32:04', 1),
(93, '2017-01-05 18:47:01', 1),
(94, '2017-01-05 19:05:03', 1),
(95, '2017-01-05 19:05:52', 1),
(96, '2017-01-05 19:06:26', 1),
(97, '2017-01-05 19:09:28', 1),
(98, '2017-01-05 19:22:12', 1),
(99, '2017-01-05 19:22:22', 1),
(100, '2017-01-05 19:22:27', 1),
(101, '2017-01-05 19:26:08', 1),
(102, '2017-01-05 19:33:26', 1),
(103, '2017-01-05 19:39:07', 1),
(104, '2017-01-05 21:42:57', 1),
(105, '2017-01-05 21:43:40', 1),
(106, '2017-01-05 21:46:02', 1),
(107, '2017-01-05 21:47:54', 1),
(108, '2017-01-05 21:49:32', 1),
(109, '2017-01-05 21:52:24', 1),
(110, '2017-01-05 21:54:09', 1),
(111, '2017-01-05 22:03:33', 1),
(112, '2017-01-05 22:04:03', 1),
(113, '2017-01-05 22:04:51', 1),
(114, '2017-01-05 22:05:17', 1),
(115, '2017-01-05 22:09:06', 1),
(116, '2017-01-05 22:09:49', 1),
(117, '2017-01-05 23:16:57', 1),
(118, '2017-01-05 23:17:01', 1),
(119, '2017-01-05 23:39:29', 1),
(120, '2017-01-06 00:21:23', 1),
(121, '2017-01-06 00:37:23', 1),
(122, '2017-01-06 00:43:51', 1),
(123, '2017-01-06 00:53:18', 1),
(124, '2017-01-06 00:53:30', 1),
(125, '2017-01-06 18:55:42', 1),
(126, '2017-01-06 19:23:57', 1),
(127, '2017-01-06 19:26:51', 1),
(128, '2017-01-06 19:27:43', 1),
(129, '2017-01-06 19:30:00', 1),
(130, '2017-01-06 19:30:29', 1),
(131, '2017-01-06 19:31:13', 1),
(132, '2017-01-06 19:33:23', 1),
(133, '2017-01-06 19:35:44', 1),
(134, '2017-01-06 19:38:02', 1),
(135, '2017-01-06 20:11:21', 1),
(136, '2017-01-06 20:13:13', 1),
(137, '2017-01-06 20:16:41', 1),
(138, '2017-01-06 20:17:50', 1),
(139, '2017-01-06 20:24:40', 1),
(140, '2017-01-06 20:26:04', 1),
(141, '2017-01-06 20:35:28', 1),
(142, '2017-01-06 22:57:41', 1),
(143, '2017-01-07 11:07:03', 1),
(144, '2017-01-07 11:35:17', 1),
(145, '2017-01-07 11:45:06', 1),
(146, '2017-01-07 13:28:49', 1),
(147, '2017-01-07 13:31:06', 1),
(148, '2017-01-07 13:33:01', 1),
(149, '2017-01-07 13:33:35', 1),
(150, '2017-01-07 13:34:02', 1),
(151, '2017-01-07 13:47:45', 1),
(152, '2017-01-07 13:48:14', 1),
(153, '2017-01-07 13:56:24', 1),
(154, '2017-01-07 13:58:32', 1),
(155, '2017-01-07 14:54:47', 1),
(156, '2017-01-07 14:59:13', 1),
(157, '2017-01-07 15:02:44', 1),
(158, '2017-01-07 15:03:40', 1),
(159, '2017-01-07 15:07:14', 1),
(160, '2017-01-07 15:07:39', 1),
(161, '2017-01-07 15:21:17', 1),
(162, '2017-01-07 15:50:59', 1),
(163, '2017-01-07 15:53:05', 1),
(164, '2017-01-07 15:56:11', 1),
(165, '2017-01-07 15:58:00', 1),
(166, '2017-01-07 16:15:14', 1),
(167, '2017-01-07 16:17:29', 1),
(168, '2017-01-07 16:19:17', 1),
(169, '2017-01-07 16:31:29', 1),
(170, '2017-01-07 16:33:20', 1),
(171, '2017-01-07 16:35:46', 1),
(172, '2017-01-07 16:36:52', 1),
(173, '2017-01-07 16:38:03', 1),
(174, '2017-01-07 17:26:40', 1),
(175, '2017-01-07 17:59:19', 1),
(176, '2017-01-07 18:00:14', 1),
(177, '2017-01-07 18:02:26', 1),
(178, '2017-01-07 18:02:55', 1),
(179, '2017-01-07 18:03:06', 1),
(180, '2017-01-07 18:03:40', 1),
(181, '2017-01-07 18:07:14', 1),
(182, '2017-01-07 18:07:35', 1),
(183, '2017-01-07 18:21:56', 1),
(184, '2017-01-07 18:26:49', 1),
(185, '2017-01-07 18:28:44', 1),
(186, '2017-01-07 18:33:01', 1),
(187, '2017-01-07 19:20:55', 1),
(188, '2017-01-07 19:29:37', 1),
(189, '2017-01-07 19:42:34', 1),
(190, '2017-01-07 19:52:13', 1),
(191, '2017-01-07 20:30:16', 1),
(192, '2017-01-07 20:30:55', 1),
(193, '2017-01-07 20:44:35', 1),
(194, '2017-01-07 20:55:20', 1),
(195, '2017-01-07 20:55:49', 1),
(196, '2017-01-08 12:31:34', 1),
(197, '2017-01-08 13:43:04', 1),
(198, '2017-01-08 13:44:43', 1),
(199, '2017-01-08 13:53:48', 1),
(200, '2017-01-08 13:56:07', 1),
(201, '2017-01-08 16:10:37', 1),
(202, '2017-01-08 16:11:16', 1),
(203, '2017-01-08 16:13:24', 1),
(204, '2017-01-08 16:19:09', 1),
(205, '2017-01-08 16:19:56', 1),
(206, '2017-01-08 16:20:12', 1),
(207, '2017-01-08 16:46:26', 1),
(208, '2017-01-08 17:20:02', 1),
(209, '2017-01-08 19:00:13', 1),
(210, '2017-01-08 19:01:42', 1),
(211, '2017-01-08 19:04:50', 1),
(212, '2017-01-08 19:06:13', 1),
(213, '2017-01-08 19:07:21', 1),
(214, '2017-01-08 19:08:14', 1),
(215, '2017-01-08 19:22:32', 1),
(216, '2017-01-08 19:28:00', 1),
(217, '2017-01-08 19:30:09', 1),
(218, '2017-01-08 19:30:26', 1),
(219, '2017-01-08 19:31:14', 1),
(220, '2017-01-08 19:32:31', 1),
(221, '2017-01-08 19:32:51', 1),
(222, '2017-01-08 19:41:18', 1),
(223, '2017-01-08 19:41:33', 1),
(224, '2017-01-08 19:42:30', 1),
(225, '2017-01-08 19:43:54', 1),
(226, '2017-01-08 19:49:37', 1),
(227, '2017-01-08 19:50:02', 1),
(228, '2017-01-08 20:27:34', 1),
(229, '2017-01-08 20:31:28', 1),
(230, '2017-01-08 20:32:45', 1),
(231, '2017-01-08 20:33:40', 1),
(232, '2017-01-08 20:33:42', 1),
(233, '2017-01-08 20:34:41', 1),
(234, '2017-01-08 20:36:22', 1),
(235, '2017-01-08 20:36:52', 1),
(236, '2017-01-08 20:37:33', 1),
(237, '2017-01-08 20:39:01', 1),
(238, '2017-01-08 20:39:41', 1),
(239, '2017-01-08 20:41:32', 1),
(240, '2017-01-08 20:43:24', 1),
(241, '2017-01-08 20:46:36', 1),
(242, '2017-01-08 20:48:03', 1),
(243, '2017-01-08 20:50:14', 1),
(244, '2017-01-08 20:51:13', 1),
(245, '2017-01-08 20:53:52', 1),
(246, '2017-01-08 20:54:56', 1),
(247, '2017-01-08 20:56:20', 1),
(248, '2017-01-08 21:20:02', 1),
(249, '2017-01-08 21:22:52', 1),
(250, '2017-01-08 21:23:24', 1),
(251, '2017-01-08 21:24:19', 1),
(252, '2017-01-08 21:28:01', 1),
(253, '2017-01-08 21:31:30', 1),
(254, '2017-01-08 21:34:54', 1),
(255, '2017-01-08 21:35:38', 1),
(256, '2017-01-08 21:36:14', 1),
(257, '2017-01-08 21:38:00', 1),
(258, '2017-01-08 21:39:09', 1),
(259, '2017-01-08 21:41:36', 1),
(260, '2017-01-08 21:48:42', 1),
(261, '2017-01-08 21:49:01', 1),
(262, '2017-01-08 21:49:10', 1),
(263, '2017-01-08 21:52:16', 1),
(264, '2017-01-08 22:00:40', 1),
(265, '2017-01-08 22:01:15', 1),
(266, '2017-01-08 22:01:56', 1),
(267, '2017-01-08 22:06:43', 1),
(268, '2017-01-08 22:07:14', 1),
(269, '2017-01-08 22:07:24', 1),
(270, '2017-01-08 22:41:37', 1),
(271, '2017-01-08 22:52:13', 1),
(272, '2017-01-08 22:52:48', 1),
(273, '2017-01-08 22:58:43', 1),
(274, '2017-01-08 23:04:36', 1),
(275, '2017-01-08 23:05:50', 1),
(276, '2017-01-08 23:08:00', 1),
(277, '2017-01-08 23:10:23', 1),
(278, '2017-01-08 23:11:05', 1),
(279, '2017-01-08 23:11:47', 1),
(280, '2017-01-08 23:12:21', 1),
(281, '2017-01-08 23:14:18', 1),
(282, '2017-01-08 23:25:21', 1),
(283, '2017-01-08 23:25:43', 1),
(284, '2017-01-08 23:31:08', 1),
(285, '2017-01-08 23:33:03', 1),
(286, '2017-01-08 23:33:44', 1),
(287, '2017-01-08 23:36:04', 1),
(288, '2017-01-08 23:37:07', 1),
(289, '2017-01-08 23:42:27', 1),
(290, '2017-01-08 23:43:29', 1),
(291, '2017-01-08 23:48:07', 1),
(292, '2017-01-08 23:49:01', 1),
(293, '2017-01-08 23:50:41', 1),
(294, '2017-01-08 23:52:08', 1),
(295, '2017-01-08 23:53:18', 1),
(296, '2017-01-08 23:59:16', 1),
(297, '2017-01-09 00:00:26', 1),
(298, '2017-01-09 00:01:02', 1),
(299, '2017-01-09 00:03:08', 1),
(300, '2017-01-09 00:05:01', 1),
(301, '2017-01-09 00:06:21', 1),
(302, '2017-01-09 00:07:20', 1),
(303, '2017-01-09 00:08:51', 1),
(304, '2017-01-09 00:10:34', 1),
(305, '2017-01-09 17:00:11', 1),
(306, '2017-01-09 17:00:43', 1),
(307, '2017-01-09 17:02:29', 1),
(308, '2017-01-09 17:02:38', 1),
(309, '2017-01-09 17:20:00', 1),
(310, '2017-01-09 17:21:17', 1),
(311, '2017-01-09 17:27:46', 1),
(312, '2017-01-09 19:19:36', 1),
(313, '2017-01-09 19:21:40', 1),
(314, '2017-01-09 19:53:13', 1),
(315, '2017-01-10 14:01:15', 1),
(316, '2017-01-11 11:17:58', 1),
(317, '2017-01-11 12:55:15', 1),
(318, '2017-01-11 20:35:38', 1),
(319, '2017-01-12 00:26:16', 1),
(320, '2017-01-12 15:51:11', 1),
(321, '2017-01-13 15:23:13', 1),
(322, '2017-01-13 19:37:15', 1),
(323, '2017-01-14 15:07:20', 1),
(324, '2017-01-14 16:23:15', 1),
(325, '2017-01-14 16:23:50', 1),
(326, '2017-01-14 16:36:26', 1),
(327, '2017-01-14 16:37:35', 1),
(328, '2017-01-14 16:38:01', 1),
(329, '2017-01-14 16:38:27', 1),
(330, '2017-01-14 17:32:12', 1),
(331, '2017-01-14 17:32:38', 1),
(332, '2017-01-14 17:42:20', 1),
(333, '2017-01-14 17:43:13', 1),
(334, '2017-01-14 17:44:26', 1),
(335, '2017-01-14 17:44:32', 1),
(336, '2017-01-14 17:58:25', 1),
(337, '2017-01-14 18:00:29', 1),
(338, '2017-01-14 18:34:17', 1),
(339, '2017-01-14 18:35:46', 1),
(340, '2017-01-14 18:36:36', 1),
(341, '2017-01-14 18:37:22', 1),
(342, '2017-01-14 18:37:26', 1),
(343, '2017-01-14 18:38:35', 1),
(344, '2017-01-14 18:39:11', 1),
(345, '2017-01-14 18:39:13', 1),
(346, '2017-01-14 18:40:32', 1),
(347, '2017-01-14 18:44:28', 1),
(348, '2017-01-14 18:45:08', 1),
(349, '2017-01-14 18:49:27', 1),
(350, '2017-01-14 18:49:30', 1),
(351, '2017-01-14 18:50:08', 1),
(352, '2017-01-14 18:50:42', 1),
(353, '2017-01-14 18:53:12', 1),
(354, '2017-01-14 18:53:49', 1),
(355, '2017-01-14 18:54:47', 1),
(356, '2017-01-14 18:56:37', 1),
(357, '2017-01-14 18:56:41', 1),
(358, '2017-01-14 19:00:44', 1),
(359, '2017-01-14 19:33:01', 1),
(360, '2017-01-14 19:33:27', 1),
(361, '2017-01-14 19:33:37', 1),
(362, '2017-01-14 19:33:47', 1),
(363, '2017-01-14 19:34:46', 1),
(364, '2017-01-14 19:34:56', 1),
(365, '2017-01-14 19:35:44', 1),
(366, '2017-01-14 19:36:25', 1),
(367, '2017-01-14 20:35:17', 1),
(368, '2017-01-14 20:35:41', 1),
(369, '2017-01-14 20:37:41', 1),
(370, '2017-01-14 20:45:07', 1),
(371, '2017-01-14 20:45:32', 1),
(372, '2017-01-14 21:14:28', 1),
(373, '2017-01-14 21:21:50', 1),
(374, '2017-01-15 11:56:23', 1),
(375, '2017-01-15 12:52:51', 1),
(376, '2017-01-15 12:54:46', 1),
(377, '2017-01-15 12:56:51', 1),
(378, '2017-01-15 13:28:31', 1),
(379, '2017-01-15 13:29:09', 1),
(380, '2017-01-15 13:34:33', 1),
(381, '2017-01-15 13:39:18', 1),
(382, '2017-01-15 13:51:25', 1),
(383, '2017-01-15 14:51:56', 1),
(384, '2017-01-15 14:57:12', 1),
(385, '2017-01-15 14:57:35', 1),
(386, '2017-01-15 14:59:34', 1),
(387, '2017-01-15 15:08:47', 1),
(388, '2017-01-15 15:14:02', 1),
(389, '2017-01-15 15:14:46', 1),
(390, '2017-01-15 15:15:39', 1),
(391, '2017-01-15 15:16:00', 1),
(392, '2017-01-15 15:18:24', 1),
(393, '2017-01-15 15:25:15', 1),
(394, '2017-01-15 15:33:36', 1),
(395, '2017-01-15 15:35:47', 1),
(396, '2017-01-15 15:38:17', 1),
(397, '2017-01-15 15:43:47', 1),
(398, '2017-01-15 15:59:20', 1),
(399, '2017-01-15 16:03:39', 1),
(400, '2017-01-15 16:07:25', 1),
(401, '2017-01-15 16:12:46', 1),
(402, '2017-01-15 16:14:09', 1),
(403, '2017-01-15 16:15:36', 1),
(404, '2017-01-15 16:16:06', 1),
(405, '2017-01-15 16:17:48', 1),
(406, '2017-01-15 16:19:00', 1),
(407, '2017-01-15 20:41:20', 1),
(408, '2017-01-15 20:43:07', 1),
(409, '2017-01-15 20:43:44', 1),
(410, '2017-01-15 20:58:04', 1),
(411, '2017-01-15 20:58:40', 1),
(412, '2017-01-15 20:58:43', 1),
(413, '2017-01-15 20:58:53', 1),
(414, '2017-01-15 21:32:20', 1),
(415, '2017-01-15 21:38:21', 1),
(416, '2017-01-15 21:43:20', 1),
(417, '2017-01-15 21:44:35', 1),
(418, '2017-01-15 21:48:47', 1),
(419, '2017-01-15 21:52:37', 1),
(420, '2017-01-15 21:53:20', 1),
(421, '2017-01-15 21:59:02', 1),
(422, '2017-01-15 21:59:45', 1),
(423, '2017-01-15 22:00:45', 1),
(424, '2017-01-15 22:01:24', 1),
(425, '2017-01-15 22:07:59', 1),
(426, '2017-01-15 22:08:28', 1),
(427, '2017-01-15 22:09:38', 1),
(428, '2017-01-15 22:14:15', 1),
(429, '2017-01-15 22:14:22', 1),
(430, '2017-01-15 22:51:31', 1),
(431, '2017-01-15 23:28:27', 1),
(432, '2017-01-15 23:29:34', 1),
(433, '2017-01-15 23:39:08', 1),
(434, '2017-01-15 23:40:59', 1),
(435, '2017-01-15 23:53:32', 1),
(436, '2017-01-15 23:55:34', 1),
(437, '2017-01-16 00:04:14', 1),
(438, '2017-01-16 00:05:22', 1),
(439, '2017-01-16 00:06:03', 1),
(440, '2017-01-16 00:07:02', 1),
(441, '2017-01-16 00:08:33', 1),
(442, '2017-01-16 00:19:40', 1),
(443, '2017-01-16 00:22:28', 1),
(444, '2017-01-16 19:59:14', 1),
(445, '2017-01-16 20:02:56', 1),
(446, '2017-01-16 20:07:11', 1),
(447, '2017-01-16 20:08:04', 1),
(448, '2017-01-16 20:09:39', 1),
(449, '2017-01-16 20:10:53', 1),
(450, '2017-01-16 20:22:20', 1),
(451, '2017-01-16 20:24:04', 1),
(452, '2017-01-16 20:26:03', 1),
(453, '2017-01-16 20:27:36', 1),
(454, '2017-01-16 20:31:22', 1),
(455, '2017-01-16 20:31:27', 1),
(456, '2017-01-16 20:43:11', 1),
(457, '2017-01-16 22:03:31', 1),
(458, '2017-01-16 22:51:42', 1),
(459, '2017-01-16 22:52:25', 1),
(460, '2017-01-16 22:55:36', 1),
(461, '2017-01-16 22:59:43', 1),
(462, '2017-01-16 23:00:12', 1),
(463, '2017-01-16 23:15:25', 1),
(464, '2017-01-16 23:16:45', 1),
(465, '2017-01-16 23:17:19', 1),
(466, '2017-01-16 23:25:30', 1),
(467, '2017-01-16 23:30:21', 1),
(468, '2017-01-16 23:31:07', 1),
(469, '2017-01-16 23:33:58', 1),
(470, '2017-01-17 00:18:24', 1),
(471, '2017-01-17 00:19:04', 1),
(472, '2017-01-17 00:19:38', 1),
(473, '2017-01-17 10:48:46', 1),
(474, '2017-01-17 17:13:04', 1),
(475, '2017-01-17 17:14:28', 1),
(476, '2017-01-17 17:23:45', 1),
(477, '2017-01-17 17:28:49', 1),
(478, '2017-01-17 17:31:16', 1),
(479, '2017-01-17 17:34:04', 1),
(480, '2017-01-17 18:06:39', 1),
(481, '2017-01-17 18:09:41', 1),
(482, '2017-01-17 18:13:53', 1),
(483, '2017-01-17 18:14:58', 1),
(484, '2017-01-17 18:15:58', 1),
(485, '2017-01-17 18:17:04', 1),
(486, '2017-01-17 18:17:20', 1),
(487, '2017-01-17 18:17:46', 1),
(488, '2017-01-17 18:17:58', 1),
(489, '2017-01-17 18:18:35', 1),
(490, '2017-01-17 18:18:50', 1),
(491, '2017-01-17 18:20:37', 1),
(492, '2017-01-17 18:21:48', 1),
(493, '2017-01-17 18:22:32', 1),
(494, '2017-01-17 18:26:14', 1),
(495, '2017-01-17 19:27:43', 1),
(496, '2017-01-17 19:33:19', 1),
(497, '2017-01-17 19:50:55', 1),
(498, '2017-01-18 20:40:25', 1),
(499, '2017-01-18 20:44:49', 1),
(500, '2017-01-18 20:45:18', 1),
(501, '2017-01-18 20:45:47', 1),
(502, '2017-01-18 20:47:15', 1),
(503, '2017-01-18 20:47:20', 1),
(504, '2017-01-18 20:49:09', 1),
(505, '2017-01-18 20:51:50', 1),
(506, '2017-01-18 21:01:58', 1),
(507, '2017-01-18 21:02:17', 1),
(508, '2017-01-18 21:06:43', 1),
(509, '2017-01-18 21:09:35', 1),
(510, '2017-01-18 21:10:56', 1),
(511, '2017-01-18 21:14:15', 1),
(512, '2017-01-18 21:15:45', 1),
(513, '2017-01-18 21:32:20', 1),
(514, '2017-01-18 21:33:22', 1),
(515, '2017-01-18 21:33:43', 1),
(516, '2017-01-18 21:34:13', 1),
(517, '2017-01-18 21:34:39', 1),
(518, '2017-01-18 21:35:30', 1),
(519, '2017-01-18 21:35:48', 1),
(520, '2017-01-18 21:36:55', 1),
(521, '2017-01-18 21:46:28', 1),
(522, '2017-01-18 21:47:39', 1),
(523, '2017-01-18 21:51:59', 1),
(524, '2017-01-18 22:02:09', 1),
(525, '2017-01-18 22:07:42', 1),
(526, '2017-01-18 22:08:55', 1),
(527, '2017-01-18 22:12:03', 1),
(528, '2017-01-18 22:14:39', 1),
(529, '2017-01-18 22:14:54', 1),
(530, '2017-01-18 22:16:28', 1),
(531, '2017-01-18 22:19:55', 1),
(532, '2017-01-18 22:22:07', 1),
(533, '2017-01-18 22:23:13', 1),
(534, '2017-01-18 23:01:53', 1),
(535, '2017-01-18 23:09:02', 1),
(536, '2017-01-18 23:09:47', 1),
(537, '2017-01-18 23:11:13', 1),
(538, '2017-01-18 23:14:13', 1),
(539, '2017-01-18 23:15:17', 1),
(540, '2017-01-18 23:21:19', 1),
(541, '2017-01-18 23:23:36', 1),
(542, '2017-01-18 23:28:23', 1),
(543, '2017-01-18 23:30:06', 1),
(544, '2017-01-18 23:44:23', 1),
(545, '2017-01-18 23:45:11', 1),
(546, '2017-01-18 23:45:27', 1),
(547, '2017-01-18 23:45:55', 1),
(548, '2017-01-18 23:46:16', 1),
(549, '2017-01-18 23:46:40', 1),
(550, '2017-01-18 23:47:36', 1),
(551, '2017-01-19 00:21:26', 1),
(552, '2017-01-19 00:22:42', 1),
(553, '2017-01-19 00:23:23', 1),
(554, '2017-01-19 00:24:38', 1),
(555, '2017-01-19 00:25:31', 1),
(556, '2017-01-19 00:37:50', 1),
(557, '2017-01-19 00:49:19', 1),
(558, '2017-01-19 00:53:01', 1),
(559, '2017-01-19 00:55:05', 1),
(560, '2017-01-19 00:55:45', 1),
(561, '2017-01-19 00:56:22', 1),
(562, '2017-01-19 01:00:21', 1),
(563, '2017-01-19 01:02:54', 1),
(564, '2017-01-19 12:19:41', 1),
(565, '2017-01-19 20:07:31', 1),
(566, '2017-01-19 20:17:51', 1),
(567, '2017-01-19 20:21:19', 1),
(568, '2017-01-19 20:22:14', 1),
(569, '2017-01-19 20:25:27', 1),
(570, '2017-01-19 20:26:08', 1),
(571, '2017-01-19 20:26:30', 1),
(572, '2017-01-19 20:28:53', 1),
(573, '2017-01-19 20:33:06', 1),
(574, '2017-01-19 20:33:22', 1),
(575, '2017-01-19 20:33:51', 1),
(576, '2017-01-19 20:34:50', 1),
(577, '2017-01-19 20:35:38', 1),
(578, '2017-01-19 20:36:23', 1),
(579, '2017-01-19 20:39:12', 1),
(580, '2017-01-19 20:42:41', 1),
(581, '2017-01-19 20:44:02', 1),
(582, '2017-01-19 20:45:05', 1),
(583, '2017-01-19 20:45:28', 1),
(584, '2017-01-19 20:51:18', 1),
(585, '2017-01-19 20:53:25', 1),
(586, '2017-01-19 20:53:56', 1),
(587, '2017-01-19 21:00:24', 1),
(588, '2017-01-19 21:01:39', 1),
(589, '2017-01-19 21:02:58', 1),
(590, '2017-01-19 21:04:48', 1),
(591, '2017-01-19 21:06:23', 1),
(592, '2017-01-19 21:06:38', 1),
(593, '2017-01-19 21:07:00', 1),
(594, '2017-01-19 21:07:27', 1),
(595, '2017-01-19 21:18:26', 1),
(596, '2017-01-19 21:19:38', 1),
(597, '2017-01-19 21:49:11', 1),
(598, '2017-01-19 21:49:47', 1),
(599, '2017-01-19 21:50:46', 1),
(600, '2017-01-19 21:52:02', 1),
(601, '2017-01-19 21:55:10', 1),
(602, '2017-01-19 22:44:09', 1),
(603, '2017-01-19 23:40:33', 1),
(604, '2017-01-19 23:45:05', 1),
(605, '2017-01-19 23:49:26', 1),
(606, '2017-01-19 23:49:58', 1),
(607, '2017-01-19 23:50:26', 1),
(608, '2017-01-19 23:51:01', 1),
(609, '2017-01-19 23:51:46', 1),
(610, '2017-01-19 23:53:12', 1),
(611, '2017-01-19 23:55:02', 1),
(612, '2017-01-19 23:56:07', 1),
(613, '2017-01-19 23:56:51', 1),
(614, '2017-01-19 23:57:24', 1),
(615, '2017-01-20 00:12:48', 1),
(616, '2017-01-20 00:15:23', 1),
(617, '2017-01-20 00:16:45', 1),
(618, '2017-01-20 00:18:27', 1),
(619, '2017-01-20 00:19:33', 1),
(620, '2017-01-20 00:20:26', 1),
(621, '2017-01-20 00:24:59', 1),
(622, '2017-01-20 00:25:37', 1),
(623, '2017-01-20 00:26:27', 1),
(624, '2017-01-20 00:27:01', 1),
(625, '2017-01-20 00:28:58', 1),
(626, '2017-01-20 00:29:21', 1),
(627, '2017-01-20 00:30:03', 1),
(628, '2017-01-20 00:34:42', 1),
(629, '2017-01-20 00:45:01', 1),
(630, '2017-01-20 01:22:09', 1),
(631, '2017-01-20 01:22:28', 1),
(632, '2017-01-20 01:22:52', 1),
(633, '2017-01-20 01:25:45', 1),
(634, '2017-01-20 01:26:57', 1),
(635, '2017-01-20 01:31:35', 1),
(636, '2017-01-20 01:32:43', 1),
(637, '2017-01-20 01:35:09', 1),
(638, '2017-01-20 01:38:45', 1),
(639, '2017-01-20 01:39:27', 1),
(640, '2017-01-20 01:40:48', 1),
(641, '2017-01-20 08:31:06', 1),
(642, '2017-01-20 08:32:11', 1),
(643, '2017-01-20 17:26:49', 1),
(644, '2017-01-20 18:39:44', 1),
(645, '2017-01-20 18:47:21', 1),
(646, '2017-01-20 19:11:11', 1),
(647, '2017-01-20 19:11:30', 1),
(648, '2017-01-20 19:13:21', 1),
(649, '2017-01-20 19:14:49', 1),
(650, '2017-01-20 19:15:37', 1),
(651, '2017-01-20 19:15:55', 1),
(652, '2017-01-20 19:16:11', 1),
(653, '2017-01-20 19:25:45', 1),
(654, '2017-01-20 19:27:45', 1),
(655, '2017-01-20 19:32:12', 1),
(656, '2017-01-20 19:36:11', 1),
(657, '2017-01-20 19:42:48', 1),
(658, '2017-01-20 19:43:18', 1),
(659, '2017-01-20 19:43:50', 1),
(660, '2017-01-20 19:44:58', 1),
(661, '2017-01-20 19:45:31', 1),
(662, '2017-01-20 19:46:23', 1),
(663, '2017-01-20 20:02:11', 1),
(664, '2017-01-20 20:03:00', 1),
(665, '2017-01-20 20:10:12', 1),
(666, '2017-01-20 20:16:49', 1),
(667, '2017-01-20 20:17:25', 1),
(668, '2017-01-20 20:18:23', 1),
(669, '2017-01-20 20:20:48', 1),
(670, '2017-01-20 20:21:34', 1),
(671, '2017-01-20 20:24:36', 1),
(672, '2017-01-20 20:25:53', 1),
(673, '2017-01-20 20:27:38', 1),
(674, '2017-01-20 20:28:34', 1),
(675, '2017-01-20 20:44:32', 1),
(676, '2017-01-20 20:50:25', 1),
(677, '2017-01-20 20:51:20', 1),
(678, '2017-01-20 20:55:08', 1),
(679, '2017-01-20 20:57:03', 1),
(680, '2017-01-20 20:57:26', 1),
(681, '2017-01-20 20:58:25', 1),
(682, '2017-01-20 21:00:32', 1),
(683, '2017-01-20 21:05:50', 1),
(684, '2017-01-20 21:09:33', 1),
(685, '2017-01-20 21:13:33', 1),
(686, '2017-01-20 21:14:00', 1),
(687, '2017-01-20 21:15:18', 1),
(688, '2017-01-20 21:18:42', 1),
(689, '2017-01-20 21:18:52', 1),
(690, '2017-01-20 21:23:11', 1),
(691, '2017-01-20 21:24:21', 1),
(692, '2017-01-20 21:26:55', 1),
(693, '2017-01-20 21:27:46', 1),
(694, '2017-01-20 21:31:20', 1),
(695, '2017-01-20 21:33:23', 1),
(696, '2017-01-20 21:34:06', 1),
(697, '2017-01-20 21:37:36', 1),
(698, '2017-01-20 21:41:20', 1),
(699, '2017-01-20 21:42:07', 1),
(700, '2017-01-20 21:43:31', 1),
(701, '2017-01-21 07:40:28', 1),
(702, '2017-01-21 07:54:05', 1),
(703, '2017-01-21 08:02:22', 1),
(704, '2017-01-21 08:17:27', 1),
(705, '2017-01-21 08:19:42', 1),
(706, '2017-01-21 08:20:16', 1),
(707, '2017-01-21 08:22:20', 1),
(708, '2017-01-21 08:23:21', 1),
(709, '2017-01-21 08:24:54', 1),
(710, '2017-01-21 08:25:02', 1),
(711, '2017-01-21 08:25:34', 1),
(712, '2017-01-21 08:37:12', 1),
(713, '2017-01-21 08:38:49', 1),
(714, '2017-01-21 08:40:53', 1),
(715, '2017-01-21 08:58:00', 1),
(716, '2017-01-21 09:00:40', 1),
(717, '2017-01-21 09:01:45', 1),
(718, '2017-01-21 09:02:43', 1),
(719, '2017-01-21 09:13:52', 1),
(720, '2017-01-21 09:31:50', 1),
(721, '2017-01-21 09:32:26', 1),
(722, '2017-01-21 09:35:04', 1),
(723, '2017-01-21 09:36:07', 1),
(724, '2017-01-21 09:37:39', 1),
(725, '2017-01-21 09:40:53', 1),
(726, '2017-01-21 09:41:41', 1),
(727, '2017-01-21 09:42:02', 1),
(728, '2017-01-21 09:43:58', 1),
(729, '2017-01-21 09:44:14', 1),
(730, '2017-01-21 09:45:56', 1),
(731, '2017-01-21 09:53:48', 1),
(732, '2017-01-21 09:54:47', 1),
(733, '2017-01-21 09:55:46', 1),
(734, '2017-01-21 09:57:57', 1),
(735, '2017-01-21 09:59:16', 1),
(736, '2017-01-21 09:59:55', 1),
(737, '2017-01-21 10:02:04', 1),
(738, '2017-01-21 10:04:14', 1),
(739, '2017-01-21 10:17:08', 1),
(740, '2017-01-21 10:18:43', 1),
(741, '2017-01-21 10:20:50', 1),
(742, '2017-01-21 10:21:02', 1),
(743, '2017-01-21 10:21:17', 1),
(744, '2017-01-21 10:22:25', 1),
(745, '2017-01-21 10:23:46', 1),
(746, '2017-01-21 12:23:51', 1),
(747, '2017-01-21 12:32:40', 1),
(748, '2017-01-21 12:32:46', 1),
(749, '2017-01-21 12:36:59', 1),
(750, '2017-01-21 12:38:47', 1),
(751, '2017-01-21 12:40:03', 1),
(752, '2017-01-21 12:45:25', 1),
(753, '2017-01-21 12:56:18', 1),
(754, '2017-01-21 13:09:17', 1),
(755, '2017-01-22 17:19:32', 1),
(756, '2017-01-22 18:14:53', 1),
(757, '2017-01-22 18:17:33', 1),
(758, '2017-01-22 18:18:07', 1),
(759, '2017-01-22 18:39:01', 1),
(760, '2017-01-22 18:40:59', 1),
(761, '2017-01-22 18:57:05', 1),
(762, '2017-01-22 18:58:26', 1),
(763, '2017-01-22 18:58:58', 1),
(764, '2017-01-22 18:59:38', 1),
(765, '2017-01-22 19:31:04', 1),
(766, '2017-01-22 19:36:10', 1),
(767, '2017-01-22 19:44:48', 1),
(768, '2017-01-22 19:45:51', 1),
(769, '2017-01-22 19:58:47', 1),
(770, '2017-01-22 19:59:49', 1),
(771, '2017-01-22 20:01:22', 1),
(772, '2017-01-22 20:27:45', 1),
(773, '2017-01-22 20:30:03', 1),
(774, '2017-01-22 20:34:51', 1),
(775, '2017-01-22 20:46:09', 1),
(776, '2017-01-22 21:18:15', 1),
(777, '2017-01-22 21:19:05', 1),
(778, '2017-01-22 21:19:09', 1),
(779, '2017-01-22 21:37:35', 1),
(780, '2017-01-22 21:38:17', 1),
(781, '2017-01-22 21:41:44', 1),
(782, '2017-01-22 21:42:06', 1),
(783, '2017-01-22 21:43:36', 1),
(784, '2017-01-22 21:45:12', 1),
(785, '2017-01-22 21:52:14', 1),
(786, '2017-01-22 21:53:30', 1),
(787, '2017-01-22 21:54:57', 1),
(788, '2017-01-22 22:11:35', 1),
(789, '2017-01-22 22:11:57', 1),
(790, '2017-01-22 22:15:44', 1),
(791, '2017-01-22 22:19:13', 1),
(792, '2017-01-22 22:20:05', 1),
(793, '2017-01-22 22:21:40', 1),
(794, '2017-01-22 22:22:35', 1),
(795, '2017-01-22 22:25:16', 1),
(796, '2017-01-22 22:52:22', 1),
(797, '2017-01-22 22:53:50', 1),
(798, '2017-01-22 22:55:12', 1),
(799, '2017-01-22 22:55:44', 1),
(800, '2017-01-22 22:58:29', 1),
(801, '2017-01-22 23:01:51', 1),
(802, '2017-01-22 23:02:16', 1),
(803, '2017-01-22 23:02:35', 1),
(804, '2017-01-22 23:37:36', 1),
(805, '2017-01-22 23:38:08', 1),
(806, '2017-01-22 23:50:17', 1),
(807, '2017-01-22 23:51:55', 1),
(808, '2017-01-23 00:02:27', 1),
(809, '2017-01-23 00:05:26', 1),
(810, '2017-01-23 00:08:58', 1),
(811, '2017-01-23 00:13:18', 1),
(812, '2017-01-23 00:15:56', 1),
(813, '2017-01-23 00:16:32', 1),
(814, '2017-01-23 00:26:22', 1),
(815, '2017-01-23 00:27:11', 1),
(816, '2017-01-23 00:27:26', 1),
(817, '2017-01-23 00:28:08', 1),
(818, '2017-01-23 00:33:18', 1),
(819, '2017-01-23 00:34:33', 1),
(820, '2017-01-23 00:53:01', 1),
(821, '2017-01-23 00:53:29', 1),
(822, '2017-01-23 01:00:27', 1),
(823, '2017-01-23 01:03:58', 1),
(824, '2017-01-23 01:16:26', 1),
(825, '2017-01-23 01:17:50', 1),
(826, '2017-01-23 01:19:37', 1),
(827, '2017-01-23 01:21:09', 1),
(828, '2017-01-23 01:38:59', 1),
(829, '2017-01-23 01:42:51', 1),
(830, '2017-01-23 02:12:05', 1),
(831, '2017-01-23 02:24:24', 1),
(832, '2017-01-24 17:50:27', 1),
(833, '2017-01-24 20:40:31', 1),
(834, '2017-01-26 16:18:19', 1),
(835, '2017-01-26 18:16:28', 1),
(836, '2017-01-26 18:19:38', 1),
(837, '2017-01-26 18:23:15', 1),
(838, '2017-01-26 18:24:41', 1),
(839, '2017-01-27 06:59:40', 1),
(840, '2017-01-27 18:38:56', 1),
(841, '2017-01-27 18:59:08', 1),
(842, '2017-01-28 14:20:01', 1),
(843, '2017-01-28 15:54:12', 1),
(844, '2017-01-28 15:56:54', 1),
(845, '2017-01-28 15:58:45', 1),
(846, '2017-01-28 16:03:02', 1),
(847, '2017-01-28 16:06:34', 1),
(848, '2017-01-28 16:11:13', 1),
(849, '2017-01-28 16:11:49', 1),
(850, '2017-01-28 23:38:22', 1),
(851, '2017-01-29 01:29:35', 1),
(852, '2017-01-29 01:33:15', 1),
(853, '2017-01-29 20:17:50', 1),
(854, '2017-01-29 21:02:39', 1),
(855, '2017-01-29 21:14:08', 1),
(856, '2017-01-29 22:15:25', 1),
(857, '2017-01-29 22:22:26', 1),
(858, '2017-01-29 22:27:28', 1),
(859, '2017-01-29 22:37:48', 1),
(860, '2017-01-29 23:02:56', 1),
(861, '2017-01-29 23:13:35', 1),
(862, '2017-01-29 23:24:55', 1),
(863, '2017-01-29 23:34:22', 1),
(864, '2017-01-29 23:34:28', 1),
(865, '2017-01-29 23:36:37', 1),
(866, '2017-01-29 23:48:36', 1),
(867, '2017-01-29 23:57:47', 1),
(868, '2017-01-30 00:03:36', 1),
(869, '2017-01-30 00:04:15', 1),
(870, '2017-01-30 00:05:01', 1),
(871, '2017-01-30 00:07:57', 1),
(872, '2017-01-30 00:14:29', 1),
(873, '2017-01-30 00:15:36', 1),
(874, '2017-01-30 00:21:11', 1),
(875, '2017-01-30 00:23:34', 1),
(876, '2017-01-30 00:24:44', 1),
(877, '2017-01-30 00:24:56', 1),
(878, '2017-01-30 00:26:11', 1),
(879, '2017-01-30 00:35:56', 1),
(880, '2017-01-30 00:36:23', 1),
(881, '2017-01-30 00:36:48', 1),
(882, '2017-01-30 00:38:15', 1),
(883, '2017-01-30 00:39:45', 1),
(884, '2017-01-30 00:42:41', 1),
(885, '2017-01-30 00:42:47', 1),
(886, '2017-01-30 00:53:28', 1),
(887, '2017-01-30 11:04:55', 1),
(888, '2017-01-30 14:38:55', 1),
(889, '2017-01-30 15:10:12', 1),
(890, '2017-01-30 15:15:14', 1),
(891, '2017-01-30 15:15:58', 1),
(892, '2017-01-30 16:07:52', 1),
(893, '2017-01-30 19:13:35', 1),
(894, '2017-01-30 19:32:47', 1),
(895, '2017-01-30 19:57:31', 1),
(896, '2017-01-30 20:01:15', 1),
(897, '2017-01-30 20:11:09', 1),
(898, '2017-01-30 20:14:27', 1),
(899, '2017-01-30 20:17:35', 1),
(900, '2017-01-30 20:19:01', 1),
(901, '2017-01-30 20:27:55', 1),
(902, '2017-01-30 20:31:13', 1),
(903, '2017-01-30 20:31:49', 1),
(904, '2017-01-30 20:35:11', 1),
(905, '2017-01-30 20:35:47', 1),
(906, '2017-01-30 20:42:14', 1),
(907, '2017-01-30 20:43:12', 1),
(908, '2017-01-30 21:51:16', 1),
(909, '2017-01-30 21:56:31', 1),
(910, '2017-01-30 22:05:22', 1),
(911, '2017-01-30 22:11:12', 1),
(912, '2017-01-30 22:12:02', 1),
(913, '2017-01-30 22:14:24', 1),
(914, '2017-01-30 22:49:44', 1),
(915, '2017-01-30 22:58:23', 1),
(916, '2017-01-30 22:59:03', 1),
(917, '2017-01-30 22:59:39', 1),
(918, '2017-01-30 23:01:11', 1),
(919, '2017-01-30 23:02:20', 1),
(920, '2017-01-30 23:02:47', 1),
(921, '2017-01-30 23:03:51', 1),
(922, '2017-01-30 23:03:56', 1),
(923, '2017-01-30 23:05:01', 1),
(924, '2017-01-30 23:06:43', 1),
(925, '2017-01-30 23:08:56', 1),
(926, '2017-01-30 23:13:30', 1),
(927, '2017-01-30 23:18:18', 1),
(928, '2017-01-30 23:23:11', 1),
(929, '2017-01-30 23:30:23', 1),
(930, '2017-01-30 23:30:34', 1),
(931, '2017-01-30 23:52:36', 1),
(932, '2017-01-30 23:53:10', 1),
(933, '2017-01-30 23:53:42', 1),
(934, '2017-01-31 00:14:49', 1),
(935, '2017-01-31 00:34:16', 1),
(936, '2017-01-31 10:36:05', 1),
(937, '2017-01-31 17:07:00', 1),
(938, '2017-01-31 17:08:20', 1),
(939, '2017-01-31 21:32:43', 1),
(940, '2017-01-31 22:14:21', 1),
(941, '2017-01-31 22:15:41', 1),
(942, '2017-01-31 22:26:56', 1),
(943, '2017-01-31 22:28:23', 1),
(944, '2017-01-31 22:28:32', 1),
(945, '2017-01-31 22:29:48', 1),
(946, '2017-01-31 22:31:14', 1),
(947, '2017-01-31 22:33:30', 1),
(948, '2017-01-31 22:34:04', 1),
(949, '2017-01-31 22:35:47', 1),
(950, '2017-01-31 22:38:29', 1),
(951, '2017-01-31 22:38:52', 1),
(952, '2017-01-31 22:39:47', 1),
(953, '2017-01-31 22:40:08', 1),
(954, '2017-01-31 22:40:23', 1),
(955, '2017-01-31 22:41:24', 1),
(956, '2017-01-31 22:43:32', 1),
(957, '2017-01-31 22:45:25', 1),
(958, '2017-01-31 22:48:08', 1),
(959, '2017-01-31 22:48:40', 1),
(960, '2017-01-31 22:52:29', 1),
(961, '2017-01-31 22:53:12', 1),
(962, '2017-01-31 22:53:51', 1),
(963, '2017-01-31 22:55:45', 1),
(964, '2017-01-31 22:55:54', 1),
(965, '2017-01-31 23:00:05', 1),
(966, '2017-01-31 23:07:06', 1),
(967, '2017-01-31 23:16:45', 1),
(968, '2017-01-31 23:17:13', 1),
(969, '2017-01-31 23:24:31', 1),
(970, '2017-01-31 23:24:39', 1),
(971, '2017-01-31 23:50:38', 1),
(972, '2017-01-31 23:58:33', 1),
(973, '2017-02-01 00:03:27', 1),
(974, '2017-02-01 00:25:48', 1),
(975, '2017-02-01 00:30:43', 1),
(976, '2017-02-01 00:46:15', 1),
(977, '2017-02-01 00:48:08', 1),
(978, '2017-02-01 09:47:59', 1),
(979, '2017-02-01 09:53:25', 1),
(980, '2017-02-01 09:54:47', 1),
(981, '2017-02-01 10:02:39', 1),
(982, '2017-02-01 10:28:06', 1),
(983, '2017-02-01 10:29:21', 1),
(984, '2017-02-01 10:48:26', 1),
(985, '2017-02-01 11:08:01', 1),
(986, '2017-02-01 11:09:36', 1),
(987, '2017-02-01 11:13:53', 1),
(988, '2017-02-01 11:14:23', 1),
(989, '2017-02-01 11:15:27', 1),
(990, '2017-02-01 11:23:04', 1),
(991, '2017-02-01 11:25:45', 1),
(992, '2017-02-01 11:37:56', 1),
(993, '2017-02-01 11:38:39', 1),
(994, '2017-02-01 11:49:22', 1),
(995, '2017-02-01 11:53:31', 1),
(996, '2017-02-01 13:42:34', 1),
(997, '2017-02-01 13:49:02', 1),
(998, '2017-02-01 13:50:26', 1),
(999, '2017-02-01 13:51:45', 1),
(1000, '2017-02-01 13:55:37', 1),
(1001, '2017-02-01 13:56:59', 1),
(1002, '2017-02-01 13:57:52', 1),
(1003, '2017-02-01 14:02:28', 1),
(1004, '2017-02-01 14:04:28', 1),
(1005, '2017-02-01 14:08:07', 1),
(1006, '2017-02-01 14:21:34', 1),
(1007, '2017-02-01 14:24:58', 1),
(1008, '2017-02-01 14:30:56', 1),
(1009, '2017-02-01 14:36:20', 1),
(1010, '2017-02-01 14:37:15', 1),
(1011, '2017-02-01 15:08:44', 1),
(1012, '2017-02-01 15:11:27', 1),
(1013, '2017-02-01 15:13:38', 1),
(1014, '2017-02-01 15:19:42', 1),
(1015, '2017-02-01 15:22:28', 1),
(1016, '2017-02-01 15:35:04', 1),
(1017, '2017-02-01 15:38:55', 1),
(1018, '2017-02-01 15:49:15', 1),
(1019, '2017-02-01 15:52:53', 1),
(1020, '2017-02-01 15:54:13', 1),
(1021, '2017-02-01 16:04:15', 1),
(1022, '2017-02-01 16:20:09', 1),
(1023, '2017-02-01 16:28:20', 1),
(1024, '2017-02-01 18:01:39', 1),
(1025, '2017-02-01 18:03:26', 1),
(1026, '2017-02-01 19:41:20', 1),
(1027, '2017-02-01 19:45:37', 1),
(1028, '2017-02-01 19:53:45', 1),
(1029, '2017-02-01 19:55:04', 1),
(1030, '2017-02-01 20:02:25', 1),
(1031, '2017-02-01 20:10:09', 1),
(1032, '2017-02-01 20:15:35', 1),
(1033, '2017-02-01 20:24:17', 1),
(1034, '2017-02-01 20:24:46', 1),
(1035, '2017-02-01 20:25:37', 1),
(1036, '2017-02-01 20:26:25', 1),
(1037, '2017-02-01 20:26:56', 1),
(1038, '2017-02-01 20:58:13', 1),
(1039, '2017-02-01 21:02:42', 1),
(1040, '2017-02-01 21:06:38', 1),
(1041, '2017-02-01 21:07:43', 1),
(1042, '2017-02-01 21:24:30', 1),
(1043, '2017-02-01 21:56:37', 1),
(1044, '2017-02-01 22:17:30', 1),
(1045, '2017-02-01 22:20:31', 1),
(1046, '2017-02-01 22:36:02', 1),
(1047, '2017-02-01 22:38:27', 1),
(1048, '2017-02-01 22:39:42', 1),
(1049, '2017-02-01 22:43:39', 1),
(1050, '2017-02-01 23:26:30', 1),
(1051, '2017-02-01 23:28:47', 1),
(1052, '2017-02-01 23:31:11', 1),
(1053, '2017-02-01 23:37:26', 1),
(1054, '2017-02-01 23:38:23', 1),
(1055, '2017-02-01 23:38:41', 1),
(1056, '2017-02-01 23:44:15', 1),
(1057, '2017-02-01 23:54:43', 1),
(1058, '2017-02-01 23:58:30', 1),
(1059, '2017-02-02 00:01:11', 1),
(1060, '2017-02-02 00:05:51', 1),
(1061, '2017-02-02 00:09:34', 1),
(1062, '2017-02-02 00:10:37', 1),
(1063, '2017-02-02 00:17:37', 1),
(1064, '2017-02-02 00:18:50', 1),
(1065, '2017-02-02 00:22:32', 1),
(1066, '2017-02-02 00:25:08', 1),
(1067, '2017-02-02 00:26:08', 1),
(1068, '2017-02-02 00:27:51', 1),
(1069, '2017-02-02 00:40:09', 1),
(1070, '2017-02-02 00:41:23', 1),
(1071, '2017-02-02 00:46:51', 1),
(1072, '2017-02-02 00:56:28', 1),
(1073, '2017-02-02 00:58:38', 1),
(1074, '2017-02-02 01:02:35', 1),
(1075, '2017-02-02 01:02:50', 1),
(1076, '2017-02-02 12:30:00', 1),
(1077, '2017-02-02 13:36:39', 1),
(1078, '2017-02-02 17:08:55', 1),
(1079, '2017-02-02 17:28:20', 1),
(1080, '2017-02-02 18:10:06', 1),
(1081, '2017-02-02 18:52:16', 1),
(1082, '2017-02-02 19:02:23', 1),
(1083, '2017-02-02 19:03:26', 1),
(1084, '2017-02-02 19:06:06', 1),
(1085, '2017-02-02 19:06:28', 1),
(1086, '2017-02-02 19:12:34', 1),
(1087, '2017-02-02 19:14:24', 1),
(1088, '2017-02-02 19:16:13', 1),
(1089, '2017-02-02 19:21:37', 1),
(1090, '2017-02-02 19:24:35', 1),
(1091, '2017-02-02 19:25:39', 1),
(1092, '2017-02-02 22:45:17', 1),
(1093, '2017-02-02 23:32:58', 1),
(1094, '2017-02-03 00:19:30', 1),
(1095, '2017-02-03 00:19:46', 1),
(1096, '2017-02-03 00:23:04', 1),
(1097, '2017-02-03 00:24:56', 1),
(1098, '2017-02-03 00:25:18', 1),
(1099, '2017-02-03 00:30:41', 1),
(1100, '2017-02-03 00:38:56', 1),
(1101, '2017-02-03 00:39:43', 1),
(1102, '2017-02-03 00:42:09', 1),
(1103, '2017-02-03 00:50:41', 1),
(1104, '2017-02-03 02:02:45', 1),
(1105, '2017-02-03 02:21:54', 1),
(1106, '2017-02-03 02:22:52', 1),
(1107, '2017-02-03 02:28:20', 1),
(1108, '2017-02-03 02:31:58', 1),
(1109, '2017-02-03 02:34:01', 1),
(1110, '2017-02-03 02:38:44', 1),
(1111, '2017-02-03 02:40:45', 1),
(1112, '2017-02-03 02:41:43', 1),
(1113, '2017-02-03 02:50:28', 1),
(1114, '2017-02-03 10:35:22', 1),
(1115, '2017-02-03 19:20:36', 1),
(1116, '2017-02-03 20:26:53', 1),
(1117, '2017-02-03 20:32:06', 1),
(1118, '2017-02-04 13:47:18', 1),
(1119, '2017-02-04 17:00:03', 1),
(1120, '2017-02-04 17:31:09', 1),
(1121, '2017-02-04 17:57:21', 1),
(1122, '2017-02-04 19:37:25', 1),
(1123, '2017-02-04 19:43:32', 1),
(1124, '2017-02-04 19:50:21', 1),
(1125, '2017-02-04 20:00:09', 1),
(1126, '2017-02-04 20:15:31', 1),
(1127, '2017-02-05 13:28:42', 1),
(1128, '2017-02-05 13:34:00', 1),
(1129, '2017-02-05 13:34:26', 1),
(1130, '2017-02-05 14:05:18', 1),
(1131, '2017-02-05 14:19:34', 1),
(1132, '2017-02-05 14:29:08', 1),
(1133, '2017-02-05 14:33:47', 1),
(1134, '2017-02-05 14:50:15', 1),
(1135, '2017-02-05 14:59:23', 1),
(1136, '2017-02-05 15:05:23', 1),
(1137, '2017-02-05 15:12:34', 1),
(1138, '2017-02-05 16:06:27', 1),
(1139, '2017-02-05 16:23:43', 1),
(1140, '2017-02-05 16:25:03', 1),
(1141, '2017-02-05 16:27:58', 1),
(1142, '2017-02-05 16:40:15', 1),
(1143, '2017-02-05 17:01:29', 1),
(1144, '2017-02-05 19:36:46', 1),
(1145, '2017-02-05 20:05:02', 1),
(1146, '2017-02-07 10:53:58', 1),
(1147, '2017-02-07 18:11:44', 1),
(1148, '2017-02-07 21:48:15', 1),
(1149, '2017-02-07 21:58:54', 1),
(1150, '2017-02-07 21:59:29', 1),
(1151, '2017-02-07 22:08:27', 1),
(1152, '2017-02-07 22:09:21', 1),
(1153, '2017-02-07 22:10:32', 1),
(1154, '2017-02-07 22:13:44', 1),
(1155, '2017-02-07 22:16:13', 1),
(1156, '2017-02-07 22:16:21', 1),
(1157, '2017-02-07 22:27:01', 1),
(1158, '2017-02-07 22:32:10', 1),
(1159, '2017-02-07 22:34:40', 1),
(1160, '2017-02-07 22:37:35', 1),
(1161, '2017-02-07 22:50:27', 1),
(1162, '2017-02-07 22:52:45', 1),
(1163, '2017-02-07 22:55:26', 1),
(1164, '2017-02-07 23:08:22', 1),
(1165, '2017-02-07 23:10:23', 1),
(1166, '2017-02-07 23:22:14', 1),
(1167, '2017-02-07 23:22:54', 1),
(1168, '2017-02-07 23:26:05', 1),
(1169, '2017-02-07 23:27:49', 1),
(1170, '2017-02-07 23:34:37', 1),
(1171, '2017-02-07 23:46:12', 1),
(1172, '2017-02-07 23:49:58', 1),
(1173, '2017-02-07 23:54:54', 1),
(1174, '2017-02-07 23:57:57', 1),
(1175, '2017-02-08 00:00:13', 1),
(1176, '2017-02-08 10:14:18', 1),
(1177, '2017-02-08 11:30:56', 1),
(1178, '2017-02-08 12:05:02', 1),
(1179, '2017-02-08 12:12:47', 1),
(1180, '2017-02-08 12:13:16', 1),
(1181, '2017-02-08 12:16:16', 1),
(1182, '2017-02-08 12:24:48', 1),
(1183, '2017-02-08 12:27:32', 1),
(1184, '2017-02-08 12:30:19', 1),
(1185, '2017-02-08 12:31:53', 1),
(1186, '2017-02-08 12:32:34', 1),
(1187, '2017-02-08 12:32:55', 1),
(1188, '2017-02-08 12:33:36', 1),
(1189, '2017-02-08 12:34:46', 1),
(1190, '2017-02-08 12:39:20', 1),
(1191, '2017-02-08 12:54:40', 1),
(1192, '2017-02-08 13:55:21', 1),
(1193, '2017-02-08 13:57:04', 1),
(1194, '2017-02-08 13:57:08', 1),
(1195, '2017-02-08 13:57:46', 1),
(1196, '2017-02-08 13:57:50', 1),
(1197, '2017-02-08 13:59:56', 1),
(1198, '2017-02-08 14:39:57', 1),
(1199, '2017-02-08 17:55:35', 1),
(1200, '2017-02-08 18:15:14', 1),
(1201, '2017-02-08 18:25:45', 1),
(1202, '2017-02-08 18:27:37', 1),
(1203, '2017-02-08 18:33:10', 1),
(1204, '2017-02-08 18:33:28', 1),
(1205, '2017-02-08 19:41:31', 1),
(1206, '2017-02-08 20:07:18', 1),
(1207, '2017-02-08 20:08:59', 1),
(1208, '2017-02-08 20:12:55', 1),
(1209, '2017-02-08 23:44:04', 1),
(1210, '2017-02-10 20:05:50', 1),
(1211, '2017-02-10 20:09:08', 1),
(1212, '2017-02-10 20:15:29', 1),
(1213, '2017-02-10 20:15:57', 1),
(1214, '2017-02-10 20:17:09', 1),
(1215, '2017-02-10 20:17:10', 1),
(1216, '2017-02-10 20:30:34', 1),
(1217, '2017-02-11 08:31:31', 1),
(1218, '2017-02-11 08:35:15', 1),
(1219, '2017-02-11 08:41:25', 1),
(1220, '2017-02-11 08:44:01', 1),
(1221, '2017-02-11 08:45:19', 1),
(1222, '2017-02-11 08:47:06', 1),
(1223, '2017-02-11 08:47:16', 1),
(1224, '2017-02-11 08:53:26', 1),
(1225, '2017-02-11 08:53:54', 1),
(1226, '2017-02-11 08:55:12', 1),
(1227, '2017-02-11 09:01:14', 1),
(1228, '2017-02-11 09:02:14', 1),
(1229, '2017-02-11 09:07:01', 1),
(1230, '2017-02-11 09:10:24', 1),
(1231, '2017-02-11 09:11:43', 1),
(1232, '2017-02-11 09:14:21', 1),
(1233, '2017-02-11 09:16:06', 1),
(1234, '2017-02-11 09:17:54', 1),
(1235, '2017-02-11 09:21:58', 1),
(1236, '2017-02-11 09:22:19', 1),
(1237, '2017-02-11 09:22:42', 1),
(1238, '2017-02-11 09:24:04', 1),
(1239, '2017-02-11 09:26:30', 1),
(1240, '2017-02-11 09:28:02', 1),
(1241, '2017-02-11 09:30:51', 1),
(1242, '2017-02-11 09:31:36', 1),
(1243, '2017-02-11 09:36:53', 1),
(1244, '2017-02-11 09:39:07', 1),
(1245, '2017-02-11 09:42:58', 1),
(1246, '2017-02-11 09:44:00', 1),
(1247, '2017-02-11 10:58:45', 1),
(1248, '2017-02-11 11:15:45', 1),
(1249, '2017-02-11 11:17:24', 1),
(1250, '2017-02-11 11:18:32', 1),
(1251, '2017-02-11 11:21:04', 1),
(1252, '2017-02-11 11:21:55', 1),
(1253, '2017-02-11 11:27:28', 1),
(1254, '2017-02-11 11:28:12', 1),
(1255, '2017-02-11 11:32:28', 1),
(1256, '2017-02-11 11:34:50', 1),
(1257, '2017-02-11 11:37:04', 1),
(1258, '2017-02-11 11:39:50', 1),
(1259, '2017-02-11 11:40:57', 1),
(1260, '2017-02-11 11:45:17', 1),
(1261, '2017-02-11 11:53:44', 1),
(1262, '2017-02-11 11:55:25', 1),
(1263, '2017-02-11 12:00:52', 1),
(1264, '2017-02-11 12:03:28', 1),
(1265, '2017-02-11 12:05:26', 1),
(1266, '2017-02-11 12:07:29', 1),
(1267, '2017-02-11 12:11:57', 1),
(1268, '2017-02-11 12:39:10', 1),
(1269, '2017-02-11 12:54:08', 1),
(1270, '2017-02-11 14:18:48', 1),
(1271, '2017-02-11 14:23:23', 1),
(1272, '2017-02-12 22:44:55', 1),
(1273, '2017-02-12 23:40:15', 1),
(1274, '2017-02-13 10:27:19', 1),
(1275, '2017-02-13 12:23:39', 1),
(1276, '2017-02-14 17:26:18', 1),
(1277, '2017-02-14 17:37:54', 1),
(1278, '2017-02-14 18:10:15', 1),
(1279, '2017-02-14 18:32:02', 1),
(1280, '2017-02-14 18:32:42', 1),
(1281, '2017-02-14 18:33:13', 1),
(1282, '2017-02-14 18:35:49', 1),
(1283, '2017-02-14 18:38:11', 1),
(1284, '2017-02-14 18:38:18', 1),
(1285, '2017-02-14 18:39:52', 1),
(1286, '2017-02-14 19:44:41', 1),
(1287, '2017-02-14 20:09:01', 1),
(1288, '2017-02-14 20:13:23', 1),
(1289, '2017-02-14 20:28:06', 1),
(1290, '2017-02-14 20:37:30', 1),
(1291, '2017-02-14 20:38:55', 1),
(1292, '2017-02-14 20:43:49', 1),
(1293, '2017-02-14 21:07:11', 1),
(1294, '2017-02-14 23:03:03', 1),
(1295, '2017-02-14 23:11:02', 1),
(1296, '2017-02-14 23:11:57', 1),
(1297, '2017-02-14 23:20:56', 1),
(1298, '2017-02-14 23:22:45', 1),
(1299, '2017-02-14 23:25:15', 1),
(1300, '2017-02-14 23:26:33', 1),
(1301, '2017-02-14 23:27:12', 1),
(1302, '2017-02-14 23:38:28', 1),
(1303, '2017-02-14 23:53:37', 1),
(1304, '2017-02-14 23:58:46', 1),
(1305, '2017-02-14 23:59:57', 1),
(1306, '2017-02-15 00:02:10', 1),
(1307, '2017-02-15 00:03:42', 1),
(1308, '2017-02-15 00:05:05', 1),
(1309, '2017-02-15 00:06:46', 1),
(1310, '2017-02-15 00:08:04', 1),
(1311, '2017-02-15 13:42:49', 1),
(1312, '2017-02-15 20:07:10', 1),
(1313, '2017-02-15 22:49:38', 1),
(1314, '2017-02-15 22:58:00', 1),
(1315, '2017-02-15 23:01:37', 1),
(1316, '2017-02-16 00:16:51', 1),
(1317, '2017-02-16 00:17:21', 1),
(1318, '2017-02-16 00:26:27', 1),
(1319, '2017-02-16 00:29:53', 1),
(1320, '2017-02-16 00:31:28', 1),
(1321, '2017-02-16 00:32:31', 1),
(1322, '2017-02-16 00:34:29', 1),
(1323, '2017-02-16 01:10:34', 1),
(1324, '2017-02-16 01:12:31', 1),
(1325, '2017-02-16 01:13:09', 1),
(1326, '2017-02-16 12:36:54', 1),
(1327, '2017-02-16 14:00:25', 1),
(1328, '2017-02-16 16:28:57', 1),
(1329, '2017-02-16 16:49:04', 1),
(1330, '2017-02-16 17:08:13', 1),
(1331, '2017-02-16 17:13:19', 1),
(1332, '2017-02-16 18:57:30', 1),
(1333, '2017-02-16 19:46:22', 1),
(1334, '2017-02-20 09:25:46', 1),
(1335, '2017-02-20 21:26:47', 1),
(1336, '2017-02-20 22:02:01', 1),
(1337, '2017-02-20 22:05:41', 1),
(1338, '2017-02-20 22:09:40', 1),
(1339, '2017-02-20 22:10:41', 1),
(1340, '2017-02-20 22:23:40', 1),
(1341, '2017-02-20 22:24:35', 1),
(1342, '2017-02-20 22:33:28', 1),
(1343, '2017-02-20 22:36:30', 1),
(1344, '2017-02-20 22:39:30', 1),
(1345, '2017-02-20 22:40:45', 1),
(1346, '2017-02-20 23:16:46', 1),
(1347, '2017-02-20 23:18:33', 1),
(1348, '2017-02-20 23:25:11', 1),
(1349, '2017-02-20 23:28:24', 1),
(1350, '2017-02-20 23:29:23', 1),
(1351, '2017-02-20 23:34:50', 1),
(1352, '2017-02-20 23:40:43', 1),
(1353, '2017-02-20 23:42:04', 1),
(1354, '2017-02-20 23:53:18', 1),
(1355, '2017-02-20 23:54:27', 1),
(1356, '2017-02-21 07:46:10', 1),
(1357, '2017-02-21 19:02:29', 1),
(1358, '2017-02-21 19:26:22', 1),
(1359, '2017-02-21 19:29:30', 1),
(1360, '2017-02-21 19:42:42', 1),
(1361, '2017-02-21 19:46:19', 1),
(1362, '2017-02-21 19:46:38', 1),
(1363, '2017-02-21 20:04:17', 1),
(1364, '2017-02-21 20:04:25', 1),
(1365, '2017-02-21 20:07:35', 1),
(1366, '2017-02-21 20:09:42', 1),
(1367, '2017-02-21 20:10:07', 1),
(1368, '2017-02-21 20:11:13', 1),
(1369, '2017-02-21 20:11:51', 1),
(1370, '2017-02-21 21:35:46', 1),
(1371, '2017-02-21 21:44:51', 1),
(1372, '2017-02-21 21:46:34', 1),
(1373, '2017-02-21 21:47:22', 1),
(1374, '2017-02-21 21:47:58', 1),
(1375, '2017-02-21 21:56:44', 1),
(1376, '2017-02-21 22:06:58', 1),
(1377, '2017-02-21 22:13:26', 1),
(1378, '2017-02-21 22:16:40', 1),
(1379, '2017-02-21 23:20:08', 1),
(1380, '2017-02-21 23:22:10', 1),
(1381, '2017-02-21 23:24:41', 1),
(1382, '2017-02-21 23:26:10', 1),
(1383, '2017-02-21 23:29:38', 1),
(1384, '2017-02-21 23:32:09', 1),
(1385, '2017-02-21 23:33:32', 1),
(1386, '2017-02-21 23:37:32', 1),
(1387, '2017-02-21 23:37:45', 1),
(1388, '2017-02-21 23:40:06', 1),
(1389, '2017-02-21 23:41:30', 1),
(1390, '2017-02-21 23:42:11', 1),
(1391, '2017-02-21 23:44:35', 1),
(1392, '2017-02-21 23:51:53', 1),
(1393, '2017-02-21 23:52:25', 1),
(1394, '2017-02-21 23:54:30', 1),
(1395, '2017-02-21 23:57:27', 1),
(1396, '2017-02-21 23:57:36', 1),
(1397, '2017-02-22 22:07:47', 1),
(1398, '2017-02-22 22:25:23', 1),
(1399, '2017-02-22 22:53:27', 1),
(1400, '2017-02-22 23:10:18', 1),
(1401, '2017-02-22 23:10:21', 1),
(1402, '2017-02-22 23:33:29', 1),
(1403, '2017-02-22 23:34:16', 1),
(1404, '2017-02-22 23:41:06', 1),
(1405, '2017-02-22 23:47:20', 1),
(1406, '2017-02-22 23:59:54', 1),
(1407, '2017-02-23 00:03:52', 1),
(1408, '2017-02-23 00:13:29', 1),
(1409, '2017-02-23 18:04:38', 1),
(1410, '2017-02-23 22:49:25', 1),
(1411, '2017-02-23 22:50:09', 1),
(1412, '2017-02-23 22:50:50', 1),
(1413, '2017-02-23 22:59:55', 1),
(1414, '2017-02-23 23:23:39', 1),
(1415, '2017-02-23 23:30:47', 1),
(1416, '2017-02-23 23:40:46', 1),
(1417, '2017-02-23 23:59:36', 1),
(1418, '2017-02-24 00:08:43', 1),
(1419, '2017-02-24 00:17:50', 1),
(1420, '2017-02-24 00:20:12', 1),
(1421, '2017-02-24 00:21:59', 1),
(1422, '2017-02-24 00:23:47', 1),
(1423, '2017-02-24 00:26:11', 1),
(1424, '2017-02-27 18:28:57', 1),
(1425, '2017-02-27 18:40:15', 1),
(1426, '2017-02-27 18:40:44', 1),
(1427, '2017-02-27 18:41:01', 1),
(1428, '2017-02-27 18:44:54', 1),
(1429, '2017-02-27 18:57:34', 1),
(1430, '2017-02-27 19:42:31', 1),
(1431, '2017-02-27 19:43:49', 1),
(1432, '2017-02-27 20:05:13', 1),
(1433, '2017-02-27 20:24:13', 1),
(1434, '2017-02-27 20:33:35', 1),
(1435, '2017-02-27 20:34:35', 1),
(1436, '2017-02-27 20:36:36', 1),
(1437, '2017-02-27 20:37:02', 1),
(1438, '2017-02-27 20:37:30', 1),
(1439, '2017-02-27 20:46:21', 1),
(1440, '2017-02-27 20:53:11', 1),
(1441, '2017-02-27 20:57:16', 1),
(1442, '2017-02-27 21:01:31', 1),
(1443, '2017-02-27 21:06:27', 1),
(1444, '2017-02-27 21:08:46', 1),
(1445, '2017-02-27 21:10:10', 1),
(1446, '2017-02-27 21:11:33', 1),
(1447, '2017-02-28 00:02:39', 1),
(1448, '2017-02-28 00:22:12', 1),
(1449, '2017-02-28 00:22:59', 1),
(1450, '2017-02-28 00:32:31', 1),
(1451, '2017-02-28 00:35:37', 1),
(1452, '2017-02-28 00:36:16', 1),
(1453, '2017-02-28 00:36:31', 1),
(1454, '2017-02-28 00:53:23', 1),
(1455, '2017-02-28 01:08:31', 1),
(1456, '2017-02-28 01:24:32', 1),
(1457, '2017-02-28 01:26:59', 1),
(1458, '2017-02-28 01:28:05', 1),
(1459, '2017-02-28 01:30:13', 1),
(1460, '2017-02-28 01:34:04', 1),
(1461, '2017-02-28 01:36:21', 1),
(1462, '2017-02-28 01:37:22', 1),
(1463, '2017-02-28 01:38:08', 1),
(1464, '2017-02-28 01:42:23', 1),
(1465, '2017-02-28 01:42:55', 1),
(1466, '2017-02-28 01:44:00', 1),
(1467, '2017-02-28 01:45:55', 1),
(1468, '2017-02-28 01:48:21', 1),
(1469, '2017-02-28 01:52:15', 1),
(1470, '2017-02-28 01:53:33', 1),
(1471, '2017-02-28 01:54:59', 1),
(1472, '2017-02-28 02:00:14', 1),
(1473, '2017-02-28 20:29:45', 1),
(1474, '2017-02-28 20:34:10', 1),
(1475, '2017-02-28 20:35:07', 1),
(1476, '2017-02-28 20:35:13', 1),
(1477, '2017-02-28 20:36:48', 1),
(1478, '2017-02-28 20:37:28', 1),
(1479, '2017-02-28 20:39:25', 1),
(1480, '2017-02-28 20:41:47', 1),
(1481, '2017-02-28 20:57:31', 1),
(1482, '2017-02-28 21:01:12', 1),
(1483, '2017-02-28 21:04:56', 1),
(1484, '2017-02-28 21:06:24', 1),
(1485, '2017-02-28 21:08:40', 1),
(1486, '2017-02-28 21:42:47', 1),
(1487, '2017-02-28 21:43:23', 1),
(1488, '2017-02-28 21:51:08', 1),
(1489, '2017-02-28 21:52:47', 1),
(1490, '2017-02-28 21:59:55', 1),
(1491, '2017-02-28 22:04:45', 1),
(1492, '2017-02-28 22:06:11', 1),
(1493, '2017-02-28 22:07:16', 1),
(1494, '2017-02-28 23:07:36', 1),
(1495, '2017-02-28 23:10:09', 1),
(1496, '2017-02-28 23:12:00', 1),
(1497, '2017-02-28 23:12:58', 1),
(1498, '2017-02-28 23:16:45', 1),
(1499, '2017-02-28 23:23:30', 1),
(1500, '2017-02-28 23:38:14', 1),
(1501, '2017-02-28 23:40:02', 1),
(1502, '2017-02-28 23:41:41', 1),
(1503, '2017-02-28 23:50:06', 1),
(1504, '2017-02-28 23:52:09', 1),
(1505, '2017-02-28 23:54:59', 1),
(1506, '2017-02-28 23:56:36', 1),
(1507, '2017-03-01 00:01:05', 1),
(1508, '2017-03-01 00:18:50', 1),
(1509, '2017-03-01 00:22:02', 1),
(1510, '2017-03-01 00:26:07', 1),
(1511, '2017-03-01 00:29:09', 1),
(1512, '2017-03-01 00:33:42', 1),
(1513, '2017-03-01 00:42:22', 1),
(1514, '2017-03-01 00:53:07', 1),
(1515, '2017-03-01 00:58:48', 1),
(1516, '2017-03-01 01:02:46', 1),
(1517, '2017-03-01 01:20:12', 1),
(1518, '2017-03-01 01:28:55', 1),
(1519, '2017-03-01 01:36:26', 1),
(1520, '2017-03-01 01:38:16', 1),
(1521, '2017-03-01 01:39:59', 1),
(1522, '2017-03-01 01:41:04', 1),
(1523, '2017-03-01 01:42:29', 1),
(1524, '2017-03-01 18:38:18', 1),
(1525, '2017-03-01 18:42:27', 1),
(1526, '2017-03-01 18:45:09', 1),
(1527, '2017-03-01 19:18:57', 1),
(1528, '2017-03-01 19:19:29', 1),
(1529, '2017-03-01 19:19:38', 1),
(1530, '2017-03-01 19:20:42', 1),
(1531, '2017-03-01 19:21:16', 1),
(1532, '2017-03-01 19:21:39', 1),
(1533, '2017-03-01 19:22:05', 1),
(1534, '2017-03-01 19:22:41', 1),
(1535, '2017-03-01 19:23:20', 1),
(1536, '2017-03-01 20:15:36', 1),
(1537, '2017-03-01 20:46:45', 1),
(1538, '2017-03-01 20:52:08', 1),
(1539, '2017-03-01 20:56:52', 1),
(1540, '2017-03-01 21:12:23', 1),
(1541, '2017-03-01 22:20:23', 1),
(1542, '2017-03-01 22:37:10', 1),
(1543, '2017-03-01 22:38:45', 1),
(1544, '2017-03-01 22:42:46', 1),
(1545, '2017-03-01 22:43:38', 1),
(1546, '2017-03-01 23:11:04', 1),
(1547, '2017-03-01 23:15:44', 1),
(1548, '2017-03-01 23:16:36', 1),
(1549, '2017-03-01 23:25:31', 1),
(1550, '2017-03-01 23:47:31', 1),
(1551, '2017-03-01 23:59:59', 1),
(1552, '2017-03-02 00:02:40', 1),
(1553, '2017-03-02 00:06:02', 1),
(1554, '2017-03-02 00:09:50', 1),
(1555, '2017-03-02 00:25:24', 1),
(1556, '2017-03-02 00:27:13', 1),
(1557, '2017-03-02 00:29:09', 1),
(1558, '2017-03-02 00:35:23', 1),
(1559, '2017-03-02 00:36:58', 1),
(1560, '2017-03-02 00:37:17', 1),
(1561, '2017-03-02 00:50:21', 1),
(1562, '2017-03-02 00:56:41', 1),
(1563, '2017-03-02 00:58:56', 1),
(1564, '2017-03-02 01:11:16', 1),
(1565, '2017-03-02 01:14:52', 1),
(1566, '2017-03-02 01:17:10', 1),
(1567, '2017-03-02 01:21:20', 1),
(1568, '2017-03-02 09:43:27', 1),
(1569, '2017-03-02 09:53:25', 1),
(1570, '2017-03-02 11:20:45', 1),
(1571, '2017-03-02 11:48:25', 1),
(1572, '2017-03-02 11:50:48', 1),
(1573, '2017-03-02 11:51:13', 1),
(1574, '2017-03-02 11:55:17', 1),
(1575, '2017-03-02 13:56:22', 1),
(1576, '2017-03-02 14:12:24', 1),
(1577, '2017-03-02 14:14:37', 1),
(1578, '2017-03-02 14:17:18', 1),
(1579, '2017-03-02 14:25:03', 1),
(1580, '2017-03-02 14:30:11', 1),
(1581, '2017-03-02 14:36:40', 1),
(1582, '2017-03-02 15:19:42', 1),
(1583, '2017-03-02 15:33:54', 1),
(1584, '2017-03-02 15:34:52', 1),
(1585, '2017-03-02 17:37:33', 1),
(1586, '2017-03-02 17:39:37', 1),
(1587, '2017-03-02 17:46:39', 1),
(1588, '2017-03-02 17:47:41', 1),
(1589, '2017-03-02 17:50:23', 1),
(1590, '2017-03-02 19:19:24', 1),
(1591, '2017-03-02 19:40:22', 1),
(1592, '2017-03-02 20:38:39', 1),
(1593, '2017-03-02 20:46:27', 1),
(1594, '2017-03-02 20:48:38', 1),
(1595, '2017-03-02 20:48:39', 1);
INSERT INTO `Admin_Visits` (`id_visit`, `date_up`, `value`) VALUES
(1596, '2017-03-03 22:59:38', 1),
(1597, '2017-03-05 18:10:36', 1),
(1598, '2017-03-05 23:15:30', 1),
(1599, '2017-03-06 00:54:06', 1),
(1600, '2017-03-07 15:40:38', 1),
(1601, '2017-03-07 15:41:17', 1),
(1602, '2017-03-07 15:41:40', 1),
(1603, '2017-03-07 15:51:42', 1),
(1604, '2017-03-13 18:16:55', 1),
(1605, '2017-03-13 18:32:15', 1),
(1606, '2017-03-13 18:44:42', 1),
(1607, '2017-03-13 18:48:30', 1),
(1608, '2017-03-13 18:48:38', 1),
(1609, '2017-03-13 18:51:13', 1),
(1610, '2017-03-13 18:52:33', 1),
(1611, '2017-03-13 18:53:29', 1),
(1612, '2017-03-13 18:54:01', 1),
(1613, '2017-03-13 18:56:06', 1),
(1614, '2017-03-13 18:57:38', 1),
(1615, '2017-03-13 18:59:17', 1),
(1616, '2017-03-13 18:59:52', 1),
(1617, '2017-03-13 19:04:37', 1),
(1618, '2017-03-13 19:06:14', 1),
(1619, '2017-03-13 21:41:52', 1),
(1620, '2017-03-13 21:44:59', 1),
(1621, '2017-03-13 21:49:32', 1),
(1622, '2017-03-13 22:13:30', 1),
(1623, '2017-03-13 22:26:47', 1),
(1624, '2017-03-13 22:31:55', 1),
(1625, '2017-03-13 22:33:15', 1),
(1626, '2017-03-13 22:34:43', 1),
(1627, '2017-03-13 22:44:05', 1),
(1628, '2017-03-13 22:47:00', 1),
(1629, '2017-03-13 22:47:30', 1),
(1630, '2017-03-13 22:48:40', 1),
(1631, '2017-03-13 22:50:19', 1),
(1632, '2017-03-13 22:54:05', 1),
(1633, '2017-03-13 23:07:36', 1),
(1634, '2017-03-13 23:09:45', 1),
(1635, '2017-03-13 23:14:33', 1),
(1636, '2017-03-13 23:16:20', 1),
(1637, '2017-03-13 23:19:27', 1),
(1638, '2017-03-13 23:21:42', 1),
(1639, '2017-03-13 23:22:11', 1),
(1640, '2017-03-13 23:26:46', 1),
(1641, '2017-03-13 23:29:46', 1),
(1642, '2017-03-13 23:44:31', 1),
(1643, '2017-03-14 00:03:35', 1),
(1644, '2017-03-14 00:06:20', 1),
(1645, '2017-03-15 20:20:57', 1),
(1646, '2017-03-15 23:22:09', 1),
(1647, '2017-03-15 23:50:13', 1),
(1648, '2017-03-16 00:24:33', 1),
(1649, '2017-03-16 00:24:37', 1),
(1650, '2017-03-16 00:25:49', 1),
(1651, '2017-03-16 00:26:51', 1),
(1652, '2017-03-16 00:27:25', 1),
(1653, '2017-03-16 00:29:20', 1),
(1654, '2017-03-16 14:48:19', 1),
(1655, '2017-03-16 20:27:14', 1),
(1656, '2017-03-16 20:27:30', 1),
(1657, '2017-03-16 20:28:32', 1),
(1658, '2017-03-16 20:29:45', 1),
(1659, '2017-03-16 20:34:54', 1),
(1660, '2017-03-16 23:37:32', 1),
(1661, '2017-03-16 23:38:45', 1),
(1662, '2017-03-17 00:12:33', 1),
(1663, '2017-03-17 00:13:38', 1),
(1664, '2017-03-17 00:20:42', 1),
(1665, '2017-03-17 00:33:12', 1),
(1666, '2017-03-17 00:33:35', 1),
(1667, '2017-03-17 00:35:29', 1),
(1668, '2017-03-17 00:36:55', 1),
(1669, '2017-03-17 00:39:01', 1),
(1670, '2017-03-17 00:41:47', 1),
(1671, '2017-03-17 00:43:31', 1),
(1672, '2017-03-17 00:45:42', 1),
(1673, '2017-03-17 00:46:54', 1),
(1674, '2017-03-17 00:49:12', 1),
(1675, '2017-03-17 00:52:32', 1),
(1676, '2017-03-17 00:53:04', 1),
(1677, '2017-03-17 00:54:38', 1),
(1678, '2017-03-17 01:18:12', 1),
(1679, '2017-03-17 01:20:50', 1),
(1680, '2017-03-17 01:24:58', 1),
(1681, '2017-03-17 01:26:46', 1),
(1682, '2017-03-17 01:28:04', 1),
(1683, '2017-03-17 01:29:34', 1),
(1684, '2017-03-17 01:30:39', 1),
(1685, '2017-03-17 01:31:44', 1),
(1686, '2017-03-17 01:33:02', 1),
(1687, '2017-03-17 01:33:51', 1),
(1688, '2017-03-17 01:34:20', 1),
(1689, '2017-03-17 01:35:36', 1),
(1690, '2017-03-17 01:39:48', 1),
(1691, '2017-03-17 01:40:24', 1),
(1692, '2017-03-17 01:42:25', 1),
(1693, '2017-03-17 01:45:38', 1),
(1694, '2017-03-17 01:46:16', 1),
(1695, '2017-03-17 07:44:30', 1),
(1696, '2017-03-17 08:00:43', 1),
(1697, '2017-03-17 08:01:58', 1),
(1698, '2017-03-17 08:27:32', 1),
(1699, '2017-03-17 08:56:31', 1),
(1700, '2017-03-17 08:57:39', 1),
(1701, '2017-03-21 09:56:02', 1),
(1702, '2017-03-21 16:23:37', 1),
(1703, '2017-03-21 16:34:18', 1),
(1704, '2017-03-21 19:02:03', 1),
(1705, '2017-03-21 19:50:48', 1),
(1706, '2017-03-21 20:52:43', 1),
(1707, '2017-03-21 20:56:48', 1),
(1708, '2017-03-21 20:57:13', 1),
(1709, '2017-03-21 21:07:11', 1),
(1710, '2017-03-21 21:07:45', 1),
(1711, '2017-03-21 21:09:37', 1),
(1712, '2017-03-21 21:13:09', 1),
(1713, '2017-03-21 21:14:11', 1),
(1714, '2017-03-21 21:15:12', 1),
(1715, '2017-03-21 21:16:31', 1),
(1716, '2017-03-21 21:17:19', 1),
(1717, '2017-03-21 21:17:50', 1),
(1718, '2017-03-21 21:21:14', 1),
(1719, '2017-03-21 21:21:25', 1),
(1720, '2017-03-21 22:17:05', 1),
(1721, '2017-03-23 10:15:57', 1),
(1722, '2017-03-27 12:41:29', 1),
(1723, '2017-03-27 12:46:20', 1),
(1724, '2017-03-27 15:17:11', 1),
(1725, '2017-03-27 15:24:58', 1),
(1726, '2017-03-29 17:18:55', 1),
(1727, '2017-03-29 19:44:31', 1),
(1728, '2017-03-29 20:34:59', 1),
(1729, '2017-03-29 20:42:32', 1),
(1730, '2017-03-30 18:06:55', 1),
(1731, '2017-03-31 10:36:08', 1),
(1732, '2017-04-01 17:36:53', 1),
(1733, '2017-04-03 20:46:17', 1),
(1734, '2017-04-04 10:44:58', 1),
(1735, '2017-04-04 12:58:02', 1),
(1736, '2017-04-07 12:47:37', 1),
(1737, '2017-04-18 10:13:11', 1),
(1738, '2017-04-19 22:11:55', 1),
(1739, '2017-04-19 22:22:28', 1),
(1740, '2017-04-19 22:57:48', 1),
(1741, '2017-04-19 23:03:46', 1),
(1742, '2017-04-19 23:06:08', 1),
(1743, '2017-04-19 23:08:06', 1),
(1744, '2017-04-19 23:20:47', 1),
(1745, '2017-04-19 23:26:41', 1),
(1746, '2017-04-19 23:32:29', 1),
(1747, '2017-04-20 22:57:03', 1),
(1748, '2017-04-20 22:58:19', 1),
(1749, '2017-04-20 23:12:01', 1),
(1750, '2017-04-20 23:18:38', 1),
(1751, '2017-04-20 23:32:22', 1),
(1752, '2017-04-20 23:51:56', 1),
(1753, '2017-04-20 23:55:59', 1),
(1754, '2017-04-21 00:02:09', 1),
(1755, '2017-04-21 00:06:19', 1),
(1756, '2017-04-21 00:08:24', 1),
(1757, '2017-04-24 21:26:53', 1),
(1758, '2017-04-24 21:35:40', 1),
(1759, '2017-04-24 22:28:56', 1),
(1760, '2017-04-24 22:30:23', 1),
(1761, '2017-04-24 22:40:39', 1),
(1762, '2017-04-24 22:45:43', 1),
(1763, '2017-04-24 23:06:48', 1),
(1764, '2017-04-24 23:32:21', 1),
(1765, '2017-04-24 23:33:19', 1),
(1766, '2017-04-24 23:41:26', 1),
(1767, '2017-04-24 23:52:16', 1),
(1768, '2017-04-25 00:01:43', 1),
(1769, '2017-04-25 00:04:21', 1),
(1770, '2017-04-25 00:10:38', 1),
(1771, '2017-04-25 00:14:15', 1),
(1772, '2017-04-25 00:17:24', 1),
(1773, '2017-04-25 00:43:33', 1),
(1774, '2017-04-25 01:06:53', 1),
(1775, '2017-04-25 01:10:24', 1),
(1776, '2017-04-25 01:15:02', 1),
(1777, '2017-04-25 01:20:58', 1),
(1778, '2017-04-25 01:22:24', 1),
(1779, '2017-04-25 01:29:29', 1),
(1780, '2017-04-25 01:30:49', 1),
(1781, '2017-04-25 01:32:52', 1),
(1782, '2017-04-25 01:34:52', 1),
(1783, '2017-04-25 01:36:48', 1),
(1784, '2017-04-25 10:56:06', 1),
(1785, '2017-04-25 11:06:52', 1),
(1786, '2017-04-25 11:09:55', 1),
(1787, '2017-04-25 11:10:55', 1),
(1788, '2017-04-25 11:13:48', 1),
(1789, '2017-04-25 11:15:31', 1),
(1790, '2017-04-25 11:18:40', 1),
(1791, '2017-04-25 11:24:56', 1),
(1792, '2017-04-25 11:28:22', 1),
(1793, '2017-04-25 11:28:56', 1),
(1794, '2017-04-25 11:34:14', 1),
(1795, '2017-04-25 11:35:37', 1),
(1796, '2017-04-25 11:36:54', 1),
(1797, '2017-04-25 17:38:14', 1),
(1798, '2017-04-25 21:26:15', 1),
(1799, '2017-04-25 21:38:33', 1),
(1800, '2017-04-25 21:45:47', 1),
(1801, '2017-04-25 22:03:55', 1),
(1802, '2017-04-26 00:17:14', 1),
(1803, '2017-04-26 00:21:04', 1),
(1804, '2017-04-26 00:50:27', 1),
(1805, '2017-04-26 01:02:23', 1),
(1806, '2017-04-26 01:03:29', 1),
(1807, '2017-04-26 01:34:23', 1),
(1808, '2017-04-26 01:37:59', 1),
(1809, '2017-04-26 01:41:55', 1),
(1810, '2017-04-26 01:42:55', 1),
(1811, '2017-04-26 16:54:31', 1),
(1812, '2017-04-27 10:16:02', 1),
(1813, '2017-04-27 10:27:08', 1),
(1814, '2017-04-28 17:52:41', 1),
(1815, '2017-05-02 23:37:52', 1),
(1816, '2017-05-04 19:34:05', 1),
(1817, '2017-05-06 16:45:04', 1),
(1818, '2017-05-06 16:52:05', 1),
(1819, '2017-05-06 19:06:17', 1),
(1820, '2017-05-06 20:58:27', 1),
(1821, '2017-05-07 02:54:39', 1),
(1822, '2017-05-07 07:24:00', 1),
(1823, '2017-05-07 08:33:59', 1),
(1824, '2017-05-07 11:02:30', 1),
(1825, '2017-05-07 13:20:35', 1),
(1826, '2017-05-08 14:14:28', 1),
(1827, '2017-05-11 11:24:34', 1),
(1828, '2017-05-11 20:39:54', 1),
(1829, '2017-05-11 21:05:43', 1),
(1830, '2017-05-12 00:08:13', 1),
(1831, '2017-05-12 00:26:15', 1),
(1832, '2017-05-12 00:28:53', 1),
(1833, '2017-05-12 00:33:24', 1),
(1834, '2017-05-12 00:34:34', 1),
(1835, '2017-05-12 00:55:16', 1),
(1836, '2017-05-12 00:56:18', 1),
(1837, '2017-05-12 01:01:09', 1),
(1838, '2017-05-12 01:02:28', 1),
(1839, '2017-05-12 01:05:45', 1),
(1840, '2017-05-12 09:52:46', 1),
(1841, '2017-05-12 21:07:59', 1),
(1842, '2017-05-12 21:13:05', 1),
(1843, '2017-05-12 21:26:33', 1),
(1844, '2017-05-13 22:32:15', 1),
(1845, '2017-05-18 17:56:34', 1),
(1846, '2017-05-21 14:10:18', 1),
(1847, '2017-05-21 14:15:48', 1),
(1848, '2017-05-21 14:16:48', 1),
(1849, '2017-05-21 14:35:37', 1),
(1850, '2017-05-21 14:37:20', 1),
(1851, '2017-05-22 16:01:45', 1),
(1852, '2017-05-22 16:02:23', 1),
(1853, '2017-05-22 16:15:35', 1),
(1854, '2017-05-22 16:16:05', 1),
(1855, '2017-05-22 16:16:24', 1),
(1856, '2017-05-24 16:31:43', 1),
(1857, '2017-05-26 09:59:39', 1),
(1858, '2017-05-26 10:01:58', 1),
(1859, '2017-05-26 10:03:15', 1),
(1860, '2017-05-26 10:55:05', 1),
(1861, '2017-05-26 10:57:19', 1),
(1862, '2017-05-26 11:00:32', 1),
(1863, '2017-05-26 11:01:38', 1),
(1864, '2017-05-26 11:58:18', 1),
(1865, '2017-05-29 12:54:08', 1),
(1866, '2017-05-31 22:26:11', 1),
(1867, '2017-06-01 00:09:40', 1),
(1868, '2017-06-01 00:12:38', 1),
(1869, '2017-06-01 01:23:10', 1),
(1870, '2017-06-01 01:28:25', 1),
(1871, '2017-06-01 01:39:50', 1),
(1872, '2017-06-01 01:41:50', 1),
(1873, '2017-06-01 01:43:08', 1),
(1874, '2017-06-01 18:18:35', 1),
(1875, '2017-06-01 18:24:04', 1),
(1876, '2017-06-01 18:24:35', 1),
(1877, '2017-06-01 18:33:01', 1),
(1878, '2017-06-01 18:35:43', 1),
(1879, '2017-06-01 18:48:05', 1),
(1880, '2017-06-01 19:13:15', 1),
(1881, '2017-06-01 19:14:11', 1),
(1882, '2017-06-01 19:27:10', 1),
(1883, '2017-06-01 19:33:35', 1),
(1884, '2017-06-01 19:41:17', 1),
(1885, '2017-06-01 19:41:50', 1),
(1886, '2017-06-04 20:12:29', 1),
(1887, '2017-06-05 17:08:20', 1),
(1888, '2017-06-05 17:12:04', 1),
(1889, '2017-06-05 19:24:36', 1),
(1890, '2017-06-07 16:18:09', 1),
(1891, '2017-06-07 16:20:01', 1),
(1892, '2017-06-07 16:28:52', 1),
(1893, '2017-06-08 20:59:25', 1),
(1894, '2017-06-08 21:24:06', 1),
(1895, '2017-06-08 21:31:01', 1),
(1896, '2017-06-09 10:47:50', 1),
(1897, '2017-06-09 10:52:18', 1),
(1898, '2017-06-09 11:04:26', 1),
(1899, '2017-06-09 16:29:29', 1),
(1900, '2017-06-10 12:38:44', 1),
(1901, '2017-06-12 19:47:06', 1),
(1902, '2017-06-13 19:54:15', 1),
(1903, '2017-06-19 10:24:44', 1),
(1904, '2017-06-19 10:25:29', 1),
(1905, '2017-06-21 16:02:26', 1),
(1906, '2017-06-21 16:08:45', 1),
(1907, '2017-06-21 18:32:02', 1),
(1908, '2017-06-21 19:31:47', 1),
(1909, '2017-06-21 19:44:50', 1),
(1910, '2017-06-21 20:11:06', 1),
(1911, '2017-06-21 20:11:30', 1),
(1912, '2017-06-21 20:14:24', 1),
(1913, '2017-06-21 20:14:58', 1),
(1914, '2017-06-21 20:15:28', 1),
(1915, '2017-06-21 20:17:44', 1),
(1916, '2017-06-21 20:22:58', 1),
(1917, '2017-06-21 20:24:09', 1),
(1918, '2017-06-21 20:24:22', 1),
(1919, '2017-06-22 17:41:12', 1),
(1920, '2017-06-23 16:30:18', 1),
(1921, '2017-06-23 16:46:27', 1),
(1922, '2017-06-23 17:32:40', 1),
(1923, '2017-06-23 17:35:56', 1),
(1924, '2017-06-23 17:37:56', 1),
(1925, '2017-06-23 18:18:40', 1),
(1926, '2017-06-23 19:32:23', 1),
(1927, '2017-06-29 19:24:48', 1),
(1928, '2017-06-29 19:29:33', 1),
(1929, '2017-06-29 19:37:24', 1),
(1930, '2017-06-29 19:38:53', 1),
(1931, '2017-06-29 19:40:29', 1),
(1932, '2017-06-29 19:43:19', 1),
(1933, '2017-06-29 19:45:40', 1),
(1934, '2017-06-29 19:46:16', 1),
(1935, '2017-06-29 19:49:08', 1),
(1936, '2017-06-29 19:49:58', 1),
(1937, '2017-06-29 19:51:05', 1),
(1938, '2017-06-29 20:01:06', 1),
(1939, '2017-06-29 20:01:13', 1),
(1940, '2017-06-29 20:01:40', 1),
(1941, '2017-06-29 20:02:25', 1),
(1942, '2017-06-29 20:02:30', 1),
(1943, '2017-06-29 20:06:40', 1),
(1944, '2017-06-29 20:07:08', 1),
(1945, '2017-07-07 16:57:05', 1),
(1946, '2017-07-07 17:25:35', 1),
(1947, '2017-07-10 17:03:29', 1),
(1948, '2017-07-12 16:14:13', 1),
(1949, '2017-07-12 17:20:51', 1),
(1950, '2017-07-12 17:40:18', 1),
(1951, '2017-07-12 17:48:50', 1),
(1952, '2017-07-14 11:38:15', 1),
(1953, '2017-07-14 12:20:14', 1),
(1954, '2017-08-18 00:46:00', 1),
(1955, '2017-09-05 14:37:52', 1),
(1956, '2017-09-06 18:05:20', 1),
(1957, '2017-09-12 19:39:55', 1),
(1958, '2017-09-12 20:01:58', 1),
(1959, '2017-09-21 12:54:56', 1),
(1960, '2017-09-25 09:34:19', 1),
(1961, '2017-09-25 12:45:51', 1),
(1962, '2017-09-26 22:22:18', 1),
(1963, '2017-09-26 22:22:42', 1),
(1964, '2017-09-27 10:19:58', 1),
(1965, '2017-09-29 03:48:29', 1),
(1966, '2017-10-05 03:50:07', 1),
(1967, '2017-10-05 03:52:33', 1),
(1968, '2017-10-06 11:53:25', 1),
(1969, '2017-10-06 12:04:46', 1),
(1970, '2017-10-06 14:36:31', 1),
(1971, '2017-10-06 15:05:45', 1),
(1972, '2017-10-06 15:09:18', 1),
(1973, '2017-10-12 17:52:31', 1),
(1974, '2017-10-12 18:21:47', 1),
(1975, '2017-10-12 18:55:01', 1),
(1976, '2017-10-20 23:45:11', 1),
(1977, '2017-10-23 11:53:18', 1),
(1978, '2017-10-26 09:33:35', 1),
(1979, '2017-10-26 10:15:17', 1),
(1980, '2017-10-26 15:56:23', 1),
(1981, '2017-10-31 14:49:20', 1),
(1982, '2017-11-07 11:54:03', 1),
(1983, '2017-11-08 13:02:16', 1),
(1984, '2017-11-08 13:03:15', 1),
(1985, '2017-11-08 13:09:57', 1),
(1986, '2017-11-08 13:11:18', 1),
(1987, '2017-11-08 13:13:21', 1),
(1988, '2017-11-08 13:19:30', 1),
(1989, '2017-11-08 13:22:06', 1),
(1990, '2017-11-08 13:31:31', 1),
(1991, '2017-11-08 13:32:31', 1),
(1992, '2017-11-08 13:33:19', 1),
(1993, '2017-11-08 13:42:02', 1),
(1994, '2017-11-08 13:59:31', 1),
(1995, '2017-11-08 14:51:57', 1),
(1996, '2017-11-08 14:56:03', 1),
(1997, '2017-11-08 15:04:13', 1),
(1998, '2017-11-08 16:09:11', 1),
(1999, '2017-11-08 16:51:57', 1),
(2000, '2017-11-08 17:08:24', 1),
(2001, '2017-11-08 17:11:05', 1),
(2002, '2017-11-08 17:11:51', 1),
(2003, '2017-11-08 17:14:57', 1),
(2004, '2017-11-08 17:15:49', 1),
(2005, '2017-11-08 17:16:12', 1),
(2006, '2017-11-08 17:17:57', 1),
(2007, '2017-11-08 17:18:37', 1),
(2008, '2017-11-08 17:20:12', 1),
(2009, '2017-11-08 17:20:42', 1),
(2010, '2017-11-08 17:20:48', 1),
(2011, '2017-11-08 17:21:54', 1),
(2012, '2017-11-08 17:37:56', 1),
(2013, '2017-11-08 17:42:09', 1),
(2014, '2017-11-08 17:43:20', 1),
(2015, '2017-11-08 17:44:33', 1),
(2016, '2017-11-08 17:53:13', 1),
(2017, '2017-11-08 18:03:50', 1),
(2018, '2017-11-08 18:09:15', 1),
(2019, '2017-11-08 18:15:01', 1),
(2020, '2017-11-08 18:54:52', 1),
(2021, '2017-11-08 18:55:21', 1),
(2022, '2017-11-08 19:17:45', 1),
(2023, '2017-11-09 13:16:27', 1),
(2024, '2017-11-14 10:48:51', 1),
(2025, '2017-11-20 08:12:04', 1),
(2026, '2017-11-20 08:13:10', 1),
(2027, '2017-11-20 08:21:43', 1),
(2028, '2017-11-22 09:06:01', 1),
(2029, '2017-11-22 09:59:16', 1),
(2030, '2017-11-23 08:57:23', 1),
(2031, '2017-11-23 09:03:46', 1),
(2032, '2017-11-23 10:04:05', 1),
(2033, '2017-11-23 10:42:08', 1),
(2034, '2017-11-23 19:28:26', 1),
(2035, '2017-11-24 08:25:03', 1),
(2036, '2017-11-26 21:32:26', 1),
(2037, '2018-01-19 14:37:10', 1),
(2038, '2018-01-19 14:39:48', 1),
(2039, '2018-01-19 15:46:21', 1),
(2040, '2018-01-21 11:32:09', 1),
(2041, '2018-01-23 21:36:06', 1),
(2042, '2018-01-24 11:37:51', 1),
(2043, '2018-01-27 14:53:50', 1),
(2044, '2018-01-27 15:03:01', 1),
(2045, '2018-01-27 15:07:01', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Campaign`
--

CREATE TABLE `Campaign` (
  `id_campaign` int(9) NOT NULL,
  `name` text NOT NULL,
  `description` text NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `fk_dimension` int(9) NOT NULL,
  `fk_company` int(9) NOT NULL,
  `fk_segment` int(9) NOT NULL,
  `fk_city` int(9) NOT NULL,
  `fk_age` int(9) NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Campaign`
--

INSERT INTO `Campaign` (`id_campaign`, `name`, `description`, `date_up`, `date_update`, `fk_dimension`, `fk_company`, `fk_segment`, `fk_city`, `fk_age`, `status`) VALUES
(1, 'Campaña de Salud', 'Campaña visual', '2016-12-05 18:00:21', '2016-12-05 18:00:21', 1, 1, 7, 1, 1, 1),
(6, '', '', '2016-12-12 02:29:41', '2016-12-12 02:29:41', 1, 1, 2, 2, 2, 1),
(7, 'jjjj', 'ppppp', '2016-12-12 02:34:08', '2016-12-12 02:34:08', 1, 1, 30, 3, 3, 1),
(8, 'xxxxxx', 'xsssssssssss', '2016-12-12 02:38:01', '2016-12-12 02:38:01', 1, 1, 34, 4, 4, 1),
(9, 'fdfsf', 'fsfsf', '2016-12-12 02:39:32', '2016-12-12 02:39:32', 1, 1, 25, 5, 4, 1),
(10, 'dasdasd', 'asdasdasdasdd', '2016-12-12 02:42:05', '2016-12-12 02:42:05', 1, 1, 28, 6, 4, 1),
(11, 'xzczczz', 'zxczxczxczxczxc', '2016-12-12 03:24:25', '2016-12-12 03:24:25', 1, 1, 14, 7, 5, 1),
(12, 'xzczczz', 'zxczxczxczxczxc', '2016-12-12 03:28:12', '2016-12-12 03:28:12', 1, 1, 27, 8, 6, 1),
(13, 'xzczczz', 'zxczxczxczxczxc', '2016-12-12 03:28:54', '2016-12-12 03:28:54', 1, 1, 2, 9, 7, 1),
(14, 'xzczczz', 'zxczxczxczxczxc', '2016-12-12 03:30:03', '2016-12-12 03:30:03', 1, 1, 13, 10, 8, 1),
(15, 'xasaf', 'asfafsaf', '2016-12-12 03:32:50', '2016-12-12 03:32:50', 1, 1, 5, 11, 7, 1),
(16, 'xasaf', 'asfafsaf', '2016-12-12 03:33:45', '2016-12-12 03:33:45', 1, 1, 34, 12, 8, 1),
(17, 'p', 'asdasd', '2016-12-12 03:34:42', '2016-12-12 03:34:42', 1, 1, 31, 13, 5, 1),
(18, 'aaaaaaaaaaa', 'asdsadasd', '2016-12-12 03:36:05', '2016-12-12 03:36:05', 1, 1, 5, 14, 5, 1),
(19, 'aaaaaaaaaaa', 'asdsadasd', '2016-12-12 03:37:16', '2016-12-12 03:37:16', 1, 1, 17, 15, 9, 1),
(20, 'aaaaaaaaaaa', 'asdsadasd', '2016-12-12 03:38:21', '2016-12-12 03:38:21', 1, 1, 8, 16, 11, 1),
(21, 'pablopabloxx', 'pablodesc', '2016-12-12 03:41:45', '2016-12-12 03:41:45', 1, 1, 11, 17, 10, 1),
(22, 'pablopablox', 'pablodesc', '2016-12-12 03:42:26', '2016-12-12 03:42:26', 1, 1, 12, 18, 10, 1),
(23, 'pablopabloxxx', 'pablodesc', '2016-12-12 03:44:11', '2016-12-12 03:44:11', 1, 1, 24, 19, 12, 1),
(24, 'pablopabloxxxx', 'pablodesc', '2016-12-12 03:44:59', '2016-12-12 03:44:59', 1, 1, 22, 20, 7, 1),
(25, 'eeeeeeeeeeeeeeeee', 'eeedesc', '2016-12-12 03:46:13', '2016-12-12 03:46:13', 1, 1, 21, 21, 6, 1),
(26, 'eeeeeeeeeeeeeeeee', 'eeedesc', '2016-12-12 03:48:03', '2016-12-12 03:48:03', 1, 1, 15, 1, 5, 1),
(27, 'asdasdasd', 'asdasdasdsadda', '2016-12-12 09:47:46', '2016-12-12 09:47:46', 1, 1, 9, 8, 9, 1),
(28, 'asdsadasfasf', 'asfasfasfasfaf', '2016-12-12 10:37:31', '2016-12-12 10:37:31', 1, 1, 8, 7, 2, 1),
(29, 'afsafasf', 'safasfsafasf', '2016-12-12 10:38:12', '2016-12-12 10:38:12', 1, 1, 2, 8, 1, 1),
(30, 'afsafasf', 'safasfsafasf', '2016-12-12 10:58:12', '2016-12-12 10:58:12', 1, 1, 14, 5, 5, 1),
(31, 'afsafasf', 'safasfsafasf', '2016-12-12 10:58:21', '2016-12-12 10:58:21', 1, 1, 16, 6, 7, 1),
(32, 'asfasdgtag', 'sgsagasggs', '2016-12-12 11:03:11', '2016-12-12 11:03:11', 1, 1, 24, 2, 8, 1),
(33, 'CAMPAÑA DE SALUD', 'SALUD', '2016-12-12 11:07:31', '2016-12-12 11:07:31', 1, 1, 1, 15, 8, 1),
(34, 'Nueva', 'Nueva', '2016-12-12 13:54:57', '2016-12-12 13:54:57', 1, 1, 10, 14, 1, 1),
(35, 'asdadsadas', 'asdaasd', '2016-12-12 14:10:12', '2016-12-12 14:10:12', 1, 1, 2, 13, 2, 1),
(36, 'asfasf', 'asfsafasf', '2016-12-12 14:11:06', '2016-12-12 14:11:06', 1, 1, 3, 13, 11, 1),
(37, 'dsdds', 'dsdsd', '2016-12-12 14:17:02', '2016-12-12 14:17:02', 1, 1, 30, 12, 8, 1),
(38, 'adasdas', 'dasdasd', '2016-12-12 14:31:05', '2016-12-12 14:31:05', 1, 1, 4, 11, 12, 1),
(39, 'adfaf', 'asfasfasf', '2016-12-12 14:32:41', '2016-12-12 14:32:41', 1, 1, 5, 10, 10, 1),
(40, 'asfas', 'fasfsafsaf', '2016-12-12 14:34:27', '2016-12-12 14:34:27', 1, 1, 6, 5, 7, 1),
(41, 'xxx', 'xxxx', '2016-12-12 14:36:09', '2016-12-12 14:36:09', 1, 1, 7, 4, 6, 1),
(42, 'asffas', 'ffsafsaf', '2016-12-12 14:38:07', '2016-12-12 14:38:07', 1, 1, 8, 2, 6, 1),
(43, 'dasd', 'asdsadsa', '2016-12-12 15:05:42', '2016-12-12 15:05:42', 1, 1, 9, 3, 5, 1),
(44, 'dada', 'asda', '2016-12-12 21:21:50', '2016-12-12 21:21:50', 1, 1, 10, 4, 2, 1),
(45, 'sada', 'sdasdad', '2016-12-12 23:59:20', '2016-12-12 23:59:20', 1, 1, 11, 5, 3, 1),
(46, 'asdsa', 'dsadsad', '2016-12-13 11:34:48', '2016-12-13 11:34:48', 1, 1, 12, 7, 3, 1),
(47, 'PABLOTITLE', 'PABLODESC', '2016-12-13 13:34:57', '2016-12-13 13:34:57', 1, 1, 13, 6, 1, 1),
(48, 'CAMPAÑA DE SEGURIDAD', 'SEGURIDAD EN COLONIAS', '2016-12-13 17:51:36', '2016-12-13 17:51:36', 1, 1, 14, 13, 6, 1),
(49, 'CAMPAÑA TECNOLOGÍA', 'TECNOLOGÍA DESCRIPCIÓN', '2016-12-13 17:58:10', '2016-12-13 17:58:10', 1, 1, 15, 12, 11, 1),
(50, 'CAMPAÑA TEST', 'TEST', '2016-12-13 18:00:21', '2016-12-13 18:00:21', 1, 1, 16, 16, 12, 1),
(51, 'CAMPAÑA DESDE CELULAR', 'PROBANDO DESDE EL CELULAR', '2016-12-13 18:51:26', '2016-12-13 18:51:26', 1, 1, 17, 17, 5, 1),
(52, 'CAMPAÑA DESDE CELULAR', 'PROBANDO DESDE EL CELULAR', '2016-12-13 18:51:32', '2016-12-13 18:51:32', 1, 1, 18, 16, 3, 1),
(53, 'CAMPAÑASONIA', 'SONIA DESCRIPCION', '2016-12-13 19:30:56', '2016-12-13 19:30:56', 1, 1, 19, 15, 7, 1),
(54, 'CAMPAÑA SONIA 2', 'DESCRIPCION CAMPAÑA', '2016-12-13 19:44:37', '2016-12-13 19:44:37', 1, 1, 20, 20, 6, 1),
(55, 'wfsafa', 'fafsaffas', '2016-12-25 13:30:07', '2016-12-25 13:30:07', 1, 1, 21, 21, 5, 1),
(56, 'f', 'sfsaf', '2016-12-25 13:37:39', '2016-12-25 13:37:39', 1, 1, 22, 8, 2, 1),
(57, 'gg', 'g', '2016-12-26 08:59:03', '2016-12-26 08:59:03', 1, 1, 23, 19, 7, 1),
(58, 'sada', 'dsad', '2016-12-26 09:50:51', '2016-12-26 09:50:51', 1, 1, 24, 18, 9, 1),
(59, 'nn', 'jhn', '2016-12-26 10:48:18', '2016-12-26 10:48:18', 1, 1, 25, 17, 11, 1),
(60, 'sadsdsa', 'sadsad', '2016-12-26 11:01:23', '2016-12-26 11:01:23', 1, 1, 26, 15, 2, 1),
(61, 'TITLE 26', 'DESC 26', '2016-12-26 12:22:10', '2016-12-26 12:22:10', 1, 1, 27, 12, 1, 1),
(62, 'TITLE 26', 'DESC 26', '2016-12-26 12:22:18', '2016-12-26 12:22:18', 1, 1, 28, 10, 10, 1),
(63, 'NEW CAMPAIGN', 'CAMP', '2016-12-26 16:04:11', '2016-12-26 16:04:11', 1, 1, 29, 6, 7, 1),
(64, 'NEW CAMPAIGN 2', 'NEW CAMPAIGN 2', '2016-12-26 16:11:12', '2016-12-26 16:11:12', 1, 1, 30, 4, 5, 1),
(65, 'NEW CAMPAIGN 2', 'NEW CAMPAIGN 2', '2016-12-26 16:11:37', '2016-12-26 16:11:37', 1, 1, 31, 11, 4, 1),
(66, 'CAMPAÑA TELCEL', 'CAMPAÑA TELCEL', '2016-12-26 17:10:47', '2016-12-26 17:10:47', 1, 1, 32, 16, 3, 1),
(67, 'PABLO CAMPAÑA', 'PABLO CAMPAÑA TELCEL', '2016-12-26 17:14:05', '2016-12-26 17:14:05', 1, 1, 33, 17, 11, 1),
(68, 'CAMPAÑA DE LOGÍSTICA', 'CAMPAÑA DE LOGÍSTICA', '2016-12-30 00:14:51', '2016-12-30 00:14:51', 1, 1, 34, 21, 4, 1),
(69, 'CAMPAÑA TEST 31 DIC', 'CAMPAÑA TEST 31 DIC', '2016-12-31 20:55:09', '2016-12-31 20:55:09', 1, 1, 4, 5, 5, 1),
(70, 'ññññññññññññl', 'ñññññop', '2017-01-02 12:38:51', '2017-01-02 12:38:51', 1, 1, 1, 4, 10, 1),
(71, 'Prueba Sonia', 'xxx', '2017-01-11 11:31:04', '2017-01-11 11:31:04', 1, 1, 25, 44, 4, 1),
(72, 'Prueba Sonia', 'xxx', '2017-01-11 11:31:09', '2017-01-11 11:31:09', 1, 1, 25, 44, 4, 1),
(73, 'Prueba Sonia', 'xxx', '2017-01-11 11:34:07', '2017-01-11 11:34:07', 1, 1, 25, 44, 4, 1),
(74, 'Prueba Sonia', 'xxx', '2017-01-11 11:34:14', '2017-01-11 11:34:14', 1, 1, 25, 44, 4, 1),
(75, 'Prueba Sonia', 'xxx', '2017-01-11 11:34:15', '2017-01-11 11:34:15', 1, 1, 25, 44, 4, 1),
(76, 'Prueba Sonia', 'xxx', '2017-01-11 11:34:20', '2017-01-11 11:34:20', 1, 1, 25, 44, 4, 1),
(77, 'Prueba Sonia', 'xxx', '2017-01-11 11:34:21', '2017-01-11 11:34:21', 1, 1, 25, 44, 4, 1),
(78, 'Prueba Sonia', 'xxx', '2017-01-11 11:34:27', '2017-01-11 11:34:27', 1, 1, 25, 44, 4, 1),
(79, 'Prueba Sonia', 'xxx', '2017-01-11 11:34:30', '2017-01-11 11:34:30', 1, 1, 25, 44, 4, 1),
(80, 'sadsadsa', 'asdsad', '2017-01-15 12:46:33', '2017-01-15 12:46:33', 1, 1, 2, 2, 2, 1),
(81, 'sadsadsa', 'asdsad', '2017-01-15 12:46:39', '2017-01-15 12:46:39', 1, 1, 2, 2, 2, 1),
(82, 'dasdsadsad', 'sadsadasda41241', '2017-01-15 12:53:57', '2017-01-15 12:53:57', 1, 1, 2, 2, 2, 1),
(83, 'test', 'test', '2017-01-15 12:55:32', '2017-01-15 12:55:32', 1, 1, 3, 35, 4, 1),
(84, 'vtest', 'test', '2017-01-15 12:57:51', '2017-01-15 12:57:51', 1, 1, 1, 2, 1, 1),
(85, 'test2', 'test2', '2017-01-15 13:29:34', '2017-01-15 13:29:34', 1, 1, 2, 3, 2, 1),
(91, 'sonia prueba 2', 'sonia prueba 2', '2017-01-21 12:31:25', '2017-01-21 12:31:25', 1, 1, 1, 1, 1, 1),
(87, 'prueba 17 enero', 'prueba 17 enero', '2017-01-17 20:18:22', '2017-01-17 20:18:22', 1, 1, 1, 1, 5, 1),
(92, 'sonia prueba 2', 'sonia prueba 2', '2017-01-21 12:31:29', '2017-01-21 12:31:29', 1, 1, 1, 1, 1, 1),
(93, 'sonia prueba 2', 'sonia prueba 2', '2017-01-21 12:31:30', '2017-01-21 12:31:30', 1, 1, 1, 1, 1, 1),
(108, 'x', 'x', '2017-10-12 19:12:44', '2017-10-12 19:12:44', 1, 23, 1, 2, 1, 1),
(109, 'x', 'x', '2017-10-31 14:54:16', '2017-10-31 14:54:16', 1, 23, 1, 1, 1, 1),
(106, 'ALL MATERIALS', 'ALL MATERIALS', '2017-06-01 00:01:39', '2017-06-01 00:01:39', 1, 1, 1, 1, 1, 1),
(110, 'Shampoo', 'esta campaña es para shampoo', '2017-11-23 19:39:13', '2017-11-23 19:39:13', 1, 23, 5, 3, 2, 1),
(111, 'Test', 'test', '2017-11-24 08:40:52', '2017-11-24 08:40:52', 1, 23, 10, 9, 7, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Campaign_Fonts`
--

CREATE TABLE `Campaign_Fonts` (
  `id_cgfont` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `fk_campaign` int(9) NOT NULL,
  `status` int(9) NOT NULL,
  `font` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Campaign_Fonts`
--

INSERT INTO `Campaign_Fonts` (`id_cgfont`, `date_up`, `date_update`, `fk_campaign`, `status`, `font`) VALUES
(1, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 'Raleway-Light.ttf'),
(2, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 'Raleway-Medium.ttf'),
(3, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, 'Raleway-ExtraLight.ttf'),
(4, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, 'Raleway-Heavy.ttf'),
(5, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, 'Raleway-ExtraBold.ttf'),
(6, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Raleway-ExtraBold.ttf'),
(7, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Raleway-ExtraLight.ttf'),
(8, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Raleway-Heavy.ttf'),
(9, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Raleway-Light.ttf'),
(10, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Raleway-Medium.ttf'),
(11, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Raleway-Regular.ttf'),
(12, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Raleway-Bold.ttf'),
(13, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, 'Raleway-Light.ttf'),
(14, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, 'Raleway-Medium.ttf'),
(15, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, 'Raleway-Regular.ttf'),
(18, '2016-12-13 19:30:57', '2016-12-13 19:30:57', 53, 1, 'LockMDL2.ttf'),
(52, '2017-01-17 20:18:23', '2017-01-17 20:18:23', 87, 1, 'OpenSans-BoldItalic.ttf'),
(53, '2017-01-20 21:14:55', '2017-01-20 21:14:55', 87, 1, 'Steelworks Vintage Demo.otf'),
(54, '2017-01-20 21:14:55', '2017-01-20 21:14:55', 87, 1, 'FoglihtenNo07.otf'),
(27, '2016-12-31 20:55:09', '2016-12-31 20:55:09', 69, 1, 'glyphicons-halflings-regular.ttf'),
(28, '2016-12-31 20:55:09', '2016-12-31 20:55:09', 69, 1, 'glyphicons-halflings-regular.ttf'),
(51, '2017-01-15 12:46:39', '2017-01-15 12:46:39', 81, 1, 'OpenSans-BoldItalic.ttf'),
(49, '2017-01-08 23:40:19', '2017-01-08 23:40:19', 69, 1, 'Wolf in the City.ttf'),
(50, '2017-01-15 12:46:33', '2017-01-15 12:46:33', 80, 1, 'OpenSans-BoldItalic.ttf');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Campaign_Material`
--

CREATE TABLE `Campaign_Material` (
  `id_cgmaterial` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `fk_campaign` int(9) NOT NULL,
  `status` int(9) NOT NULL,
  `fk_material` int(9) NOT NULL,
  `download` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Campaign_Material`
--

INSERT INTO `Campaign_Material` (`id_cgmaterial`, `date_up`, `date_update`, `fk_campaign`, `status`, `fk_material`, `download`) VALUES
(1, '2016-12-12 03:42:26', '2016-12-12 03:42:26', 22, 1, 1, 0),
(2, '2016-12-12 03:42:26', '2016-12-12 03:42:26', 22, 1, 2, 0),
(3, '2016-12-12 03:42:26', '2016-12-12 03:42:26', 22, 1, 3, 0),
(4, '2016-12-12 11:07:31', '2016-12-12 11:07:31', 33, 1, 14, 0),
(5, '2016-12-12 11:07:31', '2016-12-12 11:07:31', 33, 1, 15, 0),
(6, '2016-12-12 11:07:31', '2016-12-12 11:07:31', 33, 1, 16, 0),
(7, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 3, 0),
(8, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 4, 0),
(9, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 5, 0),
(10, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 6, 0),
(11, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, 13, 0),
(12, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, 16, 0),
(13, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, 21, 0),
(14, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 1, 0),
(15, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 5, 0),
(16, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 7, 0),
(17, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, 12, 0),
(18, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, 22, 0),
(19, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, 1, 0),
(20, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, 2, 0),
(21, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, 3, 0),
(22, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, 4, 0),
(23, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, 5, 0),
(24, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, 23, 0),
(25, '2016-12-26 12:22:10', '2016-12-26 12:22:10', 61, 1, 1, 0),
(26, '2016-12-26 12:22:10', '2016-12-26 12:22:10', 61, 1, 2, 0),
(27, '2016-12-26 12:22:10', '2016-12-26 12:22:10', 61, 1, 3, 0),
(28, '2016-12-26 12:22:18', '2016-12-26 12:22:18', 62, 1, 1, 0),
(29, '2016-12-26 12:22:18', '2016-12-26 12:22:18', 62, 1, 2, 0),
(30, '2016-12-26 12:22:18', '2016-12-26 12:22:18', 62, 1, 3, 0),
(31, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 1, 0),
(32, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 2, 0),
(33, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 3, 0),
(34, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 4, 0),
(35, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 5, 0),
(85, '2017-01-11 11:34:21', '2017-01-11 11:34:21', 77, 1, 2, 0),
(75, '2017-01-11 11:31:04', '2017-01-11 11:31:04', 71, 1, 3, 0),
(39, '2017-01-02 12:38:51', '2017-01-02 12:38:51', 70, 1, 1, 0),
(40, '2017-01-02 12:38:51', '2017-01-02 12:38:51', 70, 1, 2, 0),
(329, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 2, 0),
(328, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 1, 0),
(84, '2017-01-11 11:34:20', '2017-01-11 11:34:20', 76, 1, 2, 0),
(82, '2017-01-11 11:34:15', '2017-01-11 11:34:15', 75, 1, 2, 0),
(83, '2017-01-11 11:34:15', '2017-01-11 11:34:15', 75, 1, 3, 0),
(81, '2017-01-11 11:34:14', '2017-01-11 11:34:14', 74, 1, 3, 0),
(79, '2017-01-11 11:34:07', '2017-01-11 11:34:07', 73, 1, 3, 0),
(80, '2017-01-11 11:34:14', '2017-01-11 11:34:14', 74, 1, 2, 0),
(78, '2017-01-11 11:34:07', '2017-01-11 11:34:07', 73, 1, 2, 0),
(76, '2017-01-11 11:31:10', '2017-01-11 11:31:10', 72, 1, 2, 0),
(77, '2017-01-11 11:31:10', '2017-01-11 11:31:10', 72, 1, 3, 0),
(73, '2017-01-05 19:49:30', '2017-01-05 19:49:30', 69, 1, 7, 0),
(74, '2017-01-11 11:31:04', '2017-01-11 11:31:04', 71, 1, 2, 0),
(72, '2017-01-05 19:49:30', '2017-01-05 19:49:30', 69, 1, 6, 0),
(71, '2017-01-05 19:49:30', '2017-01-05 19:49:30', 69, 1, 1, 0),
(69, '2017-01-03 20:27:06', '2017-01-03 20:27:06', 69, 1, 5, 0),
(68, '2017-01-03 20:27:06', '2017-01-03 20:27:06', 69, 1, 4, 0),
(67, '2017-01-03 15:19:19', '2017-01-03 15:19:19', 69, 1, 3, 0),
(70, '2017-01-05 19:49:30', '2017-01-05 19:49:30', 69, 1, 2, 0),
(86, '2017-01-15 12:46:33', '2017-01-15 12:46:33', 80, 1, 1, 0),
(87, '2017-01-15 12:46:33', '2017-01-15 12:46:33', 80, 1, 2, 0),
(88, '2017-01-15 12:46:39', '2017-01-15 12:46:39', 81, 1, 1, 0),
(89, '2017-01-15 12:46:39', '2017-01-15 12:46:39', 81, 1, 2, 0),
(90, '2017-01-15 12:53:57', '2017-01-15 12:53:57', 82, 1, 2, 0),
(91, '2017-01-15 12:55:32', '2017-01-15 12:55:32', 83, 1, 2, 0),
(92, '2017-01-15 12:57:51', '2017-01-15 12:57:51', 84, 1, 1, 0),
(93, '2017-01-15 13:29:34', '2017-01-15 13:29:34', 85, 1, 1, 0),
(95, '2017-01-17 20:18:23', '2017-01-17 20:18:23', 87, 1, 1, 0),
(96, '2017-01-17 20:18:23', '2017-01-17 20:18:23', 87, 1, 2, 0),
(97, '2017-01-17 21:06:54', '2017-01-17 21:06:54', 87, 1, 3, 0),
(98, '2017-01-17 21:06:54', '2017-01-17 21:06:54', 87, 1, 4, 0),
(314, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 15, 0),
(313, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 14, 0),
(312, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 13, 0),
(311, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 12, 0),
(310, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 11, 0),
(309, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 10, 0),
(308, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 9, 0),
(307, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 8, 0),
(162, '2017-04-26 01:36:10', '2017-04-26 01:36:10', 85, 1, 3, 0),
(161, '2017-04-26 01:36:10', '2017-04-26 01:36:10', 85, 1, 2, 0),
(306, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 7, 0),
(305, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 6, 0),
(304, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 5, 0),
(303, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 4, 0),
(302, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 3, 0),
(301, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 2, 0),
(300, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 1, 0),
(299, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 31, 0),
(298, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 30, 0),
(297, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 29, 0),
(296, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 28, 0),
(295, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 27, 0),
(294, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 23, 0),
(293, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 22, 0),
(292, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 21, 0),
(291, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 20, 0),
(290, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 19, 0),
(289, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 18, 0),
(288, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 17, 0),
(287, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 16, 0),
(286, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 15, 0),
(285, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 14, 0),
(284, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 13, 0),
(283, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 12, 0),
(282, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 11, 0),
(281, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 10, 0),
(280, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 9, 0),
(279, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 8, 0),
(272, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 1, 0),
(273, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 2, 0),
(274, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 3, 0),
(275, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 4, 0),
(276, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 5, 0),
(277, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 6, 0),
(278, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 7, 0),
(327, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 31, 0),
(326, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 30, 0),
(325, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 29, 0),
(324, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 28, 0),
(323, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 27, 0),
(322, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 23, 0),
(321, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 22, 0),
(320, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 21, 0),
(319, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 20, 0),
(318, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 19, 0),
(315, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 16, 0),
(316, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 17, 0),
(317, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, 18, 0),
(220, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 1, 0),
(221, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 2, 0),
(222, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 3, 0),
(223, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 4, 0),
(224, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 5, 0),
(225, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 6, 0),
(226, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 7, 0),
(227, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 8, 0),
(228, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 9, 0),
(229, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 10, 0),
(230, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 11, 0),
(231, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 12, 0),
(232, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 13, 0),
(233, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 14, 0),
(234, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 15, 0),
(235, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 16, 0),
(236, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 17, 0),
(237, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 18, 0),
(238, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 19, 0),
(239, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 20, 0),
(240, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 21, 0),
(241, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 22, 0),
(242, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 23, 0),
(243, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 27, 0),
(244, '2017-06-01 00:01:39', '2017-06-01 00:01:39', 106, 1, 28, 0),
(330, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 3, 0),
(331, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 4, 0),
(332, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 5, 0),
(333, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 6, 0),
(334, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 7, 0),
(335, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 8, 0),
(336, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 9, 0),
(337, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 10, 0),
(338, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 11, 0),
(339, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 12, 0),
(340, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 13, 0),
(341, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 14, 0),
(342, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 15, 0),
(343, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 16, 0),
(344, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 17, 0),
(345, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 18, 0),
(346, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 19, 0),
(347, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 20, 0),
(348, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 21, 0),
(349, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 22, 0),
(350, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 23, 0),
(351, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 27, 0),
(352, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 28, 0),
(353, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 29, 0),
(354, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 30, 0),
(355, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 31, 0),
(356, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 1, 0),
(357, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 2, 0),
(358, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 3, 0),
(359, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 4, 0),
(360, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 5, 0),
(361, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 6, 0),
(362, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 7, 0),
(363, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 8, 0),
(364, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 9, 0),
(365, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 10, 0),
(366, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 11, 0),
(367, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 12, 0),
(368, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 13, 0),
(369, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 14, 0),
(370, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 15, 0),
(371, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 16, 0),
(372, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 17, 0),
(373, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 18, 0),
(374, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 19, 0),
(375, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 20, 0),
(376, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 21, 0),
(377, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 22, 0),
(378, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 23, 0),
(379, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 27, 0),
(380, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 28, 0),
(381, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 29, 0),
(382, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 30, 0),
(383, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 31, 0),
(384, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 32, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Campaign_Pack`
--

CREATE TABLE `Campaign_Pack` (
  `id_cgpack` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `fk_campaign` int(9) NOT NULL,
  `status` int(9) NOT NULL,
  `image` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Campaign_Pack`
--

INSERT INTO `Campaign_Pack` (`id_cgpack`, `date_up`, `date_update`, `fk_campaign`, `status`, `image`) VALUES
(6, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, '512.png'),
(7, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, '740.png'),
(8, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, '1020.png'),
(9, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 'evidenciareportes.png'),
(10, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, '1.png'),
(11, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Chrysanthemum.jpg'),
(12, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Desert.jpg'),
(13, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Hydrangeas.jpg'),
(14, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Jellyfish.jpg'),
(15, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Koala.jpg'),
(16, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Lighthouse.jpg'),
(17, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Penguins.jpg'),
(18, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'Tulips.jpg'),
(19, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, 'Penguins.jpg'),
(20, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, 'Tulips.jpg'),
(21, '2016-12-13 18:51:27', '2016-12-13 18:51:27', 51, 1, 'edited_Screenshot_2016-11-30-09-36-50.jpg'),
(22, '2016-12-13 18:51:27', '2016-12-13 18:51:27', 51, 1, 'edited_20161003_000410.jpg'),
(23, '2016-12-13 18:51:27', '2016-12-13 18:51:27', 51, 1, 'edited_Screenshot_2016-10-26-12-05-02.jpg'),
(24, '2016-12-13 18:51:33', '2016-12-13 18:51:33', 52, 1, 'edited_Screenshot_2016-11-30-09-36-50.jpg'),
(25, '2016-12-13 18:51:33', '2016-12-13 18:51:33', 52, 1, 'edited_20161003_000410.jpg'),
(26, '2016-12-13 18:51:33', '2016-12-13 18:51:33', 52, 1, 'edited_Screenshot_2016-10-26-12-05-02.jpg'),
(27, '2016-12-13 19:30:57', '2016-12-13 19:30:57', 53, 1, 'WhatsApp Image 2016-11-09 at 19.33.05.jpeg'),
(28, '2016-12-13 19:30:57', '2016-12-13 19:30:57', 53, 1, '2151787.jpg'),
(29, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, '01.jpg'),
(33, '2016-12-26 12:22:10', '2016-12-26 12:22:10', 61, 1, ''),
(34, '2016-12-26 12:22:18', '2016-12-26 12:22:18', 62, 1, ''),
(35, '2016-12-26 16:04:11', '2016-12-26 16:04:11', 63, 1, ''),
(36, '2016-12-26 16:04:11', '2016-12-26 16:04:11', 63, 1, ''),
(37, '2016-12-26 16:04:11', '2016-12-26 16:04:11', 63, 1, ''),
(38, '2016-12-26 16:11:12', '2016-12-26 16:11:12', 64, 1, 'alta.jpg'),
(39, '2016-12-26 16:11:12', '2016-12-26 16:11:12', 64, 1, 'croiss.png'),
(40, '2016-12-26 16:11:38', '2016-12-26 16:11:38', 65, 1, 'alta.jpg'),
(41, '2016-12-26 16:11:38', '2016-12-26 16:11:38', 65, 1, 'croiss.png'),
(42, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, 'TELCEL2.jpg'),
(43, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, 'TELCEL.jpg'),
(44, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, 'TELCEL3.png'),
(45, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 'TELCEL2.jpg'),
(46, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 'TELCEL.jpg'),
(47, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 'TELCEL3.png'),
(48, '2016-12-30 00:14:51', '2016-12-30 00:14:51', 68, 1, 'icon-email.png'),
(49, '2016-12-30 00:14:52', '2016-12-30 00:14:52', 68, 1, 'mock.png'),
(50, '2016-12-30 00:14:52', '2016-12-30 00:14:52', 68, 1, 'icon-user.png'),
(51, '2016-12-30 00:14:52', '2016-12-30 00:14:52', 68, 1, 'wizadwhite.png'),
(52, '2016-12-30 00:14:52', '2016-12-30 00:14:52', 68, 1, 'face3.jpg'),
(88, '2017-01-15 12:46:39', '2017-01-15 12:46:39', 81, 1, 'Wizad-(White).png'),
(55, '2017-01-02 12:38:51', '2017-01-02 12:38:51', 70, 1, '12315197_1067978123246989_1079679984_o.jpg'),
(56, '2017-01-02 12:38:51', '2017-01-02 12:38:51', 70, 1, '13.png'),
(206, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 'IMG_4005.JPG'),
(205, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 'IMG_4005.JPG'),
(87, '2017-01-15 12:46:33', '2017-01-15 12:46:33', 80, 1, 'Wizad-(White).png'),
(86, '2017-01-11 11:34:31', '2017-01-11 11:34:31', 79, 1, 'Wizad-W.png'),
(85, '2017-01-11 11:34:27', '2017-01-11 11:34:27', 78, 1, 'Wizad-W.png'),
(84, '2017-01-11 11:34:21', '2017-01-11 11:34:21', 77, 1, 'Wizad-W.png'),
(83, '2017-01-11 11:34:20', '2017-01-11 11:34:20', 76, 1, 'Wizad-W.png'),
(82, '2017-01-11 11:34:15', '2017-01-11 11:34:15', 75, 1, 'Wizad-W.png'),
(81, '2017-01-11 11:34:14', '2017-01-11 11:34:14', 74, 1, 'Wizad-W.png'),
(80, '2017-01-11 11:34:07', '2017-01-11 11:34:07', 73, 1, 'Wizad-W.png'),
(77, '2017-01-05 19:50:35', '2017-01-05 19:50:35', 69, 1, 'TELCEL3.png'),
(76, '2017-01-05 19:50:35', '2017-01-05 19:50:35', 69, 1, 'TELCEL.jpg'),
(75, '2017-01-05 19:50:35', '2017-01-05 19:50:35', 69, 1, 'TELCEL2.jpg'),
(79, '2017-01-11 11:31:10', '2017-01-11 11:31:10', 72, 1, 'Wizad-W.png'),
(78, '2017-01-11 11:31:04', '2017-01-11 11:31:04', 71, 1, 'Wizad-W.png'),
(89, '2017-01-15 12:53:57', '2017-01-15 12:53:57', 82, 1, 'TELCEL3.png'),
(90, '2017-01-17 20:18:23', '2017-01-17 20:18:23', 87, 1, 'TELCEL3.png'),
(91, '2017-01-17 20:39:48', '2017-01-17 20:39:48', 87, 1, 'TELCEL2.jpg'),
(92, '2017-01-17 20:39:48', '2017-01-17 20:39:48', 87, 1, 'TELCEL.jpg'),
(93, '2017-01-17 20:39:48', '2017-01-17 20:39:48', 87, 1, 'mbled.png'),
(128, '2017-04-26 01:35:33', '2017-04-26 01:35:33', 85, 1, '13.png'),
(127, '2017-04-26 01:35:33', '2017-04-26 01:35:33', 85, 1, '1.png'),
(142, '2017-06-01 18:38:15', '2017-06-01 18:38:15', 106, 1, '61972.png'),
(143, '2017-06-01 18:38:15', '2017-06-01 18:38:15', 106, 1, 'autofin iconos.png'),
(144, '2017-06-01 18:38:15', '2017-06-01 18:38:15', 106, 1, 'autofinazul.png'),
(204, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 'Mano de obra fina Zapatos de Mujer Tapita Loafer Negro Steve Madden Negro ADALYNN 017_0.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Campaign_Palette`
--

CREATE TABLE `Campaign_Palette` (
  `id_cgpalette` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `fk_campaign` int(9) NOT NULL,
  `status` int(9) NOT NULL,
  `color` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Campaign_Palette`
--

INSERT INTO `Campaign_Palette` (`id_cgpalette`, `date_up`, `date_update`, `fk_campaign`, `status`, `color`) VALUES
(1, '2016-12-12 10:37:32', '2016-12-12 10:37:32', 28, 1, '#975656'),
(2, '2016-12-12 10:38:13', '2016-12-12 10:38:13', 29, 1, '#ae6a6a'),
(3, '2016-12-12 10:58:13', '2016-12-12 10:58:13', 30, 1, '#ae6a6a'),
(4, '2016-12-12 10:58:21', '2016-12-12 10:58:21', 31, 1, '#ae6a6a'),
(5, '2016-12-12 11:07:31', '2016-12-12 11:07:31', 33, 1, '#33ffba'),
(6, '2016-12-12 11:07:31', '2016-12-12 11:07:31', 33, 1, '#aa33ff'),
(7, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, '#5600ff'),
(8, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, '#ff0000'),
(9, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, '#0e4dea'),
(10, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, '#e317dc'),
(11, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, '#ab1818'),
(12, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, '#1865ab'),
(13, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, '#06111c'),
(14, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, '#814646'),
(15, '2016-12-13 18:51:27', '2016-12-13 18:51:27', 51, 1, '#a14545'),
(16, '2016-12-13 18:51:27', '2016-12-13 18:51:27', 51, 1, '#2716f2'),
(17, '2016-12-13 18:51:33', '2016-12-13 18:51:33', 52, 1, '#a14545'),
(18, '2016-12-13 18:51:33', '2016-12-13 18:51:33', 52, 1, '#2716f2'),
(19, '2016-12-13 19:30:57', '2016-12-13 19:30:57', 53, 1, '#864e4e'),
(20, '2016-12-13 19:30:57', '2016-12-13 19:30:57', 53, 1, '#FFFFF'),
(21, '2016-12-13 19:30:57', '2016-12-13 19:30:57', 53, 1, '#9220dd'),
(22, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, '#913030'),
(23, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, '#d1ff00'),
(24, '2016-12-26 12:22:10', '2016-12-26 12:22:10', 61, 1, '#ae2e2e'),
(25, '2016-12-26 12:22:10', '2016-12-26 12:22:10', 61, 1, '#7e2eae'),
(26, '2016-12-26 12:22:18', '2016-12-26 12:22:18', 62, 1, '#ae2e2e'),
(27, '2016-12-26 12:22:18', '2016-12-26 12:22:18', 62, 1, '#7e2eae'),
(28, '2016-12-26 16:04:11', '2016-12-26 16:04:11', 63, 1, '#811818'),
(29, '2016-12-26 16:04:11', '2016-12-26 16:04:11', 63, 1, '#0000fc'),
(30, '2016-12-26 16:11:12', '2016-12-26 16:11:12', 64, 1, '#d33a3a'),
(31, '2016-12-26 16:11:12', '2016-12-26 16:11:12', 64, 1, '#3a56d3'),
(32, '2016-12-26 16:11:38', '2016-12-26 16:11:38', 65, 1, '#d33a3a'),
(33, '2016-12-26 16:11:38', '2016-12-26 16:11:38', 65, 1, '#3a56d3'),
(34, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, '#6c73f4'),
(35, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, '#ffffff'),
(36, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, '#ffffff'),
(37, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, '#fe2a2a'),
(38, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, '#3200ff'),
(39, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, '#cec2ff'),
(40, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, '#b5b5b5'),
(41, '2016-12-30 00:14:51', '2016-12-30 00:14:51', 68, 1, '#b31818'),
(42, '2016-12-30 00:14:51', '2016-12-30 00:14:51', 68, 1, '#7600ff'),
(43, '2016-12-30 00:14:51', '2016-12-30 00:14:51', 68, 1, '#0a0118'),
(44, '2016-12-31 20:55:09', '2016-12-31 20:55:09', 69, 1, '#e30000'),
(45, '2016-12-31 20:55:09', '2016-12-31 20:55:09', 69, 1, '#00e377'),
(46, '2016-12-31 20:55:09', '2016-12-31 20:55:09', 69, 1, '#e36000'),
(47, '2016-12-31 20:55:09', '2016-12-31 20:55:09', 69, 1, '#a3856d'),
(48, '2016-12-31 20:55:09', '2016-12-31 20:55:09', 69, 1, '#67f097'),
(49, '2016-12-31 20:55:09', '2016-12-31 20:55:09', 69, 1, '#67f097'),
(50, '2017-01-02 12:38:51', '2017-01-02 12:38:51', 70, 1, '#9c1919'),
(51, '2017-01-02 12:38:51', '2017-01-02 12:38:51', 70, 1, '#3c199c'),
(145, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, '#743636'),
(144, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, ''),
(80, '2017-01-11 11:34:14', '2017-01-11 11:34:14', 74, 1, '#462446'),
(79, '2017-01-11 11:34:14', '2017-01-11 11:34:14', 74, 1, ''),
(78, '2017-01-11 11:34:07', '2017-01-11 11:34:07', 73, 1, '#44BBFF'),
(77, '2017-01-11 11:34:07', '2017-01-11 11:34:07', 73, 1, '#462446'),
(76, '2017-01-11 11:34:07', '2017-01-11 11:34:07', 73, 1, ''),
(75, '2017-01-11 11:31:10', '2017-01-11 11:31:10', 72, 1, '#44BBFF'),
(74, '2017-01-11 11:31:10', '2017-01-11 11:31:10', 72, 1, '#462446'),
(73, '2017-01-11 11:31:10', '2017-01-11 11:31:10', 72, 1, ''),
(72, '2017-01-11 11:31:04', '2017-01-11 11:31:04', 71, 1, '#44BBFF'),
(71, '2017-01-11 11:31:04', '2017-01-11 11:31:04', 71, 1, '#462446'),
(70, '2017-01-11 11:31:04', '2017-01-11 11:31:04', 71, 1, ''),
(69, '2017-01-09 20:02:53', '2017-01-09 20:02:53', 69, 1, '#ffffff'),
(68, '2017-01-03 20:27:06', '2017-01-03 20:27:06', 69, 1, '#5f76ac'),
(67, '2017-01-03 15:16:06', '2017-01-03 15:16:06', 69, 1, '#3720c4'),
(81, '2017-01-11 11:34:14', '2017-01-11 11:34:14', 74, 1, '#44BBFF'),
(82, '2017-01-11 11:34:15', '2017-01-11 11:34:15', 75, 1, ''),
(83, '2017-01-11 11:34:15', '2017-01-11 11:34:15', 75, 1, '#462446'),
(84, '2017-01-11 11:34:15', '2017-01-11 11:34:15', 75, 1, '#44BBFF'),
(85, '2017-01-11 11:34:20', '2017-01-11 11:34:20', 76, 1, ''),
(86, '2017-01-11 11:34:20', '2017-01-11 11:34:20', 76, 1, '#462446'),
(87, '2017-01-11 11:34:20', '2017-01-11 11:34:20', 76, 1, '#44BBFF'),
(88, '2017-01-11 11:34:21', '2017-01-11 11:34:21', 77, 1, ''),
(89, '2017-01-11 11:34:21', '2017-01-11 11:34:21', 77, 1, '#462446'),
(90, '2017-01-11 11:34:21', '2017-01-11 11:34:21', 77, 1, '#44BBFF'),
(91, '2017-01-11 11:34:27', '2017-01-11 11:34:27', 78, 1, ''),
(92, '2017-01-11 11:34:27', '2017-01-11 11:34:27', 78, 1, '#462446'),
(93, '2017-01-11 11:34:27', '2017-01-11 11:34:27', 78, 1, '#44BBFF'),
(94, '2017-01-11 11:34:31', '2017-01-11 11:34:31', 79, 1, ''),
(95, '2017-01-11 11:34:31', '2017-01-11 11:34:31', 79, 1, '#462446'),
(96, '2017-01-11 11:34:31', '2017-01-11 11:34:31', 79, 1, '#44BBFF'),
(97, '2017-01-15 12:46:33', '2017-01-15 12:46:33', 80, 1, ''),
(98, '2017-01-15 12:46:33', '2017-01-15 12:46:33', 80, 1, ''),
(99, '2017-01-15 12:46:39', '2017-01-15 12:46:39', 81, 1, ''),
(100, '2017-01-15 12:46:39', '2017-01-15 12:46:39', 81, 1, ''),
(101, '2017-01-15 12:53:57', '2017-01-15 12:53:57', 82, 1, ''),
(102, '2017-01-15 12:55:32', '2017-01-15 12:55:32', 83, 1, ''),
(103, '2017-01-15 12:55:32', '2017-01-15 12:55:32', 83, 1, '#e21d1d'),
(104, '2017-01-15 12:57:51', '2017-01-15 12:57:51', 84, 1, '#07ff75'),
(110, '2017-01-26 18:21:42', '2017-01-26 18:21:42', 87, 1, '#8f00ff'),
(106, '2017-01-17 20:18:23', '2017-01-17 20:18:23', 87, 1, '#f20000'),
(107, '2017-01-17 20:18:23', '2017-01-17 20:18:23', 87, 1, '#5c2020'),
(141, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, '#5e2e2e'),
(142, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, ''),
(143, '2017-10-31 14:54:16', '2017-10-31 14:54:16', 109, 1, '#856767'),
(146, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, '#2566845'),
(147, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, '#b74545'),
(148, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, '#177525');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Campaign_Texts`
--

CREATE TABLE `Campaign_Texts` (
  `id_cgtext` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `fk_campaign` int(9) NOT NULL,
  `status` int(9) NOT NULL,
  `text` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Campaign_Texts`
--

INSERT INTO `Campaign_Texts` (`id_cgtext`, `date_up`, `date_update`, `fk_campaign`, `status`, `text`) VALUES
(1, '2016-12-12 03:44:11', '2016-12-12 03:44:11', 23, 1, 'xssxsxsxs'),
(2, '2016-12-12 03:44:59', '2016-12-12 03:44:59', 24, 1, 'xssxsxsxs'),
(3, '2016-12-12 03:46:13', '2016-12-12 03:46:13', 25, 1, 'ttttt1'),
(4, '2016-12-12 03:48:03', '2016-12-12 03:48:03', 26, 1, 'ttttt1'),
(5, '2016-12-12 09:47:46', '2016-12-12 09:47:46', 27, 1, 'asdasdasdasdasdas'),
(6, '2016-12-12 10:37:31', '2016-12-12 10:37:31', 28, 1, 'afasfasfasfasf'),
(7, '2016-12-12 10:38:13', '2016-12-12 10:38:13', 29, 1, 'asfsafasfasfsfsafsa'),
(8, '2016-12-12 10:54:22', '2016-12-12 10:54:22', 27, 1, 'asdasf'),
(9, '2016-12-12 10:58:13', '2016-12-12 10:58:13', 30, 1, 'asfsafasfasfsfsafsa'),
(10, '2016-12-12 10:58:21', '2016-12-12 10:58:21', 31, 1, 'asfsafasfasfsfsafsa'),
(11, '2016-12-12 11:03:13', '2016-12-12 11:03:13', 32, 1, 'fasfasfasgsa'),
(12, '2016-12-12 11:07:31', '2016-12-12 11:07:31', 33, 1, 'SALUD 1'),
(13, '2016-12-12 11:07:31', '2016-12-12 11:07:31', 33, 1, 'SALUD 2'),
(14, '2016-12-12 11:07:31', '2016-12-12 11:07:31', 33, 1, 'SALUD 3'),
(15, '2016-12-12 14:11:16', '2016-12-12 14:11:16', 36, 1, 'afgasf'),
(16, '2016-12-12 14:11:16', '2016-12-12 14:11:16', 36, 1, 'asfasfas'),
(17, '2016-12-12 14:11:16', '2016-12-12 14:11:16', 36, 1, 'fsafsaf'),
(18, '2016-12-12 14:11:16', '2016-12-12 14:11:16', 36, 1, 'fsafafasf'),
(19, '2016-12-12 14:12:21', '2016-12-12 14:12:21', 36, 1, 'afgasf'),
(20, '2016-12-12 14:12:21', '2016-12-12 14:12:21', 36, 1, 'asfasfas'),
(21, '2016-12-12 14:12:21', '2016-12-12 14:12:21', 36, 1, 'fsafsaf'),
(22, '2016-12-12 14:12:21', '2016-12-12 14:12:21', 36, 1, 'fsafafasf'),
(23, '2016-12-12 14:13:32', '2016-12-12 14:13:32', 36, 1, 'afgasf'),
(24, '2016-12-12 14:13:32', '2016-12-12 14:13:32', 36, 1, 'asfasfas'),
(25, '2016-12-12 14:13:32', '2016-12-12 14:13:32', 36, 1, 'fsafsaf'),
(26, '2016-12-12 14:13:32', '2016-12-12 14:13:32', 36, 1, 'fsafafasf'),
(27, '2016-12-12 14:17:25', '2016-12-12 14:17:25', 37, 1, 'dsdsdsdsd'),
(28, '2016-12-12 14:31:08', '2016-12-12 14:31:08', 38, 1, 'asdasdasd'),
(29, '2016-12-12 14:32:45', '2016-12-12 14:32:45', 39, 1, 'asfasfasf'),
(30, '2016-12-12 14:34:31', '2016-12-12 14:34:31', 40, 1, 'asfasfasfa'),
(31, '2016-12-12 14:36:14', '2016-12-12 14:36:14', 41, 1, 'lkljl'),
(32, '2016-12-12 14:38:11', '2016-12-12 14:38:11', 42, 1, 'asfsafsa'),
(33, '2016-12-12 15:05:45', '2016-12-12 15:05:45', 43, 1, 'asd'),
(34, '2016-12-12 21:21:53', '2016-12-12 21:21:53', 44, 1, 'sadasdad'),
(35, '2016-12-12 23:59:22', '2016-12-12 23:59:22', 45, 1, ''),
(36, '2016-12-13 11:34:54', '2016-12-13 11:34:54', 46, 1, 'asdasd'),
(37, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 'TEXT1T'),
(38, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 'TEXT2T'),
(39, '2016-12-13 13:34:58', '2016-12-13 13:34:58', 47, 1, 'TEXT3T'),
(40, '2016-12-13 17:51:36', '2016-12-13 17:51:36', 48, 1, 'SEGURIDAD EN COLONIAS'),
(41, '2016-12-13 17:58:10', '2016-12-13 17:58:10', 49, 1, 'TECNOLOGÃA EMERGENTE'),
(42, '2016-12-13 18:00:21', '2016-12-13 18:00:21', 50, 1, 'TEST TEXT'),
(43, '2016-12-13 18:51:27', '2016-12-13 18:51:27', 51, 1, 'Texto 1'),
(44, '2016-12-13 18:51:27', '2016-12-13 18:51:27', 51, 1, 'Texto 2'),
(45, '2016-12-13 18:51:33', '2016-12-13 18:51:33', 52, 1, 'Texto 1'),
(46, '2016-12-13 18:51:33', '2016-12-13 18:51:33', 52, 1, 'Texto 2'),
(47, '2016-12-13 19:30:57', '2016-12-13 19:30:57', 53, 1, 'SONIA1'),
(48, '2016-12-13 19:44:37', '2016-12-13 19:44:37', 54, 1, 'TEXTO  1'),
(49, '2016-12-25 13:30:12', '2016-12-25 13:30:12', 55, 1, 'safsa'),
(50, '2016-12-25 13:30:12', '2016-12-25 13:30:12', 55, 1, 'fsafsafafa'),
(51, '2016-12-25 13:37:40', '2016-12-25 13:37:40', 56, 1, ''),
(52, '2016-12-26 08:59:05', '2016-12-26 08:59:05', 57, 1, ''),
(53, '2016-12-26 10:48:21', '2016-12-26 10:48:21', 59, 1, ''),
(54, '2016-12-26 11:01:26', '2016-12-26 11:01:26', 60, 1, 'fasfsaf'),
(55, '2016-12-26 12:22:10', '2016-12-26 12:22:10', 61, 1, 'TEXT26'),
(56, '2016-12-26 12:22:18', '2016-12-26 12:22:18', 62, 1, 'TEXT26'),
(57, '2016-12-26 16:04:11', '2016-12-26 16:04:11', 63, 1, 'NEW CAMPAIGN'),
(58, '2016-12-26 16:11:12', '2016-12-26 16:11:12', 64, 1, 'NEW CAMPAIGN 2'),
(59, '2016-12-26 16:11:38', '2016-12-26 16:11:38', 65, 1, 'NEW CAMPAIGN 2'),
(60, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, 'CAMPAÑA TELCEL'),
(61, '2016-12-26 17:10:47', '2016-12-26 17:10:47', 66, 1, 'CAMPAÑA TELCEL2'),
(62, '2016-12-26 17:14:05', '2016-12-26 17:14:05', 67, 1, 'PABLO CAMPAÃ‘A1'),
(63, '2016-12-30 00:14:51', '2016-12-30 00:14:51', 68, 1, 'LOGÃSTICA 1'),
(81, '2017-01-11 11:34:14', '2017-01-11 11:34:14', 74, 1, 'Prueba WIZAD hoy'),
(65, '2017-01-02 12:38:51', '2017-01-02 12:38:51', 70, 1, 'ññññññ'),
(80, '2017-01-11 11:34:07', '2017-01-11 11:34:07', 73, 1, 'Prueba WIZAD hoy'),
(75, '2017-01-03 15:18:55', '2017-01-03 15:18:55', 69, 1, 'HELP'),
(79, '2017-01-11 11:31:10', '2017-01-11 11:31:10', 72, 1, 'Prueba WIZAD hoy'),
(78, '2017-01-11 11:31:04', '2017-01-11 11:31:04', 71, 1, 'Prueba WIZAD hoy'),
(77, '2017-01-05 19:49:30', '2017-01-05 19:49:30', 69, 1, 'oi'),
(76, '2017-01-03 20:27:06', '2017-01-03 20:27:06', 69, 1, 'new text'),
(74, '2017-01-03 15:09:57', '2017-01-03 15:09:57', 69, 1, 'gassagasgasg'),
(82, '2017-01-11 11:34:15', '2017-01-11 11:34:15', 75, 1, 'Prueba WIZAD hoy'),
(83, '2017-01-11 11:34:20', '2017-01-11 11:34:20', 76, 1, 'Prueba WIZAD hoy'),
(84, '2017-01-11 11:34:21', '2017-01-11 11:34:21', 77, 1, 'Prueba WIZAD hoy'),
(85, '2017-01-11 11:34:27', '2017-01-11 11:34:27', 78, 1, 'Prueba WIZAD hoy'),
(86, '2017-01-11 11:34:31', '2017-01-11 11:34:31', 79, 1, 'Prueba WIZAD hoy'),
(87, '2017-01-15 12:46:33', '2017-01-15 12:46:33', 80, 1, 'dasda'),
(88, '2017-01-15 12:46:39', '2017-01-15 12:46:39', 81, 1, 'dasda'),
(89, '2017-01-15 12:53:57', '2017-01-15 12:53:57', 82, 1, 'dadsad'),
(90, '2017-01-15 12:55:32', '2017-01-15 12:55:32', 83, 1, 'test'),
(91, '2017-01-15 12:57:51', '2017-01-15 12:57:51', 84, 1, 'testtest'),
(92, '2017-01-15 13:29:34', '2017-01-15 13:29:34', 85, 1, 'test2'),
(94, '2017-01-17 20:18:23', '2017-01-17 20:18:23', 87, 1, 'prueba 17 enero'),
(109, '2017-10-12 19:12:44', '2017-10-12 19:12:44', 108, 1, 'dqwdq'),
(110, '2017-11-23 19:39:14', '2017-11-23 19:39:14', 110, 1, 'Usa el shampoo por simpre'),
(111, '2017-11-24 08:40:52', '2017-11-24 08:40:52', 111, 1, 'Lets do it');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `City`
--

CREATE TABLE `City` (
  `id_city` int(9) NOT NULL,
  `description` text NOT NULL,
  `fk_state` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `City`
--

INSERT INTO `City` (`id_city`, `description`, `fk_state`) VALUES
(1, 'MONTERREY', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Company`
--

CREATE TABLE `Company` (
  `id_company` int(9) NOT NULL,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `logo` text NOT NULL,
  `no_employees` int(9) NOT NULL,
  `storage` int(9) NOT NULL,
  `industry` text NOT NULL,
  `web_page` text NOT NULL,
  `city` int(9) NOT NULL,
  `state` int(9) NOT NULL,
  `pc` int(9) NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Company`
--

INSERT INTO `Company` (`id_company`, `name`, `address`, `date_up`, `date_update`, `logo`, `no_employees`, `storage`, `industry`, `web_page`, `city`, `state`, `pc`, `status`) VALUES
(1, 'MBLED TECH', 'San Pedro Garza Garcia, Lomas del Valle 4408', '2016-12-04 19:16:28', '2017-11-08 13:05:57', 'data:image/png;base64,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', 55, 0, 'Software and Technology', 'www.mbledteq.com', 1, 1, 66969, 1),
(2, 'MBLED MUSIC', 'San Pedro Garza Garcia, Lomas del Valle 4408', '2016-12-04 19:16:28', '2016-12-05 04:34:16', '', 60, 0, 'MUSIC INDUSTRY', 'www.mbledMUSIC.com', 1, 1, 66969, 1),
(3, 'WIZAD ADMIN', 'DIRECCION POR CONFIRMAR', '2016-12-04 19:16:28', '2016-12-05 04:34:16', 'a', 100, 0, 'MARKETING', 'www.wizadQA.mbledteq.com', 1, 1, 66969, 1),
(4, 'PRUEBA GRATIS', 'WIZAD.COM.MX', '2016-12-04 19:16:28', '2016-12-05 04:34:16', '', 100, 0, 'MARKETING', 'www.wizadQA.mbledteq.com', 1, 1, 66969, 1),
(30, 'SAMSUNG', 'SAMSUNG DIRECCION', '2017-03-02 21:13:15', '2017-03-02 21:13:15', '', 5, 200, 'CELULARES', 'WWW.SAMSUNG.COM', 4, 0, 848214, 1),
(23, 'Autofin', 'Av. Eugenio Garza Sada 4010', '2017-01-27 18:40:38', '2017-04-25 21:46:46', '', 5, 200, 'Autofinanciamiento', 'www.autofinauto.com', 44, 0, 64740, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Company_Fonts`
--

CREATE TABLE `Company_Fonts` (
  `id_font` int(9) NOT NULL,
  `fk_company` int(9) NOT NULL,
  `font` text NOT NULL,
  `date_up` int(200) NOT NULL,
  `date_update` int(200) NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Company_Fonts`
--

INSERT INTO `Company_Fonts` (`id_font`, `fk_company`, `font`, `date_up`, `date_update`, `status`) VALUES
(5, 1, 'OpenSans-BoldItalic.ttf', 2017, 2017, 1),
(7, 23, 'ACaslonPro-Semibold.otf', 2017, 2017, 1),
(8, 23, 'ACaslonPro-Bold.otf', 2017, 2017, 1),
(9, 23, 'ACaslonPro-BoldItalic.otf', 2017, 2017, 1),
(10, 23, 'ACaslonPro-Italic.otf', 2017, 2017, 1),
(11, 23, 'ACaslonPro-Regular.otf', 2017, 2017, 1),
(12, 23, 'ACaslonPro-SemiboldItalic.otf', 2017, 2017, 1),
(13, 23, 'ACaslonPro-Semibold.otf', 2017, 2017, 1),
(14, 23, 'ACaslonPro-Bold.otf', 2017, 2017, 1),
(15, 23, 'ACaslonPro-BoldItalic.otf', 2017, 2017, 1),
(16, 23, 'ACaslonPro-Italic.otf', 2017, 2017, 1),
(17, 23, 'ACaslonPro-Regular.otf', 2017, 2017, 1),
(18, 23, 'ACaslonPro-SemiboldItalic.otf', 2017, 2017, 1),
(19, 23, 'adineuePROCyr-BlackWeb.ttf', 2017, 2017, 1),
(20, 23, 'adineuePROCyr-LightWeb.ttf', 2017, 2017, 1),
(21, 23, 'adihausbold.ttf', 2017, 2017, 1),
(22, 23, 'adihausdin-Bold.ttf', 2017, 2017, 1),
(23, 23, 'adihausdin-Medium.ttf', 2017, 2017, 1),
(24, 23, 'adihausdin-Regular.ttf', 2017, 2017, 1),
(25, 23, 'AdobeArabic-Bold.otf', 2017, 2017, 1),
(26, 23, 'adineuePROCyr-LightWeb.ttf', 2017, 2017, 1),
(27, 23, 'adineuePROCyr-BlackWeb.ttf', 2017, 2017, 1),
(28, 23, 'AdobeDevanagari-Italic.otf', 2017, 2017, 1),
(29, 23, 'AdobeDevanagari-BoldItalic.otf', 2017, 2017, 1),
(30, 23, 'AdobeDevanagari-Regular.otf', 2017, 2017, 1),
(31, 23, 'AdobeFanHeitiStd-Bold.otf', 2017, 2017, 1),
(32, 23, 'AdobeGothicStd-Bold.otf', 2017, 2017, 1),
(33, 23, 'AdobeGurmukhi-Bold.otf', 2017, 2017, 1),
(34, 23, 'AdobeGurmukhi-Regular.otf', 2017, 2017, 1),
(35, 23, 'AdobeHebrew-Bold.otf', 2017, 2017, 1),
(36, 23, 'AdobeHebrew-BoldItalic.otf', 2017, 2017, 1),
(37, 23, 'AdobeArabic-Italic.otf', 2017, 2017, 1),
(38, 23, 'AdobeFangsongStd-Regular.otf', 2017, 2017, 1),
(39, 23, 'AdobeDevanagari-Bold.otf', 2017, 2017, 1),
(40, 23, 'AdobePiStd.otf', 2017, 2017, 1),
(41, 23, 'AdobeThai-Bold.otf', 2017, 2017, 1),
(42, 23, 'AdobeThai-BoldItalic.otf', 2017, 2017, 1),
(43, 23, 'AdobeThai-Italic.otf', 2017, 2017, 1),
(44, 23, 'AdobeThai-Regular.otf', 2017, 2017, 1),
(45, 23, 'AGaramondPro-Bold.otf', 2017, 2017, 1),
(46, 23, 'AdobeHebrew-Italic.otf', 2017, 2017, 1),
(47, 23, 'AdobeHebrew-Regular.otf', 2017, 2017, 1),
(48, 23, 'AdobeHeitiStd-Regular.otf', 2017, 2017, 1),
(49, 23, 'AdobeSongStd-Light.otf', 2017, 2017, 1),
(50, 23, 'AdobeMingStd-Light.otf', 2017, 2017, 1),
(51, 23, 'AdobeKaitiStd-Regular.otf', 2017, 2017, 1),
(52, 23, 'AdobeNaskh-Medium.otf', 2017, 2017, 1),
(53, 23, 'AdobeMyungjoStd-Medium.otf', 2017, 2017, 1),
(54, 23, 'Arial Narrow.ttf', 2017, 2017, 1),
(55, 23, 'Arial Narrow Italic.ttf', 2017, 2017, 1),
(56, 23, 'Arial Rounded Bold.ttf', 2017, 2017, 1),
(57, 23, 'Arial Black.ttf', 2017, 2017, 1),
(58, 23, 'Arial Bold.ttf', 2017, 2017, 1),
(59, 23, 'Arial Italic.ttf', 2017, 2017, 1),
(60, 23, 'Arial Narrow Bold Italic.ttf', 2017, 2017, 1),
(61, 23, 'Arial Narrow Bold.ttf', 2017, 2017, 1),
(62, 23, 'ARIALNI.TTF', 2017, 2017, 1),
(63, 23, 'ARIALNBI.TTF', 2017, 2017, 1),
(64, 23, 'ARIALN.TTF', 2017, 2017, 1),
(65, 23, 'ARIALNB.TTF', 2017, 2017, 1),
(66, 23, 'Austral-Sans_Stamp-Thin.otf', 2017, 2017, 1),
(67, 23, 'Austral-Sans_Stamp-Light.otf', 2017, 2017, 1),
(68, 23, 'Austral-Sans_Stamp-Thin.ttf', 2017, 2017, 1),
(69, 23, 'Austral-Sans_Stamp-Light.ttf', 2017, 2017, 1),
(70, 23, 'Austral-Sans_Stamp-Regular.ttf', 2017, 2017, 1),
(71, 23, 'BELLB.TTF', 2017, 2017, 1),
(72, 23, 'BELLI.TTF', 2017, 2017, 1),
(73, 23, 'BebasNeue.otf', 2017, 2017, 1),
(74, 23, 'BEERNOTE trial.ttf', 2017, 2017, 1),
(75, 23, 'BERNHC.TTF', 2017, 2017, 1),
(76, 23, 'BELL.TTF', 2017, 2017, 1),
(77, 23, 'Blogger Sans-Italic_0.otf', 2017, 2017, 1),
(78, 23, 'Blogger Sans-Bold Italic.otf', 2017, 2017, 1),
(79, 23, 'Blogger Sans-Bold Italic_0.otf', 2017, 2017, 1),
(80, 23, 'Blogger Sans-Bold_0.otf', 2017, 2017, 1),
(81, 23, 'Blogger Sans-Bold.otf', 2017, 2017, 1),
(82, 23, 'Blogger Sans-Italic.otf', 2017, 2017, 1),
(83, 23, 'BOD_CBI.TTF', 2017, 2017, 1),
(84, 23, 'BOD_CI.TTF', 2017, 2017, 1),
(85, 23, 'BOD_I.TTF', 2017, 2017, 1),
(86, 23, 'BOD_B.TTF', 2017, 2017, 1),
(87, 23, 'BOD_BI.TTF', 2017, 2017, 1),
(88, 23, 'BOD_CR.TTF', 2017, 2017, 1),
(89, 23, 'BOD_BLAI.TTF', 2017, 2017, 1),
(90, 23, 'BOD_BLAR.TTF', 2017, 2017, 1),
(91, 23, 'BOD_CB.TTF', 2017, 2017, 1),
(92, 23, 'CALIFB.TTF', 2017, 2017, 1),
(93, 23, 'CALIFI.TTF', 2017, 2017, 1),
(94, 23, 'calibri.ttf', 2017, 2017, 1),
(95, 23, 'CALIST.TTF', 2017, 2017, 1),
(96, 23, 'CALIFR.TTF', 2017, 2017, 1),
(97, 23, 'cambriab.ttf', 2017, 2017, 1),
(98, 23, 'Courier New.ttf', 2017, 2017, 1),
(99, 23, 'Candarab.ttf', 2017, 2017, 1),
(100, 23, 'Candara.ttf', 2017, 2017, 1),
(101, 23, 'CASTELAR.TTF', 2017, 2017, 1),
(102, 23, 'CENTAUR.TTF', 2017, 2017, 1),
(103, 23, 'CENTURY.TTF', 2017, 2017, 1),
(104, 23, 'ChaparralPro-Bold.otf', 2017, 2017, 1),
(105, 23, 'Chalkduster.ttf', 2017, 2017, 1),
(106, 23, 'cheddar jack.ttf', 2017, 2017, 1),
(107, 23, 'christmaseve.ttf', 2017, 2017, 1),
(108, 23, 'chocolate cake.ttf', 2017, 2017, 1),
(109, 23, 'chunkyness.ttf', 2017, 2017, 1),
(110, 23, 'ColabBol.otf', 2017, 2017, 1),
(111, 23, 'ColabLig.otf', 2017, 2017, 1),
(112, 23, 'Comfortaa-Bold.ttf', 2017, 2017, 1),
(113, 23, 'comic.ttf', 2017, 2017, 1),
(114, 23, 'comicz.ttf', 2017, 2017, 1),
(115, 23, 'CloseRace.ttf', 2017, 2017, 1),
(116, 23, 'consola.ttf', 2017, 2017, 1),
(117, 23, 'CooperBlackStd.otf', 2017, 2017, 1),
(118, 23, 'corbel.ttf', 2017, 2017, 1),
(119, 23, 'Dosis-Bold.otf', 2017, 2017, 1),
(120, 23, 'FRABK.TTF', 2017, 2017, 1),
(121, 23, 'Education.ttf', 2017, 2017, 1),
(122, 23, 'ElephantHiccups.ttf', 2017, 2017, 1),
(123, 23, 'Erase Old Year.ttf', 2017, 2017, 1),
(124, 23, 'FELIXTI.TTF', 2017, 2017, 1),
(125, 23, 'FINALPHA.ttf', 2017, 2017, 1),
(126, 23, 'Floyd.ttf', 2017, 2017, 1),
(127, 23, 'Folklore.otf', 2017, 2017, 1),
(128, 23, 'FORTE.TTF', 2017, 2017, 1),
(129, 23, 'Farisi.ttf', 2017, 2017, 1),
(130, 23, 'Gurmukhi.ttf', 2017, 2017, 1),
(131, 23, 'FRAHV.TTF', 2017, 2017, 1),
(132, 23, 'FREEBSC_.ttf', 2017, 2017, 1),
(133, 23, 'Freshman.ttf', 2017, 2017, 1),
(134, 23, 'Halloween Too.ttf', 2017, 2017, 1),
(135, 23, 'FuturaStd-ExtraBold.otf', 2017, 2017, 1),
(136, 23, 'FuturaStd-Bold.otf', 2017, 2017, 1),
(137, 23, 'gadugi.ttf', 2017, 2017, 1),
(138, 23, 'GARA.TTF', 2017, 2017, 1),
(139, 23, 'Gabriola.ttf', 2017, 2017, 1),
(140, 23, 'Georgia Bold.ttf', 2017, 2017, 1),
(141, 23, 'Georgia.ttf', 2017, 2017, 1),
(142, 23, 'georgiai.ttf', 2017, 2017, 1),
(143, 23, 'GILLUBCD.TTF', 2017, 2017, 1),
(144, 23, 'GILSANUB.TTF', 2017, 2017, 1),
(145, 23, 'Gotham-Black.otf', 2017, 2017, 1),
(146, 23, 'Gotham-Bold.otf', 2017, 2017, 1),
(147, 23, 'GOTHICB.TTF', 2017, 2017, 1),
(148, 23, 'GOUDOS.TTF', 2017, 2017, 1),
(149, 23, 'GreatVibes-Regular.otf', 2017, 2017, 1),
(150, 23, 'GOUDOSB.TTF', 2017, 2017, 1),
(151, 23, 'HandTest.ttf', 2017, 2017, 1),
(152, 23, 'HARLOWSI.TTF', 2017, 2017, 1),
(153, 23, 'HelsinkiStd.otf', 2017, 2017, 1),
(154, 23, 'Helvetica.otf', 2017, 2017, 1),
(155, 23, 'HoboStd.otf', 2017, 2017, 1),
(156, 23, 'icomoon.ttf', 2017, 2017, 1),
(157, 23, 'Impact.ttf', 2017, 2017, 1),
(158, 23, 'himalaya.ttf', 2017, 2017, 1),
(159, 23, 'IMPRISHA.TTF', 2017, 2017, 1),
(160, 23, 'inglobal.ttf', 2017, 2017, 1),
(161, 23, 'INFROMAN.TTF', 2017, 2017, 1),
(162, 23, 'inglobali.ttf', 2017, 2017, 1),
(163, 23, 'ITCEDSCR.TTF', 2017, 2017, 1),
(164, 23, 'ITCKRIST.TTF', 2017, 2017, 1),
(165, 23, 'MontereyFLF.ttf', 2017, 2017, 1),
(166, 23, 'LSANS.TTF', 2017, 2017, 1),
(167, 23, 'Lobster 1.4.otf', 2017, 2017, 1),
(168, 23, 'LTYPEO.TTF', 2017, 2017, 1),
(169, 23, 'MAESTI__.ttf', 2017, 2017, 1),
(170, 23, 'MAESTB__.ttf', 2017, 2017, 1),
(171, 23, 'MAESW___.TTF', 2017, 2017, 1),
(172, 23, 'MesquiteStd.otf', 2017, 2017, 1),
(173, 23, 'MardianDemo.ttf', 2017, 2017, 1),
(174, 23, 'MinionPro-Bold.otf', 2017, 2017, 1),
(175, 23, 'MinionPro-Regular.otf', 2017, 2017, 1),
(176, 23, 'MISTRAL.TTF', 2017, 2017, 1),
(177, 23, 'micross.ttf', 2017, 2017, 1),
(178, 23, 'RepriseBigTimeStd.otf', 2017, 2017, 1),
(179, 23, 'Montserrat-Black.otf', 2017, 2017, 1),
(180, 23, 'Moon Bold.otf', 2017, 2017, 1),
(181, 23, 'Moon Flower Bold.ttf', 2017, 2017, 1),
(182, 23, 'MyriadPro-Bold.otf', 2017, 2017, 1),
(183, 23, 'NIAGENG.TTF', 2017, 2017, 1),
(184, 23, 'ntailu.ttf', 2017, 2017, 1),
(185, 23, 'NuevaStd-Cond.otf', 2017, 2017, 1),
(186, 23, 'OpusRomanChordsStd.otf', 2017, 2017, 1),
(187, 23, 'OpusStd.otf', 2017, 2017, 1),
(188, 23, 'NIAGSOL.TTF', 2017, 2017, 1),
(189, 23, 'Orbitron-Black.ttf', 2017, 2017, 1),
(190, 23, 'phagspa.ttf', 2017, 2017, 1),
(191, 23, 'PrestigeEliteStd-Bd.otf', 2017, 2017, 1),
(192, 23, 'prstartk.ttf', 2017, 2017, 1),
(193, 23, 'Raiders.ttf', 2017, 2017, 1),
(194, 23, 'Raleway-Bold.ttf', 2017, 2017, 1),
(195, 23, 'Raleway-Thin.ttf', 2017, 2017, 1),
(196, 23, 'pala.ttf', 2017, 2017, 1),
(197, 23, 'ROCK.TTF', 2017, 2017, 1),
(198, 23, 'Trattatello.ttf', 2017, 2017, 1),
(199, 23, 'Sathu.ttf', 2017, 2017, 1),
(200, 23, 'segmdl2.ttf', 2017, 2017, 1),
(201, 23, 'seguibli.ttf', 2017, 2017, 1),
(202, 23, 'Rudiment.ttf', 2017, 2017, 1),
(203, 23, 'SFNSText-Heavy.otf', 2017, 2017, 1),
(204, 23, 'Silvery Tarjey.ttf', 2017, 2017, 1),
(205, 23, 'Silom.ttf', 2017, 2017, 1),
(206, 23, 'Space Comics.ttf', 2017, 2017, 1),
(207, 23, 'SourceSansPro-Black.otf', 2017, 2017, 1),
(208, 23, 'square-deal.ttf', 2017, 2017, 1),
(209, 23, 'STENCIL.TTF', 2017, 2017, 1),
(210, 23, 'StencilStd.otf', 2017, 2017, 1),
(211, 23, 'STIXIntDReg.otf', 2017, 2017, 1),
(212, 23, 'Symbol.ttf', 2017, 2017, 1),
(213, 23, 'Tasty_Birds.otf', 2017, 2017, 1),
(214, 23, 'TektonPro-Bold.otf', 2017, 2017, 1),
(215, 23, 'Tahoma.ttf', 2017, 2017, 1),
(216, 23, 'The Urban Way.ttf', 2017, 2017, 1),
(217, 23, 'TENOCLOCK-Regular.ttf', 2017, 2017, 1),
(218, 23, 'TheNextFont.ttf', 2017, 2017, 1),
(219, 23, 'Times New Roman.ttf', 2017, 2017, 1),
(220, 23, 'ZapfDingbats.ttf', 2017, 2017, 1),
(221, 23, 'TrueLove.ttf', 2017, 2017, 1),
(222, 23, 'Zapfino.ttf', 2017, 2017, 1),
(223, 23, 'Verdana.ttf', 2017, 2017, 1),
(224, 23, 'VINERITC.TTF', 2017, 2017, 1),
(225, 23, 'Walrus-Bold.otf', 2017, 2017, 1),
(226, 23, 'wingding.ttf', 2017, 2017, 1),
(227, 23, 'Urban Class.ttf', 2017, 2017, 1),
(228, 23, 'yuminl.ttf', 2017, 2017, 1),
(229, 23, 'YuppySC-Regular.otf', 2017, 2017, 1),
(230, 23, 'Yu Gothic Bold.otf', 2017, 2017, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Company_Pack`
--

CREATE TABLE `Company_Pack` (
  `id_pack` int(9) NOT NULL,
  `fk_company` int(9) NOT NULL,
  `image` text NOT NULL,
  `status` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Company_Pack`
--

INSERT INTO `Company_Pack` (`id_pack`, `fk_company`, `image`, `status`, `date_up`, `date_update`) VALUES
(12, 23, 'autofinazul.png', 1, '2017-02-14 18:25:16', '2017-02-14 18:25:16'),
(13, 23, 'autofin iconos.png', 1, '2017-02-14 18:25:19', '2017-02-14 18:25:19'),
(15, 23, 'Logo DSP.png', 1, '2017-07-12 17:53:50', '2017-07-12 17:53:50'),
(8, 23, 'Logo DSP.png', 1, '2017-02-07 18:18:02', '2017-02-07 18:18:02'),
(6, 1, 'cablevision.jpg', 1, '2017-01-08 22:07:56', '2017-01-08 22:07:56'),
(16, 23, 'Logo DSP.jpg', 1, '2017-07-12 17:53:50', '2017-07-12 17:53:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Company_Palette`
--

CREATE TABLE `Company_Palette` (
  `id_palette` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `color` text NOT NULL,
  `fk_company` int(9) NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Company_Palette`
--

INSERT INTO `Company_Palette` (`id_palette`, `date_up`, `date_update`, `color`, `fk_company`, `status`) VALUES
(1, '2016-12-05 04:27:14', '2016-12-05 04:27:14', '#a00c0c', 1, 1),
(33, '2017-02-07 18:18:02', '2017-02-07 18:18:02', '#002F5F', 23, 1),
(3, '2016-12-05 04:27:36', '2016-12-05 04:27:36', '#04f27c', 1, 1),
(10, '2016-12-05 11:19:06', '2016-12-05 11:19:06', '#ff6600', 1, 1),
(27, '2016-12-12 03:42:26', '2016-12-12 03:42:26', '#ffdf00', 22, 1),
(6, '2016-12-05 11:15:52', '2016-12-05 11:15:52', '#a04949', 1, 1),
(7, '2016-12-05 11:16:01', '2016-12-05 11:16:01', '#a04949', 1, 1),
(34, '2017-02-07 18:18:02', '2017-02-07 18:18:02', '#C60C30', 23, 1),
(11, '2016-12-10 20:28:29', '2016-12-10 20:28:29', '#ae1919', 1, 1),
(12, '2016-12-10 20:29:54', '2016-12-10 20:29:54', '#ad3a3a', 1, 1),
(31, '2017-01-07 19:44:21', '2017-01-07 19:44:21', '#e5008b', 1, 1),
(26, '2016-12-12 03:42:26', '2016-12-12 03:42:26', '', 22, 1),
(25, '2016-12-12 01:52:13', '2016-12-12 01:52:13', '#ffd9f5', 1, 1),
(23, '2016-12-12 01:51:05', '2016-12-12 01:51:05', '#fbff00', 1, 1),
(28, '2017-01-07 19:24:50', '2017-01-07 19:24:50', '#2833e5', 0, 1),
(30, '2017-01-07 19:43:11', '2017-01-07 19:43:11', '#ff36b0', 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Company_Subscription`
--

CREATE TABLE `Company_Subscription` (
  `id_csubs` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `fk_company` int(9) NOT NULL,
  `fk_subscription` int(9) NOT NULL,
  `fk_contract` int(9) NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Company_Subscription`
--

INSERT INTO `Company_Subscription` (`id_csubs`, `date_up`, `date_update`, `fk_company`, `fk_subscription`, `fk_contract`, `status`) VALUES
(1, '2017-12-04 21:09:01', '2016-12-04 21:09:01', 1, 2, 1, 1),
(2, '2016-12-04 21:09:01', '2016-12-04 21:09:01', 2, 2, 2, 1),
(3, '2020-06-15 21:09:01', '2016-12-04 21:09:01', 3, 100, 1, 1),
(4, '2016-12-12 21:09:01', '2016-12-04 21:09:01', 4, 2, 1, 1),
(5, '2017-01-07 20:45:55', '2017-01-07 20:45:55', 18, 0, 1, 1),
(6, '2017-01-07 20:56:13', '2017-01-07 20:56:13', 19, 3, 2, 1),
(7, '2017-01-08 14:01:55', '2017-01-08 14:01:55', 20, 2, 2, 1),
(8, '2017-01-08 22:59:59', '2017-01-08 22:59:59', 21, 3, 2, 1),
(9, '2017-01-09 19:40:06', '2017-01-09 19:40:06', 22, 3, 1, 1),
(10, '2017-01-27 18:40:38', '2017-01-27 18:40:38', 23, 4, 2, 1),
(11, '2017-03-02 00:27:49', '2017-03-02 00:27:49', 24, 2, 1, 1),
(12, '2017-03-02 00:28:17', '2017-03-02 00:28:17', 25, 2, 1, 1),
(13, '2017-03-02 00:30:51', '2017-03-02 00:30:51', 26, 3, 1, 1),
(14, '2017-03-02 00:35:50', '2017-03-02 00:35:50', 27, 3, 1, 1),
(15, '2017-03-02 00:37:59', '2017-03-02 00:37:59', 28, 3, 1, 1),
(16, '2017-03-02 00:40:23', '2017-03-02 00:40:23', 29, 3, 1, 1),
(17, '2017-03-02 21:13:15', '2017-03-02 21:13:15', 30, 4, 1, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Company_TextConfig`
--

CREATE TABLE `Company_TextConfig` (
  `id_config` int(9) NOT NULL,
  `fk_company` int(9) NOT NULL,
  `text_config` text NOT NULL,
  `status` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Company_TextConfig`
--

INSERT INTO `Company_TextConfig` (`id_config`, `fk_company`, `text_config`, `status`, `date_up`, `date_update`) VALUES
(32, 1, 'Test 3', 1, '2017-01-07 19:30:21', '2017-01-07 19:30:21'),
(7, 1, 'Titulos', 1, '2016-12-05 10:46:31', '2016-12-05 10:46:31'),
(6, 1, 'Ejemplo de mi texto guardado', 1, '2016-12-05 10:43:58', '2016-12-05 10:43:58'),
(33, 1, 'test 4', 1, '2017-01-07 19:43:11', '2017-01-07 19:43:11'),
(34, 23, 'EMPRESA SONIA', 1, '2017-02-01 19:56:02', '2017-02-01 19:56:02'),
(31, 22, 'xssxsxsxs', 1, '2016-12-12 03:42:26', '2016-12-12 03:42:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Control_History`
--

CREATE TABLE `Control_History` (
  `id_history` int(9) NOT NULL,
  `fk_user` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `description` text NOT NULL,
  `status` int(9) NOT NULL COMMENT 'Send, not send, new, think about this status'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_Age`
--

CREATE TABLE `Ct_Age` (
  `id_age` int(9) NOT NULL,
  `rangee` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Ct_Age`
--

INSERT INTO `Ct_Age` (`id_age`, `rangee`) VALUES
(1, '5-10'),
(2, '11-15'),
(3, '11-20'),
(4, '20-25'),
(5, '20-30'),
(6, '30-35'),
(7, '30-40'),
(8, '40-45'),
(9, '40-50'),
(10, '50-55'),
(11, '50-60'),
(12, '60+');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_City`
--

CREATE TABLE `Ct_City` (
  `id_city` int(9) NOT NULL,
  `name` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Ct_City`
--

INSERT INTO `Ct_City` (`id_city`, `name`) VALUES
(1, 'Aguascalientes'),
(2, 'Ensenada'),
(3, 'Mexicali'),
(4, 'Tijuana'),
(5, 'La Paz'),
(6, 'Los Cabos'),
(7, 'Campeche'),
(8, 'Ciudad del Carmen'),
(9, 'Saltillo'),
(10, 'Monclova-Frontera'),
(11, 'La Laguna'),
(12, 'Piedras Negras'),
(13, 'Tecomán'),
(14, 'Colima-Villa de Álvarez'),
(15, 'Manzanillo'),
(16, 'Tuxtla Gutiérrez'),
(17, 'Tapachula'),
(18, 'Chihuahua'),
(19, 'Juárez'),
(20, 'Valle de México'),
(21, 'Durango'),
(22, 'Celaya'),
(23, 'Guanajuato'),
(24, 'Irapuato'),
(25, 'León'),
(26, 'La Piedad-Pénjamo'),
(27, 'San Francisco del Rincón'),
(28, 'Salamanca'),
(29, 'Acapulco'),
(30, 'Chilpancingo'),
(31, 'Tula'),
(32, 'Tulancingo'),
(33, 'Pachuca'),
(34, 'Guadalajara'),
(35, 'Ocotlán'),
(36, 'Puerto Vallarta'),
(37, 'Toluca'),
(38, 'Zamora-Jacona'),
(39, 'Morelia'),
(40, 'Uruapan'),
(41, 'Cuautla'),
(42, 'Cuernavaca'),
(43, 'Tepic'),
(44, 'Monterrey'),
(45, 'Oaxaca'),
(46, 'Tehuantepec-Salina Cruz'),
(47, 'Puebla-Tlaxcala'),
(48, 'Tehuacán'),
(49, 'Querétaro'),
(50, 'San Juan del Río'),
(51, 'Cancún'),
(52, 'Chetumal'),
(53, 'Rioverde-Ciudad Fernández'),
(54, 'San Luis Potosí-Soledad'),
(55, 'Los Mochis'),
(56, 'Culiacán'),
(57, 'Mazatlán'),
(58, 'Ciudad Obregón'),
(59, 'Guaymas'),
(60, 'Hermosillo'),
(61, 'Cárdenas'),
(62, 'Villahermosa'),
(63, 'Tampico-Pánuco'),
(64, 'Matamoros'),
(65, 'Nuevo Laredo'),
(66, 'Reynosa-Río Bravo'),
(67, 'Ciudad Victoria'),
(68, 'Tlaxcala-Apizaco'),
(69, 'Veracruz'),
(70, 'Córdoba'),
(71, 'Orizaba'),
(72, 'Xalapa'),
(73, 'Poza Rica'),
(74, 'Coatzacoalcos'),
(75, 'Minatitlán'),
(76, 'Mérida'),
(77, 'Zacatecas-Guadalupe');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_Dimensions`
--

CREATE TABLE `Ct_Dimensions` (
  `id_dimension` int(9) NOT NULL,
  `description` text NOT NULL,
  `height` decimal(9,5) NOT NULL,
  `width` decimal(9,5) NOT NULL,
  `image` text NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Ct_Dimensions`
--

INSERT INTO `Ct_Dimensions` (`id_dimension`, `description`, `height`, `width`, `image`, `status`) VALUES
(1, 'Banner', '512.00000', '512.00000', 'http://wizadqa.mbledteq.com/512.png', 1),
(2, 'Flyer', '740.00000', '320.00000', 'http://wizadqa.mbledteq.com/740.png', 1),
(3, 'Banner', '1020.00000', '350.00000', 'http://wizadqa.mbledteq.com/1020.png', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_Edad`
--

CREATE TABLE `Ct_Edad` (
  `id_edad` int(9) NOT NULL,
  `rango` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_Material`
--

CREATE TABLE `Ct_Material` (
  `id_material` int(9) NOT NULL,
  `description` text NOT NULL,
  `width` text NOT NULL,
  `height` text NOT NULL,
  `width_small` varchar(9) NOT NULL,
  `height_small` varchar(9) NOT NULL,
  `width_multiplier` varchar(9) NOT NULL,
  `height_multiplier` varchar(9) NOT NULL,
  `thumbnail` text NOT NULL,
  `free` int(9) NOT NULL,
  `multiplier` varchar(9) NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Ct_Material`
--

INSERT INTO `Ct_Material` (`id_material`, `description`, `width`, `height`, `width_small`, `height_small`, `width_multiplier`, `height_multiplier`, `thumbnail`, `free`, `multiplier`, `status`) VALUES
(1, 'Carta de negocio (carta)', '2550', '3300\n', '510', '660', '5', '5', 'CartaDeNegocio.png', 0, '3.3', 0),
(2, 'Flyer 1/4', '1274\n', '1652\n', '637', '826', '2', '2', 'Flyerpequeño.png', 1, '2', 1),
(3, 'Flyer 1/3', '1098\n', '2550\n', '366', '850', '3', '3', 'Flyer.png', 1, '2', 1),
(4, 'Díptico vertical', '2550\n', '3300', '510', '660', '5', '5', 'Diptico.png', 1, '3.3', 1),
(5, 'Tríptico', '3300', '2550', '660', '510', '5', '5', 'Triptico.png', 1, '3.3', 1),
(6, 'Poster (carta)', '2550\n', '3300\n', '510', '660', '5', '5', 'PosterPequeño.png', 1, '3.3', 1),
(7, 'Poster estándar / Tabloide', '2550\n', '4200\n', '510', '840', '5', '5', 'PosterEstandarTabloide.png', 1, '3.3', 1),
(8, 'Poster grande', '3300\n', '5100\n', '550', '850', '6', '6', 'PosterGrande.png', 1, '4.5', 1),
(9, 'Banner jumbo', '9440\n', '2360\n', '1258.667', '314.66667', '7.5', '7.5', 'BannerElectronicoHorizontal.png', 1, '13', 1),
(10, 'Email', '0', '0', '0', '0', '0', '0', 'Email.png', 1, '0', 1),
(11, 'Banner chico', '5900\n', '11800\n', '590', '1180', '10', '10', 'BannerVertical.png', 1, '8', 1),
(12, 'Banner largo', '5900\n', '17700\n', '590', '1770', '10', '10', 'BannerRectangular.png', 1, '8', 1),
(13, 'Facebook perfil', '180\n\n', '180\n', '180', '180', '1', '1', 'FacebookPerfil.png', 1, '1', 1),
(14, 'Facebook portada', '851\n', '315\n', '851', '315', '1', '1', 'FacebookPortada.png', 1, '1', 1),
(15, 'Facebook icon app', '111', '74', '111', '74', '1', '1', 'FacebookIconApp.png', 1, '1', 1),
(16, 'Twitter perfil', '400', '400', '400', '400', '1', '1', 'TwitterPerfil.png', 1, '1', 1),
(17, 'Twitter portada', '1500\n', '500', '750', '250', '2', '2', 'TwitterPortada.png', 1, '2', 1),
(18, 'Google+ perfil', '250', '250', '250', '250', '1', '1', 'GooglePerfil.png', 1, '1', 1),
(19, 'Google+ portada', '1080\n', '608\n', '720', '405.3333', '1.5', '1.5', 'GooglePortada.png', 1, '1.4', 1),
(20, 'Tarjetas de presentación', '1062', '590', '708', '393.3333', '1.5', '1.5', 'TarjetasDePresentacion.png', 1, '1.4', 1),
(21, 'Invitaciones', '1475\n', '1888\n', '590', '755.2', '2.5', '2.5', 'Invitaciones.png', 1, '2', 1),
(22, 'Postal', '1416\n', '2124\n', '590', '885', '2.4', '2.4', 'Postal.png', 1, '2', 1),
(23, 'Lona 1 (cuadrada)', '11800\n', '11800\n', '737.5', '737.5', '16', '16', 'FichaTecnica.png', 1, '15', 1),
(27, 'Twitter foto', '1024\n\n', '512\n', '682.667', '341.33333', '1.5', '1.5', 'NewMaterial.png', 1, '1.3', 1),
(28, 'Postcard', '500', '500', '500', '500', '1', '1', 'NewMaterial.png', 1, '1', 1),
(29, 'Lona Cuadrada (prueba)', '11800', '11800', '', '', '', '', 'NewMaterial.png', 1, '', 1),
(30, 'Banner1', '5900', '11800', '', '', '', '', 'NewMaterial.png', 1, '', 1),
(31, 'Lona rectangular (prueba)', '23600', '11800', '', '', '', '', 'NewMaterial.png', 0, '', 1),
(32, 'Lona', '2838', '254', '', '', '', '', 'NewMaterial.png', 0, '', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_Segment`
--

CREATE TABLE `Ct_Segment` (
  `id_segment` int(9) NOT NULL,
  `description` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Ct_Segment`
--

INSERT INTO `Ct_Segment` (`id_segment`, `description`) VALUES
(1, 'Alimentos y bebidas'),
(2, 'Alojamiento y hoteles'),
(3, 'Animales'),
(4, 'Audio, fotografía y video'),
(5, 'Automotores'),
(6, 'Belleza y cuidado personal'),
(7, 'Calzados'),
(8, 'Computación e informática'),
(9, 'Construcción y mantenimiento'),
(10, 'Deportes'),
(11, 'Enseñanza, cursos y capacitaciones'),
(12, 'Entidades financieras'),
(13, 'Entretenimiento'),
(14, 'Estaciones de servicio'),
(15, 'Gastronomía'),
(16, 'Hogar'),
(17, 'Indumentaria'),
(18, 'Industria'),
(19, 'Jardín'),
(20, 'Joyería y relojería'),
(21, 'Juguetes'),
(22, 'Librería y papelería'),
(23, 'Máquinas y herramientas'),
(24, 'Materiales de construcción'),
(25, 'Medios de comunicación y publicidad'),
(26, 'Medicina y medicamentos'),
(27, 'Música'),
(28, 'Óptica'),
(29, 'Seguros y seguridad'),
(30, 'Servicio para eventos'),
(31, 'Servicios en general'),
(32, 'Talleres'),
(33, 'Telefonía e internet'),
(34, 'Logística y Transporte'),
(35, 'Turismo'),
(36, 'Otros');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_Subscription`
--

CREATE TABLE `Ct_Subscription` (
  `id_subs` int(9) NOT NULL,
  `description` text NOT NULL,
  `users` int(9) NOT NULL,
  `storage` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Ct_Subscription`
--

INSERT INTO `Ct_Subscription` (`id_subs`, `description`, `users`, `storage`) VALUES
(1, 'PERSONAL', 1, 50),
(2, 'PROFESIONAL', 3, 100),
(3, 'EMPRESARIAL', 5, 150),
(4, 'CORPORATIVA', 5, 200),
(100, 'Master', 1000, 1000);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_SubscriptionPlan`
--

CREATE TABLE `Ct_SubscriptionPlan` (
  `frequency` text NOT NULL,
  `id_subsplan` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Ct_SubscriptionPlan`
--

INSERT INTO `Ct_SubscriptionPlan` (`frequency`, `id_subsplan`) VALUES
('Mensual', 1),
('Anual', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Ct_UserType`
--

CREATE TABLE `Ct_UserType` (
  `id_usertype` int(9) NOT NULL,
  `description` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `Ct_UserType`
--

INSERT INTO `Ct_UserType` (`id_usertype`, `description`) VALUES
(1, 'Administrador Global'),
(2, 'Administrador Empresa'),
(3, 'Disenador Empresa'),
(4, 'Disenador Individual');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Design`
--

CREATE TABLE `Design` (
  `id_design` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `fk_user` int(11) NOT NULL,
  `fk_campaign` int(11) NOT NULL,
  `status` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Det_Subscription`
--

CREATE TABLE `Det_Subscription` (
  `id_detsubs` int(11) NOT NULL,
  `fk_subs` int(11) NOT NULL,
  `price` decimal(10,5) NOT NULL,
  `individual_user_cost` decimal(10,5) NOT NULL,
  `image` text NOT NULL,
  `first_plus` text NOT NULL,
  `sec_plus` text NOT NULL,
  `third_plus` text NOT NULL,
  `frth_plus` text NOT NULL,
  `fifth_plus` text NOT NULL,
  `sixth_plus` text NOT NULL,
  `sevn_plus` text NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `General_Messages`
--

CREATE TABLE `General_Messages` (
  `id_gmessage` int(9) NOT NULL,
  `user_up` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `user_send` int(9) NOT NULL,
  `user_receive` int(9) NOT NULL,
  `focus_group` int(9) NOT NULL,
  `message` int(200) NOT NULL,
  `status` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Image_Bank`
--

CREATE TABLE `Image_Bank` (
  `id_bank` int(9) NOT NULL,
  `image` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Session`
--

CREATE TABLE `Session` (
  `id_session` int(9) NOT NULL,
  `key_session` text NOT NULL,
  `user_id` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `State`
--

CREATE TABLE `State` (
  `id_state` int(9) NOT NULL,
  `description` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `State`
--

INSERT INTO `State` (`id_state`, `description`) VALUES
(1, 'NUEVO LEON');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `User`
--

CREATE TABLE `User` (
  `id_user` int(9) NOT NULL,
  `name` text NOT NULL,
  `namenoemail` text NOT NULL,
  `password` text NOT NULL,
  `type` int(9) NOT NULL,
  `date_up` text NOT NULL,
  `date_update` text NOT NULL,
  `home_phone` text NOT NULL,
  `mobile_phone` text NOT NULL,
  `image` text NOT NULL,
  `fk_company` int(9) NOT NULL,
  `free_campaign` int(9) NOT NULL,
  `status` int(9) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `User`
--

INSERT INTO `User` (`id_user`, `name`, `namenoemail`, `password`, `type`, `date_up`, `date_update`, `home_phone`, `mobile_phone`, `image`, `fk_company`, `free_campaign`, `status`) VALUES
(1, 'pbarrera@heypromo.com', 'PABLOB', 'pablo', 2, '2016-12-03 20:04:25', '2016-12-05 00:08:55', '54646463', '97887887', 'data:image/png;base64,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', 1, 1, 1);
INSERT INTO `User` (`id_user`, `name`, `namenoemail`, `password`, `type`, `date_up`, `date_update`, `home_phone`, `mobile_phone`, `image`, `fk_company`, `free_campaign`, `status`) VALUES
(2, 'sonia@wizad.mx', 'SONIA MASTER', 'sonia', 1, '2016-12-03 20:04:25', '2017-01-30 16:57:45', '81145454', '88844877', 'data:image/png;base64,/9j/4SGaRXhpZgAATU0AKgAAAAgABwESAAMAAAABAAEAAAEaAAUAAAABAAAAYgEbAAUAAAABAAAAagEoAAMAAAABAAIAAAExAAIAAAAcAAAAcgEyAAIAAAAUAAAAjodpAAQAAAABAAAApAAAANAACvyAAAAnEAAK/IAAACcQQWRvYmUgUGhvdG9zaG9wIENTNSBXaW5kb3dzADIwMTE6MTE6MDIgMTA6MDU6NDUAAAAAA6ABAAMAAAABAAEAAKACAAQAAAABAAAAzKADAAQAAAABAAAAzQAAAAAAAAAGAQMAAwAAAAEABgAAARoABQAAAAEAAAEeARsABQAAAAEAAAEmASgAAwAAAAEAAgAAAgEABAAAAAEAAAEuAgIABAAAAAEAACBkAAAAAAAAAEgAAAABAAAASAAAAAH/2P/tAAxBZG9iZV9DTQAB/+4ADkFkb2JlAGSAAAAAAf/bAIQADAgICAkIDAkJDBELCgsRFQ8MDA8VGBMTFRMTGBEMDAwMDAwRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAENCwsNDg0QDg4QFA4ODhQUDg4ODhQRDAwMDAwREQwMDAwMDBEMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM/8AAEQgAoACfAwEiAAIRAQMRAf/dAAQACv/EAT8AAAEFAQEBAQEBAAAAAAAAAAMAAQIEBQYHCAkKCwEAAQUBAQEBAQEAAAAAAAAAAQACAwQFBgcICQoLEAABBAEDAgQCBQcGCAUDDDMBAAIRAwQhEjEFQVFhEyJxgTIGFJGhsUIjJBVSwWIzNHKC0UMHJZJT8OHxY3M1FqKygyZEk1RkRcKjdDYX0lXiZfKzhMPTdePzRieUpIW0lcTU5PSltcXV5fVWZnaGlqa2xtbm9jdHV2d3h5ent8fX5/cRAAICAQIEBAMEBQYHBwYFNQEAAhEDITESBEFRYXEiEwUygZEUobFCI8FS0fAzJGLhcoKSQ1MVY3M08SUGFqKygwcmNcLSRJNUoxdkRVU2dGXi8rOEw9N14/NGlKSFtJXE1OT0pbXF1eX1VmZ2hpamtsbW5vYnN0dXZ3eHl6e3x//aAAwDAQACEQMRAD8A9VSSTJKXSTJJKXSTJSkpdJMSAJOg8VgdU+vf1W6Y413ZzLrhp6ONNz5/d/Rbq2O/4x6dCE5moRMj/VFqegSXJVfXbqucf8lfVvOyGH6FmQWYrT8H272f9JXaOp/XK0S/oePjk9rc4E/+AYtyecExvwjznC/8XiRb0CSx25n1oB/SdLxSPFma4n/Nfg1/9UrVObnkfp+n2Vnxrsqsb/58qf8A+BphgR2/xopbySgx4e3cAR5OBB/6SkmqXSTJJKXSTJJKXSSSSU//0PVUydMkpSSSBmZuLg4tmZmWtox6W77LHaAAf6+1qW+gUnOi4/rf+MTDx8j9ndCod1jqLzsYKpNId3HqM3OyNn5/ofo/9LfUsPN6v1/6+Z7+ldIDsLo7P6TY+RLD+dmFv0vU/wAB06t36T/tU/0/5rtPq/8AVjpP1dxjXhs/SuH6fKsj1Hx+8/6NdTfzKa/0TFZOPHhF5vVOrGIGhH/ay/7hF3s87X9UfrN9Yf0/1t6i+jHdqOl4ZDWgdm2ubuq/9u3/APdldD0/ov1a+rzAMPFqxngfzkb7j/11++9GyM8vrL6nGvHB2+qB73n9zHa7/wA/LKsfveXRtntM/wCc8+5yw/iXx+WOPBiAN6xiPRhr94Y4fP8A35NrDynEbnpX+M6j+uMn9HUXDxcQ38m5Bd1rJP0WMaPOSfytWekufyfGOen/AJUx8ICMW5HlcI/RvzLpVdWtd/Ovaz/rZcPwtDlZrzcl4LqhVkgctY4sf/mWLETsLw8GqfUH0NvM+UKXB8Y5gERmZT/rRl+s/wCf7mL/AMaWz5XGdQAPp6f+bwy/5zuVdVxnP9O3dRZMFtgjX+srgIIkcLN6g/HdiD7Tt+1bRDWmXB3/AJBUsLqD8VwaSX0nlg1Inuz/AMgtf/Sn3fPHDzEo5ITAkMsBw5MfF+jzGL9GX9xrfd/cgZwBiR+idYy/2cnoEkwTrXaqkkkklLpJJJKf/9H1VMnTFJSznNY0ueQ1rRLnHQADkkry3rHUs76+fWCrpPTHmvplLi9jyDG1p229Str/ADvpeng1P/8AA/V/R6n+M76y+hT+wcV+197PU6g9p1bSfoY3t/OyY/Sf8B/4YW59Rfq7+xOjtdezbn5u23K8W6focb/0HY7/ALe9ZXMQGDF78h+snphB6d8i06mvtdbpPScHo+BXg4LNlNfc6ue4/Tuuf+fbZ+e5CyHnOyTiMMY9euQ4d4/MlWs/INGK97fpH2t+J0n+ysirJqpwLa26X2u2n+rHO7/OXPfE+dgMgwzl6TGWfPZ9WWMfkwX/AK+fz/1G3y+IkGYGtiEP6p/Syf4CPMyBfb7dKa/bU0aANH539pARqcPKu/m6zt/ePtH3uV2rojjBusjxawf9/f8A+RWBHk+c5uZyDHI8Zvjl+rx/4PF+i3Tlw4gI8QFdPmk5nHKmyq2z+bY5/jtBK07bugdNcGZN9FNnMXWN3/Ha9yuVZuHdjnJpursx2gk3Mc0sAb9OXtOz2LQw/wDF8n+ezRj3jjHH/wA6XD/0WKfNSERKOKXDLSM5ConycmvpWa86tbXP7zv4N3KzX0QDWy4/Bgj/AKR3LjOu/X7qGTc+rpTvs2K0wLYBseP3vf8AzTP3Nv6X/qFn4+f9dG2V3VPz7NxGzcLHscTwNj91T1Yx/D/h+M6Qnnr9KR/7mHA6MfhXPTxieTLi5YyFxxy+b/D+bhe/yH/Vzp5LczIqZY0Alltg3/8AbIO7/oKifrt9WaLGV4u65z3Bo9GrbBJ2/Su9FcV9cTafrHluuaG2ltBsaNQHejTvaP7S3Om4n1Fxc7EYzItz8x9tYrbqWNscW7HexlNWxtn8uxXMcccJmOLHixcJrioRmo/DMEOXxZs8uZ5mWXH7ohgHFjj6IzPHL9z1fNxtzqf+MT7HmZGHVg73Y9j6jY+yASxxZu9Ntf8AJ/fVLE/xl5nrj7biVOxydfRLmvaJ1d+kc9lm1v5n6JYeVdVj/W+7IuMVU9SdZYYmGtv3PO0fS9oROq3W/Wj6xOPTqI9aGVgiDtaNpvvcPo/61pHNlJJE9RLhjCt29D4ZyMYwjPlh7csPu5eZlkmBjlp6fV/jvq1F1d9LL6XbqrWh9bh3a4bmu/zVNV8DFGHhY+I07hj1MqDvEMaGbv8AoqwtAbavIS4eI8JuNnhP9Xoukkkkh//S9VVbqOdR07ByM/JMU41brX+JDRu2t/lP+ixWVxP+NTqDqOi42Awwc68bx410j13j/t70FJhx+5kjD946/wB39JBNC3kvqpiX/WX63tys4b4e7qGYDqPYW/Z6Pd/g22+hVs/0NK9iXC/4qMAM6dm9RcPdlXClhP7lDe3/AF625XOr/wCMPBxHvowKXZNrCWue/wBlYI00/wALZtd/IZ/XUnxHPAZakRGOMcER5fNQZ+U5PPzMuHDA5DvKvlj/AHpS9MXp8vFryawywuDQ4OG0wZGn8Vn39Q+r3SLG1ZN9VNziBDjusE/Rc8Dc+pn8v2Vri6v8YvXW5AfdXTZVPvpDS3T85rH7nva7+v6izvrhezI+sOVkV/QuZRY2dDDqKXN/KsjJPASc0ccZZbEeKcfVXg7PLfAuY94YOZmYYpQlkBwy4rlCUI8Bv/aPffWv6w3dEwqr8epl1l7yxpeTtGm7dDPp/wCcuT6x9ZuqdQ+r+Lkm041jsi2m0Y5cwPa1lb27vdu/wv0d60P8YJA6R0tvnP3Vt/vXMW/+JnG/8O3/APnrHRz5J8c436eEaf4ra+E8ly/3fl8xxxllOacTM62I+7Hb/BSU9A9X6uZHXTkBpps2Cgtnd7mM/nd/0v0n+jUemZOVR0fq7a3ObTbXVW+DA3PsHP8AXobexU7MnP8A2fVjPLhg+o+ypsQx1mgsdv8A8I+uf+tf2103Rqem9W+quV0nBZ6fVmxe5rzLrXMO5rq3e32uZ+h9P/A/+C2QwAlKo+k8B/w51+i6PMznixGWf9djlzMKIEeDleXjkh/O/wCz9v1Saf1Jw67cvLznVtus6fjutx6nCQbdfTdH8nY5NlfX76x3j9HZXigjiqsaj43+r/0VQ6F1vK6BnvvZWHna6q6iyW8H/oWVvb+6iZ+X1H619Ya6mgeu9ra2V1yQ1gJ99rz/AF/e9ETIxiMJGM7NxiPmv+sjJyolzmTNzOHHl5fgicebLKMo4eAeuHtS/el+s42P1qe5/W7nvO5zqsdznHkk0Ue5dTgdL+pHR7qMi7NF+W1zHMa6wWFtmm39Dit/Nf8AQ9RUusfUvrmd1m19DKxj7KWNyLHhrXenTVU47G+pd9Jn7is9P/xdsxrK8vqOa3ZSRZZXW2Gwz3+7Isc32e33/olLHHkGSZ9sSuRIlPYNHmOb5OXKYMZ5yWLhxRjPFy3qyZLxxrHLh4vbecyqK8n633Y1oJqv6k6uyDB2vv2O2/2XJdW6Z1H6s9XaWPczY71MPKbHuaP+jvb9C+n/ANFWLUz+r/Vjp/VrM7p2M/qOabn3faLXltLbHEvmmtrR6uxzvbvb/LZYg5P196nlt9PJwsG+qd3p21Oe2R3h9qjIxjiuXr4riY+pt48nOTOIw5cnl/aGPLjzmGKU5fvQh6//ABz53v8AoHUbOqdIxs+2sVWXNJcwTEtc6suZu/Mft3sWguQ+rX14b1HKr6dlY7Ma14il9Z/RktE+n6bv5r2t9nvXXq/jmJRBB4q0J21eT57lsnL55wyY/Z4iZwhfHEY5S9HDP9LhXSSST2q//9P1VeWf41Mk2dexMafZj4u+PB1z3B3/AEMZi9SXjn+MWwu+tudr/NVUsHl+j9X/ANGq58Ojee/3Yk/9z/3S2Z0fRPqHjfZvqj01sQbKjef+vOfkf+jF51XkV4v1hblWz6ePmeq+NTtZbvdH+avU/q20N+rvS2jgYeOPuqYvLqBQfrJX9p2fZ/to9b1I2bPV/Sepv9np7Pp7ll/ESTlB6mcj+L0X/FuuHm7BI9uNgb1+sZ9Rz8Trf1gfl5L/ALFiXvaHP2l5ZW1oY3c2vdusc1n9hT+uDaW/WHJbjwaQygVbTI2iinZtP7u1L61ZPS8vrLndJqazHa1tc1t2tseJ3PYxob4+l/wmxbmb9Q+pZeJg30OrZlDHrryqrCR7miGHeA/3Mr2UvZ/wSq8Mp+4I+siXEZDr8zrjPg5c8pkyyly0JYZYIYMn+T/m8nFL9L/Je362H166hg5OD0urGvZc9rS9wY4OgFrGt3/ubv5Sw8lj6/qxgl4gXZeQ+s+LQyiou/7cY5q08X6lV0ZbautdSxcQGD6LLR6rgT+b6vptr3fv/pF1H1i6ng/Vrp2M3Hxq33tmvBrcJDNoHqW7/wCc9vs3+/1Ld6kMDLjyZP1egHdpx5vFy/3XlOUEubl7k8gP83GXEMkv5z5f8p/4XBpfVj6vszPqqcPqdLmNvtfdUSNtjJDWV3M3fQd7PZ+/X/wb1T6V9X8X6sdVHUOr9Rx2NoDzj1tJ9R+4Gre+nbv/AJt/0KvV96zumfWbrnU+vYFeTlv9F2Qyaq4rYQXfRc2uPUb/AMbvVL65j/snzv6zP/PdaBnjEIzjGzjIgDLT+t+iux8rzcuazcvmzjHj5uE+YyY8I9zhjKftSxwnlHp4oy9c+B7/ABz9VPrG919VdGbayA9z69tgH5u4WNrtcxS6vkYv1c6JkZWBi1VuZtDK2NDGl7iK2us9Pbv2zuXl3TepZfTMyvMxHbba+x1a5p+lXYPzq3rtvrH1rE6z9TX5WP7T6tbbaiZcx8+5n8r+Q/8APUkOYEoTNCOQAnRp8z8IyYOa5aHHPNyWTJCBjOXyer+bnw8MfV+jN5rE651bqXW8D7ZlWWNdlUzVO2v+cbxSzbWtv/GF16x146Lju21sDX5ZB+k4++qn+oxv6T/1WuX6Fr1zpw/7t0f+fGKPWLnX9Wzbnc2ZFh+W521v9lqrjLIYpCzc5anwdmXI4Tz2GQhGMOXxGUIRAjH3JT4YS4f6qul9KzerZbcPCYHWEFzi4w1rRAdZY79xsrrav8WLzXNvUQ2w8hlW5oP9Z1jNytf4uMetvScvJYP09lxrJ7xWxjq2/wCda9cZlfWDrmWSMjOvM/SYHljfnXXsYnCOKEIynEzM7rWhowZM/Pc1zefDyuWHL4+VMYzlKIyZMkp9alGXp9L1/RfqZj9I6vTkZ2fU97HfqtGjHPeQdroe7d7Pp+nWu2XkP1U1+smATqTbqT8HL15WeVlEwPDHhF7XxOJ8exZsfMY/eze/M4x6uCOKMfVL0xhFdJJJWHHf/9T1ReNf4wWH/nf1Cfz20kf9s1t/76vZV5T/AI0MY0/WWq8CG5WKwz4uqfYx/wD0LKVc+HGs5H70SP8Auv8AuVs9n0H6qW+t9Wek2eOHQD8RW1rv+pXC0/UzrHUMzIvtaMLENtjvWyPaS3cfc2n6f0fd+k9Ov+Wul/xa5oyfqtTTPvwrLMd3w3etV/4DcxWvr3/4mMr+tV/58YqPPYY8eTis+2ZmtuJ0/hHN5sOUYsJjGXNSx4vckOP2/Vw8UYf4bztN31O+rLvVqe7q/UWfRe2DW137zH/zNf8AXb9puYuv6v1mnpfSX9QtAnaPSqnV1jh+jr/8n/wa8dK6H649c/aWczFoeHYeCNlbmmWvfA9W3/0VX/6lVLHzHDCdAR2EIjuf0nc5v4N7vM8sJTyZr458zlyH/J4/b4ccIx9GPi4/lg4WTkXZV9mTkO9S61xfY89ydVvfWWjLx+idBpzNwvbTdIfMhpdW6msz9H06djNn5iJ9SPq+epZ3229s4eG4GDw+0e5lf9Wv+ct/63/pFo/4zf57p39W38tSZHGRhnkP6VAf43zNnLzmOXxLleUxgfquOcyP0D7GSMMUf8CXqeb+rX/ig6d/4Yr/ACqx9c//ABT539Zn/nutV/q1/wCKDp3/AIYr/KrH1z/8U+f/AFmf+e60z/In+/8A9y2D/wBtI/8AnLL/ANLQcj7Pf9n+0+m70N/p+rHt3xv9Pd+/sSZfeyqylljm1XbRawGGu2neze387Y76K7X6h4GL1HovUcTKZvpttaHDuPbo5h/Nc1y5nr/Qsromace6XVPl2PfGj2j/ANGM/wALX/3xKWKUYRyDaW/9VWHn8WTms3KToZcUgYA/5WNRycUf6+NF0L/l3pv/AIbo/wDPjFP6xYVmD1vNx3jaPVc+vzZYfVq/6DlHoQJ6506OftVP/nxi9J+s31Xxuu1Ndu9HMqEVXxMtnd6Vrfzq/wDz3/np+LEcmKXD80ZWGvz3xCHJ89h9z+ay4jCZH6BE/RN4f6qfWk9CstqurddiXkOeGRvY4ab6w6Gv3fnsRfrT9Z+ndVoGP0/ENAdaL7r3ta173APbq2rfu+n9N9iHd9Q/rNVYWMx2XtH+ErtYGn/t51Vn/QVnC/xd9bucDlPqxGfnSfUf/ZZX+jd/28iBzHD7fCeHxH/dLZz+EDP99OeHu6H0ZL4iPllLDD9L/BaH1Lx7L/rJhhgMVl1r3Ds1rXau/rP2MXrSyuhfV3p/RKSzGBfbZHq3vgud5fyGfyGrVVvl8Rxwo7k2XnfjHPw5zmePGCMcIjHDi3lRlLjr/CXSSSUzmv8A/9X1VcP/AI1en+t0jF6i0Euwb9rz4V3j0nT/ANfbjLuFT6t06nqnTcnp1/8AN5VbqyeYJHssH8qt/vapMGT28sJ/unX+7+kgiwQ+a/4serDD61b06wxV1Jn6Of8AT0guaP8ArtHqf9s1rtfr2P8AsXy/jV/59rXj5GZ0/MLSfRz8G6J/cupd9L+rvb/22vUeudYo619QbOo0+31hV6lfJZY22tt1Lv8Ai7ArHxfFUZZRqJxIJ/rCOn+NFs/Cz/TOWH+ux/8ApSL50mSPC7z63fVH7RT+1+ms/TFoflY7RG/T+eqaP8L/AKVn+F/43+d52GMzjIj9GtHu+Y53Fy+XDjynhGfijGf6MZw4KjL+/wAbX+pH1qx8RjOkZu2uouPoZHADnHd6d/8AWc72Wqf+M7+e6f8A1bfy1LiF1WV0zrXWuidDFNNmRe1mQHPdoBWHsbj+pbZtY39G32e79IpY5JTxSx0ZEAcNf3o+lz83JYOW+IYedExjjklkjmEzww45Ycs/d4pfL/Xcj6s/+KDp/wDx7Pyqx9c9PrPnf1mf+e611X1Y+pJ6XkN6j1Kxll9X81Wz6DCRHqPe/bvfr7fb7FrWM6BTmWZrMdl+bYQ51sbyHAbW7LLJbV7R/gU2Yhiw/rskcNy4vWfVVfox/Sa2b4xhHPnLhhLmIxwnDcPTA5JZPc+aX6H9dz/8XuBk4nSLLchhr+1WepU1wglga1rX6/v/AJn8hbvVuk4XVsR2LmN3Vk7muGjmOHFlbvzXqjb1jJef0bW1Dx+kfx9v/RVS2+67+dsc/wAidP8AN+iq2T45yuOHt44SzUK1/Vwl/jer/mORlhzGbmZcyZDDOUuMcBuUP3f8Vh036tfVvouUMtltmTfXPpB7g/YSNstZSxjd+3/SLTt63yKKp8HPP/fGrL8lKqp91ja69XOMD/yR/qrOl8Z5rIRjwRji4jQGOPFORl/WnxMmXH7svc5ics0gPmyHQRi3LL+p3Y7skv20t/d9vfb7fztv9pH6JW4C60zDiG88kSXf9UoZjt5r6Zi6hsB57SP3v6v07EP6w9Zo+rPQnZDQH3AeliVH/CXOkt3fyG+6+7/g2LS5DlJ5eejIZJ5vYjwTlOXHGfNz9M4Y/wDV4+JqZsgGHh4RH3DYiBw/qh8spf3k1f1p6G/rF3RTktZnUlrdj/a17nBr/TosPsttZvbvq/nVZyesYmLf6F4exxLWtO2Q5zvoMbtn3OXhFrn3Oe+93rWWuL7Xv1L3uO99jv6zzuXef4t+rfWDMz3YFlv2rpmNXvtdfL31E+3GqoyPp/pH/wCDv9T9DR+j2LquY5DgxmcJ/KPVxf8ActPHOPF6gSP6p4T/AN0+kJ0ydUFP/9b1VMnTJKfNv8Z/1edVkM+sGM39HbtpzgOGvEV42S7/AIz+jWf+g6x/q9ZZ/wA1/rHQXH0mOwrG1zoHvscyx4H7z2U1b/8Ai165lYtGXj24uSwW0XtNdtbuHNcNrmryrqONf9SreodMsxG9Qw+q+k7Dvve5jNmO6ywV3ehsfbkVOtZ6jGWU+ps9X/CK7GcuY5TJyor3eGsd/pRv/uGTlskcPM4c0gTHHkhOQj81QlxelzMLBy+oZLMXErNtthAAA0Gv03n8xjfznL2qtmytrCZ2gNn4BeV/V3/GFmdNyXMz6KrOnWmfSxam0mk/vUVs/n2O/wAJXc/1vz2W/wCCf6b07qfT+qYrcvp97Mmh2gew8H9x7fpV2f8AB2e9UhyGTlb4/VxV6o/J5N74p8W+/wAoVD24YuLhBPFOXHWsv8VzOodC+q/2r7Xl4dbshx37W7huM/TsoY5tNm5351rPep29Xs2hmNW2pjRAnUgDjawexq0cvBpymjf7Xt+i8cif+qasm/pmXUdG+q395mv/AEPpLD+KT+I45S9iPDhP6eCP63/qn6cf8FZhnDLGIzZJTlDSMcsjKEf9mJelr23XXGbXl/xOg/s/RUEj7TDvafA6FKR4rm5ynKRMyTI7mWsm4AANBQ8FJJSPFFrxMm7+bqc4HgkQP850JQxzmeGEZTPaI4iokDUkDzYMY+x7WMBc93ACu0B1JNGJF2W8RZaPosHgHo+P0u4MLbrNjXfSZX9J38l9v7v8hqsZWV03o2C/JybGYmJUJc92g+H79tjvzGfzj1v/AA74Rm0lIHHOWnF/lo8X6OGH6M/9bP8A8K/TaWfmo7D1Dt+h/hn/ALhG1mH0jDty8u1tbK2l+RkO4AGp/wBfz15D9aPrFf8AWHqhy3B1eLSDXhUO5ZWT7rLB9H18ja19v/W6f8GrX1t+t+V9YbxXW12P02l26nHP0nuH0b8n+X/o6f8AA/8AGrniQJJ0A7ldr8N+Hw5XGKiIkCoxH6Hf/Dk5+XIZkkmyd12se97a62OssscGV1tEuc9x2V1sb+8952r2n6ofV5vQOj14z4dl3H1sywcG1wH6Np/0dDf0Nf8A25/hFzX+Lv6oOq2df6kwixwnAocILGkf0uxp/wALa0/oG/4Kr/jf0XoCi5/mRM+1A+mJ9R/el/6CqArVdJJJUFz/AP/X9VTJ0ySlKl1fpGB1nAswM+v1KX6gjR7HD6F1L/zLa/zXK6kiCQQQaI2KnxL6yfVfqP1dyNuSPWw7HbcfNaPY792u7/QZH/Bu9lv+BVDp/UuodLyvtfTsh+Nfw5zeHD9y6t36O5n/ABi94yMbHyqX4+TW26mwbbKrAHNcPBzHe1y89+sH+LCxpdkfV5+5nJwLnaj+TjZL/wDz3k/+xC08HPQmODNQJ0uvRP8AvfurDE7hP0X/ABp47g2rrmOaX8HKxgX1Hzso1vq/639oXY9O610jqrA7p2ZTk6SWscC4f8ZV/OV/22Lw3LxcrCvONm02Yt4/wVzSxxH8jd/ON/lVoJY0uDiPcOHcEfB30k/J8PxT9UDwX29cPp/6OrjI0L9COY14h7Q4eBEof2XF/wBDX/mheG0dc67jgNx+p5dbRw0XPLf82wvarP8Azu+tUR+1sj/ofl9NVZ/COI2Tjl4yjqkZSNrHk+2MqqZ9BjW/AAfkQc3qPT+n1+rn5NWLX2dc9rAfhvI3LxK76wfWC8EXdUzHtPLRc5o+6osWeWgvNjvdYeXuJc7/AD3y5SY/hQjoZiI7Qj/6Kg5L8X1DrH+NHpOO11fSKndQuiBa4GqgHx3vHrW/1aq/f/pl591frfVOtZIyepXm5zZ9Kse2qsHtRT9Fv/GO/TP/ANIqPiT25Wn0T6t9Z668fs/HJomHZVssoH/XY3W/1Mdtqt48GDlxxbVvOe60knRzCQBJ4Xf/AFM/xf2PdX1Tr1WxrYfj4DxrPLLc1n/UYv8A2/8A6Jb31Z+oXTOiOZlZB+3dRbq294hlZ/7rUe7Z/wAc/wBS5dQqfM8/xAwxaDrPqf7q6MOpUkkks9eukkkkp//Q9VTJ0klLJJ0klLJJ0klNfMwMLPpNGbj15NJ/wdrA9v3Plcr1D/Fd9Xsgl2G+/AeeG1v9Suf+KyfU/wChYxdkkpMebJj+SRj9dP8AFQQC+Y5X+KfqzD+p9Qx729vWY+o/fWcn/qVRs/xZ/WthhrMazzbcf/RlNa9cSU8fiGcbmMvMf97wo4A+SVf4svrVZ9IYtXm+5x/89UPWjif4ps1xBzupV1juzHqLz/27e5v/AJ4XpSSUviGc7ER8h/3yuAPMdL/xefVnp7m2PoOdc3UWZZ9QA+VEMxv/AAFdK1oaA1oAAEADgAKSSrTyTmbnIyPiVyySdJNUsknSSUpJJJJT/9n/7SiKUGhvdG9zaG9wIDMuMAA4QklNBCUAAAAAABAAAAAAAAAAAAAAAAAAAAAAOEJJTQQ6AAAAAACTAAAAEAAAAAEAAAAAAAtwcmludE91dHB1dAAAAAUAAAAAQ2xyU2VudW0AAAAAQ2xyUwAAAABSR0JDAAAAAEludGVlbnVtAAAAAEludGUAAAAAQ2xybQAAAABNcEJsYm9vbAEAAAAPcHJpbnRTaXh0ZWVuQml0Ym9vbAAAAAALcHJpbnRlck5hbWVURVhUAAAAAQAAADhCSU0EOwAAAAABsgAAABAAAAABAAAAAAAScHJpbnRPdXRwdXRPcHRpb25zAAAAEgAAAABDcHRuYm9vbAAAAAAAQ2xicmJvb2wAAAAAAFJnc01ib29sAAAAAABDcm5DYm9vbAAAAAAAQ250Q2Jvb2wAAAAAAExibHNib29sAAAAAABOZ3R2Ym9vbAAAAAAARW1sRGJvb2wAAAAAAEludHJib29sAAAAAABCY2tnT2JqYwAAAAEAAAAAAABSR0JDAAAAAwAAAABSZCAgZG91YkBv4AAAAAAAAAAAAEdybiBkb3ViQG/gAAAAAAAAAAAAQmwgIGRvdWJAb+AAAAAAAAAAAABCcmRUVW50RiNSbHQAAAAAAAAAAAAAAABCbGQgVW50RiNSbHQAAAAAAAAAAAAAAABSc2x0VW50RiNQeGxAUgAAAAAAAAAAAAp2ZWN0b3JEYXRhYm9vbAEAAAAAUGdQc2VudW0AAAAAUGdQcwAAAABQZ1BDAAAAAExlZnRVbnRGI1JsdAAAAAAAAAAAAAAAAFRvcCBVbnRGI1JsdAAAAAAAAAAAAAAAAFNjbCBVbnRGI1ByY0BZAAAAAAAAOEJJTQPtAAAAAAAQAEgAAAABAAIASAAAAAEAAjhCSU0EJgAAAAAADgAAAAAAAAAAAAA/gAAAOEJJTQQNAAAAAAAEAAAAHjhCSU0EGQAAAAAABAAAAB44QklNA/MAAAAAAAkAAAAAAAAAAAEAOEJJTScQAAAAAAAKAAEAAAAAAAAAAjhCSU0D9QAAAAAASAAvZmYAAQBsZmYABgAAAAAAAQAvZmYAAQChmZoABgAAAAAAAQAyAAAAAQBaAAAABgAAAAAAAQA1AAAAAQAtAAAABgAAAAAAAThCSU0D+AAAAAAAcAAA/////////////////////////////wPoAAAAAP////////////////////////////8D6AAAAAD/////////////////////////////A+gAAAAA/////////////////////////////wPoAAA4QklNBAgAAAAAABAAAAABAAACQAAAAkAAAAAAOEJJTQQeAAAAAAAEAAAAADhCSU0EGgAAAAADSwAAAAYAAAAAAAAAAAAAAM0AAADMAAAACwBiAHUAcgBnAGUAcgAtAGsAaQBuAGcAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAMwAAADNAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAEAAAAAAABudWxsAAAAAgAAAAZib3VuZHNPYmpjAAAAAQAAAAAAAFJjdDEAAAAEAAAAAFRvcCBsb25nAAAAAAAAAABMZWZ0bG9uZwAAAAAAAAAAQnRvbWxvbmcAAADNAAAAAFJnaHRsb25nAAAAzAAAAAZzbGljZXNW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IABQAGgAbwB0AG8AcwBoAG8AcAAAABMAQQBkAG8AYgBlACAAUABoAG8AdABvAHMAaABvAHAAIABDAFMANQAAAAEAOEJJTQQGAAAAAAAHAAUBAQABAQD/4Q4jaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLwA8P3hwYWNrZXQgYmVnaW49Iu+7vyIgaWQ9Ilc1TTBNcENlaGlIenJlU3pOVGN6a2M5ZCI/PiA8eDp4bXBtZXRhIHhtbG5zOng9ImFkb2JlOm5zOm1ldGEvIiB4OnhtcHRrPSJBZG9iZSBYTVAgQ29yZSA1LjAtYzA2MCA2MS4xMzQ3NzcsIDIwMTAvMDIvMTItMTc6MzI6MDAgICAgICAgICI+IDxyZGY6UkRGIHhtbG5zOnJkZj0iaHR0cDovL3d3dy53My5vcmcvMTk5OS8wMi8yMi1yZGYtc3ludGF4LW5zIyI+IDxyZGY6RGVzY3JpcHRpb24gcmRmOmFib3V0PSIiIHhtbG5zOnhtcD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wLyIgeG1sbnM6ZGM9Imh0dHA6Ly9wdXJsLm9yZy9kYy9lbGVtZW50cy8xLjEvIiB4bWxuczpwaG90b3Nob3A9Imh0dHA6Ly9ucy5hZG9iZS5jb20vcGhvdG9zaG9wLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdEV2dD0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlRXZlbnQjIiB4bXA6Q3JlYXRvclRvb2w9IkFkb2JlIFBob3Rvc2hvcCBDUzUgV2luZG93cyIgeG1wOkNyZWF0ZURhdGU9IjIwMTEtMTEtMDJUMDg6NDc6MzAtMDU6MDAiIHhtcDpNb2RpZnlEYXRlPSIyMDExLTExLTAyVDEwOjA1OjQ1LTA1OjAwIiB4bXA6TWV0YWRhdGFEYXRlPSIyMDExLTExLTAyVDEwOjA1OjQ1LTA1OjAwIiBkYzpmb3JtYXQ9ImltYWdlL2pwZWciIHBob3Rvc2hvcDpDb2xvck1vZGU9IjMiIHBob3Rvc2hvcDpJQ0NQcm9maWxlPSJzUkdCIElFQzYxOTY2LTIuMSIgeG1wTU06SW5zdGFuY2VJRD0ieG1wLmlpZDpCMUExRUQyMzY0MDVFMTExQUEyOUEyQjY1OTdFQ0EzQyIgeG1wTU06RG9jdW1lbnRJRD0ieG1wLmRpZDpCMEExRUQyMzY0MDVFMTExQUEyOUEyQjY1OTdFQ0EzQyIgeG1wTU06T3JpZ2luYWxEb2N1bWVudElEPSJ4bXAuZGlkOkIwQTFFRDIzNjQwNUUxMTFBQTI5QTJCNjU5N0VDQTNDIj4gPHhtcE1NOkhpc3Rvcnk+IDxyZGY6U2VxPiA8cmRmOmxpIHN0RXZ0OmFjdGlvbj0iY3JlYXRlZCIgc3RFdnQ6aW5zdGFuY2VJRD0ieG1wLmlpZDpCMEExRUQyMzY0MDVFMTExQUEyOUEyQjY1OTdFQ0EzQyIgc3RFdnQ6d2hlbj0iMjAxMS0xMS0wMlQwODo0NzozMC0wNTowMCIgc3RFdnQ6c29mdHdhcmVBZ2VudD0iQWRvYmUgUGhvdG9zaG9wIENTNSBXaW5kb3dzIi8+IDxyZGY6bGkgc3RFdnQ6YWN0aW9uPSJjb252ZXJ0ZWQiIHN0RXZ0OnBhcmFtZXRlcnM9ImZyb20gaW1hZ2UvcG5nIHRvIGltYWdlL2pwZWciLz4gPHJkZjpsaSBzdEV2dDphY3Rpb249InNhdmVkIiBzdEV2dDppbnN0YW5jZUlEPSJ4bXAuaWlkOkIxQTFFRDIzNjQwNUUxMTFBQTI5QTJCNjU5N0VDQTNDIiBzdEV2dDp3aGVuPSIyMDExLTExLTAyVDEwOjA1OjQ1LTA1OjAwIiBzdEV2dDpzb2Z0d2FyZUFnZW50PSJBZG9iZSBQaG90b3Nob3AgQ1M1IFdpbmRvd3MiIHN0RXZ0OmNoYW5nZWQ9Ii8iLz4gPC9yZGY6U2VxPiA8L3htcE1NOkhpc3Rvcnk+IDwvcmRmOkRlc2NyaXB0aW9uPiA8L3JkZjpSREY+IDwveDp4bXBtZXRhPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg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', 3, 1, 1);
INSERT INTO `User` (`id_user`, `name`, `namenoemail`, `password`, `type`, `date_up`, `date_update`, `home_phone`, `mobile_phone`, `image`, `fk_company`, `free_campaign`, `status`) VALUES
(12, 'disenador@test.com', 'DISENADOR', '123', 3, '2016-12-12 22:06:29', '2016-12-12 22:06:29', '0', '0', '', 1, 1, 1),
(26, 'alanbarreraf@hotmail.com', 'ALAN GRATIS', 'alan', 3, '2017-07-07 22:37:03', '2017-01-30 20:20:49', '412481274', '111111', '', 4, 0, 1),
(101, 'sbmoralesv@outlook.com', '', 'sbmv8273', 3, '2017-02-16 19:45:07', '2017-02-16 19:50:13', '0', '0', '', 4, 0, 1),
(100, 'soniag@wizad.mx', 'SONIA GRATIS', 'sonia', 3, '2017-07-08 11:30:25', '2017-02-08 20:29:27', '0', '0', '', 4, 0, 1),
(98, 'sonia.rodriguez@autofinauto.com', 'SONIA DESIGN', 'soniadiseño', 3, '2017-01-30 17:43:11', '2017-01-31 11:24:13', '222222', '8182740581', '', 23, 1, 1),
(96, 'sonia_sre@hotmail.com', 'SONIA CADMIN', 'soniaadmin', 2, '2017-01-27 18:40:38', '2017-04-25 21:47:38', '123438500', '2147483647', 'data:image/jpeg;base64,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', 23, 1, 1),
(108, 'JUAN@HOTMAIL.COM', 'JUAN', 'ui1qncdi', 2, '2017-03-02 21:13:15', '2017-03-02 21:13:15', '1241251', '14121215', '', 30, 0, 1),
(109, 'contacto@wizad.mx', 'undefined', 'gi7m2dcq', 3, '2017-04-20 23:35:40', '2017-04-20 23:35:40', '0', '0', '', 4, 0, 1),
(110, 'notificaciones@wizad.mx', 'undefined', '6nbzyckl', 3, '2017-04-20 23:38:21', '2017-04-20 23:38:21', '39393939', '39393939', '', 4, 0, 1),
(111, 'facturacion@wizad.mx', 'undefined', 'd648uywe', 3, '2017-04-20 23:56:31', '2017-04-20 23:56:31', '0', '0', '', 4, 0, 1),
(112, 'paua@gmail.com', '', 'b4xy67ac', 3, '2017-05-11 11:27:46', '2017-05-11 11:27:46', '0', '2147483647', '', 4, 0, 1),
(113, 'asfsaf', 'undefined', 'xbfan29t', 3, '2017-05-11 22:16:13', '2017-05-11 22:16:13', '121251', '12512552', '', 4, 0, 1),
(114, '', '', '', 3, '2017-05-11 22:31:59', '2017-05-11 22:31:59', '0', '0', '', 0, 0, 1),
(115, '', '', '', 3, '2017-05-11 22:32:02', '2017-05-11 22:32:02', '0', '0', '', 0, 0, 1),
(116, '', '', '', 3, '2017-05-11 22:40:38', '2017-05-11 22:40:38', '0', '0', '', 0, 0, 1),
(117, '', '', '', 3, '2017-05-11 22:54:32', '2017-05-11 22:54:32', '0', '0', '', 0, 0, 1),
(118, 'asfasf', 'asfasf', 'asfasf', 3, '2017-05-11 23:07:37', '2017-05-11 23:07:37', '0', '0', '', 4, 0, 1),
(119, 'tttttttttt@ttt.co', 'tttttttttt', 'TNR19', 3, '2017-05-11 23:49:13', '2017-05-11 23:49:13', '0', '0', '', 4, 0, 1),
(120, 'alanbarreraff@gmail.com', 'tttttttttt', '2mGsi', 3, '2017-05-11 23:54:49', '2017-05-11 23:54:49', '0', '0', '', 4, 0, 1),
(121, 'asfa@go.co', 'asfasfasf', 'YCXdv', 3, '2017-05-12 00:02:05', '2017-05-12 00:02:05', '0', '0', '', 4, 0, 1),
(122, 'a@.co', 'afafsaf', 'q8o4q', 3, '2017-05-12 00:03:27', '2017-05-12 00:03:27', '0', '0', '', 4, 0, 1),
(123, '', '', '', 3, '2017-05-12 00:20:24', '2017-05-12 00:20:24', '0', '0', '', 0, 0, 1),
(124, '', '', '', 3, '2017-05-12 21:06:31', '2017-05-12 21:06:31', '0', '0', '', 0, 0, 1),
(125, 'panucho4@hotmail.com', 'Prueba 12/05', 'BSyvT', 3, '2017-05-12 21:07:36', '2017-05-12 21:07:36', '0', '0', '', 4, 0, 1);
INSERT INTO `User` (`id_user`, `name`, `namenoemail`, `password`, `type`, `date_up`, `date_update`, `home_phone`, `mobile_phone`, `image`, `fk_company`, `free_campaign`, `status`) VALUES
(126, 'sonia_sre @hotmail,com', 'Sonia', '9SDdd', 3, '2017-05-13 22:25:53', '2017-05-13 22:25:53', '0', '0', '', 4, 0, 1),
(127, '', '', '', 3, '2017-05-13 22:35:00', '2017-05-13 22:35:00', '0', '0', '', 0, 0, 1),
(128, '', '', '', 3, '2017-05-13 22:37:17', '2017-05-13 22:37:17', '0', '0', '', 0, 0, 1),
(129, '', '', '', 3, '2017-05-13 22:40:13', '2017-05-13 22:40:13', '0', '0', '', 0, 0, 1),
(130, '', '', '', 3, '2017-05-13 22:43:44', '2017-05-13 22:43:44', '0', '0', '', 0, 0, 1),
(131, 'ilthardz@gmail.com', 'Iltha', 'm8sur', 3, '2017-05-13 22:57:57', '2017-05-13 22:57:57', '0', '0', '', 4, 0, 1),
(132, 'edithrdz@hotmail.com', 'undefined', 'gntofb9w', 3, '2017-05-13 23:07:26', '2017-05-13 23:07:26', '55656', '65656', '', 4, 0, 1),
(133, '', '', '', 3, '2017-05-21 13:07:35', '2017-05-21 13:07:35', '0', '0', '', 0, 0, 1),
(134, 'test', 'test', 'k9igR', 3, '2017-05-21 14:42:38', '2017-05-21 14:42:38', '0', '0', '', 4, 0, 1),
(135, 'fsaf', 'fsafas', 'lif41', 3, '2017-05-21 14:43:09', '2017-05-21 14:43:09', '0', '0', '', 4, 0, 1),
(136, '', '', '', 3, '2017-05-21 14:44:50', '2017-05-21 14:44:50', '0', '0', '', 0, 0, 1),
(137, '', '', '', 3, '2017-05-21 14:46:50', '2017-05-21 14:46:50', '0', '0', '', 0, 0, 1),
(138, '', '', '', 3, '2017-05-21 14:47:28', '2017-05-21 14:47:28', '0', '0', '', 0, 0, 1),
(139, '', '', '', 3, '2017-05-21 14:47:57', '2017-05-21 14:47:57', '0', '0', '', 0, 0, 1),
(140, '', '', '', 3, '2017-05-21 14:49:16', '2017-05-21 14:49:16', '0', '0', '', 0, 0, 1),
(141, '', '', '', 3, '2017-05-21 14:50:54', '2017-05-21 14:50:54', '0', '0', '', 0, 0, 1),
(142, '', '', '', 3, '2017-05-21 14:53:22', '2017-05-21 14:53:22', '0', '0', '', 0, 0, 1),
(143, 'dsadsaad', 'sadsadsadsa', 'deWpW', 3, '2017-05-21 14:54:55', '2017-05-21 14:54:55', '0', '0', '', 4, 0, 1),
(144, 'holahola', 'pablo test registro', 'ZFTad', 3, '2017-05-21 14:55:21', '2017-05-21 14:55:21', '0', '0', '', 4, 0, 1),
(145, 'pablo@test.com', 'pablo test', 'GOav2', 3, '2017-05-21 14:56:22', '2017-05-21 14:56:22', '0', '0', '', 4, 0, 1),
(146, '', '', '', 3, '2017-05-22 16:10:03', '2017-05-22 16:10:03', '0', '0', '', 0, 0, 1),
(147, 'pablobarrera@gmail.com', 'alan', 'p2uSj', 3, '2017-06-01 19:38:16', '2017-06-01 19:38:16', '0', '0', '', 4, 0, 1),
(148, '', '', '', 3, '2017-06-01 19:39:46', '2017-06-01 19:39:46', '0', '0', '', 0, 0, 1),
(149, '', '', '', 3, '2017-06-01 19:40:10', '2017-06-01 19:40:10', '0', '0', '', 0, 0, 1),
(150, 'jesusvicente@gmail.com', 'Jesus Piña', '31zgy5nc', 3, '2017-06-01 19:40:57', '2017-06-01 19:40:57', '0', '0', '', 4, 0, 1),
(151, 'afsafsaf', 'pablo@pablo.com', 'YjrnU', 3, '2017-06-01 19:48:25', '2017-06-01 19:48:25', '0', '0', '', 4, 0, 1),
(152, '', '', '', 3, '2017-06-22 18:02:42', '2017-06-22 18:02:42', '0', '0', '', 0, 0, 1),
(153, '', '', '', 3, '2017-07-14 11:42:55', '2017-07-14 11:42:55', '0', '0', '', 0, 0, 1),
(154, 'jesus.pina@yokatia.mx', 'Jesus Pina', 'TmuzF', 3, '2017-08-01 08:31:55', '2017-08-01 08:31:55', '0', '0', '', 4, 0, 1),
(155, 'jptelcel@gmail.com', 'Jesus Prueba 2', '7R5v2', 3, '2017-08-01 08:40:39', '2017-08-01 08:40:39', '0', '0', '', 4, 0, 1),
(156, 'pancho@prueba.com', 'Pancho Lopez', 'U7lcm', 3, '2017-08-01 08:47:14', '2017-08-01 08:47:14', '0', '0', '', 4, 0, 1),
(157, 'yaquedo@listo.com', 'Jesus Prueba 3', 'WEoCX', 3, '2017-08-01 08:48:22', '2017-08-01 08:48:22', '0', '0', '', 4, 0, 1),
(158, 'erickbell83@gmail.com', 'Erick', 'Yo80c', 3, '2017-09-06 18:03:07', '2017-09-06 18:03:07', '0', '0', '', 4, 0, 1),
(159, 'empresas.wizad.mx', 'erickbell83@gmail.com', '9zvDa', 3, '2017-09-06 18:05:04', '2017-09-06 18:05:04', '0', '0', '', 4, 0, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Admin_History`
--
ALTER TABLE `Admin_History`
  ADD PRIMARY KEY (`id_history`);

--
-- Indices de la tabla `Admin_Inbox`
--
ALTER TABLE `Admin_Inbox`
  ADD PRIMARY KEY (`id_inbox`);

--
-- Indices de la tabla `Admin_Visits`
--
ALTER TABLE `Admin_Visits`
  ADD PRIMARY KEY (`id_visit`);

--
-- Indices de la tabla `Campaign`
--
ALTER TABLE `Campaign`
  ADD PRIMARY KEY (`id_campaign`);

--
-- Indices de la tabla `Campaign_Fonts`
--
ALTER TABLE `Campaign_Fonts`
  ADD PRIMARY KEY (`id_cgfont`);

--
-- Indices de la tabla `Campaign_Material`
--
ALTER TABLE `Campaign_Material`
  ADD PRIMARY KEY (`id_cgmaterial`);

--
-- Indices de la tabla `Campaign_Pack`
--
ALTER TABLE `Campaign_Pack`
  ADD PRIMARY KEY (`id_cgpack`);

--
-- Indices de la tabla `Campaign_Palette`
--
ALTER TABLE `Campaign_Palette`
  ADD PRIMARY KEY (`id_cgpalette`);

--
-- Indices de la tabla `Campaign_Texts`
--
ALTER TABLE `Campaign_Texts`
  ADD PRIMARY KEY (`id_cgtext`);

--
-- Indices de la tabla `Company`
--
ALTER TABLE `Company`
  ADD PRIMARY KEY (`id_company`);

--
-- Indices de la tabla `Company_Fonts`
--
ALTER TABLE `Company_Fonts`
  ADD PRIMARY KEY (`id_font`);

--
-- Indices de la tabla `Company_Pack`
--
ALTER TABLE `Company_Pack`
  ADD PRIMARY KEY (`id_pack`);

--
-- Indices de la tabla `Company_Palette`
--
ALTER TABLE `Company_Palette`
  ADD PRIMARY KEY (`id_palette`);

--
-- Indices de la tabla `Company_Subscription`
--
ALTER TABLE `Company_Subscription`
  ADD PRIMARY KEY (`id_csubs`);

--
-- Indices de la tabla `Company_TextConfig`
--
ALTER TABLE `Company_TextConfig`
  ADD PRIMARY KEY (`id_config`);

--
-- Indices de la tabla `Control_History`
--
ALTER TABLE `Control_History`
  ADD PRIMARY KEY (`id_history`);

--
-- Indices de la tabla `Ct_Age`
--
ALTER TABLE `Ct_Age`
  ADD PRIMARY KEY (`id_age`);

--
-- Indices de la tabla `Ct_City`
--
ALTER TABLE `Ct_City`
  ADD PRIMARY KEY (`id_city`);

--
-- Indices de la tabla `Ct_Dimensions`
--
ALTER TABLE `Ct_Dimensions`
  ADD PRIMARY KEY (`id_dimension`);

--
-- Indices de la tabla `Ct_Edad`
--
ALTER TABLE `Ct_Edad`
  ADD PRIMARY KEY (`id_edad`);

--
-- Indices de la tabla `Ct_Material`
--
ALTER TABLE `Ct_Material`
  ADD PRIMARY KEY (`id_material`);

--
-- Indices de la tabla `Ct_Segment`
--
ALTER TABLE `Ct_Segment`
  ADD PRIMARY KEY (`id_segment`);

--
-- Indices de la tabla `Ct_Subscription`
--
ALTER TABLE `Ct_Subscription`
  ADD PRIMARY KEY (`id_subs`);

--
-- Indices de la tabla `Ct_SubscriptionPlan`
--
ALTER TABLE `Ct_SubscriptionPlan`
  ADD PRIMARY KEY (`id_subsplan`);

--
-- Indices de la tabla `Ct_UserType`
--
ALTER TABLE `Ct_UserType`
  ADD PRIMARY KEY (`id_usertype`);

--
-- Indices de la tabla `Design`
--
ALTER TABLE `Design`
  ADD PRIMARY KEY (`id_design`),
  ADD UNIQUE KEY `id_design` (`id_design`);

--
-- Indices de la tabla `Det_Subscription`
--
ALTER TABLE `Det_Subscription`
  ADD PRIMARY KEY (`id_detsubs`);

--
-- Indices de la tabla `General_Messages`
--
ALTER TABLE `General_Messages`
  ADD PRIMARY KEY (`id_gmessage`);

--
-- Indices de la tabla `Image_Bank`
--
ALTER TABLE `Image_Bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indices de la tabla `Session`
--
ALTER TABLE `Session`
  ADD PRIMARY KEY (`id_session`);

--
-- Indices de la tabla `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Admin_History`
--
ALTER TABLE `Admin_History`
  MODIFY `id_history` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2458;
--
-- AUTO_INCREMENT de la tabla `Admin_Inbox`
--
ALTER TABLE `Admin_Inbox`
  MODIFY `id_inbox` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `Admin_Visits`
--
ALTER TABLE `Admin_Visits`
  MODIFY `id_visit` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2046;
--
-- AUTO_INCREMENT de la tabla `Campaign`
--
ALTER TABLE `Campaign`
  MODIFY `id_campaign` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;
--
-- AUTO_INCREMENT de la tabla `Campaign_Fonts`
--
ALTER TABLE `Campaign_Fonts`
  MODIFY `id_cgfont` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT de la tabla `Campaign_Material`
--
ALTER TABLE `Campaign_Material`
  MODIFY `id_cgmaterial` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=385;
--
-- AUTO_INCREMENT de la tabla `Campaign_Pack`
--
ALTER TABLE `Campaign_Pack`
  MODIFY `id_cgpack` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=207;
--
-- AUTO_INCREMENT de la tabla `Campaign_Palette`
--
ALTER TABLE `Campaign_Palette`
  MODIFY `id_cgpalette` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;
--
-- AUTO_INCREMENT de la tabla `Campaign_Texts`
--
ALTER TABLE `Campaign_Texts`
  MODIFY `id_cgtext` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=112;
--
-- AUTO_INCREMENT de la tabla `Company`
--
ALTER TABLE `Company`
  MODIFY `id_company` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT de la tabla `Company_Fonts`
--
ALTER TABLE `Company_Fonts`
  MODIFY `id_font` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231;
--
-- AUTO_INCREMENT de la tabla `Company_Pack`
--
ALTER TABLE `Company_Pack`
  MODIFY `id_pack` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT de la tabla `Company_Palette`
--
ALTER TABLE `Company_Palette`
  MODIFY `id_palette` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT de la tabla `Company_Subscription`
--
ALTER TABLE `Company_Subscription`
  MODIFY `id_csubs` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;
--
-- AUTO_INCREMENT de la tabla `Company_TextConfig`
--
ALTER TABLE `Company_TextConfig`
  MODIFY `id_config` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
--
-- AUTO_INCREMENT de la tabla `Control_History`
--
ALTER TABLE `Control_History`
  MODIFY `id_history` int(9) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `Ct_Age`
--
ALTER TABLE `Ct_Age`
  MODIFY `id_age` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- AUTO_INCREMENT de la tabla `Ct_City`
--
ALTER TABLE `Ct_City`
  MODIFY `id_city` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=78;
--
-- AUTO_INCREMENT de la tabla `Ct_Dimensions`
--
ALTER TABLE `Ct_Dimensions`
  MODIFY `id_dimension` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT de la tabla `Ct_Edad`
--
ALTER TABLE `Ct_Edad`
  MODIFY `id_edad` int(9) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `Ct_Material`
--
ALTER TABLE `Ct_Material`
  MODIFY `id_material` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
--
-- AUTO_INCREMENT de la tabla `Ct_Segment`
--
ALTER TABLE `Ct_Segment`
  MODIFY `id_segment` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;
--
-- AUTO_INCREMENT de la tabla `Ct_Subscription`
--
ALTER TABLE `Ct_Subscription`
  MODIFY `id_subs` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=101;
--
-- AUTO_INCREMENT de la tabla `Ct_SubscriptionPlan`
--
ALTER TABLE `Ct_SubscriptionPlan`
  MODIFY `id_subsplan` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT de la tabla `Ct_UserType`
--
ALTER TABLE `Ct_UserType`
  MODIFY `id_usertype` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT de la tabla `Design`
--
ALTER TABLE `Design`
  MODIFY `id_design` int(9) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `Det_Subscription`
--
ALTER TABLE `Det_Subscription`
  MODIFY `id_detsubs` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `General_Messages`
--
ALTER TABLE `General_Messages`
  MODIFY `id_gmessage` int(9) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `Image_Bank`
--
ALTER TABLE `Image_Bank`
  MODIFY `id_bank` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT de la tabla `Session`
--
ALTER TABLE `Session`
  MODIFY `id_session` int(9) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT de la tabla `User`
--
ALTER TABLE `User`
  MODIFY `id_user` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=160;COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
