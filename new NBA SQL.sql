CREATE DATABASE NigeriaBasketballAssociation
GO

USE NigeriaBasketballAssociation
GO

-- 1. Cán bộ
CREATE TABLE GiangVien (
    MaCB VARCHAR(20) PRIMARY KEY,
    HoTen NVARCHAR(100) NOT NULL,
    GioiTinh NVARCHAR(10)
        CHECK (GioiTinh IN (N'Nam', N'Nữ')),
    NgaySinh DATE,
    QueQuan NVARCHAR(100),
    DanToc NVARCHAR(50),
    TonGiao NVARCHAR(50),
    SDT VARCHAR(15),
    TrinhDoChuyenMon NVARCHAR(100),
    TrinhDoLLCT NVARCHAR(100),
    DonViCongTac NVARCHAR(100) NOT NULL,
    ChucVu NVARCHAR(100),
    CapBac NVARCHAR(50),
    HeSoLuong DECIMAL(5,2),
    ChucDanh NVARCHAR(100),
    HocHam NVARCHAR(50),
    HocVi NVARCHAR(50),
    LinhVucChuyenMon NVARCHAR(200),
    NamGanNhatDayGioi INT NOT NULL
	CHECK (NamGanNhatDayGioi >= 1900)
);

-- 2. Đề tài
CREATE TABLE DeTaiNCKH (
    MaDT VARCHAR(20) PRIMARY KEY,
    TenDeTai NVARCHAR(300) NOT NULL,
    DonViChuTri NVARCHAR(200),
    ThangDangKy INT CHECK (ThangDangKy BETWEEN 1 AND 12),
    NamDangKy INT CHECK (NamDangKy >= 2000),
    CapNhiemVu NVARCHAR(100),
    ThoiGianThucHien INT CHECK (ThoiGianThucHien > 0),
    SoQuyetDinh NVARCHAR(50),
    TongGioKhoaHoc DECIMAL(10,2) CHECK (TongGioKhoaHoc >= 0),
    ChuNhiemDT VARCHAR(20) NOT NULL,
    CONSTRAINT FK_DeTai_GiangVien
        FOREIGN KEY (ChuNhiemDT) REFERENCES GiangVien(MaCB)
);
GO

SELECT 
    dt.MaDT,
    cb.HoTen,
    cb.HocHam,
    cb.HocVi
FROM DeTaiNCKH dt
JOIN GiangVien cb ON dt.ChuNhiemDT = cb.MaCB;

-- 3. Thành viên đề tài
CREATE TABLE ThanhVienDeTai (
    MaDT VARCHAR(20) NOT NULL,
    MaCB VARCHAR(20) NOT NULL,
    TyLeDongGop DECIMAL(10,2) CHECK (TyLeDongGop > 0 AND TyLeDongGop <= 100),

    CONSTRAINT PK_ThanhVienDeTai 
        PRIMARY KEY (MaDT, MaCB),

    CONSTRAINT FK_TVDT_DeTai 
        FOREIGN KEY (MaDT) REFERENCES DeTaiNCKH(MaDT),

    CONSTRAINT FK_TVDT_GiangVien 
        FOREIGN KEY (MaCB) REFERENCES GiangVien(MaCB)
);

SELECT 
    dt.MaDT,
    cb.HoTen,
    cb.HocHam,
    cb.HocVi,
    tv.TyLeDongGop
FROM ThanhVienDeTai tv
JOIN GiangVien cb ON tv.MaCB = cb.MaCB
JOIN DeTaiNCKH dt ON tv.MaDT = dt.MaDT;

-- 4. Nhiệm vụ
CREATE TABLE NhiemVuNCKH (
    MaNhiemVu INT IDENTITY(1,1) PRIMARY KEY,
    MaDT VARCHAR(20) NOT NULL,
    NoiDung NVARCHAR(300),
    KetQuaCanDat NVARCHAR(300),
    ThoiGianBatDau DATE NOT NULL,
	ThoiHanHoanThanh DATE NOT NULL,
    TinhTrang NVARCHAR(50)
        CHECK (TinhTrang IN (N'Chưa triển khai', N'Đang thực hiện', N'Quá hạn',N'Hoàn thành')),
	CONSTRAINT CK_NhiemVu_Ngay
        CHECK (ThoiHanHoanThanh >= ThoiGianBatDau),
    CONSTRAINT FK_NhiemVu_DeTai
        FOREIGN KEY (MaDT) REFERENCES DeTaiNCKH(MaDT)
);

