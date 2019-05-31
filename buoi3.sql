--1.	Thực hiện việc kiểm tra rằng buộc khoá ngoại.
--2.	Không cho phép cascade delete trong các rằng buộc khoá ngoại. 
--------Ví dụ không cho phép xoá các CTHOADON nào có SOHD còn trong table HOADON
create trigger t2 on chitiethoadon
for delete
as
	if exists (select a.MAHD from deleted a, hoadon b
				where a.MAHD=b.MAHD)
	begin
		print N'Khong duoc xoa hoa don nay'
		Rollback Tran
	end
drop trigger t2

insert into CHITIETHOADON values ('HD013','VT05',50,NULL,100)
delete from CHITIETHOADON where MAHD like 'HD013'
--3.	không cho phép user nhập vào hai vật tư có cùng tên.
create trigger t3 on vattu
for insert, update
as
	if  (select count(*) from inserted a, VATTU c
				where a.TENVT = c.TENVT)>1
	begin
		print N'Khong the nhap ten vat tu nay'
		Rollback Tran
	end
drop trigger t3
insert into VATTU values ('VT08','XI MANG','BAO',500,10)
update VATTU set TENVT='XI MANG' where MAVT='VT02'
delete from vattu where MAVT = 'VT08'
select * from inserted
--4.	Khi user đặt hàng thì KHUYENMAI là 5% nếu SL >100, 10% nếu SL >500.
create trigger t4 on chitiethoadon
for insert, update
as
	update CHITIETHOADON set KHUYENMAI=case	when sl>100 and sl<=500 then sl*GIABAN*0.05
											when sl>500 then sl*GIABAN*0.1
											else 0
										end
	where mahd in (select mahd from inserted) and mavt in(select mavt from inserted)
insert into CHITIETHOADON values ('HD001','VT02',150,NULL,10000)
update CHITIETHOADON set sl=150 where mahd='HD001' and mavt='VT01'
drop trigger t4
--5.	Chỉ cho phép mua các mặt  hàng có số lượng tồn lớn hơn hoặc bằng số lượng cần mua 
--------và tính lại số lượng tồn mỗi khi có đơn hàng.
create trigger t5 on chitiethoadon
for insert, update
as
	if exists (select * from inserted a, VATTU b where a.MAVT=b.MAVT and a.SL>b.SLTON)
		begin
			print N'Khong du so luong ban'
			Rollback Tran
		end
	else
		update VATTU set SLTON= SLTON-(select sl from inserted a where a.MAVT=VATTU.MAVT)
		where inserted.mavt=vattu.MAVT

drop trigger t5
insert into CHITIETHOADON values ('HD015','VT01',4000,NULL,10000)
select * from HOADON
select * from CHITIETHOADON
select * from VATTU
drop table VATTU

--6.	Không cho phép user xoá một lúc nhiều hơn một vật tư.
--7.	Chỉ bán mặt hàng GẠCH (các laọi gạcg) với số lượng là bội số của 100.

