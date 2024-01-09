SET schema 'DAI_Schema';
--entferne die Tabellen, wenn Sie existent sind
drop table if exists Maschine CASCADE;
drop table if exists Anlage CASCADE;
drop table if exists ERP_Daten CASCADE;
drop table if exists Betriebsdaten CASCADE;
drop table if exists AnlagenAnalyse CASCADE;
drop table if exists Analysen CASCADE;
drop sequence if exists serialnumber_seq cascade;

--erstelle die Tabellen
CREATE TABLE Anlage
(PK_Anlagenname VARCHAR(256) primary key unique not null,
 Ort text not null,
 Ländercode VARCHAR(5) not null
 );

CREATE TABLE ERP_Daten
(PK_ERPDataID serial primary key,
 Produktpreis real,
 CHECK(Produktpreis >= 0),
 ServiceEinsätze smallint,
 CHECK(ServiceEinsätze >= 0),
 Fehlerhistorie text,
 Auslaufmodell bool,
 Prototype bool
 );

CREATE TABLE Maschine
(PK_Bezeichnung VARCHAR(256) primary key not null,
 FK_Anlagenname VARCHAR(256) references Anlage not null,
 FK_ERPDataID serial references ERP_Daten, 
 Seriennummer int unique,
 CHECK(Seriennummer > 0),
 Modellytpe VARCHAR(256) not null,
 Baujahr timestamp 
 );

--erstelle die Sequenz für die Befüllung der Seriennummern der Maschinen
CREATE SEQUENCE serialnumber_seq
INCREMENT 1
START 1437493932;



CREATE TABLE Betriebsdaten
(
 FK_Bezeichnung VARCHAR(256) references Maschine,
 Zeitstempel timestamp,
 Parameter1 real,
 Parameter2 real,
 Parameter3 real,
 Parameter4 real,
 Parameter5 real,
 Parameter6 real
 );

CREATE TABLE Analysen
(PF_AnalyseID serial primary key,
 Zeitraum timestamp,
 Verfügbarkeit real,
 CHECK(Verfügbarkeit >= 0),
 Performance real
 );

CREATE TABLE AnlagenAnalyse
(
 PKFK_Anlagenname VARCHAR(256) references Anlage,
 PKFK_AnalyseID serial references Analysen
 );

--*********************************************************************************************************************************--
--befüllen die Tabellen mit Daten
--*********************************************************************************************************************************--
insert into Anlage values('Anlage X','Salzburg','AT'); 
insert into Anlage values('Anlage Y','München','DE'); 
insert into Anlage values('Anlage Z','Verona','IT'); 
insert into Anlage values('Anlage M','Sarajevo','BIH');
insert into Anlage values('Anlage S','Belgrad','SRB');

insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(10000,2,'nur Wartungsservice, keine Fehler vorhanden', false,false); 
insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(23000,0,'keine Einsätze vorhanden', false,false); 
insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(10000,0,'keine Einsätze vorhanden', false,false); 
insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(46399,1,'Fehlerbehebung : Endschalter gewechselt', false,false);
insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(17500,5,'Wartungen: Standardwartung | Fehlerbehebungen : Frequenzumrichter getauscht; Lager defekt', true,false);
insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(17500,3,'nur Wartungsservice, keine Fehler vorhanden', true,false);
insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(43000,2,'nur Wartungsservice, keine Fehler vorhanden', false,false);
insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(23000,1,'Fehlerbehebung : Softwarefehler durch Update behoben', false,false);
insert into ERP_Daten(Produktpreis,ServiceEinsätze,Fehlerhistorie,Auslaufmodell,Prototype) values(10000,0,'keine Einsätze vorhanden', false,false);

insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eTFx1','Anlage X',nextval('serialnumber_seq'),'1000er', '2010-03-22'); 
insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eTFx2','Anlage X',nextval('serialnumber_seq'),'2000er', '2012-07-05'); 
insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eTFx3','Anlage Z',nextval('serialnumber_seq'),'1000er', '2010-05-29'); 
insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eRFx4','Anlage Z',nextval('serialnumber_seq'),'x700', '2018-08-20');
insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eSFx5','Anlage M',nextval('serialnumber_seq'),'500er', '2008-02-18');
insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eSFx6','Anlage S',nextval('serialnumber_seq'),'500er', '2006-01-09');
insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eMFx7','Anlage S',nextval('serialnumber_seq'),'s6000', '2020-09-13');
insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eTFx8','Anlage Y',nextval('serialnumber_seq'),'2000er', '2013-05-19');
insert into Maschine(PK_Bezeichnung,FK_Anlagenname,Seriennummer,Modellytpe,Baujahr) values('eTFx9','Anlage Y',nextval('serialnumber_seq'),'1000er', '2010-11-10');

