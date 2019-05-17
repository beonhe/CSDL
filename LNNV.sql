--1.	Hiển danh sách tất cả các khách hàng gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
create view v1
as
select * from KHACHHANG
-------
Select * from v1
--2.	Hiển danh sách các khách hàng có địa chỉ là “TAN BINH” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
Create view v2
as
Select *
From KHACHHANG
Where DIACHI like 'TAN BINH'
------
Select * From v2
--3.	Hiển danh sách các khách hàng có địa chỉ là “BINH CHANH” gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
Create view v3
as
Select *
From KHACHHANG
Where DIACHI like 'BINH CHANH'
------
Select * From v3
--4.	Hiển danh sách các khách hàng gồm các thông tin mã khách hàng, tên khách hàng, địa chỉ và địa chỉ E-mail của những khách hàng chưa có số điện thoại
Create view v4
as
Select *
From KHACHHANG
Where DT is NULL
drop view v4
----
Select * from v4
--5.	Hiển danh sách các khách hàng chưa có số điện thoại và cũng chưa có địa chỉ Email gồm mã khách hàng, tên khách hàng, địa chỉ.
Create view v5
as
Select MAKH, TENKH, DIACHI
From KHACHHANG
Where DT is NULL and EMAIL is NULL
------
Select * From v5
--6.	Hiển danh sách các khách hàng đã có số điện thoại và địa chỉ E-mail gồm mã khách hàng, tên khách hàng, địa chỉ, điện thoại, và địa chỉ E-mail.
Create view v6
as
Select MAKH, TENKH, DIACHI, DT, EMAIL
From KHACHHANG
Where MAKH not in (Select MAKH
From KHACHHANG
Where DT is NULL or EMAIL is NULL)
drop view v6
---------
Select * From v6
--7.	Hiển danh sách tất cả các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua.
Create view v7
as
Select MAVT, TENVT, DVT, GIAMUA
From VATTU
-----
Select * From v7
--8.	Hiển danh sách các vật tư có đơn vị tính là “CAI” gồm mã vật tư, tên vật tư và giá mua.
Create view v8
as
Select MAVT, TENVT, GIAMUA
From VATTU
Where DVT like 'CAI'
-----
Select * From v8
--9.	Hiển danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua trên 25000.
Create view v9
as
Select MAVT, TENVT, DVT, GIAMUA
From VATTU
Where GIAMUA > 25000
-----
Select * From v9
--10.	Hiển danh sách các vật tư là “GẠCH” (bao gồm các loại gạch) gồm mã vật tư, tên vật tư, đơn vị tính và giá mua .
Create view v10
as
Select MAVT, TENVT, DVT, GIAMUA
From VATTU
Where TENVT like 'GACH%'
-----
Select * From v10
--11.	Hiển danh sách các vật tư gồm mã vật tư, tên vật tư, đơn vị tính và giá mua mà có giá mua nằm trong khoảng từ 20000 đến 40000.
Create view v11
as
Select MAVT, TENVT, DVT, GIAMUA
From VATTU
Where 20000 <= GIAMUA and GIAMUA <=40000 
-----
Select * From v11
--12.	Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
Create view v12
as
Select MAHD, NGAY, TENKH, DIACHI, DT
From HOADON HD, KHACHHANG KH
Where HD.MAKH = KH.MAKH
-------
Select * From v12
--13.	Tạo query để lấy ra các thông tin gồm Mã hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của ngày 25/5/2000.
Create view v13
as
Select MAHD, TENKH, DIACHI, DT
From HOADON HD, KHACHHANG KH
Where HD.MAKH = KH.MAKH and DAY(hd.NGAY)=25 and MONTH(Hd.NGAY)=5 and YEAR(hd.ngay)=2000
drop view v13
-------
Select * From v13
--14.	Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại của 
--------những hoá đơn trong tháng 6/2000.
Create view v14
as
Select MAHD, NGAY, TENKH, DIACHI, DT
From HOADON HD, KHACHHANG KH
Where HD.MAKH = KH.MAKH and MONTH(Hd.NGAY)=6 and YEAR(hd.ngay)=2000
drop view v14
-------
Select * From v14
--15.	Tạo query để lấy ra các thông tin gồm Mã hoá đơn, ngày lập hoá đơn, tên khách hàng, địa chỉ khách hàng và số điện thoại.
Create view v15
as
Select MAHD, NGAY, TENKH, DIACHI, DT
From HOADON HD, KHACHHANG KH
Where HD.MAKH = KH.MAKH
-------
Select * From v15
--16.	Lấy ra danh sách những khách hàng (tên khách hàng, địa chỉ, số điện thoại) đã mua hàng trong tháng 6/2000.
Create view v16
as
Select Distinct TENKH, DIACHI, DT
From HOADON HD, KHACHHANG KH
Where HD.MAKH = KH.MAKH and MONTH(Hd.NGAY)=6 and YEAR(hd.ngay)=2000
drop view v16
-------
Select * From v16
--17.	Lấy ra danh sách những khách hàng không mua hàng trong tháng 6/2000 gồm các thông tin tên khách hàng, địa chỉ, số điện thoại.
Create view v17
as
Select Distinct TENKH, DIACHI, DT
From KHACHHANG KH
Where MAKH not in (Select HD.MAKH
					From HOADON HD, KHACHHANG KH
					Where HD.MAKH = KH.MAKH and MONTH(Hd.NGAY)=6 and YEAR(hd.ngay)=2000)
