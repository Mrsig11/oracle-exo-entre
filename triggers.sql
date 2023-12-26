CREATE OR REPLACE TRIGGER idClientAutoIncr BEFORE INSERT ON ExoEntr.Clients
FOR EACH ROW
BEGIN
    :NEW.idClient := seqIdClient.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER idCarteFidAutoIncr BEFORE INSERT ON ExoEntr.CarteFidelites
FOR EACH ROW
BEGIN
    :NEW.idCarteFid := seqIdCarteFid.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER idFactureAutoIncr BEFORE INSERT ON ExoEntr.Factures
FOR EACH ROW
BEGIN
    :NEW.idFacture := seqIdFacture.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER idArticleAutoIncr BEFORE INSERT ON ExoEntr.Articles
FOR EACH ROW
BEGIN
    :NEW.idArticle := seqIdArticle.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER idCommandeAutoIncr BEFORE INSERT ON ExoEntr.Commandes
FOR EACH ROW
BEGIN
    :NEW.idCommande := seqIdCommande.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER idLigneFactureAutoIncr BEFORE INSERT ON ExoEntr.LigneFactures
FOR EACH ROW
BEGIN
    :NEW.idLigneFacture := seqIdLigneFacture.NEXTVAL;
END;
/

CREATE OR REPLACE TRIGGER deleteLignesFacture BEFORE DELETE ON ExoEntr.Factures
FOR EACH ROW
BEGIN
    DELETE FROM ExoEntr.LigneFactures WHERE idFacture = :OLD.idFacture;
END;
/

CREATE OR REPLACE TRIGGER updateQteStockArt AFTER INSERT ON ExoEntr.Commandes
FOR EACH ROW
BEGIN
    -- Mettre à jour la quantité en stock de l'article après chaque commande
    UPDATE ExoEntr.Articles
    SET quantiteStockArticle = quantiteStockArticle - :NEW.quantiteCommande
    WHERE idArticle = :NEW.idArticle;
END;
/
