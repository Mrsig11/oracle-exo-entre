CREATE OR REPLACE PROCEDURE insertOneClient(client_data IN SYS.ODCIVARCHAR2LIST) AS
BEGIN
    INSERT INTO ExoEntr.Clients (
      nomClient,
      prenomClient,
      dateNaissClient,
      civiliteClient,
      adresseClient,
      codePostalClient,
      villeClient,
      telClient,
      mailClient
    ) VALUES (
        client_data(1),
        client_data(2),
        TO_DATE(client_data(3), 'DD-MON-YYYY'),
        client_data(4),
        client_data(5),
        client_data(6),
        client_data(7),
        client_data(8),
        client_data(9)
    );
    COMMIT;
      DBMS_OUTPUT.PUT_LINE('Client inséré avec succès.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
/

-- CREATE OR REPLACE PROCEDURE insertManyClients(clients_data IN DataInsertArray) AS
-- BEGIN
--   FOR i IN 1..clients_data.COUNT LOOP
--     insertOneClient(clients_data(i));
--   END LOOP;
--   COMMIT;
-- END;
-- /

CREATE OR REPLACE PROCEDURE insertOneCarteFidelite(carte_fidelite_data IN SYS.ODCIVARCHAR2LIST) AS
BEGIN
  INSERT INTO ExoEntr.CarteFidelites (
    dateDebutCarteFid,
    dateFinCarteFid,
    pointsFid,
    idClient
  ) VALUES (
    carte_fidelite_data(1),
    carte_fidelite_data(2),
    carte_fidelite_data(3),
    carte_fidelite_data(4)
  );
  
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('Carte de fidélité insérée avec succès.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
/

-- CREATE OR REPLACE PROCEDURE insertManyCarteFidelite(carte_fidelites_data IN DataInsertArray) AS
-- BEGIN
--   FOR i IN 1..carte_fidelites_data.COUNT LOOP
--     insertOneCarteFidelite(carte_fidelites_data(i));
--   END LOOP;
--   COMMIT;
-- END;
-- /

CREATE OR REPLACE PROCEDURE insertOneFacture(facture_data IN SYS.ODCIVARCHAR2LIST) AS
BEGIN
  INSERT INTO ExoEntr.Factures (
    numFacture,
    idClient
  ) VALUES (
    facture_data(1),
    facture_data(2)
  );
  
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('Facture insérée avec succès.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
/

-- CREATE OR REPLACE PROCEDURE insertManyFacture(factures_data IN DataInsertArray) AS
-- BEGIN
--   FOR i IN 1..factures_data.COUNT LOOP
--     insertOneFacture(factures_data(i));
--   END LOOP;
--   COMMIT;
-- END;
-- /

CREATE OR REPLACE PROCEDURE insertOneArticle(article_data IN SYS.ODCIVARCHAR2LIST) AS
BEGIN
  INSERT INTO ExoEntr.Articles (
    libelleArticle,
    typeArticle,
    quantiteStockArticle
  ) VALUES (
    article_data(1),
    article_data(2),
    article_data(3)
  );

  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('Article inséré avec succès.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
/

-- CREATE OR REPLACE PROCEDURE insertManyArticle(articles_data IN DataInsertArray) AS
-- BEGIN
--     FOR i IN 1..articles_data.COUNT LOOP
--         insertOneArticle(articles_data(i));
--     END LOOP;
--     COMMIT;
-- END;
-- /

CREATE OR REPLACE PROCEDURE insertOneCommande(commande_data IN SYS.ODCIVARCHAR2LIST) AS
BEGIN
  INSERT INTO ExoEntr.Commandes (
    idClient,
    idArticle,
    numCommande,
    dateCommandes
  ) VALUES (
    commande_data(1),
    commande_data(2),
    commande_data(3),
    SYSDATE
  );
  
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('Commande insérée avec succès.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
/

-- CREATE OR REPLACE PROCEDURE insertManyCommande(commandes_data IN DataInsertArray) AS
-- BEGIN
--     FOR i IN 1..commandes_data.COUNT LOOP
--         insertOneCommande(commandes_data(i));
--     END LOOP;
--     COMMIT;
-- END;
-- /

CREATE OR REPLACE PROCEDURE insertOneLigneFacture(ligne_facture_data IN SYS.ODCIVARCHAR2LIST) AS
BEGIN
  INSERT INTO ExoEntr.LigneFactures (
    idFacture,
    idArticle,
    quantite
  ) VALUES (
    ligne_facture_data(1),
    ligne_facture_data(2),
    ligne_facture_data(3)
  );
  
  COMMIT;
  
  DBMS_OUTPUT.PUT_LINE('Ligne de facture insérée avec succès.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Erreur : ' || SQLERRM);
END;
/

-- CREATE OR REPLACE PROCEDURE insertManyLigneFacture(ligne_factures_data IN DataInsertArray) AS
-- BEGIN
--     FOR i IN 1..ligne_factures_data.COUNT LOOP
--         insertOneLigneFacture(ligne_factures_data(i));
--     END LOOP;
--     COMMIT;
-- END;
-- /

CREATE OR REPLACE PROCEDURE addPrivAdmin IS v_grant_command VARCHAR2(1000);
BEGIN
    FOR rec IN (SELECT 'GRANT EXECUTE ON ' || object_name || ' TO adminRole' AS grant_command
                FROM all_procedures
                WHERE object_type = 'PROCEDURE' AND owner = 'EXOENTR') 
    LOOP
        v_grant_command := rec.grant_command;
        -- Afficher la commande (facultatif)
        DBMS_OUTPUT.PUT_LINE('Commande GRANT : ' || v_grant_command);
        
        -- Exécuter la commande GRANT
        EXECUTE IMMEDIATE v_grant_command;
    END LOOP;
END;
/


CREATE OR REPLACE PROCEDURE addPrivGestVente IS v_grant_command VARCHAR2(1000);
BEGIN
    FOR rec IN (SELECT 'GRANT EXECUTE ON ' || object_name || ' TO gestionnaireVenteRole' AS grant_command
                FROM all_procedures
                WHERE object_type = 'PROCEDURE' AND owner = 'EXOENTR') 
    LOOP
        v_grant_command := rec.grant_command;
        -- Afficher la commande (facultatif)
        DBMS_OUTPUT.PUT_LINE('Commande GRANT : ' || v_grant_command);
        
        -- Exécuter la commande GRANT
        EXECUTE IMMEDIATE v_grant_command;
    END LOOP;
    -- REVOKE EXECUTE ON ExoEntr.insertOneClient FROM gestionnaireVenteRole;
    -- REVOKE EXECUTE ON ExoEntr.insertOneCommande FROM gestionnaireVenteRole;
END;
/
