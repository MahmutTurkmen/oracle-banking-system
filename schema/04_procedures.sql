--1️⃣ Prosedür oluştur
create or replace procedure transfer_money (
	p_from_account_id number,
	p_to_account_id number,
	p_amount number)
is v_balance number;
begin 

--2️⃣ Gönderen hesabın bakiyesini al
select balance into v_balance from accounts 
where account_id=p_from_account_id;

--3️⃣ Bakiye kontrolü
if v_balance< p_amount then 
RAISE_APPLICATION_ERROR(-20001,'Insufficient balance');
END IF; 

--4️⃣ Gönderen hesaptan düş
update accounts 
set balance= balance- p_amount
where account_id= p_from_account_id;

--5️⃣ Alıcı hesaba ekle
update accounts 
set balance= balance+ p_amount 
where account_id= p_to_account_id;

--6️⃣ Transaction kaydı ekle 
insert into transactions (
from_account_id, 
to_account_id, 
amount, 
transaction_type, 
status
) values( 
p_from_account_id, 
p_to_account_id, 
p_amount, 
'TRANSFER', 'SUCCESS'); 

--7️⃣ İşlemi kaydet 
commit;

exception 
when others then 

insert into transactions (
from account_id, 
to_account_id, 
amount, 
transaction_type, 
status 
) values ( 
p_from_account_id,
p_to_account_id, 
p_amount, 
'TRANSFER', 
'FAILED');

ROLLBACK;
RAISE;
END;
/ 
