

-- KeepInTouch
-- CREATING SCALAR FUNCTION
------------------------------------
-- Calculate age using year difference

CREATE FUNCTION [sf_CalculateAge]
(
	@Year INT -->> TAKE INPUT
)

RETURNS INT
AS
BEGIN

	------------------------------------------
	DECLARE @Age INT;

	SET @Age = YEAR(GETDATE()) - @Year;

	IF (@Age IS NULL) SET @Age = -1;

	RETURN @Age;
	------------------------------------------

END
