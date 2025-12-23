USE [master]
GO
/****** Object:  Database [NigeriaBasketballAssociation]    Script Date: 12/17/2025 8:50:19 AM ******/
CREATE DATABASE [NigeriaBasketballAssociation]
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [NigeriaBasketballAssociation].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET ARITHABORT OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET  ENABLE_BROKER 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET RECOVERY FULL 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET  MULTI_USER 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET DB_CHAINING OFF 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'NigeriaBasketballAssociation', N'ON'
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET QUERY_STORE = ON
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [NigeriaBasketballAssociation]
GO
/****** Object:  Table [dbo].[GiaoTrinh_TienDo]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoTrinh_TienDo](
	[MaGTrinh] [varchar](20) NOT NULL,
	[GiaoNhiemVu] [bit] NOT NULL,
	[BienSoanNoiDung] [bit] NOT NULL,
	[ThamDinhNoiDung] [bit] NOT NULL,
	[GopYPhanBien] [bit] NOT NULL,
	[SuaNoiDungThamDinh] [bit] NOT NULL,
	[InAnPhatHanh] [bit] NOT NULL,
 CONSTRAINT [PK_GiaoTrinh_TienDo] PRIMARY KEY CLUSTERED 
(
	[MaGTrinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GiaoTrinhHoanThanh]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GiaoTrinhHoanThanh] AS
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
/****** Object:  Table [dbo].[GiaoTrinh]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoTrinh](
	[MaGTrinh] [varchar](20) NOT NULL,
	[TenGTrinh] [nvarchar](200) NULL,
	[ChuyenNganh] [nvarchar](100) NULL,
	[CapDoDaoTao] [nvarchar](50) NULL,
	[Keywords] [nvarchar](200) NULL,
	[TongGioKhoaHoc] [float] NULL,
	[HoanThanh] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaGTrinh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaoTrinh_TacGia]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaoTrinh_TacGia](
	[MaGTrinh] [varchar](20) NOT NULL,
	[MaCB] [varchar](20) NOT NULL,
	[VaiTro] [nvarchar](50) NULL,
	[TyLeDongGop] [float] NULL,
 CONSTRAINT [PK_GiaoTrinh_TacGia] PRIMARY KEY CLUSTERED 
(
	[MaGTrinh] ASC,
	[MaCB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Gio_GiaoTrinh]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Gio_GiaoTrinh] AS
SELECT 
    tg.MaCB,
    SUM(gt.TongGioKhoaHoc * tg.TyLeDongGop / 100) AS GioGiaoTrinh
FROM GiaoTrinh_TacGia tg
JOIN GiaoTrinh gt ON tg.MaGTrinh = gt.MaGTrinh
JOIN GiaoTrinhHoanThanh vht ON gt.MaGTrinh = vht.MaGTrinh
GROUP BY tg.MaCB;
GO
/****** Object:  Table [dbo].[CongBoKhoaHoc]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CongBoKhoaHoc](
	[MaCBKH] [int] IDENTITY(1,1) NOT NULL,
	[TieuDe] [nvarchar](300) NULL,
	[LoaiHinh] [nvarchar](50) NULL,
	[LinhVuc] [nvarchar](200) NULL,
	[TuKhoa] [nvarchar](200) NULL,
	[NamCongBo] [int] NULL,
	[NgayXuatBan] [date] NULL,
	[NgonNgu] [nvarchar](50) NULL,
	[GioKhoaHoc] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCBKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CongBo_TacGia]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CongBo_TacGia](
	[MaCBKH] [int] NOT NULL,
	[MaCB] [varchar](20) NOT NULL,
	[TyLeDongGop] [float] NULL,
 CONSTRAINT [PK_CongBo_TacGia] PRIMARY KEY CLUSTERED 
(
	[MaCBKH] ASC,
	[MaCB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Gio_CongBoKH]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Gio_CongBoKH] AS
SELECT 
    tg.MaCB,
    SUM(cb.GioKhoaHoc * tg.TyLeDongGop / 100) AS GioCongBo
FROM CongBo_TacGia tg
JOIN CongBoKhoaHoc cb ON tg.MaCBKH = cb.MaCBKH
GROUP BY tg.MaCB;
GO
/****** Object:  Table [dbo].[SangChe]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SangChe](
	[MaSC] [varchar](50) NOT NULL,
	[TenSangChe] [nvarchar](200) NULL,
	[SoDonDangKy] [nvarchar](50) NULL,
	[NgayNop] [date] NULL,
	[CoQuanNop] [nvarchar](100) NULL,
	[TinhTrang] [nvarchar](50) NULL,
	[NgayCap] [date] NULL,
	[NgayCongBo] [date] NULL,
	[NgayBatDau] [date] NULL,
	[NgayKetThuc] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaSC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SangChe_TacGia]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SangChe_TacGia](
	[MaSC] [varchar](50) NOT NULL,
	[MaCB] [varchar](20) NOT NULL,
	[VaiTro] [nvarchar](50) NULL,
 CONSTRAINT [PK_SangChe_TacGia] PRIMARY KEY CLUSTERED 
(
	[MaSC] ASC,
	[MaCB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Gio_SangChe]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Gio_SangChe] AS
SELECT 
    tg.MaCB,
    COUNT(*) * 100 AS GioSangChe
FROM SangChe_TacGia tg
JOIN SangChe sc ON tg.MaSC = sc.MaSC
WHERE sc.TinhTrang = N'Chấp nhận'
GROUP BY tg.MaCB;
GO
/****** Object:  Table [dbo].[GiangVien]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiangVien](
	[MaCB] [varchar](20) NOT NULL,
	[HoTen] [nvarchar](100) NOT NULL,
	[GioiTinh] [nvarchar](10) NULL,
	[NgaySinh] [date] NULL,
	[QueQuan] [nvarchar](100) NULL,
	[DanToc] [nvarchar](50) NULL,
	[TonGiao] [nvarchar](50) NULL,
	[SDT] [varchar](15) NULL,
	[TrinhDoChuyenMon] [nvarchar](100) NULL,
	[TrinhDoLLCT] [nvarchar](100) NULL,
	[DonViCongTac] [nvarchar](100) NOT NULL,
	[ChucVu] [nvarchar](100) NULL,
	[CapBac] [nvarchar](50) NULL,
	[HeSoLuong] [decimal](5, 2) NULL,
	[ChucDanh] [nvarchar](100) NULL,
	[HocHam] [nvarchar](50) NULL,
	[HocVi] [nvarchar](50) NULL,
	[LinhVucChuyenMon] [nvarchar](200) NULL,
	[NamGanNhatDayGioi] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeTaiNCKH]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeTaiNCKH](
	[MaDT] [varchar](20) NOT NULL,
	[TenDeTai] [nvarchar](300) NOT NULL,
	[DonViChuTri] [nvarchar](200) NULL,
	[ThangDangKy] [int] NULL,
	[NamDangKy] [int] NULL,
	[CapNhiemVu] [nvarchar](100) NULL,
	[ThoiGianThucHien] [int] NULL,
	[SoQuyetDinh] [nvarchar](50) NULL,
	[TongGioKhoaHoc] [float] NULL,
	[ChuNhiemDT] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[MaDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ThanhVienDeTai]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhVienDeTai](
	[MaDT] [varchar](20) NOT NULL,
	[MaCB] [varchar](20) NOT NULL,
	[TyLeDongGop] [float] NULL,
 CONSTRAINT [PK_ThanhVienDeTai] PRIMARY KEY CLUSTERED 
(
	[MaDT] ASC,
	[MaCB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Gio_DeTai]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- 18. View tổng hợp giờ
CREATE VIEW [dbo].[Gio_DeTai] AS
SELECT 
    tv.MaCB,
    SUM(dt.TongGioKhoaHoc * tv.TyLeDongGop / 100) AS GioDeTai
FROM ThanhVienDeTai tv
JOIN DeTaiNCKH dt ON tv.MaDT = dt.MaDT
GROUP BY tv.MaCB;
GO
/****** Object:  View [dbo].[TongHopGioNCKH]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TongHopGioNCKH] AS
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
/****** Object:  Table [dbo].[NhiemVuNCKH]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhiemVuNCKH](
	[MaNhiemVu] [int] IDENTITY(1,1) NOT NULL,
	[MaDT] [varchar](20) NOT NULL,
	[NoiDung] [nvarchar](300) NULL,
	[KetQuaCanDat] [nvarchar](300) NULL,
	[ThoiGianBatDau] [date] NOT NULL,
	[ThoiHanHoanThanh] [date] NOT NULL,
	[TinhTrang] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaNhiemVu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GiaHanNhiemVu]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GiaHanNhiemVu](
	[MaNhiemVu] [int] NOT NULL,
	[LanGiaHan] [int] NOT NULL,
	[LyDo] [nvarchar](300) NULL,
	[ThoiGianGiaHan] [date] NULL,
 CONSTRAINT [PK_GiaHanNhiemVu] PRIMARY KEY CLUSTERED 
(
	[MaNhiemVu] ASC,
	[LanGiaHan] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GiaHanQuaHan]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GiaHanQuaHan] AS
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
/****** Object:  Table [dbo].[ThanhVienHoiDong]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ThanhVienHoiDong](
	[MaHoiDong] [int] NOT NULL,
	[MaCB] [varchar](20) NOT NULL,
	[ChucDanhHoiDong] [nvarchar](50) NULL,
 CONSTRAINT [PK_TVHD] PRIMARY KEY CLUSTERED 
(
	[MaHoiDong] ASC,
	[MaCB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[HoiDongHopLe]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[HoiDongHopLe] AS
SELECT MaHoiDong
FROM ThanhVienHoiDong tv
JOIN GiangVien gv ON tv.MaCB = gv.MaCB
GROUP BY MaHoiDong
HAVING 
    COUNT(*) = 5
    AND SUM(CASE WHEN gv.HocHam LIKE N'PGS%' THEN 1 ELSE 0 END) >= 2
    AND SUM(CASE WHEN gv.ChucVu IN (N'Cục trưởng', N'Phó Cục trưởng') THEN 1 ELSE 0 END) >= 1
    AND MIN(CASE WHEN gv.HocVi = N'Tiến sĩ' THEN 1 ELSE 0 END) = 1;
GO
/****** Object:  Table [dbo].[HoiDong]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoiDong](
	[MaHoiDong] [varchar](20) NOT NULL,
	[MaDT] [varchar](20) NOT NULL,
	[TenNhiemVu] [nvarchar](200) NULL,
	[NgayDanhGia] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MaHoiDong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhGiaHoiDong]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhGiaHoiDong](
	[MaHoiDong] [int] NOT NULL,
	[MaCB] [varchar](20) NOT NULL,
	[KetQua] [nvarchar](20) NULL,
 CONSTRAINT [PK_DanhGiaHoiDong] PRIMARY KEY CLUSTERED 
(
	[MaHoiDong] ASC,
	[MaCB] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[KetQuaDanhGia]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[KetQuaDanhGia] AS
SELECT 
    hd.MaDT,
    hd.TenNhiemVu,
    COUNT(*) AS TongPhieu,
    SUM(CASE WHEN dg.KetQua = N'Thông qua' THEN 1 ELSE 0 END) AS SoPhieuThongQua
FROM DanhGiaHoiDong dg
JOIN HoiDong hd ON dg.MaHoiDong = hd.MaHoiDong
GROUP BY hd.MaDT, hd.TenNhiemVu
HAVING SUM(CASE WHEN dg.KetQua = N'Thông qua' THEN 1 ELSE 0 END) >= 3;
GO
/****** Object:  View [dbo].[GioGTrinhHopLe]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GioGTrinhHopLe] AS
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
/****** Object:  Table [dbo].[HoiNghi]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HoiNghi](
	[MaCBKH] [int] NOT NULL,
	[TenHoiNghi] [nvarchar](200) NULL,
	[DiaDiem] [nvarchar](200) NULL,
	[NhaXuatBan] [nvarchar](200) NULL,
	[ISBN] [nvarchar](50) NULL,
	[DOI] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCBKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TapChi]    Script Date: 12/17/2025 8:50:20 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TapChi](
	[MaCBKH] [int] NOT NULL,
	[TenTapChi] [nvarchar](200) NULL,
	[ISSN] [nvarchar](50) NULL,
	[XepHang] [nvarchar](50) NULL,
	[DOI] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MaCBKH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GiaoTrinh_TienDo] ADD  DEFAULT ((0)) FOR [GiaoNhiemVu]
GO
ALTER TABLE [dbo].[GiaoTrinh_TienDo] ADD  DEFAULT ((0)) FOR [BienSoanNoiDung]
GO
ALTER TABLE [dbo].[GiaoTrinh_TienDo] ADD  DEFAULT ((0)) FOR [ThamDinhNoiDung]
GO
ALTER TABLE [dbo].[GiaoTrinh_TienDo] ADD  DEFAULT ((0)) FOR [GopYPhanBien]
GO
ALTER TABLE [dbo].[GiaoTrinh_TienDo] ADD  DEFAULT ((0)) FOR [SuaNoiDungThamDinh]
GO
ALTER TABLE [dbo].[GiaoTrinh_TienDo] ADD  DEFAULT ((0)) FOR [InAnPhatHanh]
GO
ALTER TABLE [dbo].[CongBo_TacGia]  WITH CHECK ADD  CONSTRAINT [FK_TGCB_CongBo] FOREIGN KEY([MaCBKH])
REFERENCES [dbo].[CongBoKhoaHoc] ([MaCBKH])
GO
ALTER TABLE [dbo].[CongBo_TacGia] CHECK CONSTRAINT [FK_TGCB_CongBo]
GO
ALTER TABLE [dbo].[CongBo_TacGia]  WITH CHECK ADD  CONSTRAINT [FK_TGCB_GiangVien] FOREIGN KEY([MaCB])
REFERENCES [dbo].[GiangVien] ([MaCB])
GO
ALTER TABLE [dbo].[CongBo_TacGia] CHECK CONSTRAINT [FK_TGCB_GiangVien]
GO
ALTER TABLE [dbo].[DanhGiaHoiDong]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_GiangVien] FOREIGN KEY([MaCB])
REFERENCES [dbo].[GiangVien] ([MaCB])
GO
ALTER TABLE [dbo].[DanhGiaHoiDong] CHECK CONSTRAINT [FK_DanhGia_GiangVien]
GO
ALTER TABLE [dbo].[DanhGiaHoiDong]  WITH CHECK ADD  CONSTRAINT [FK_DanhGia_HoiDong] FOREIGN KEY([MaHoiDong])
REFERENCES [dbo].[HoiDong] ([MaHoiDong])
GO
ALTER TABLE [dbo].[DanhGiaHoiDong] CHECK CONSTRAINT [FK_DanhGia_HoiDong]
GO
ALTER TABLE [dbo].[DeTaiNCKH]  WITH CHECK ADD  CONSTRAINT [FK_DeTai_GiangVien] FOREIGN KEY([ChuNhiemDT])
REFERENCES [dbo].[GiangVien] ([MaCB])
GO
ALTER TABLE [dbo].[DeTaiNCKH] CHECK CONSTRAINT [FK_DeTai_GiangVien]
GO
ALTER TABLE [dbo].[GiaHanNhiemVu]  WITH CHECK ADD  CONSTRAINT [FK_GiaHan_NhiemVu] FOREIGN KEY([MaNhiemVu])
REFERENCES [dbo].[NhiemVuNCKH] ([MaNhiemVu])
GO
ALTER TABLE [dbo].[GiaHanNhiemVu] CHECK CONSTRAINT [FK_GiaHan_NhiemVu]
GO
ALTER TABLE [dbo].[GiaoTrinh_TacGia]  WITH CHECK ADD  CONSTRAINT [FK_GT_TG_GiangVien] FOREIGN KEY([MaCB])
REFERENCES [dbo].[GiangVien] ([MaCB])
GO
ALTER TABLE [dbo].[GiaoTrinh_TacGia] CHECK CONSTRAINT [FK_GT_TG_GiangVien]
GO
ALTER TABLE [dbo].[GiaoTrinh_TacGia]  WITH CHECK ADD  CONSTRAINT [FK_GT_TG_GTrinh] FOREIGN KEY([MaGTrinh])
REFERENCES [dbo].[GiaoTrinh] ([MaGTrinh])
GO
ALTER TABLE [dbo].[GiaoTrinh_TacGia] CHECK CONSTRAINT [FK_GT_TG_GTrinh]
GO
ALTER TABLE [dbo].[GiaoTrinh_TienDo]  WITH CHECK ADD  CONSTRAINT [FK_GiaoTrinh_TienDo] FOREIGN KEY([MaGTrinh])
REFERENCES [dbo].[GiaoTrinh] ([MaGTrinh])
GO
ALTER TABLE [dbo].[GiaoTrinh_TienDo] CHECK CONSTRAINT [FK_GiaoTrinh_TienDo]
GO
ALTER TABLE [dbo].[HoiDong]  WITH CHECK ADD  CONSTRAINT [FK_HoiDong_DeTai] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DeTaiNCKH] ([MaDT])
GO
ALTER TABLE [dbo].[HoiDong] CHECK CONSTRAINT [FK_HoiDong_DeTai]
GO
ALTER TABLE [dbo].[HoiNghi]  WITH CHECK ADD  CONSTRAINT [FK_HN_CongBo] FOREIGN KEY([MaCBKH])
REFERENCES [dbo].[CongBoKhoaHoc] ([MaCBKH])
GO
ALTER TABLE [dbo].[HoiNghi] CHECK CONSTRAINT [FK_HN_CongBo]
GO
ALTER TABLE [dbo].[NhiemVuNCKH]  WITH CHECK ADD  CONSTRAINT [FK_NhiemVu_DeTai] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DeTaiNCKH] ([MaDT])
GO
ALTER TABLE [dbo].[NhiemVuNCKH] CHECK CONSTRAINT [FK_NhiemVu_DeTai]
GO
ALTER TABLE [dbo].[SangChe_TacGia]  WITH CHECK ADD  CONSTRAINT [FK_SCTG_GiangVien] FOREIGN KEY([MaCB])
REFERENCES [dbo].[GiangVien] ([MaCB])
GO
ALTER TABLE [dbo].[SangChe_TacGia] CHECK CONSTRAINT [FK_SCTG_GiangVien]
GO
ALTER TABLE [dbo].[SangChe_TacGia]  WITH CHECK ADD  CONSTRAINT [FK_SCTG_SangChe] FOREIGN KEY([MaSC])
REFERENCES [dbo].[SangChe] ([MaSC])
GO
ALTER TABLE [dbo].[SangChe_TacGia] CHECK CONSTRAINT [FK_SCTG_SangChe]
GO
ALTER TABLE [dbo].[TapChi]  WITH CHECK ADD  CONSTRAINT [FK_TC_CongBo] FOREIGN KEY([MaCBKH])
REFERENCES [dbo].[CongBoKhoaHoc] ([MaCBKH])
GO
ALTER TABLE [dbo].[TapChi] CHECK CONSTRAINT [FK_TC_CongBo]
GO
ALTER TABLE [dbo].[ThanhVienDeTai]  WITH CHECK ADD  CONSTRAINT [FK_TVDT_DeTai] FOREIGN KEY([MaDT])
REFERENCES [dbo].[DeTaiNCKH] ([MaDT])
GO
ALTER TABLE [dbo].[ThanhVienDeTai] CHECK CONSTRAINT [FK_TVDT_DeTai]
GO
ALTER TABLE [dbo].[ThanhVienDeTai]  WITH CHECK ADD  CONSTRAINT [FK_TVDT_GiangVien] FOREIGN KEY([MaCB])
REFERENCES [dbo].[GiangVien] ([MaCB])
GO
ALTER TABLE [dbo].[ThanhVienDeTai] CHECK CONSTRAINT [FK_TVDT_GiangVien]
GO
ALTER TABLE [dbo].[ThanhVienHoiDong]  WITH CHECK ADD  CONSTRAINT [FK_TVHD_GiangVien] FOREIGN KEY([MaCB])
REFERENCES [dbo].[GiangVien] ([MaCB])
GO
ALTER TABLE [dbo].[ThanhVienHoiDong] CHECK CONSTRAINT [FK_TVHD_GiangVien]
GO
ALTER TABLE [dbo].[ThanhVienHoiDong]  WITH CHECK ADD  CONSTRAINT [FK_TVHD_HoiDong] FOREIGN KEY([MaHoiDong])
REFERENCES [dbo].[HoiDong] ([MaHoiDong])
GO
ALTER TABLE [dbo].[ThanhVienHoiDong] CHECK CONSTRAINT [FK_TVHD_HoiDong]
GO
ALTER TABLE [dbo].[CongBo_TacGia]  WITH CHECK ADD CHECK  (([TyLeDongGop]>(0) AND [TyLeDongGop]<=(100)))
GO
ALTER TABLE [dbo].[DanhGiaHoiDong]  WITH CHECK ADD CHECK  (([KetQua]=N'Không thông qua' OR [KetQua]=N'Thông qua'))
GO
ALTER TABLE [dbo].[DeTaiNCKH]  WITH CHECK ADD CHECK  (([NamDangKy]>=(2000)))
GO
ALTER TABLE [dbo].[DeTaiNCKH]  WITH CHECK ADD CHECK  (([ThangDangKy]>=(1) AND [ThangDangKy]<=(12)))
GO
ALTER TABLE [dbo].[DeTaiNCKH]  WITH CHECK ADD CHECK  (([ThoiGianThucHien]>(0)))
GO
ALTER TABLE [dbo].[DeTaiNCKH]  WITH CHECK ADD CHECK  (([TongGioKhoaHoc]>=(0)))
GO
ALTER TABLE [dbo].[GiaHanNhiemVu]  WITH CHECK ADD CHECK  (([LanGiaHan]>(0)))
GO
ALTER TABLE [dbo].[GiangVien]  WITH CHECK ADD CHECK  (([GioiTinh]=N'Nữ' OR [GioiTinh]=N'Nam'))
GO
ALTER TABLE [dbo].[GiangVien]  WITH CHECK ADD CHECK  (([NamGanNhatDayGioi]>=(1900)))
GO
ALTER TABLE [dbo].[GiaoTrinh_TacGia]  WITH CHECK ADD CHECK  (([TyLeDongGop]>(0) AND [TyLeDongGop]<=(100)))
GO
ALTER TABLE [dbo].[NhiemVuNCKH]  WITH CHECK ADD CHECK  (([TinhTrang]=N'Quá hạn' OR [TinhTrang]=N'Đang thực hiện' OR [TinhTrang]=N'Chưa triển khai'))
GO
ALTER TABLE [dbo].[NhiemVuNCKH]  WITH CHECK ADD  CONSTRAINT [CK_NhiemVu_Ngay] CHECK  (([ThoiHanHoanThanh]>=[ThoiGianBatDau]))
GO
ALTER TABLE [dbo].[NhiemVuNCKH] CHECK CONSTRAINT [CK_NhiemVu_Ngay]
GO
ALTER TABLE [dbo].[SangChe]  WITH CHECK ADD CHECK  (([TinhTrang]=N'Từ chối' OR [TinhTrang]=N'Chấp nhận' OR [TinhTrang]=N'Chờ duyệt'))
GO
ALTER TABLE [dbo].[ThanhVienDeTai]  WITH CHECK ADD CHECK  (([TyLeDongGop]>(0) AND [TyLeDongGop]<=(100)))
GO
USE [master]
GO
ALTER DATABASE [NigeriaBasketballAssociation] SET  READ_WRITE 
GO

