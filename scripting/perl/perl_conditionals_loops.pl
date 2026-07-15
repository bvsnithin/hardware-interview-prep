#If statement - works just like it does in any other programming language
my $name = "Jason";
if($name == "Jason"){
    print "Name is correct\n";
}else {
    print "Not Jason\n";
}
#The above is one way of using if with print statements. A print statement can also come before if
$name = "Nyra";
print("Name is Nyra\n") if($name == "Nyra");

#Unlike python (elif) or java/c++(else if), perl uses elsif for an else if construct

my $num = 1;
if($num == 2){
    print "Not 1\n";
}
elsif($num == 1){
    print "It is 1!\n";
}
else{
    print "Not 2 or 1\n";
}


#Loops. Perl has for, while, and do. But it also has until and do until
# For loop
@list3 = (1..9); #Creates a list of elements from 1 to 9
for (@list3){
    print $_."\n";  #$_ is a special variable for loops
}

# Create a multiplication table for 5
for(@list3){
    print ($_ * 5);
    print":::";
}
print"\n";