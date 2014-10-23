IF OBJECT_ID ('spDev_ScriptDiagrams', 'P') IS NOT NULL
BEGIN
	DROP PROCEDURE spDev_ScriptDiagrams;
END

IF OBJECT_ID ('Tool_VarbinaryToVarcharHex', 'FN') IS NOT NULL
BEGIN
	DROP FUNCTION Tool_VarbinaryToVarcharHex;
END
