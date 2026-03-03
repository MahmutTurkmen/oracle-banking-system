-- customers(müşteriler) tablosunu oluşturuyorum.
create table customers(
	customer_id number primary key,
	first_name varchar2(50) not null,
	last_name varchar2(50) not null,
	email varchar2(100) unique,
	phone varchar2(20),
	created_at date default sysdate);

-- sequence oluşturuyorum.
create sequence customers_seq start with 1 increment by 1;

-- trigger oluşturuyorum.
create or replace trigger customers_trigger 
before insert on costomers for each row 
begin :NEW.customer_id := customers_seq.NEXTVAL;
end; /
