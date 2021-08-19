Declare @SQL VARCHAR(MAX)
Select @SQL = COALESCE(@SQL+', ' ,'') + Column_Name From Hospital.INFORMATION_SCHEMA.Columns Where Is_Nullable='NO' And Column_Name Not In ('encounterid','adjustedlos','procedurescount','ActualLOS') Order By Ordinal_Position
Set @SQL='Set NoCount On; Select '+@SQL+',Cast(Round(ActualLOS,0) As TinyInt) As ActualLOS From Hospital..Patient_Summary Where EncounterId Not In (Select EncounterId From Hospital..Patient_Summary Group By EncounterId Having Count(*)>1)'
Exec(@SQL)