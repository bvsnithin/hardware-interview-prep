# Opening files in perl
# The syntax for opening a file is open(file_handle, mode, file_name);
# 1) file_handle: Or also called the file pointer. Used to associate with the file
# 2) mode: Read/Write/Append mode. 
#           "<" : read mode, 
#           ">" : write mode, If the file does not exist, a new file is created. 
#                             If the file already exists, the content of the file is wipe out
#           ">>": append mode    
# After opening the file, we need to close it explicity as a good practice (In python we use "with" to do this for us). 
# Python syntax for comparison -> with open("name of file","mode") as file_handle:
# Perl syntax -> open(file handle,"mode","file name")
# If we don't then perl wil close it for us!   


my $fh;  #File Handle Created
open($fh,"<","../practice_files/log_file.txt") or die $!;
print"Opened successfully\n";
close($fh);

# die -> This will terminate the execution when there is an exception and prints the errors message
# $! -> This is the variable that contains the error message(! is the special variable name for error message)
# Instead of $!, we can also write our own error message
# open($fh,"<","../practice_files/log_file__.txt") or die "File is not found";
# print"Opened successfully\n";
# close($fh);


#Read
open($fh, "<", "../practice_files/log_file.txt") or die $!;

# The diamond operator <> is used to read from a filehandle. 
# <$fh> reads one line at a time from the file until it reaches the end (EOF).
while(<$fh>){
    print $_."\n";
}

close($fh);

my $fh1;
open($fh1,"<","../practice_files/inventory.csv") or die $!;

while(<$fh1>){
    print $_."\n"; 
}

close($fh1)