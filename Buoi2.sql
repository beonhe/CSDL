--1.	Viết  hàm tính doanh thu cuả năm.. với năm là tham số truyền  vào.
create function f1 (@nam int)
returns bigint
begin
	declare @dt bigint
	set @dt=(select sum(sl*GIABAN) 
			from HOADON a, CHITIETHOADON b
			where a.MAHD=b.MAHD and year(Ngay)=@nam)
	return @dt
end
Select 'Doanh thu ='+str(dbo.f1(2000),10)
--2.	Viết  hàm tính doanh thu cuả tháng .. với tháng là tham số truyền  vào.
create function f2 (@thang int)
returns bigint
begin
	declare @dt bigint
	set @dt=(select sum(sl*GIABAN) 
			from HOADON a, CHITIETHOADON b
			where a.MAHD=b.MAHD and Month(Ngay)=@thang)
	return @dt
end
Select 'Doanh thu ='+str(dbo.f2(4),10)
--3.	Viết hàm tính doanh thu của khách hàng với  mã khách hàng là tham số truyền vào.
create function f3 (@makh varchar(5))
returns bigint
begin
	declare @dt bigint
	set @dt=(select sum(sl*GIABAN)
			from CHITIETHOADON a, HOADON b
			where a.MAHD=b.MAHD and b.MAKH=@makh)
	return @dt
end
drop function f3
Select 'Doanh thu khach hang:' +str(dbo.f3('KH03'),10)
--4.	Viết hàm tính tổng số lượng bán được cho từng mặt hàng theo tháng với  mã hàng và thàng nhập vào,  
--------nếu tháng không nhập vào tức là tính tất cả các tháng.
create function f4 (@mahang varchar(5), @thang int)
returns bigint
begin
	declare @sl bigint
	if(@thang is NULL)
		set @sl = (Select sum(sl)
					from CHITIETHOADON a
					where @mahang=a.MAVT)
	else
		set @sl = (select sum(sl)
					from CHITIETHOADON a, HOADON b
					where @mahang=a.MAVT and @thang=month(ngay) and a.MAHD=b.MAHD)
	return @sl
end
drop function f4
select 'so luong =' + str(dbo.f4('VT02',NULL))
--5.	Viết hàm tính lãi ((giá bán – trừ giá mua )* slố lượng bán được ) cho từng mặt hàng, với mã mặt hàng là tham số truyền vào. 
--------Nếu mã mặt hàng không truyền vào thì tính cho tất cả các mặt hàng.
create function f5 (@mahang varchar(5))
returns bigint
begin
	declare @lai bigint
	if(@mahang is NULL)
		set @lai = (select sum((a.GIABAN-b.GIAMUA)*SL)
					from CHITIETHOADON a, VATTU b
					where a.MAVT=b.MAVT)
	else
		set @lai = (select sum((a.GIABAN-b.GIAMUA)*SL)
					from CHITIETHOADON a, VATTU b
					where @mahang=a.MAVT and @mahang=b.MAVT)
	return @lai
end
select 'Lai=' + str(dbo.f5('VT01'))
--1.	Lấy ra danh các khách hàng đã mua hàng trong ngày [ngày]…. Với [ngày] là tham số truyền vào.
create proc p1 @ngay int
as
	select b.*, a.NGAY
	from HOADON a, KHACHHANG b
	where @ngay=DAY(ngay) and a.MAKH=b.MAKH
drop proc p1
exec p1 25
--2.	Lấy ra danh sách X khách hàng  có tổng trị giá các đơn hàng lớn nhất.
create proc p2 @X int
as
	select top (@x) b.MAKH, b.TENKH, sum(sl*giaban) as [gia tri don hang]
	from CHITIETHOADON a, KHACHHANG b,HOADON c
	where a.MAHD=c.MAHD and b.MAKH=c.MAKH
	group by b.MAKH, b.TENKH
	order by [gia tri don hang] DESC
drop proc p2
exec p2 3
--3.	Lấy ra danh sách X mặt hàng có số lượng bán lớn nhất.
create proc p3 @x int
as
	select top (@x) a.MAVT, a.TENVT, sum(b.SL) as [so luong ban]
	from VATTU a, CHITIETHOADON b
	where a.MAVT=b.MAVT
	group by a.MAVT, a.TENVT
	order by [so luong ban] DESC

exec p3 3
--4.	Lấy ra danh sách X mặt hàng bán ra có lãi 1t nhất.
create proc p4 @x int
as
	select top (@x) a.MAVT, a.TENVT, sum((GIABAN-GIAMUA)*SL) as [lai]
	from VATTU a, CHITIETHOADON b, HOADON c
	where a.MAVT=b.MAVT and b.MAHD=c.MAHD
	group by a.MAVT, a.TENVT
	order by [lai]

exec p4 3
--5.	Tính giá trị cho cột khuyến mãi như sau: Khuyến mãi 5% nếu SL >100, 10% nếu SL>500.
create proc p5
as
	update CHITIETHOADON
	set KHUYENMAI=case when sl>100 and sl<=500 then sl*GIABAN*0.05
						when sl>500 then sl*GIABAN*0.1
						else 0
					end
drop proc p5
exec p5
select * from CHITIETHOADON
--6.	Tính số lại số lượng tồn cho tất cả các mặt hàng. (SLTON = SLTON – tổng sl bán được)
create proc p6
as
	update VATTU
	set SLTON=SLTON-(select sum(sl) from CHITIETHOADON b where VATTU.MAVT=b.MAVT )

drop proc p6
exec p6
select * from VATTU
--7.	Tính trị giá cho mỗi hoá đơn.
create proc p7
as
	update HOADON
	set TONGTG=(select sum(sl*giaban) from CHITIETHOADON b where HOADON.MAHD=b.MAHD)
exec p7
select * from HOADON
--8.	Tạo ra table KH_VIP có cấu trúc giống với cấu trúc table KHACHHANG. Lưu các khách hàng có tổng trị giá của tất cả các đơn hàng >=10000000 
--------vào table KH_VIP.
create proc p8
as
	if exists (select * from qlvt.dbo.sysobjects where xtype='u' and name='KH_VIP')
	begin
		drop table KH_VIP
	end
	create table KH_VIP(
	MAKH	Nvarchar(5)	primary key,
	TENKH	Nvarchar(30)not null,
	DIACHI	Nvarchar(50),
	DT	Nvarchar(15),
	EMAIL	Nvarchar(30))
	insert into KH_VIP select a.MAKH, a.TENKH,a.DT,a.DIACHI,a.EMAIL from KHACHHANG a, HOADON b, CHITIETHOADON c
				where a.MAKH=b.MAKH and b.MAHD=c.MAHD
				group by a.MAKH, a.TENKH,a.DT,a.DIACHI,a.EMAIL
				having sum(sl*giaban)>10000000
exec p8
select * from KH_VIP
