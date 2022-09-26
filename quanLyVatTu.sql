create database quanlyvattu;
use quanlyvattu;
create table VatTu(
id int primary key,
ma_vat_tu varchar(45) unique,
ten_vat_tu varchar(255),
don_vi_tinh varchar(255),
gia_tien int
);
create table TonKho(
id int primary key auto_increment,
vat_tu_id int,
foreign key (vat_tu_id) references Vattu(id),
so_luong_dau int,
tong_so_luong_nhap int,
tong_so_luong_xuat int);
create table NhaCungCap(
id int primary key auto_increment,
ma_nha_cung_cap varchar(45) unique,
ten_nha_cung_cap varchar(255),
dia_chi varchar(255),
so_dien_thoai varchar(25)
);
create table DonDatHang(
id int primary key auto_increment,
ma_don varchar(45) unique,
ngay_dat_hang date,
nha_cung_cap_id int,
foreign key (nha_cung_cap_id) references NhaCungCap(id)
);
create table PhieuNhap(
id int primary key auto_increment,
ma_phieu_nhap varchar(45) unique,
ngay_nhap date,
don_hang_id int,
foreign key (don_hang_id) references DonDatHang(id)
);
create table PhieuXuat(
id int primary key auto_increment,
ma_phieu_xuat varchar(45) unique,
ngay_xuat date,
ten_khach_hang varchar(45)
);
create table ChiTietDonHang(
id int primary key auto_increment,
don_hang_id int,
foreign key (don_hang_id) references DonDatHang(id),
vat_tu_id int,
foreign key (vat_tu_id) references VatTu(id),
so_luong_dat int
);
create table ChiTietPhieuNhap(
id int primary key auto_increment,
phieu_nhap_id int,
vat_tu_id int,
foreign key (phieu_nhap_id) references PhieuNhap(id),
foreign key (vat_tu_id) references VatTu(id),
so_luong_nhap int,
don_gia_nhap int,
ghi_chu varchar(255)
);
create table ChiTietPhieuXuat(
id int primary key auto_increment,
phieu_xuat_id int,
vat_tu_id int,
foreign key (phieu_xuat_id) references PhieuXuat(id),
foreign key (vat_tu_id) references VatTu(id),
so_luong_xuat int,
don_gia_xuat int,
ghi_chu varchar(255)
);
insert into Vattu(id,ma_vat_tu,ten_vat_tu,don_vi_tinh,gia_tien) values (1,'1','cát','khối',250000),
																		(2,'2','xi măng','bao',100000),
                                                                        (3,'3','gạch','viên',3000),
                                                                        (4,'4', 'đá','kg',10000),
                                                                        (5,'5','thép 5 li','met',15000);
insert into tonkho(id,vat_tu_id,so_luong_dau,tong_so_luong_nhap,tong_so_luong_xuat) values (1,1,1000,200,300),
																							(2,2,1000,300,200),
                                                                                            (3,3,10000,234,345),
                                                                                            (4,4,3000,500,600),
                                                                                            (5,5,2000,500,1000);
insert into nhacungcap(id,ma_nha_cung_cap,ten_nha_cung_cap,dia_chi, so_dien_thoai) values (1,'KSB','Công Ty cổ phần khoáng sản Bình Dương','Bình Dương','0998098767'),
																							(2,'HT1','Công Ty cổ phần xi măng Hà Tiên','Bình Phước','0965096745'),
                                                                                            (3,'HPG','Tập đoàn thép Hòa Phát','Bình Định','0934253645');
insert into DondatHang(id,ma_don,ngay_dat_hang,nha_cung_cap_id) values (1,'DH1','2022-09-25',1),
                                                                        (2,'DH2','2022-09-25',2),
                                                                        (3,'DH3','2022-09-25',3);
insert into PhieuNhap(id,ma_phieu_nhap,ngay_nhap,don_hang_id) values(1,'PN1','2022-09-26',1),
																	(2,'PN3','2022-09-27',3),
                                                                    (3,'PN2','2022-09-28',2);
insert into PhieuXuat(id,ma_phieu_xuat,ngay_xuat,ten_khach_hang) values(1,'PX1','2022-09-26','Công ty xây dựng Trường Thành'),
																	(2,'PX2','2022-09-27','Công ty xây dựng Phục Hưng'),
                                                                    (3,'PX3','2022-09-28','Công ty xây dựng Cát Bà');
insert into ChiTietDonHang(id,don_hang_id,vat_tu_id,so_luong_dat) value(1,1,1,100),
																		(2,1,2,200),
																		(3,2,2,300),
																		(4,2,3,400),
																		(5,2,4,500),
																		(6,3,5,600);
insert into ChiTietPhieuNhap values(1,1,1,100,200000,null),
									(2,1,2,200,80000,null),
									(3,3,2,300,80000,null),
									(4,3,3,400,2500,null),
									(5,3,4,500,8000,null),
									(6,2,5,600,12000,null);
insert into ChiTietPhieuXuat values(1,1,1,100, 250000,null),                                   
									(2,1,2,200, 100000,null),                                   
									(3,2,3,300, 3000,null),                                   
									(4,2,4,400, 10000,null),                                   
									(5,3,5,500, 15000,null),                                   
									(6,3,1,600, 250000,null);        
create view vw_CTPNHAP as
select phieu_nhap_id, vat_tu_id,so_luong_nhap,don_gia_nhap, (so_luong_nhap*don_gia_nhap) as 'thanh_tien'
from chitietphieunhap;
create view vw_CTPNHAP_VT as
select CTPN.phieu_nhap_id, CTPN.vat_tu_id,vt.ten_vat_tu,CTPN.so_luong_nhap,CTPN.don_gia_nhap, (CTPN.so_luong_nhap*CTPN.don_gia_nhap) as 'thanh_tien'
from chitietphieunhap CTPN join vattu VT on ctpn.vat_tu_id=vt.id;