drop view v17
-------
Select * From v17
--18.	Tạo query để lấy ra các thông tin gồm các thông tin mã hóa đơn, ,mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng ,
-------- trị giá mua (giá mua * số lượng), trị giá bán , ( giá bán * số lượng).
Create view v18
as
Select a.MAHD, b.MAVT, b.TENVT, b.DVT, a.GIABAN, b.GIAMUA, a.SL, b.GIAMUA*(b.SLTON+a.SL) as [Tri gia mua], sum(a.GIABAN*a.SL) as [Tri gia ban]
From CHITIETHOADON a, VATTU b
Where a.MAVT=b.MAVT
group by a.MAHD, b.MAVT, b.TENVT, b.DVT, a.GIABAN, b.GIAMUA, a.SL, b.GIAMUA*(b.SLTON+a.SL)
drop view v18
---------
Select * From v18
--19.	Tạo query để lấy ra các chi tiết hoá đơn gồm các thông tin mã hóa đơn, ,mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng , 
---------trị giá mua (giá mua * số lượng), trị giá bán , ( giá bán * số lượng) mà có giá bán lớn hơn hoặc bằng giá mua.
Create view v19
as
Select *
From v18
Where GIABAN >= GIAMUA
drop view v19
---------
Select * From v19
--20.	Tạo query để lấy ra các thông tin gồm mã hóa đơn, ,mã vật tư, tên vật tư, đơn vị tính, giá bán, giá mua, số lượng , trị giá mua (giá mua * số lượng), 
---------trị giá bán , ( giá bán * số lượng) và cột khuyến mãi với khuyến mãi 10% cho những mặt hàng bán trong một hóa đơn lơn hơn 100.
Create view v20
as
Select v18.*, sum(SL) as [Soluong], [Khuyen mai] =
	case
		when sum(SL)>100 then [Tri gia ban]*0.1
		else 0
	end
From v18
group by MAHD, MAVT, TENVT, DVT, GIABAN, GIAMUA, SL, [Tri gia mua], [Tri gia ban]
drop view v20
------
Select * From v20
--21.	Tìm ra những mặt hàng chưa bán được.
Create view v21
as
Select MAVT, TENVT
From  VATTU
Where MAVT not in (Select MAVT 
						From CHITIETHOADON)