-- 5. Gia hạn
CREATE TABLE GiaHanNhiemVu (
    MaNhiemVu INT NOT NULL,
    LanGiaHan INT NOT NULL CHECK (LanGiaHan > 0),
    LyDo NVARCHAR(300),
    ThoiGianGiaHan DATE,

    CONSTRAINT PK_GiaHanNhiemVu
        PRIMARY KEY (MaNhiemVu, LanGiaHan),

    CONSTRAINT FK_GiaHan_NhiemVu
        FOREIGN KEY (MaNhiemVu)
        REFERENCES NhiemVuNCKH(MaNhiemVu)
);
GO

CREATE VIEW GiaHanQuaHan AS
SELECT 
    dt.MaDT,
    nv.NoiDung,
    gh.LanGiaHan,
    gh.LyDo,
    gh.ThoiGianGiaHan
FROM GiaHanNhiemVu gh
JOIN NhiemVuNCKH nv ON gh.MaNhiemVu = nv.MaNhiemVu
JOIN DeTaiNCKH dt ON nv.MaDT = dt.MaDT
WHERE nv.TinhTrang = N'Quá hạn';
GO

-- 6. Hội đồng
CREATE TABLE HoiDong (
    MaHoiDong VARCHAR(20) PRIMARY KEY,
    MaDT VARCHAR(20) NOT NULL,
    TenNhiemVu NVARCHAR(200),
    NgayDanhGia DATE,
    CONSTRAINT FK_HoiDong_DeTai
        FOREIGN KEY (MaDT) REFERENCES DeTaiNCKH(MaDT)
);

-- 7. Thành viên hội đồng
CREATE TABLE ThanhVienHoiDong (
    MaHoiDong VARCHAR(20) NOT NULL,
    MaCB VARCHAR(20) NOT NULL,
    ChucDanhHoiDong NVARCHAR(50),

    CONSTRAINT PK_TVHD 
        PRIMARY KEY (MaHoiDong, MaCB),

    CONSTRAINT FK_TVHD_HoiDong 
        FOREIGN KEY (MaHoiDong) REFERENCES HoiDong(MaHoiDong),

    CONSTRAINT FK_TVHD_GiangVien 
        FOREIGN KEY (MaCB) REFERENCES GiangVien(MaCB)
);
GO
CREATE VIEW HoiDongHopLe AS
SELECT 
    tv.MaHoiDong
FROM ThanhVienHoiDong tv
JOIN GiangVien gv 
    ON tv.MaCB = gv.MaCB
GROUP BY tv.MaHoiDong
HAVING 
    COUNT(*) >= 5
    AND SUM(CASE WHEN gv.HocHam LIKE N'PGS%' THEN 1 ELSE 0 END) >= 2
    AND SUM(CASE WHEN gv.ChucVu IN (N'Cục trưởng', N'Phó Cục trưởng') THEN 1 ELSE 0 END) >= 1
    AND SUM(CASE WHEN gv.HocVi = N'Tiến sĩ' THEN 1 ELSE 0 END) >= 1;
GO


-- 8. Đánh giá
CREATE TABLE DanhGiaHoiDong (
    MaHoiDong VARCHAR(20) NOT NULL,
    MaCB VARCHAR(20) NOT NULL,
    KetQua NVARCHAR(20)
        CHECK (KetQua IN (N'Thông qua', N'Không thông qua')),

    CONSTRAINT PK_DanhGiaHoiDong
        PRIMARY KEY (MaHoiDong, MaCB),

    CONSTRAINT FK_DanhGia_HoiDong
        FOREIGN KEY (MaHoiDong) REFERENCES HoiDong(MaHoiDong),

    CONSTRAINT FK_DanhGia_GiangVien
        FOREIGN KEY (MaCB) REFERENCES GiangVien(MaCB)
);
GO

CREATE VIEW KetQuaDanhGia AS
SELECT 
    hd.MaHoiDong,
    hd.MaDT,
    hd.TenNhiemVu,
    COUNT(dg.MaCB) AS TongPhieu,
    SUM(CASE WHEN dg.KetQua = N'Thông qua' THEN 1 ELSE 0 END) AS SoPhieuThongQua,
    CASE 
        WHEN SUM(CASE WHEN dg.KetQua = N'Thông qua' THEN 1 ELSE 0 END) >= 3
            THEN N'Đạt'
        ELSE N'Không đạt'
    END AS KetLuan
FROM HoiDong hd
LEFT JOIN DanhGiaHoiDong dg 
    ON hd.MaHoiDong = dg.MaHoiDong
GROUP BY hd.MaHoiDong, hd.MaDT, hd.TenNhiemVu;
GO

-- 9. Giáo trình
CREATE TABLE GiaoTrinh (
    MaGTrinh VARCHAR(20) PRIMARY KEY,
    TenGTrinh NVARCHAR(200),
    ChuyenNganh NVARCHAR(100),
    CapDoDaoTao NVARCHAR(50),
    Keywords NVARCHAR(200),
    TongGioKhoaHoc DECIMAL(10,2)
);

