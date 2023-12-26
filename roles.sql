CREATE USER adminExoEntr IDENTIFIED BY adminExoEntr;
GRANT CONNECT TO adminExoEntr;

CREATE USER gestionnaireVenteExoEntr IDENTIFIED BY gestionnaireVenteExoEntr;
GRANT CONNECT TO gestionnaireVenteExoEntr;

CREATE ROLE adminRole;
CREATE ROLE gestionnaireVenteRole;

GRANT ALL ON ExoEntr.Clients TO adminRole;
GRANT ALL ON ExoEntr.CarteFidelites TO adminRole;
GRANT ALL ON ExoEntr.Articles TO adminRole;
GRANT ALL ON ExoEntr.Factures TO adminRole;
GRANT SELECT ON ExoEntr.Commandes TO adminRole;
GRANT ALL ON ExoEntr.LigneFactures TO adminRole;
BEGIN
    addPrivAdmin;
END;
/



-- GRANT EXECUTE ON insertOneArticle TO adminRole;

-- Privileges gestionnaireVenteRole
GRANT SELECT ON ExoEntr.Clients TO gestionnaireVenteRole;
GRANT ALL ON ExoEntr.CarteFidelites TO gestionnaireVenteRole;
GRANT ALL ON ExoEntr.Articles TO gestionnaireVenteRole;
GRANT ALL ON ExoEntr.Factures TO gestionnaireVenteRole;
GRANT SELECT ON ExoEntr.Commandes TO gestionnaireVenteRole;
GRANT ALL ON ExoEntr.LigneFactures TO gestionnaireVenteRole;
BEGIN
    addPrivGestVente;
END;
/



GRANT adminRole TO adminExoEntr;
GRANT gestionnaireVenteRole TO gestionnaireVenteExoEntr;

