CONNECT adminExoEntr/adminExoEntr;

DECLARE
	-- Déclarez une variable de type SYS.ODCIVARCHAR2LIST pour stocker les données de l'article.
	article_data SYS.ODCIVARCHAR2LIST;
BEGIN
    -- Initialisez les données de l'article dans la variable.
    article_data := SYS.ODCIVARCHAR2LIST('Livre1', 'Livre', 2);

    -- Appelez la procédure avec les données de l'article.
    EXECUTE IMMEDIATE 'SET ROLE adminRole';
    ExoEntr.insertOneArticle(article_data);
    EXECUTE IMMEDIATE 'SET ROLE NONE';
END;
/

CONNECT gestionnaireVenteExoEntr/gestionnaireVenteExoEntr;
DECLARE
   v_user_has_privilege BOOLEAN;
BEGIN
   -- Vérifier si l'utilisateur a les privilèges nécessaires
   SELECT COUNT(*)
   INTO v_user_has_privilege
   FROM USER_TAB_PRIVS
   WHERE TABLE_NAME = 'COMMANDES'
      AND PRIVILEGE = 'INSERT';

   -- Si l'utilisateur n'a pas les privilèges, lever une exception
   IF v_user_has_privilege = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'L\'utilisateur n\'a pas les privilèges nécessaires pour effectuer l\'insertion.');
   END IF;

   -- Exécuter l'instruction INSERT
   INSERT INTO ExoEntr.Commandes (idClient, idArticle, numCommande, quantiteCommande, dateCommandes)
   VALUES (76, 13, 'b368d836-027d-4808-8920-7bc484399ed9', '55', TO_DATE('2023-11-14', 'YYYY-MM-DD'));

   -- Afficher un message en cas de succès
   DBMS_OUTPUT.PUT_LINE('Insertion réussie.');
EXCEPTION
   WHEN OTHERS THEN
      -- Gérer les exceptions ici
      DBMS_OUTPUT.PUT_LINE('Une erreur s\'est produite : ' || SQLERRM);
END;
/