create view vw_CTPNHAP_VT_PN as
select CTPN.phieu_nhap_id,pn.ngay_nhap,pn.ma_phieu_nhap, CTPN.vat_tu_id,vt.ten_vat_tu,CTPN.so_luong_nhap,CTPN.don_gia_nhap, (CTPN.so_luong_nhap*CTPN.don_gia_nhap) as 'thanh_tien'
from chitietphieunhap CTPN join vattu VT on ctpn.vat_tu_id=vt.id join PhieuNhap PN on ctpn.phieu_nhap_id=pn.id;
create view vw_CTPNHAP_VT_PN_DH as
select CTPN.phieu_nhap_id,pn.ngay_nhap,pn.ma_phieu_nhap,  ncc.ma_nha_cung_cap, CTPN.vat_tu_id,vt.ten_vat_tu,CTPN.so_luong_nhap,CTPN.don_gia_nhap, (CTPN.so_luong_nhap*CTPN.don_gia_nhap) as 'thanh_tien'
from chitietphieunhap CTPN 
join vattu VT on ctpn.vat_tu_id=vt.id 
join PhieuNhap PN on ctpn.phieu_nhap_id=pn.id 
join Dondathang ddh on pn.don_hang_id = ddh.id
join NhaCungCap NCC on ddh.nha_cung_cap_id= ncc.id ;
create view vw_CTPNHAP_loc as
select phieu_nhap_id, vat_tu_id,so_luong_nhap,don_gia_nhap, (so_luong_nhap*don_gia_nhap) as 'thanh_tien'
from chitietphieunhap
where so_luong_nhap >250;
create view vw_CTPNHAP_VT_loc as
select CTPN.phieu_nhap_id, CTPN.vat_tu_id,vt.ten_vat_tu,CTPN.so_luong_nhap,CTPN.don_gia_nhap, (CTPN.so_luong_nhap*CTPN.don_gia_nhap) as 'thanh_tien'
from chitietphieunhap CTPN join vattu VT on ctpn.vat_tu_id=vt.id
where vt.don_vi_tinh='bao';
create view vw_CTPXUAT as
select phieu_xuat_id,vat_tu_id,so_luong_xuat,don_gia_xuat,(so_luong_xuat*don_gia_xuat) as 'thanh_tien'
from ChiTietPhieuXuat;
create view vw_CTPXUAT_VT as
select CTPX.phieu_xuat_id,CTPX.vat_tu_id,vattu.ten_vat_tu,CTPX.so_luong_xuat,CTPX.don_gia_xuat,(CTPX.so_luong_xuat*CTPX.don_gia_xuat) as 'thanh_tien'
from ChiTietPhieuXuat CTPX join vattu on ctpx.vat_tu_id=vattu.id;
create view vw_CTPXUAT_VT_PX as
select CTPX.phieu_xuat_id,px.ten_khach_hang,CTPX.vat_tu_id,vattu.ten_vat_tu,CTPX.so_luong_xuat,CTPX.don_gia_xuat,(CTPX.so_luong_xuat*CTPX.don_gia_xuat) as 'thanh_tien'
from ChiTietPhieuXuat CTPX join vattu on ctpx.vat_tu_id=vattu.id
join PhieuXuat px on ctpx.phieu_xuat_id=px.id;
DELIMITER //
CREATE PROCEDURE tinh_tong_so_luong_cuoi(in ma_vat_tu varchar(45) )
BEGIN
  select vt.ma_vat_tu,(tk.so_luong_dau+tk.tong_so_luong_nhap-tk.tong_so_luong_xuat) as'tong_so_luong_cuoi'
  from Vattu vt join TonKho Tk on vt.id=tk.vat_tu_id
  where vt.ma_vat_tu=ma_vat_tu;
END //
DELIMITER ;
call tinh_tong_so_luong_cuoi('1');
DELIMITER //
CREATE PROCEDURE tinh_tong_tien_xuat(in ma_vat_tu varchar(45))
BEGIN
select vt.ma_vat_tu, sum(thanh_tien)as 'tong_tien_xuat'
from vw_ctpxuat_vt join vattu vt on vw_ctpxuat_vt.vat_tu_id= vt.id
where vt.ma_vat_tu=ma_vat_tu
group by vt.ma_vat_tu;
END //
DELIMITER ;
call tinh_tong_tien_xuat('1');
DELIMITER //
CREATE PROCEDURE tinh_tong_so_luong_dat(in so_don_hang varchar(45))
BEGIN
select ddh.ma_don, sum(ctdh.so_luong_dat) as'tong_so_luong'
from dondathang ddh join chitietdonhang ctdh on ddh.id=ctdh.don_hang_id
where ddh.ma_don=so_don_hang
group by ddh.ma_don;
END //
DELIMITER ;
call tinh_tong_so_luong_dat('2');
DELIMITER //
CREATE PROCEDURE them_mot_don_dat_hang(id int,ma_don varchar(45) ,ngay_dat_hang date,nha_cung_cap_id int)
BEGIN
  insert into DonDatHang value(id,ma_don,ngay_dat_hang,nha_cung_cap_id);
END //
DELIMITER ;
call them_mot_don_dat_hang	(4,'4','2022-09-26',1);	
DELIMITER //
CREATE PROCEDURE them_chi_tiet_don_dat_hang(id int ,don_hang_id int,vat_tu_id int,so_luong_dat int)
BEGIN
  insert into chitietdonhang value(id ,don_hang_id ,vat_tu_id ,so_luong_dat);
END //
DELIMITER ;
call them_chi_tiet_don_dat_hang(7,4,1,100);
							



