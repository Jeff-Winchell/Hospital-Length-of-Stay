Set ANSI_Warnings Off
Create Table #Correlation (Column_Name SysName,R_Squared Real Not Null,Nullable Bit Not Null)
Declare Correlation Cursor For Select Column_Name,Case When Is_Nullable='NO' Then '0' Else '1' End From Hospital.Information_Schema.Columns 
	Where Columns.DATA_TYPE In ('Float','Int','SmallInt','TinyInt','Bit') And Column_Name Not In ('encounterid','ActualLOS','AdjustedLOS','EncounterId','proceduresCount')
	Order By COLUMNS.ORDINAL_POSITION
Declare @Column_Name SysName,@Is_Nullable Char(1)
Open Correlation
Fetch Next From Correlation Into @Column_Name,@Is_Nullable
While @@FETCH_STATUS=0 Begin
	Exec('Insert Into #Correlation Select '''+@Column_Name+''',Square((Avg(Cast('+@Column_Name+' As Float)* actualLOS) - (Avg(Cast('+@Column_Name+' As Float)) * Avg(actualLOS))) / (StDevP(Cast('+@Column_Name+' As Float)) * StDevP(actualLOS))),'+@Is_Nullable+' From Hospital..Patient_Summary Where '+@Column_Name+' Is Not Null')
	Fetch Next From Correlation Into @Column_Name,@Is_Nullable
End
Close Correlation
Deallocate Correlation
Select * From #Correlation order by 2 desc
Drop Table #Correlation