delimiter $

create trigger triggerPopust before insert on RegistrovaniKorisnik
for each row
begin
	declare msg varchar(255);
	if (new.tip = 'student' or new.tip = 'senior') then
		set new.popust = 0.2;
	else if (new.tip = 'standard') then
		set new.popust = 0.2;
	else
		set msg = 'Greska! Tip registrovanog korisnika je student, senior ili standard';
		SIGNAL sqlstate '45000' set message_text = msg;
	end if;
end $


create trigger triggerUkupanIznos before insert on KupujeUlaznicu
for each row
begin
	declare cenaUlaznice int;
	declare popust double;
	declare msg varchar(255);
	if (new.vrstaUlaznice not in ('standard', 'vip', 'love box')) then
		set msg = 'Greska! Vrsta ulaznice moze biti standard, vip ili love box';
		SIGNAL sqlstate '45000' set message_text = msg;
	else
		set cenaUlaznice = (select cu.cena from CenaUlaznice cu where cu.idProjekcije = new.idProjekcije and cu.vrstaUlaznice = new.vrstaUlaznice);
		set popust = (select rk.popust from RegistrovaniKorisnik rk where rk.idRegistrovanogKorisnika = new.idRegistrovanogKorisnika);
		set new.ukupanIznos = cenaUlaznice * new.brojUlaznica * (1 - popust);
	end if;
end $

create trigger triggerBrojKupljenihUlaznica after insert on KupujeUlaznicu
for each row
begin
	update Projekcija pr
	set pr.brojProdatihUlaznica = pr.brojProdatihUlaznica + new.brojUlaznica
	where pr.idProjekcije = new.idProjekcije;
end $

delimiter ;














