Set ANSI_Warnings Off
Create Table #MINMAX (Column_Name SysName,Min_Value Real Not Null,Max_Value Real Not Null,Nullable Bit Not Null)
Declare MinMax Cursor For Select Column_Name,Case When Is_Nullable='NO' Then '0' Else '1' End From Hospital.Information_Schema.Columns Where Column_Name Not In ('encounterid') And Columns.DATA_TYPE In ('Float','Int','TinyInt') 
	Order By COLUMNS.ORDINAL_POSITION
Declare @Column_Name SysName,@Is_Nullable Char(1)
Open MinMax
Fetch Next From MinMax Into @Column_Name,@Is_Nullable
While @@FETCH_STATUS=0 Begin
	Exec('Insert Into #MinMax Select '''+@Column_Name+''',Min('+@Column_Name+'),Max('+@Column_Name+'),'+@Is_Nullable+' From Hospital..Patient_Summary')
	Fetch Next From MinMax Into @Column_Name,@Is_Nullable
End
Close MinMax
Deallocate MinMax
Select * From #MinMax
Drop Table #MinMax

Create Table #Values (Column_Name SysName,Column_Value VarChar(8000))
Declare ColValues Cursor For Select Column_Name From Hospital.Information_Schema.Columns Where Columns.DATA_TYPE In ('VarChar','Char','NVarChar','Char') Order By COLUMNS.ORDINAL_POSITION
Open ColValues
Fetch Next From ColValues Into @Column_Name
While @@FETCH_STATUS=0 Begin
	Exec('Insert Into #Values Select Distinct '''+@Column_Name+''','+@Column_Name+' From Hospital..Patient_Summary Where '+@Column_Name+' Is Not Null')
	Fetch Next From ColValues Into @Column_Name
End
Close ColValues
Deallocate ColValues
Select * From #Values Order By 1,2
Drop Table #Values