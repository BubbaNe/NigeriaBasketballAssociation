USE NigeriaBasketballAssociation;
GO

CREATE TABLE DangNhap (
    DangNhapID INT IDENTITY PRIMARY KEY,
    TenDangNhap VARCHAR(100) NOT NULL UNIQUE,
    MatKhau VARCHAR(255) NOT NULL,    --co the hash truoc de tang bao mat
);
GO
