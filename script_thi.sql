

create table congty (
mact nvarchar(10) primary key,
tencongty nvarchar(30) not null,
thanhpho nvarchar(20) not null
)

create table nhanvien(
manv nvarchar(10) primary key,
tennv nvarchar(30) not null,
diachi nvarchar(50),
bacluong bigint not null,
chuyenmon nvarchar(30),
mact nvarchar(10) not null
)

create table duan(
mada nvarchar(10) primary key,
tenduan nvarchar(30) not null,
mact nvarchar(10) not null,
thoigianthuchien  int not null
)

create table thamgia(
mada nvarchar(10) not null,
manv nvarchar(10) not null,
vaitro nvarchar(30) not null
)

alter table thamgia add
constraint PK1 primary key (mada,manv),
constraint FK1 foreign key(mada) references duan(mada),
constraint FK2 foreign key(manv) references nhanvien(manv)

alter table duan add
constraint FK3 foreign key(mact) references congty(mact)

alter table nhanvien add
constraint FK4 foreign key(mact) references congty(mact)

--==================Nhan du lieu
INSERT INTO congty VALUES ('CT01','Xuat Nhap Khau Thang Long','Hai Phong')
INSERT INTO congty VALUES ('CT02','Quan Ly Du �n S�ng H�n','Can Tho')
INSERT INTO congty VALUES ('CT03','Xuat Nhap Khau Ben Th�nh','Sai Gon')
---
INSERT INTO nhanvien VALUES ('NV01','NGUYEN THI BE','123/12 Hai B� Trung - HP', 5400000,'cskv','CT01')
INSERT INTO nhanvien VALUES ('NV02','LE HOANG NAM','14 - Cam Chi - HP', 4300000,'cnkt','CT01')
INSERT INTO nhanvien VALUES ('NV03','MAI THI QUE ANH','12/05 Tran Hung �ao - HP', 5700000,'cntt','CT01')
INSERT INTO nhanvien VALUES ('NV04','TRAN THI CHIEU','154 - L�ng Ha - HP', 4800000,'cnmt','CT01')

INSERT INTO nhanvien VALUES ('NV05','LE VAN SANG','123/12 Hai B� Trung - CT', 5400000,'cntt','CT02')
INSERT INTO nhanvien VALUES ('NV06','TRAN HOANG KHAI','14 - Tran Ph� - CT', 4250000,'cnqtkd','CT02')
INSERT INTO nhanvien VALUES ('NV07','MAI THI QUYNH','345 Tran Hung �ao - CT', 5700000,'cntt','CT02')
INSERT INTO nhanvien VALUES ('NV08','TRAN THI THU V�N','154 - B� Trieu - CT', 4950000,'ksdt','CT02')

INSERT INTO nhanvien VALUES ('NV09','NGUYEN THI BAY','3 T�n �uc Thang - SG', 5200000,'cnkt','CT03')
INSERT INTO nhanvien VALUES ('NV10','LE TRAN QUOC','1434 - XVNT - SG', 4700000,'cnkt','CT03')
INSERT INTO nhanvien VALUES ('NV11','PHAM HAI CHAU','1726 Tran Hung �ao - SG', 6700000,'cntt','CT03')
INSERT INTO nhanvien VALUES ('NV12','TRAN THI TRUC SON','154 - L� Loi - SG', 4800000,'ksvt','CT03')
INSERT INTO nhanvien VALUES ('NV13','NGUYEN THI BAY','292 Hai B� Trung - SG', 5500000,'cnkt','CT03')
-----
INSERT INTO duan VALUES ('DA01','MAY NUOC NONG','CT01',60)
INSERT INTO duan VALUES ('DA02','HAT NHUA','CT01',80)
INSERT INTO duan VALUES ('DA03','VAN PHONG TT','CT01',365)

INSERT INTO duan VALUES ('DA04','CNTT PA132','CT02',120)
INSERT INTO duan VALUES ('DA05','DONG TAU SONG HAN','CT02',720)
INSERT INTO duan VALUES ('DA06','SIEU THI TRUNG TAM','CT02',1230)

INSERT INTO duan VALUES ('DA07','HAM THU THIEM','CT03',12093)
INSERT INTO duan VALUES ('DA08','CANG CAT LAI','CT03',790)
-----
INSERT INTO thamgia VALUES ('DA01','NV01','khao sat')
INSERT INTO thamgia VALUES ('DA02','NV02','khao sat')
INSERT INTO thamgia VALUES ('DA02','NV01','thu nghiem')
INSERT INTO thamgia VALUES ('DA03','NV05','thi cong')
INSERT INTO thamgia VALUES ('DA03','NV03','thuc hien')
INSERT INTO thamgia VALUES ('DA03','NV04','thu nghiem')

INSERT INTO thamgia VALUES ('DA04','NV05','khao sat')
INSERT INTO thamgia VALUES ('DA04','NV06','khao sat')
INSERT INTO thamgia VALUES ('DA05','NV07','thu nghiem')
INSERT INTO thamgia VALUES ('DA06','NV05','thi cong')
INSERT INTO thamgia VALUES ('DA06','NV08','thuc hien')
INSERT INTO thamgia VALUES ('DA06','NV13','thu nghiem')

INSERT INTO thamgia VALUES ('DA07','NV05','quan ly')
INSERT INTO thamgia VALUES ('DA07','NV09','khao sat')
INSERT INTO thamgia VALUES ('DA07','NV10','thu nghiem')
INSERT INTO thamgia VALUES ('DA07','NV08','thuc hien')
INSERT INTO thamgia VALUES ('DA08','NV11','thi cong')
INSERT INTO thamgia VALUES ('DA08','NV12','thuc hien')
INSERT INTO thamgia VALUES ('DA08','NV13','thu nghiem')

