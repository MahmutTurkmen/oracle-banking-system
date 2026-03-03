-- transactions(işlemler) tablosunu oluşturdum.
create table transactions (
transactions_id number primary key,
from_account_id number,
to_account_id number,
amount_number(15, 2) check (amount > 0),
transaction_type varchar2(20)
check (transaction_type in ('TRANSFER', 'DEPOSIT', 'WITHDRAW')),

transaction_date date default sysdate, status varchar2(20)
check (status in ('SUCCESS', 'FAILED')),

constraint fk_from_account foreign key (from_account_id)
references accounts(account_id),

constraint fk_to_account foreign key(to_account_id)
references accounts(account_id));

-- sequence oluşturdum.
create sequence transactions_seq start with 1 increment by 1;

-- trigger oluşturdum. 
create or replace trigger transactions_trigger before insert on transactions
for each row begin :NEW.transaction_id := transactions_seq.NEXTVAL;
end; /
