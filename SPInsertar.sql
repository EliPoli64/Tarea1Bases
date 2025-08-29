CREATE OR ALTER PROCEDURE [dbo].[sp_InsertarEmpleado]
    @innombre VARCHAR(64),
    @insalario MONEY
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM dbo.Empleado WHERE Nombre = @innombre)
    BEGIN
        SELECT
            500 AS codigo,
            'El usuario ya existe.' AS mensaje;
        RETURN;
    END
    BEGIN TRANSACTION;

    BEGIN TRY
        INSERT INTO dbo.Empleado (Nombre, Salario)
        VALUES (@innombre, @insalario);

        COMMIT TRANSACTION;

        SELECT
            200 AS Codigo,
            'Empleado insertado exitosamente.' AS Mensaje;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        SELECT
            500 AS Codigo,
            'Error inesperado.' AS Mensaje;
    END CATCH;
END;

GO