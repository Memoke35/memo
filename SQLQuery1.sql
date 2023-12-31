USE [kaydetme ]
GO
/****** Object:  Trigger [dbo].[urun_ekleme_silme_guncelleme_trigger]    Script Date: 16.08.2023 16:52:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TRIGGER [dbo].[urun_ekleme_silme_guncelleme_trigger]
ON [dbo].[urunler]
AFTER INSERT, UPDATE, DELETE 
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO urunlerkopya 
        SELECT d.*
        FROM deleted d;
    END
    ELSE IF EXISTS (SELECT * FROM inserted)
    BEGIN
        INSERT INTO urunlerkopya 
        SELECT i.*
        FROM inserted i;
    END;
END;
