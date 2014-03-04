*Expected Input / Command Line*

produced by a shell-one-liner such as this pipe:

(Enter SQL command interactively)


    sqsh  -Smysrv  -Uguest -Psecrit -Dtempdb -m vert  -i <<SQL  | perl   ./out-gridview.pl
    sp_who;
    SQL

or 

(Enter SQL command from file)

    sqsh  -Smysrv  -Uguest -Psecrit -Dtempdb -m vert  -i in-out-files/test-1.sql | perl   ./out-gridview.pl
    
*Hint*

sqsh is a free, open source command-line client for Sybase and Microsoft SQL Server databases.
Usage of the -m vert option is critical here. This returns data aligned in a key:value manner. 
This script will turn the key:value pairs into a grid view control.


*Expected output (only 2 records shown)*


    spid:       61
    ecid:       0
    status:     sleeping                      
    loginame:   knb
    hostname:   h7                                                                                                           blk:        0    
    dbname:     master
    cmd:        AWAITING COMMAND
    request_id: 0
    
    spid:       62
    ecid:       0
    status:     runnable                      
    loginame:   knb
    hostname:   h3                                                                                                      
    blk:        0    
    dbname:     tempdb
    cmd:        SELECT          
    request_id: 0

*Result*

![](https://github.com/knbknb/out_gridview_pl/raw/master/pics/out-gridview-screenshot-cropped.png)
