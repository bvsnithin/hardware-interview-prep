# For Loop
# In perl we can use for loop with the following; "for", "foreach", "for(initialization;condition;increment)" type syntax

#Iterating the list using for
print("Simple for loop: ");
@list1 = (1..10);
for (@list1){
    print "$_ "; #$_ is the special variable that hold the value per iteration
}
print"\n";

#Iterating using a variable pointer instead of $_
print("for with a variable: ");
for my $i (@list1){
    print "$i ";
}
print"\n";

#foreach usage
print("foreach: ");
foreach (@list1){
    print $_." ";
}
print "\n";

#Iterating over hash
%score = (
    "Ben" => 10,
    "Nigel" => 22,
    "Tennisolr" => 15,
    "Elliot" => 12,
    "Younus" => 18
);

for(keys %score){
    print "$_ scored: $score{$_}";
    print"\n";
}
print"\n";

foreach my $key (keys %score){
    print $key." ";
}
print "\n";

#Using c/c++ style for loop
for(my $i = 0;$i < $#list1;$i=$i+1){
    print "$list1[$i] ";
}
print"\n";