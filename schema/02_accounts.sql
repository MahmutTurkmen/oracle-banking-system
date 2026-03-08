--1️⃣ Tablo oluşturma
create table accounts(
  account_id number primary key,
  customer_id number not null,
  account number varchar2(20) unique not null,
  balance number(15,2) default 0 check (balance >= 0),
  account_type varchar2(20) check (account_type in ('SAVINGS','CHECKING')),
  created_at date default sysdate,
  constraint fk_customer foreign key (customer_id) references customers(customer_id)
  );

--2️⃣ Sequence
create sequence accounts_seq start with 1 increment by 1;

--3️⃣ Trigger
create or replace trigger accounts_trigger before insert on accounts
for each row 
begin
    :NEW.account_id := accounts_seq.NEXTVAL;
end; /