-- 10. Tiến độ giáo trình
CREATE TABLE GiaoTrinh_TienDo (
    MaGTrinh VARCHAR(20) NOT NULL,

    GiaoNhiemVu     BIT NOT NULL DEFAULT 0,
    BienSoanNoiDung BIT NOT NULL DEFAULT 0,
    ThamDinhNoiDung        BIT NOT NULL DEFAULT 0,
    GopYPhanBien    BIT NOT NULL DEFAULT 0,
    SuaNoiDungThamDinh      BIT NOT NULL DEFAULT 0,
    InAnPhatHanh    BIT NOT NULL DEFAULT 0,

    CONSTRAINT PK_GiaoTrinh_TienDo PRIMARY KEY (MaGTrinh),
    CONSTRAINT FK_GiaoTrinh_TienDo 
        FOREIGN KEY (MaGTrinh) REFERENCES GiaoTrinh(MaGTrinh)
);
GO

-- 11. Tác giả giáo trình
CREATE TABLE GiaoTrinh_TacGia (
    MaGTrinh VARCHAR(20) NOT NULL,
    MaCB VARCHAR(20) NOT NULL,
    VaiTro NVARCHAR(50),
    TyLeDongGop DECIMAL(10,2) CHECK (TyLeDongGop > 0 AND TyLeDongGop <= 100),

    CONSTRAINT PK_GiaoTrinh_TacGia 
        PRIMARY KEY (MaGTrinh, MaCB),

    CONSTRAINT FK_GT_TG_GTrinh 
        FOREIGN KEY (MaGTrinh) REFERENCES GiaoTrinh(MaGTrinh),

    CONSTRAINT FK_GT_TG_GiangVien 
        FOREIGN KEY (MaCB) REFERENCES GiangVien(MaCB)
);
GO

CREATE VIEW GioGTrinhHopLe AS
SELECT tg.MaCB,
       gt.TongGioKhoaHoc * tg.TyLeDongGop / 100 AS GioDuocTinh
FROM GiaoTrinh_TacGia tg
JOIN GiaoTrinh gt ON tg.MaGTrinh = gt.MaGTrinh
JOIN GiaoTrinh_TienDo td ON gt.MaGTrinh = td.MaGTrinh
WHERE td.GiaoNhiemVu = 1
  AND td.BienSoanNoiDung = 1
  AND td.ThamDinhNoiDung = 1
  AND td.GopYPhanBien = 1
  AND td.SuaNoiDungThamDinh = 1
  AND td.InAnPhatHanh = 1;
GO

-- 12. Công bố khoa học
CREATE TABLE CongBoKhoaHoc (
    MaCBKH INT IDENTITY(1,1) PRIMARY KEY,
    TieuDe NVARCHAR(300),
    LoaiHinh NVARCHAR(50),
    LinhVuc NVARCHAR(200),
	TuKhoa NVARCHAR(200),
    NamCongBo INT,
    NgayXuatBan DATE,
    NgonNgu NVARCHAR(50),
    GioKhoaHoc DECIMAL(10,2)
);

-- 13. Tác giả công bố
CREATE TABLE CongBo_TacGia (
    MaCBKH INT NOT NULL,
    MaCB   VARCHAR(20) NOT NULL,
    TyLeDongGop DECIMAL(10,2) CHECK (TyLeDongGop > 0 AND TyLeDongGop <= 100),

    CONSTRAINT PK_CongBo_TacGia 
        PRIMARY KEY (MaCBKH, MaCB),

    CONSTRAINT FK_TGCB_CongBo 
        FOREIGN KEY (MaCBKH) REFERENCES CongBoKhoaHoc(MaCBKH),

    CONSTRAINT FK_TGCB_GiangVien 
        FOREIGN KEY (MaCB) REFERENCES GiangVien(MaCB)
);

-- 14. Tạp chí
CREATE TABLE TapChi (
    MaCBKH INT PRIMARY KEY,
    TenTapChi NVARCHAR(200),
    ISSN NVARCHAR(50),
    XepHang NVARCHAR(50),
    DOI NVARCHAR(100),
    CONSTRAINT FK_TC_CongBo FOREIGN KEY (MaCBKH) REFERENCES CongBoKhoaHoc(MaCBKH)
);

-- 15. Hội Nghị
CREATE TABLE HoiNghi (
    MaCBKH INT PRIMARY KEY,
    TenHoiNghi NVARCHAR(200),
    DiaDiem NVARCHAR(200),
    NhaXuatBan NVARCHAR(200),
    ISBN NVARCHAR(50),
    DOI NVARCHAR(100),
    CONSTRAINT FK_HN_CongBo FOREIGN KEY (MaCBKH) REFERENCES CongBoKhoaHoc(MaCBKH)
);