insert into Betriebsdaten values('eTFx1','2010-06-10',12.9,36,899, 129,82,99); 
insert into Betriebsdaten values('eTFx2','2012-08-15',10,30.7,910, 118,76,91); 
insert into Betriebsdaten values('eTFx3','2010-09-30',3.76,43.1,525, 94,109,86); 
insert into Betriebsdaten values('eRFx4','2019-05-13',5,25.1,1700, 113,107,89);
insert into Betriebsdaten values('eSFx5','2009-02-18',13.9,29,830, 78,94,76);
insert into Betriebsdaten values('eSFx6','2007-10-19',6,22,715, 88,68,80);
insert into Betriebsdaten values('eMFx7','2022-04-26',17,33,970, 98,103,96);
insert into Betriebsdaten values('eTFx8','2016-02-23',19,17.8,609, 56,98,83);
insert into Betriebsdaten values('eTFx9','2017-03-28',18.3,28,750, 88,79,64);

insert into Analysen(Zeitraum,Verfügbarkeit,performance) values('2019-05-15',85, 0.76); 
insert into Analysen(Zeitraum,Verfügbarkeit,performance) values('2022-04-30',93,0.92); 
insert into Analysen(Zeitraum,Verfügbarkeit,performance) values('2017-03-31',60, 0.43); 
 
insert into AnlagenAnalyse(PKFK_Anlagenname) values('Anlage Z'); 
insert into AnlagenAnalyse(PKFK_Anlagenname) values('Anlage S'); 
insert into AnlagenAnalyse(PKFK_Anlagenname) values('Anlage Y'); 

--*********************************************************************************************************************************--
--Datenabfragen
--*********************************************************************************************************************************--

--select * from Anlage;
--select * from ERP_Daten;
select * from Maschine;
--select * from betriebsdaten;
--select * from Analysen;
--select * from AnlagenAnalyse natural join Analysen;

-- Maschinen filtern, wo eine Analyse durchgeführt wurde
select PK_Bezeichnung, Seriennummer, Modellytpe, FK_Anlagenname from maschine 
where FK_Anlagenname in (select PKFK_Anlagenname from AnlagenAnalyse);

-- Maschinen filtern, die eine Analyse aufweisen und nach einem bestimmten Baujahr gebaut wurden
select PK_Bezeichnung, Seriennummer, Modellytpe, Baujahr, FK_Anlagenname from maschine 
where FK_Anlagenname in (select PKFK_Anlagenname from AnlagenAnalyse) and Baujahr >= '2017-01-01';

-- Maschinen filtern, die über keine Analysen verfügen
select PK_Bezeichnung, Seriennummer, Modellytpe, FK_Anlagenname from maschine 
where FK_Anlagenname not in (select PKFK_Anlagenname from AnlagenAnalyse);

-- Maschinen filter, die eine Performance zwischen 0.9 und 0.95 aufweisen
select * from maschine where FK_Anlagenname in (select PKFK_Anlagenname from AnlagenAnalyse 
where PKFK_AnalyseID in (select PF_AnalyseID from analysen 
where performance between 0.9 and 0.95)) order by baujahr desc;

-- Hole alle Betriebsdaten zu den Maschinen die zwischen dem Zeitraum "2015" und "2022" liegen
select * from betriebsdaten where FK_Bezeichnung in (select PK_Bezeichnung from maschine) 
and Zeitstempel between '2015-01-01' and '2022-01-01';

-- liefert die Anzahl an Maschinen zur zugehörigen Anlage
select count(*) from maschine where FK_Anlagenname = 'Anlage Z';


-- filtere die ERP Datensätze zu den Maschinen, die eine Performance zwischen 0.9 und 0.95 aufweisen und sortieren Sie absteigend nach Serviceeinsätzen
select * from ERP_Daten where PK_ERPDataID in 
(select FK_ERPDataID from maschine where FK_Anlagenname in (select PKFK_Anlagenname from AnlagenAnalyse 
where PKFK_AnalyseID in (select PF_AnalyseID from analysen 
where performance between 0.9 and 0.95))) order by ServiceEinsätze desc;

-- Kreuzprodukt "Cross Join" aus der Tabelle Anlage, Maschine und Betriebsdaten bilden
SELECT * FROM Anlage, Maschine CROSS JOIN Betriebsdaten;

-- Theta Join, alle Anlagen Analysen die eine Verfügbarkeit größer/gleich 90% haben in Tabelle Anlage Joinen
SELECT * FROM Analysen JOIN Anlage ON Analysen.Verfügbarkeit >= 90;

-- Natural Join, alle Anlagen Analysen die eine Verfügbarkeit größer/gleich 90% haben in Tabelle Anlage Joinen
SELECT * FROM maschine NATURAL JOIN betriebsdaten;

-- Mengenvereinigung "Union" Anzahl der Serviceeinsätze mit Seriennummer vereinigen
SELECT Seriennummer FROM maschine union SELECT ServiceEinsätze FROM erp_daten;

-- Mengendifferenz zwischen Betriebsdaten und Analysen
SELECT Zeitstempel, Parameter1, Parameter2 from Betriebsdaten EXCEPT distinct SELECT Zeitraum, Verfügbarkeit, Performance FROM Analysen; 

--View erstellen mit allen Maschinen ERP Daten mit einer Verfügbarkeit >= 90% und weniger als 2 Serviceeinsätzen
CREATE VIEW PreisLeistung AS
SELECT *  FROM ERP_Daten join analysen ON analysen.Verfügbarkeit >= 90 and erp_daten.serviceeinsätze <= 1;

select produktpreis, performance, serviceeinsätze, fehlerhistorie from PreisLeistung;


