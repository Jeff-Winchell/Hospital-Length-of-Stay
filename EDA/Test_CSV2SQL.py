import os
os.system('SQLCMD -E -i "Test_DDL.SQL"')
with open(os.path.dirname(os.getcwd())+'\data.csv') as Input:
    with open('converted_data.csv','w') as Output:
        Output.write(Input.read().replace('True','1').replace('False','0'))
os.system('osql -E -n -Q "Bulk Insert Hospital.dbo.Patient_Summary From \''+os.getcwd()+'\\'+'converted_data.csv\' With (MaxErrors=1,DataFileType=\'char\',FirstRow=2,RowTerminator=\'0x0a\',FieldTerminator=\',\')"')
os.remove('converted_data.csv')