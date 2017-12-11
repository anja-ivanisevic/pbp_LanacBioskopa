use Lanac_bioskopa;

insert into Grad values 
	(11000, 'Beograd'),
	(21000, 'Novi Sad'),
	(26000, 'Pancevo');

insert into Bioskop values
	(1, 'Bulevar Despota Stefana 12', '011224887', 11000, 1, 'cinestarBeograd@gmail.com'),
	(2, 'Bulevar Milutina Milankovica 34', '011278887', 11000, 2, 'cinestarNoviBeograd@gmail.com'),
	(3, 'Branka Radicevica 78', '021200887', 21000, 3, 'cinestarNoviSad@gmail.com'),
	(4, 'Milosa Obrenovica 12', '013226687', 26000, 4, 'cinestarPancevo@gmail.com');

insert into Zaposleni values
	(1, 'Milica', 'Vasiljevic', 'dipl. ekonomista', '0654435678', 1),
	(2, 'Bojan', 'Markovic', 'master ekonomista', '0654777678', 2),
	(3, 'Mirko', 'Sremic', 'visa poslovna', '063488888', 3),
	(4, 'Sreten', 'Katic', 'dipl. ekonomista', '0694435788', 4),
	(5, 'Marina', 'Lazic', 'student', '0654098678', 1),
	(6, 'Sanja', 'Slobic', 'student', '0604435775', 1),
	(7, 'Sofija', 'Simonovic', 'visa poslovna', '0654435644', 1),
	(8, 'Milan', 'Popovic', 'dipl. ekonomista', '0654435678', 2),
	(9, 'Slavica', 'Simic', 'student', '0644665678', 2),
	(10, 'Stanko', 'Boricic', 'student', '0604435666', 3),
	(11, 'Sara', 'Veljkovic', 'dipl. ekonomista', '0634435610', 4);

insert into Upravnik values
	(1),
	(2),
	(3),
	(4);

insert into Recepcionar values
	(5),
	(6),
	(9),
	(11);

insert into Kinooperater values
	(7),
	(8),
	(10);

insert into BioskopskaSala values
	(1, 150, false, 1),
	(2, 200, true, 2),
	(3, 250, false, 3),
	(4, 100, true, 4);

insert into Film values
	(1, 'Titanic', 'James Cameron', 'opis...'),
	(2, 'Gladiator', 'Rid Leyscott', 'opis...'),
	(3, 'The Godfather', 'Francis Ford Coppola', 'opis...'),
	(4, 'Pulp fiction', 'Quentin Tarantino', 'opis...'),
	(5, 'Forrest Gump', 'Robert Zemeckis', 'opis...');

insert into PrikazujeSe values
	(1, 1),
	(1, 3),
	(2, 2),
	(2, 3),
	(2, 5),
	(3, 1),
	(3, 4),
	(3, 5),
	(4, 2),
	(4, 3),
	(4, 4),
	(4, 5);

insert into Projekcija values
	(1, '20:00', '2017-12-14', 10, false, 'u pripremi', 1, 1, 7, 1),
	(2, '19:00', '2017-12-09', 97, true, 'odrzana', 2, 2, 8, 2),
	(3, '18:00', '2017-09-09', 13, false, 'otkazana', 2, 3, 8, 2),
	(4, '21:00', '2017-12-20', 45, false, 'u pripremi', 3, 1, 10, 3),
	(5, '21:00', '2017-10-10', 98, false, 'odrzana', 3, 5, 10, 3);

insert into CenaUlaznice values
	('standard', 250, 1),
	('love box', 290, 1),
	('vip', 350, 1),
	('standard', 220, 2),
	('love box', 250, 2),
	('vip', 310, 2),
	('standard', 280, 3),
	('love box', 340, 3),
	('vip', 390, 3),
	('standard', 250, 4),
	('love box', 290, 4),
	('vip', 350, 4),
	('standard', 270, 5),
	('love box', 300, 5),
	('vip', 350, 5);

insert into RegistrovaniKorisnik values
	(1, 'Sima', 'Ristic', '0657644323', 'student', 0.2),
	(2, 'Branislav', 'Dragic', '0698754556', 'student', 0.2),
	(3, 'Miroslav', 'Ilic', '060856888', 'senior', 0.2),
	(4, 'Sanja', 'Spasic', '0634264826', 'standard', 0),
	(5, 'Slobodan', 'Novicic', '0654262866', 'standard', 0);

insert into KupujeUlaznicu values
	(1, 1, 'vip', 2, 0),
	(1, 3, 'love box', 2, 0),
	(2, 4, 'standard', 3, 0),
	(2, 5, 'vip', 1, 0),
	(3, 3, 'standard', 2, 0),
	(4, 4, 'love box', 2, 0);


























