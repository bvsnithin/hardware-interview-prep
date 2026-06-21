#!/usr/bin/perl    
# This is called as a shebang. This tells linux/unix systems that this file needs to be run with perl interpreter located at usr/bin/perl
# If it is not present, then we need to explicitly run with the perl command. Example perl hello_world.pl
# Note that this shebang is onlt needed if you want to run the script with "./basics.pl". You are fine to run without it using "perl basics.pl"

# use strict;
# use warninig;

#These two are commonly seen in scripts and placed at the top of the script. 

#use strict; => This enfources strict programming rules. 

#Without use strict:
# $foo = 42;  
# print $foo;
# This works without any problem. But if use strict is used, then perl gives an error because in perl strict programming, variables must be declared first before using. 
# Example: my $foo; $foo = 8; print $foo

#use warnings; => This tells Perl to display warnings about suspicious code that might still run but could indicate a bug.

my $foo;
$foo = 8;
print "$foo\n";

print "Hello World\n";

#====Variables=====
#Scalars start with $
my $name = "John Cena";
#Arrays start with $
my @list = (1,2,4,3,21);
#Key-Value pairs start with $ 
my %hash = (key1 => "val1", key2 => "val2");

#=====Arrays and Hashes=====
my @arr = (10,20,40);
push(@arr,50);             #Appends to the array. Use push(Array_Name, value);
my $length = scalar(@arr); #This gives the array length
print "Length of arr: $length\n";

