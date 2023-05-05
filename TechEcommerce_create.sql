-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2023-01-17 18:16:59.648

-- tables
-- Table: Adres

CREATE SEQUENCE seq_adresy MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_adresyDostawcy MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_dostawcy MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_kategorie MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_klienci MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_produkcty MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_rodzajePlatnosci MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_spedytorzy MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_zamowienia MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;
CREATE SEQUENCE seq_zamowieniaProdukty MINVALUE 1 START WITH 1 INCREMENT BY 1 CACHE 20;


CREATE TABLE Adres (
    Adres_ID integer PRIMARY KEY,
    Ulica varchar2(250)  NOT NULL,
    NumerLokalu integer  NOT NULL,
    KodPocztowy varchar2(20)  NOT NULL,
    Miasto varchar2(100)  NOT NULL,
    Kraj varchar2(100)  NOT NULL
) ;

-- Table: AdresDostawca
CREATE TABLE AdresDostawca (
    AdresDostawcaID integer PRIMARY KEY,
    Ulica varchar2(300)  NOT NULL,
    KodPocztowy varchar2(100)  NOT NULL,
    Miasto varchar2(250)  NOT NULL,
    Kraj varchar2(200)  NOT NULL
) ;

-- Table: Dostawca
CREATE TABLE Dostawca (
    Dostawca_ID integer PRIMARY KEY ,
    NazwaFirmy varchar2(250)  NOT NULL,
    NumerNIP integer  NOT NULL,
    NumerKRS integer  NOT NULL,
    AdresDostawcaID integer  NOT NULL
) ;

-- Table: Kategoria
CREATE TABLE Kategoria (
    Kategoria_ID integer PRIMARY KEY ,
    Nazwa varchar2(250)  NOT NULL,
    Opis varchar2(500)  NOT NULL
) ;

-- Table: Klient
CREATE TABLE Klient (
    Klient_ID integer PRIMARY KEY,
    Adres_ID integer  NOT NULL,
    Login varchar2(250)  NOT NULL,
    Haslo varchar2(250)  NOT NULL,
    Imie varchar2(100)  NOT NULL,
    Nazwisko varchar2(100)  NOT NULL,
    Email varchar2(250)  NOT NULL,
    NumerTelefonu varchar2(100)  NOT NULL
) ;

-- Table: Produkt
CREATE TABLE Produkt (
    Produkt_ID integer PRIMARY KEY,
    Nazwa varchar2(250)  NOT NULL,
    Opis varchar2(500)  NOT NULL,
    Cena float  NOT NULL,
    Rabat float  NULL,
    Ilosc integer  NULL,
    Kategoria_ID integer  NOT NULL,
    Dostawca_ID integer  NOT NULL
) ;

-- Table: RodzajPlatnosci
CREATE TABLE RodzajPlatnosci (
    RodzajPlatnosci_ID integer PRIMARY KEY,
    RodzajPlatnosci varchar2(200)  NOT NULL
) ;

-- Table: Spedytor
CREATE TABLE Spedytor (
    Spedytor_ID integer  PRIMARY KEY,
    NazwaFirmy varchar2(250)  NOT NULL,
    NumerTelefonu varchar2(100)  NOT NULL
) ;

-- Table: Zamowienie
CREATE TABLE Zamowienie (
    Zamowienie_ID integer PRIMARY KEY,
    Klient_ID integer  NOT NULL,
    Spedytor_ID integer  NOT NULL,
    RodzajPlatnosci_ID integer  NOT NULL,
    DataZamowienia date  NOT NULL,
    DataWysylki date  NOT NULL,
) ;

-- Table: ZamowienieProdukt
CREATE TABLE ZamowienieProdukt (
    ZamowienieProdukt_ID integer PRIMARY KEY,
    Zamowienie_ID integer  NOT NULL,
    Produkt_ID integer  NOT NULL,
    NumerZamowienia varchar2(250)  NOT NULL,
    Ilosc integer  NOT NULL,
    CenaTotal float  NOT NULL,
    Rabat float  NULL
) ;

-- foreign keys
-- Reference: Dostawca_AdresDostawca (table: Dostawca)
ALTER TABLE Dostawca ADD CONSTRAINT Dostawca_AdresDostawca
    FOREIGN KEY (AdresDostawcaID)
    REFERENCES AdresDostawca (AdresDostawcaID);

-- Reference: Klient_Adres (table: Klient)
ALTER TABLE Klient ADD CONSTRAINT Klient_Adres
    FOREIGN KEY (Adres_ID)
    REFERENCES Adres (Adres_ID);

-- Reference: Produkt_Dostawca (table: Produkt)
ALTER TABLE Produkt ADD CONSTRAINT Produkt_Dostawca
    FOREIGN KEY (Dostawca_ID)
    REFERENCES Dostawca (Dostawca_ID);

-- Reference: Produkt_Kategoria (table: Produkt)
ALTER TABLE Produkt ADD CONSTRAINT Produkt_Kategoria
    FOREIGN KEY (Kategoria_ID)
    REFERENCES Kategoria (Kategoria_ID);

-- Reference: ZamowienieProdukt_Produkt (table: ZamowienieProdukt)
ALTER TABLE ZamowienieProdukt ADD CONSTRAINT ZamowienieProdukt_Produkt
    FOREIGN KEY (Produkt_ID)
    REFERENCES Produkt (Produkt_ID);

-- Reference: ZamowienieProdukt_Zamowienie (table: ZamowienieProdukt)
ALTER TABLE ZamowienieProdukt ADD CONSTRAINT ZamowienieProdukt_Zamowienie
    FOREIGN KEY (Zamowienie_ID)
    REFERENCES Zamowienie (Zamowienie_ID);

-- Reference: Zamowienie_Klient (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienie_Klient
    FOREIGN KEY (Klient_ID)
    REFERENCES Klient (Klient_ID);

-- Reference: Zamowienie_RodzajPlatnosci (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienie_RodzajPlatnosci
    FOREIGN KEY (RodzajPlatnosci_ID)
    REFERENCES RodzajPlatnosci (RodzajPlatnosci_ID);

-- Reference: Zamowienie_Spedytor (table: Zamowienie)
ALTER TABLE Zamowienie ADD CONSTRAINT Zamowienie_Spedytor
    FOREIGN KEY (Spedytor_ID)
    REFERENCES Spedytor (Spedytor_ID);

-- End of file.

