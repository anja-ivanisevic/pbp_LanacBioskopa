drop database if exists Lanac_bioskopa;

create database Lanac_bioskopa;

use Lanac_bioskopa;

create table Grad (
	ptt int not null primary key,
	naziv varchar(45) not null
);

create table Bioskop (
	idBioskopa int not null primary key,
	adresa varchar(45) not null,
	brojTelefona varchar(45) not null,
	gradPtt int not null references grad(ptt) on delete cascade on update cascade,
	idUpravnika int not null references Upravnik(idZaposlenog) on delete cascade on update cascade,
	email varchar(45) not null 
);

create table Zaposleni (
	idZaposlenog int not null primary key,
	ime varchar(45) not null,
	prezime varchar(45) not null,
	struka varchar(45) not null,
	brojTelefona varchar(45) not null,
	idBioskopa int not null references Bioskop(idBioskopa) on delete cascade on update cascade
);

create table Upravnik (
	idZaposlenog int not null primary key references Zaposleni(idZaposlenog) on delete cascade on update cascade
);

create table Recepcionar (
	idZaposlenog int not null primary key references Zaposleni(idZaposlenog) on delete cascade on update cascade
);

create table Kinooperater (
	idZaposlenog int not null primary key references Zaposleni(idZaposlenog) on delete cascade on update cascade
);

create table BioskopskaSala (
	idBioskopskeSale int not null,
	kapacitet int not null,
	omogucen3d bool not null default false,
	idBioskopa int not null references Bioskop(idBioskopa) on delete cascade on update cascade,
	primary key (idBioskopa, idBioskopskeSale)
);

create table Film (
	idFilma int not null primary key,
	naziv varchar(45) not null,
	imeRezisera varchar(45) not null,
	opis varchar(255) not null
);

create table PrikazujeSe (
	idBioskopa int not null references Bioskop(idBioskopa) on delete cascade on update cascade,
	idFilma int not null references Film(idFilma) on delete cascade on update cascade,
	primary key (idBioskopa, idFilma)
);

create table Projekcija (
	idProjekcije int not null primary key,
	vreme time(6) not null,
	datum date not null,
	brojProdatihUlaznica int not null default 0,
	jeste3d bool not null default false,
	status varchar(45) not null,
	idBioskopa int not null,
	idFilma int not null references PrikazujeSe(idFilma) on delete cascade on update cascade,	
	idKinooperatera int not null references Kinooperater(idZaposlenog) on delete cascade on update cascade,	
	idBioskopskeSale int not null references BioskopskaSala(idBioskopskeSale) on delete cascade on update cascade,
	foreign key (idBioskopa) references PrikazujeSe(idBioskopa) on delete cascade on update cascade,
	foreign key (idBioskopa) references BioskopskaSala(idBioskopa) on delete cascade on update cascade
);

create table CenaUlaznice (
	vrstaUlaznice varchar(45) not null,
	cena int not null,
	idProjekcije int not null references Projekcija(idProjekcije) on delete cascade on update cascade,
	primary key(vrstaUlaznice, idProjekcije)
);

create table RegistrovaniKorisnik (
	idRegistrovanogKorisnika int not null primary key,
	ime varchar(45) not null,
	prezime varchar(45) not null,
	brojTelefona varchar(45) not null,
	tip varchar(45) not null,
	popust double not null
);

create table KupujeUlaznicu (
	idProjekcije int not null references Projekcija(idProjekcije) on delete cascade on update cascade,
	idRegistrovanogKorisnika int not null references RegistrovaniKorisnik(idRegistrovanogKorisnika) on delete cascade on update cascade,
	vrstaUlaznice varchar(45) not null,
	brojUlaznica int not null,
	ukupanIznos int not null,
	primary key(idProjekcije, idRegistrovanogKorisnika)
);




















