CREATE OR ALTER PROCEDURE [dbo].[sp_FiltrarEmpleados]
    @infiltro VARCHAR(64)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @TranEmpezada BIT = 0;

    BEGIN TRY
        IF @@TRANCOUNT = 0
        BEGIN
            BEGIN TRANSACTION;
            SET @TranEmpezada = 1;
        END
        SELECT ID, Nombre, Salario FROM [dbo].[Empleado] E 
        WHERE E.Nombre LIKE '%' + @infiltro + '%';
        IF @TranEmpezada = 1
        BEGIN
            COMMIT TRANSACTION;
        END
    END TRY

    BEGIN CATCH
        IF @TranEmpezada = 1
        BEGIN
            ROLLBACK TRANSACTION;
        END
        SELECT
            500 AS codigo,
            'Error inesperado.' AS mensaje;
    END CATCH;
END;
GO