delimiter $


-- Triger koji postavlja popust registrovanom korisniku na osnovu tipa korisnika

drop trigger if exists triggerPopust $

create trigger triggerPopust before insert on RegistrovaniKorisnik
for each row
begin
	declare msg varchar(255);
	if (new.tip = 'student' or new.tip = 'senior') then
		set new.popust = 0.2;
	elseif (new.tip = 'standard') then
		set new.popust = 0;
	else
		set msg = 'Greska! Tip registrovanog korisnika je student, senior ili standard';
		SIGNAL sqlstate '45000' set message_text = msg;
	end if;
end $


-- Triger koji proverava da li je ostalo raspolozivih karata i ako jeste izracunava ukupan iznos prilikom kupovine ulaznica

drop trigger if exists triggerNovaKupovina $

create trigger triggerNovaKupovina before insert on KupujeUlaznicu
for each row
begin
	declare cenaUlaznice int;
	declare popust double;
	declare msg varchar(255);
	declare idSale int;
	declare kapacitet int;
	declare brProdatihUlaznica int;
	declare status varchar(45);

	set idSale = (select p.idBioskopskeSale from Projekcija p where p.idProjekcije = new.idProjekcije);
	set kapacitet = (select bs.kapacitet from BioskopskaSala bs where bs.idBioskopskeSale = idSale);
	set brProdatihUlaznica = (select p.brojProdatihUlaznica from Projekcija p where p.idProjekcije = new.idProjekcije);
	set status = (select p.status from Projekcija p where p.idProjekcije = new.idProjekcije);

	if (brProdatihUlaznica + new.brojUlaznica > kapacitet and status = 'u pripremi') then
		set msg = 'Greska! Nema raspolozivih karata za trazenu projekciju.';
		SIGNAL sqlstate '45000' set message_text = msg;
	else
		if (new.vrstaUlaznice not in ('standard', 'vip', 'love box')) then
			set msg = 'Greska! Vrsta ulaznice moze biti standard, vip ili love box';
			SIGNAL sqlstate '45000' set message_text = msg;
		else
			set cenaUlaznice = (select cu.cena from CenaUlaznice cu where cu.idProjekcije = new.idProjekcije and cu.vrstaUlaznice = new.vrstaUlaznice);
			set popust = (select rk.popust from RegistrovaniKorisnik rk where rk.idRegistrovanogKorisnika = new.idRegistrovanogKorisnika);
			set new.ukupanIznos = cenaUlaznice * new.brojUlaznica * (1 - popust);
		end if;
	end if;
end $


-- Triger koji azurira broj kupljenih ulaznica

drop trigger if exists triggerBrojProdatihUlaznica $

create trigger triggerBrojProdatihUlaznica after insert on KupujeUlaznicu
for each row
begin
	update Projekcija pr
	set pr.brojProdatihUlaznica = pr.brojProdatihUlaznica + new.brojUlaznica
	where pr.idProjekcije = new.idProjekcije;
end $


-- Triger koji ne dozvoljava da se unese 3D projekcija za salu koja ne podrzava 3D

drop trigger if exists trigger3dProjekcija $

create trigger trigger3dProjekcija before insert on Projekcija
for each row
begin
	declare msg varchar(255);
	declare omogucen3d bool;
	set omogucen3d = (select bs.omogucen3d from BioskopskaSala bs where bs.idBioskopskeSale = new.idBioskopskeSale);

	if(omogucen3d = false and new.jeste3d = true) then
		set msg = 'Greska! Izabrali ste 3D projekciju a izabrana sala ne podrzava 3D';
		SIGNAL sqlstate '45000' set message_text = msg;
	end if;
end $


delimiter ;