-- 16. Sáng chế
CREATE TABLE SangChe (
    MaSC VARCHAR(50) PRIMARY KEY,
    TenSangChe NVARCHAR(200),
    SoDonDangKy NVARCHAR(50),
    NgayNop DATE,
    CoQuanNop NVARCHAR(100),
    TinhTrang NVARCHAR(50)
	CHECK (TinhTrang IN (N'Chờ duyệt', N'Chấp nhận', N'Từ chối')),
    NgayCap DATE,
    NgayCongBo DATE,
    NgayBatDau DATE,
    NgayKetThuc DATE
);

--17. Tác giả sáng chế
CREATE TABLE SangChe_TacGia (
    MaSC VARCHAR(50) NOT NULL,
    MaCB     VARCHAR(20) NOT NULL,
    VaiTro   NVARCHAR(50),

    CONSTRAINT PK_SangChe_TacGia
        PRIMARY KEY (MaSC, MaCB),

    CONSTRAINT FK_SCTG_SangChe
        FOREIGN KEY (MaSC) REFERENCES SangChe(MaSC),

    CONSTRAINT FK_SCTG_GiangVien
        FOREIGN KEY (MaCB) REFERENCES GiangVien(MaCB)
);
GO

-- 18. View tổng hợp giờ
CREATE VIEW Gio_DeTai AS
SELECT 
    tv.MaCB,
    SUM(dt.TongGioKhoaHoc * tv.TyLeDongGop / 100) AS GioDeTai
FROM ThanhVienDeTai tv
JOIN DeTaiNCKH dt ON tv.MaDT = dt.MaDT
GROUP BY tv.MaCB;
GO

CREATE VIEW GiaoTrinhHoanThanh AS
SELECT MaGTrinh
FROM GiaoTrinh_TienDo
WHERE 
    GiaoNhiemVu = 1
    AND BienSoanNoiDung = 1
    AND ThamDinhNoiDung = 1
    AND GopYPhanBien = 1
    AND SuaNoiDungThamDinh = 1
    AND InAnPhatHanh = 1;
GO

CREATE VIEW Gio_GiaoTrinh AS
SELECT 
    tg.MaCB,
    SUM(gt.TongGioKhoaHoc * tg.TyLeDongGop / 100) AS GioGiaoTrinh
FROM GiaoTrinh_TacGia tg
JOIN GiaoTrinh gt ON tg.MaGTrinh = gt.MaGTrinh
JOIN GiaoTrinhHoanThanh vht ON gt.MaGTrinh = vht.MaGTrinh
GROUP BY tg.MaCB;
GO

CREATE VIEW Gio_CongBoKH AS
SELECT 
    tg.MaCB,
    SUM(cb.GioKhoaHoc * tg.TyLeDongGop / 100) AS GioCongBo
FROM CongBo_TacGia tg
JOIN CongBoKhoaHoc cb ON tg.MaCBKH = cb.MaCBKH
GROUP BY tg.MaCB;
GO

CREATE VIEW Gio_SangChe AS
SELECT 
    tg.MaCB,
    COUNT(*) * 100.0 AS GioSangChe
FROM SangChe_TacGia tg
JOIN SangChe sc ON tg.MaSC = sc.MaSC
WHERE sc.TinhTrang = N'Chấp nhận'
GROUP BY tg.MaCB;
GO

CREATE VIEW TongHopGioNCKH AS
SELECT 
    gv.MaCB,
    gv.HoTen,
    ISNULL(dt.GioDeTai, 0)     AS GioDeTai,
    ISNULL(gt.GioGiaoTrinh, 0) AS GioGiaoTrinh,
    ISNULL(cb.GioCongBo, 0)    AS GioCongBo,
    ISNULL(sc.GioSangChe, 0)   AS GioSangChe,
    (
        ISNULL(dt.GioDeTai, 0)
      + ISNULL(gt.GioGiaoTrinh, 0)
      + ISNULL(cb.GioCongBo, 0)
      + ISNULL(sc.GioSangChe, 0)
    ) AS TongGioNCKH
FROM GiangVien gv
LEFT JOIN Gio_DeTai dt      ON gv.MaCB = dt.MaCB
LEFT JOIN Gio_GiaoTrinh gt  ON gv.MaCB = gt.MaCB
LEFT JOIN Gio_CongBoKH cb   ON gv.MaCB = cb.MaCB
LEFT JOIN Gio_SangChe sc    ON gv.MaCB = sc.MaCB;
GO

-- 19. Phần đăng nhập
CREATE TABLE DangNhap (
    DangNhapID INT IDENTITY PRIMARY KEY,
    TenDangNhap VARCHAR(100) NOT NULL UNIQUE,
    MatKhau VARCHAR(255) NOT NULL    --co the hash truoc de tang bao mat
);

GO
