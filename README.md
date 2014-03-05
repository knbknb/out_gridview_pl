<h3>README.md</h3>

Working on Linux, I have a SQL client tool, [sqsh](www.sqsh.org) that generates database-data in paragraph mode. For sql output with many columns, I prefer the output to be displayed this way. This is okay for many use cases I have on the command line. And grepping things out goes a long way; I can do a lot with grep.

Sometimes though I'd like to send this output via pipe to a GUI app. What I'd like to send the data to is something like [Microsoft PowerShell's out-gridview cmdlet](http://technet.microsoft.com/en-us/library/ff730930.aspx).

I want a read-only data-grid widget window. 



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

I have written my own quick and dirty solution here. The script works and generates output that looks like this:

How can I improve the sorting commands? Clicking on a column header button to sort does not work. It generates errors such as:

*Result*

![](https://github.com/knbknb/out_gridview_pl/raw/master/pics/out-gridview-screenshot-cropped.png)
