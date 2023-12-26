CREATE TABLE ExoEntr.Clients (
    idClient NUMBER(10) NOT NULL,
    nomClient VARCHAR2(255) NOT NULL,
    prenomClient VARCHAR2(255) NOT NULL,
    dateNaissClient DATE NOT NULL,
    civiliteClient VARCHAR2(255) NOT NULL,
    adresseClient VARCHAR2(255) NOT NULL,
    codePostalClient VARCHAR2(255) NOT NULL,
    villeClient VARCHAR2(255) NOT NULL,
    telClient VARCHAR2(255) NOT NULL,
    mailClient VARCHAR2(255) NOT NULL,
    CONSTRAINT Clients_idClient_pk PRIMARY KEY (idClient)
);

CREATE TABLE ExoEntr.CarteFidelites (
    idCarteFid NUMBER(10) NOT NULL,
    dateDebutCarteFid DATE NOT NULL,
    dateFinCarteFid DATE NOT NULL,
    pointsFid NUMBER(7) NOT NULL,
    idClient NUMBER(10) NOT NULL,
    CONSTRAINT CarteFidelites_idCarteFid_pk PRIMARY KEY (idCarteFid),
    CONSTRAINT Clients_CarteFid_idClient_fk FOREIGN KEY (idClient) REFERENCES Clients (idClient)
);

CREATE TABLE ExoEntr.Factures (
    idFacture NUMBER(10) NOT NULL,
    numFacture VARCHAR2(255) NOT NULL,
    idClient NUMBER(10) NOT NULL,
    CONSTRAINT Factures_idFacture_pk PRIMARY KEY (idFacture),
    CONSTRAINT Clients_Factures_idClient_fk FOREIGN KEY (idClient) REFERENCES Clients (idClient)
);

CREATE TABLE ExoEntr.Articles (
    idArticle NUMBER(10) NOT NULL,
    libelleArticle VARCHAR2(100) NOT NULL,
    typeArticle VARCHAR2(20) NOT NULL,
    quantiteStockArticle NUMBER(7) NOT NULL,
    CONSTRAINT Articles_idArticle_pk PRIMARY KEY (idArticle),
    CHECK (quantiteStockArticle >= 0)
);

CREATE TABLE ExoEntr.Commandes (
    idCommande NUMBER(10) NOT NULL,
    idClient NUMBER(10) NOT NULL,
    idArticle NUMBER(10) NOT NULL,
    quantiteCommande NUMBER(4) NOT NULL,
    numCommande VARCHAR2(255) NOT NULL,
    dateCommandes DATE DEFAULT SYSDATE NOT NULL,
    CONSTRAINT Commandes_idCommande_pk PRIMARY KEY (idCommande),
    CONSTRAINT Clients_Commandes_idClient_fk FOREIGN KEY (idClient) REFERENCES Clients (idClient),
    CONSTRAINT Art_Com_idArticle_fk FOREIGN KEY (idArticle) REFERENCES Articles (idArticle)
);

CREATE TABLE ExoEntr.LigneFactures (
    idLigneFacture NUMBER(10) NOT NULL,
    idFacture NUMBER(10) NOT NULL,
    idArticle NUMBER(10) NOT NULL,
    quantite NUMBER(5) NOT NULL,
    CONSTRAINT Fact_LigneFact_idFacture_fk FOREIGN KEY (idFacture) REFERENCES Factures (idFacture),
    CONSTRAINT Art_LigneFact_idArticle_fk FOREIGN KEY (idArticle) REFERENCES Articles (idArticle)
);