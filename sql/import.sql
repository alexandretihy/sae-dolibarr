SET NAMES utf8mb4;

CREATE TEMPORARY TABLE tmp_tiers (
  code_tiers VARCHAR(24), 
  nom VARCHAR(128), 
  forme_juridique VARCHAR(16),
  adresse VARCHAR(255), 
  code_postal VARCHAR(10), 
  ville VARCHAR(64),
  pays_code VARCHAR(2), 
  telephone VARCHAR(30), 
  email VARCHAR(128),
  site_web VARCHAR(255), 
  siren VARCHAR(9), 
  siret VARCHAR(14),
  tva_intra VARCHAR(20), 
  contact_prenom VARCHAR(64), 
  contact_nom VARCHAR(64),
  client TINYINT, 
  fournisseur TINYINT
) DEFAULT CHARSET=utf8mb4;

-- Chargement des clients
LOAD DATA LOCAL INFILE '/data/clients.csv' INTO TABLE tmp_tiers
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Chargement des fournisseurs
LOAD DATA LOCAL INFILE '/data/fournisseurs.csv' INTO TABLE tmp_tiers
  CHARACTER SET utf8mb4
  FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
  LINES TERMINATED BY '\n' IGNORE 1 LINES;

-- Insertion idempotente dans Dolibarr (llx_societe)
INSERT INTO llx_societe
  (nom, entity, statut, code_client, code_fournisseur, address, zip, town,
   fk_pays, phone, email, url, siren, siret, tva_intra, client, fournisseur, datec)
SELECT
  t.nom, 
  1, 
  1,
  IF(t.client = 1, t.code_tiers, NULL),
  IF(t.fournisseur = 1, t.code_tiers, NULL),
  t.adresse, 
  t.code_postal, 
  t.ville,
  c.rowid, 
  t.telephone, 
  t.email, 
  t.site_web, 
  t.siren, 
  t.siret, 
  t.tva_intra,
  t.client, 
  t.fournisseur, 
  NOW()
FROM tmp_tiers t
LEFT JOIN llx_c_country c ON c.code = t.pays_code
WHERE NOT EXISTS (SELECT 1 FROM llx_societe s WHERE s.nom = t.nom);

SELECT COUNT(*) AS nb_tiers FROM llx_societe;
