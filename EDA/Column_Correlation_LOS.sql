Set ANSI_Warnings Off
Create Table #Correlation (Column_Name SysName,R_Squared Real Not Null,Nullable Bit Not Null)
Declare Correlation Cursor For Select Column_Name,Case When Is_Nullable='NO' Then '0' Else '1' End From Hospital.Information_Schema.Columns Where Column_Name Not In ('encounterid') And Columns.DATA_TYPE In ('Float','Int','TinyInt') 
	Order By COLUMNS.ORDINAL_POSITION
Declare @Column_Name SysName,@Is_Nullable Char(1)
Open Correlation
Fetch Next From Correlation Into @Column_Name,@Is_Nullable
While @@FETCH_STATUS=0 Begin
	--(Avg(Cast(measurementA As Real)* actualLOS) - (Avg(Cast(measurementA As Real)) * Avg(actualLOS))) / (StDevP(Cast(measurementA As Real)) * StDevP(actualLOS)) 
	Exec('Insert Into #Correlation Select '''+@Column_Name+''',Square((Avg(Cast('+@Column_Name+' As Float)* actualLOS) - (Avg(Cast('+@Column_Name+' As Float)) * Avg(actualLOS))) / (StDevP(Cast('+@Column_Name+' As Float)) * StDevP(actualLOS))),'+@Is_Nullable+' From Hospital..Patient_Summary')
	Fetch Next From Correlation Into @Column_Name,@Is_Nullable
End
Close Correlation
Deallocate Correlation
Select * From #Correlation
Drop Table #Correlation