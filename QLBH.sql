--1.	Hiển thị danh sách các khách hàng có địa chỉ là “Tân Bình” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
CREATE VIEW V1
AS
select *
from KHACHHANG
where DIACHI like N'Tân Bình'
select *
from  V1


--2.	Hiển thị danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng, địa chỉ và địa chỉ E-mail của những khách hàng chưa có số điện thoại.

CREATE VIEW V2
as
select MAKH, TENKH, DIACHI, EMAIL
from KHACHHANG
where DT is null
select *
from V2
--3.	Hiển thị danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ.
CREATE VIEW V3
as
select MAKH, TENKH,DIACHI
from KHACHHANG
where DT is null and EMAIL is null
select *
from V3
--4.	Hiển thị danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
CREATE VIEW V4
as
select *
from KHACHHANG
where DT is not null and EMAIL is not null 
select *
from V4
--5.	Hiển thị danh sách các vật tư có đơn vị tính là “Cái” gồm mã vật tư, tên vật tư và giá mua.
CREATE VIEW V5
as
select MAVT, TENVT, GIAMUA
from VATTU
where DVT =N'CÁI'
select *
FROM v5
--6.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên 25000.
CREATE VIEW V6
as
select MAVT, TENVT, DVT,GIAMUA
from VATTU
where  GIAMUA>=25000
select *
FROM V6
--7.	Hiển thị danh sách các vật tư là “Gạch” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua. 
CREATE VIEW V7
as
select MAVT, TENVT, DVT,GIAMUA
from VATTU
where  TENVT LIKE N'GẠCH%'
select *
from V7
--8.	Hiển thị danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
CREATE VIEW V8
as
select MAVT, TENVT, DVT,GIAMUA
from VATTU
where  GIAMUA between 20000 and 40000
select *
FROM V8
--9.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
CREATE VIEW V9
as
select MAHD, NGAY, TENKH, DIACHI, DT
from KHACHHANG K, HOADON H
where  K.MAKH=H.MAKH
select *
FROM V9
----.	Lấy ra các thông tin gồm Mã hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2010.
SET DATEFORMAT DMY
CREATE VIEW V10
as
SET DATEFORMAT DMY

select MAHD, TENKH, DIACHI,DT
from KHACHHANG K, HOADON H
where  K.MAKH=H.MAKH AND NGAY ='25/5/2010'
select *
FROM V10
--11.	Lấy ra các thông tin gồm Mã hóa đơn, ngày lập hóa đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của những hóa đơn trong tháng 6/2010.
SET DATEFORMAT DMY
CREATE VIEW V11
as
SET DATEFORMAT DMY

select MAHD, NGAY, TENKH,DIACHI,DT
from KHACHHANG K, HOADON H
where  K.MAKH=H.MAKH AND MONTH(NGAY)=6 AND YEAR(NGAY)=2010
select *
FROM V10
--12.	Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2010.
SET DATEFORMAT DMY
CREATE VIEW V12
as
SET DATEFORMAT DMY

select TENKH, DIACHI,DT
from KHACHHANG K, HOADON H
where  K.MAKH=H.MAKH AND MONTH(NGAY)=6 AND YEAR(NGAY)=2010
select *
FROM V12
--13.	Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2010 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
SET DATEFORMAT DMY
CREATE VIEW V13
as
SET DATEFORMAT DMY

select *
from KHACHHANG 
where  MAKH NOT IN
(
	SELECT DISTINCT K.MAKH
	FROM KHACHHANG K, HOADON H
	WHERE K.MAKH=H.MAKH AND MONTH(NGAY)=6 AND YEAR(NGAY)=2010 
)
select *
FROM V13
--14.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng).
CREATE VIEW V14
AS
	SELECT MAHD, MAVT,TENVT,DVT,GIABAN,GIAMUA,SL,GIAMUA*SL AS [ TRI GIA MUA], GIABAN*SL AS[TRI GIA BAN]
	FROM VATTU T, CTHD C
	WHERE T.MAVT=C.MAVT
SELECT *
FROM V14
--15.	Lấy ra các chi tiết hóa đơn gồm các thông tin mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) mà có giá bán lớn hơn hoặc bằng giá mua.
16.	Lấy ra các thông tin gồm mã hóa đơn, mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng, trị giá mua (giá mua * số lượng), trị giá bán (giá bán * số lượng) và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lớn hơn 100.
17.	Tìm ra những mặt hàng chưa bán được.
18.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
19.	Tạo bảng tổng hợp tháng 5/2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
20.	Tạo bảng tổng hợp quý 1 – 2010 gồm các thông tin: mã hóa đơn, ngày hóa đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
