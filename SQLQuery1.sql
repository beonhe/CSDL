1.	Hiển thị danh sách các khách hàng có địa chỉ là “Tân Bình” gồm mã khách hàng, tên khách hàng, địa chỉ, 
điện thoại, và địa chỉ E-mail.
create view V1 ([MAKH], [Tên KH],[Điện Thoại],[Địa Chỉ],[Email])
as
 select MAKH, TENKH, DIACHI, DT, EMAIL
 from KHANHHANG
 where DIACHI like 'TÂN BÌNH' 
 select *
 from V1
2.	Hiển thị danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng, địa chỉ và 
địa chỉ E-mail của những khách hàng chưa có số điện thoại.
create view V2
as
select  MAKH as[MAKH], TENKH as [Tên KH], DIACHI as[Địa chỉ], EMAIL
from KHANHHANG
where DT is NULL
select *
from V2
3.	Hiển thị danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa chỉ Email 
gồm mã khách hàng, tên khách hàng, địa chỉ.
create view v3
as
select MAKH, TENKH, DIACHI
from KHANHHANG
where DT is NULL and EMAIL is NULL
4.	Hiển thị danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, 
tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
create view v4
as
select MAKH, TENKH, DIACHI, DT, EMAIL
from KHANHHANG
where DT  is NOT NULL and EMAIL is NOT NULL
5.	Hiển thị danh sách các vật tư có đơn vị tính là “Cái” gồm mã vật tư, 
tên vật tư và giá mua.
create view v5
as
select MAVT,TENVT, GIAMUA
from VATTU
where DVT like N'CÁI'
6.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn 
vị tính và giá mua mà có giá mua trên 25000.
create view v6
as
select MAVT, TENVT, DVT, GIAMUA
from VATTU
where GIAMUA > '25000'
7.	Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật tư, 
tên vật tư, đơn vị tính và giá mua. 
create view v7
as
select MAVT, TENVT, DVT, GIAMUA
from VATTU
where TENVT like N'gạch%'
8.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và 
giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
create view v8
as
select MAVT, TENVT, DVT, GIAMUA
from VATTU
where GIAMUA between 20000 and 40000
9.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, 
địa chỉ khách hàng và số điện thoại.
create view v9
as
select MAHD, NGAY, TENKH, DIACHI, DT
from HOADON H, KHANHHANG K
where H.MAKH=K.MAKH
10.	Lấy ra các thông tin gồm Mã hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại 
của ngày 25/5/2010.
set dateformat dmy
create view v10
as
select MAHD, TENKH, DIACHI, DT
from KHANHHANG K, HOADON H
--where K.MAKH=H.MAKH and NGAY='25/5/2010'
where K.MAKH=H.MAKH and CONVERT(varchar(10), NGAY, 103)='25/05/2010'

11.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, 
địa chỉ khách hàng và số điện thoại của những hóa đơn trong tháng 6/2010.

create view v11
as
select MAHD, NGAY, TENKH, DIACHI, DT
from KHANHHANG K, HOADON H
where K.MAKH=H.MAKH and  MONTH(H.NGAY)=6
12.	Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) 
đã mua hàng trong tháng 6/2010.
13.	Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2010 
gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
create view v13
as
select NGAY, TENKH, DIACHI, DT
from KHANHHANG K, HOADON H
where K.MAKH=H.MAKH and NOT MONTH(H.NGAY)=6
14.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, 
giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng).
create view v14
as
select H.MAHD, V.MAVT, TENVT, DVT, GIABAN, GIAMUA, SL,
(GIAMUA*SL) as [Trị giá Mua], (GIABAN*SL) as [Trị giá bán]
from  HOADON H, CTHD C, VATTU V
where H.MAHD= C.MAHD and C.MAVT=V.MAVT
select * 
from v14
15.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, 
giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) 
mà có giá bán lớn hơn hoặc bằng giá mua.
create view v15
as
select *
from v14
where GIABAN>=GIAMUA
16.	Lấy ra các thông tin gồm mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, 
giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) và 
cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lớn hơn 100.
create view v16
as
select H.MAHD, V.MAVT, TENVT, DVT, GIABAN, GIAMUA, SL,
(GIAMUA*SL) as [Trị giá Mua], (GIABAN*SL) as [Trị giá bán], 
KHUYENMAI= case when SL>100 then (GIABAN*SL)*0.1
else 0
end
from  HOADON H, CTHD C, VATTU V
where H.MAHD= C.MAHD and C.MAVT=V.MAVT
17.	Tìm ra những mặt hàng chưa bán được.
select 
18.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
19.	Tạo bảng tổng hợp tháng 5/2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
20.	Tạo bảng tổng hợp quý 1 – 2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