-------
Select * From v21
--22.	Tạo bảng tổng hợp gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, đơn vị tính, 
--------giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
Create view v22
as
Select a.MAHD, b.NGAY, c.TENKH, c.DIACHI, c.DT, a.TENVT, a.DVT, a.GIAMUA, a.GIABAN, a.SL, a.[Tri gia mua], a.[Tri gia ban]
From v18 a, HOADON b, KHACHHANG c
Where a.MAHD=b.MAHD and b.MAKH = c.MAKH
drop view v22
--------
Select * From v22
--23.	Tạo bảng tổng hợp của tháng 5/2000 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, 
--------đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
Create view v23
as
Select a.MAHD, b.NGAY, c.TENKH, c.DIACHI, c.DT, a.TENVT, a.DVT, a.GIAMUA, a.GIABAN, a.SL, a.[Tri gia mua], a.[Tri gia ban]
From v18 a, HOADON b, KHACHHANG c
Where a.MAHD=b.MAHD and b.MAKH = c.MAKH and MONTH(b.NGAY)=5 and YEAR(b.NGAY)=2000
drop view v23
--------
Select * From v23
--24.	Tạo bảng tổng hợp của tháng 6/2000 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, 
---------đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
Create view v24
as
Select a.MAHD, b.NGAY, c.TENKH, c.DIACHI, c.DT, a.TENVT, a.DVT, a.GIAMUA, a.GIABAN, a.SL, a.[Tri gia mua], a.[Tri gia ban]
From v18 a, HOADON b, KHACHHANG c
Where a.MAHD=b.MAHD and b.MAKH = c.MAKH and MONTH(b.NGAY)=6 and YEAR(b.NGAY)=2000
drop view v24
--------
Select * From v24
--25.	Tạo bảng tổng hợp của quý 1 năm 2000 gồm các thông tin: mã hóa đơn, ngày hoá đơn, tên khách hàng, địa chỉ, số điện thoại, tên vật tư, 
--------đơn vị tính, giá mua, giá bán, số lượng, trị giá mua, trị giá bán. 
Create view v25
as
Select a.MAHD, b.NGAY, c.TENKH, c.DIACHI, c.DT, a.TENVT, a.DVT, a.GIAMUA, a.GIABAN, a.SL, a.[Tri gia mua], a.[Tri gia ban]
From v18 a, HOADON b, KHACHHANG c
Where a.MAHD=b.MAHD and b.MAKH = c.MAKH and MONTH(b.NGAY)>=1 and MONTH(b.NGAY)<=3 and YEAR(b.NGAY)=2000
drop view v25
--------
Select * From v25
--26.	Lấy ra danh sách các hoá đơn gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.

--27.	Lấy ra hoá đơn có tổng trị giá lớn nhất gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
--28.	Lấy ra hoá đơn có tổng trị giá lớn nhất trong tháng 5/2000 gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, 
---------tổng trị giá của hoá đơn.
--29.	Lấy ra hoá đơn có tổng trị giá nhỏ nhất gồm các thông tin: Số hoá đơn, ngày, tên khách hàng, địa chỉ khách hàng, tổng trị giá của hoá đơn.
--30.	Đếm xem mỗi khách hàng có bao nhiêu hoá đơn.
--31.	Lấy ra các thông tin của khách hàng có số lượng hoá đơn mua hàng nhiều nhất.
--32.	Lấy ra các thông tin của khách hàng có số lượng hàng mua nhiều nhất.
--33.	Lấy ra các thông tin về các mặt hàng mà được bán trong nhiều hoá đơn nhất.
--34.	Lấy ra các thông tin về các mặt hàng mà được bán nhiều nhất.
--35.	Lấy ra danh sách tất cả các khách hàng gồm Mã khách hàng, tên khách hàng, địa chỉ , số lượng hoá đơn đã mua (nếu khách hàng đó chưa mua hàng thì cột số lượng hoá đơn để trống)


