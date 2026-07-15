print ":::::: Perl Basics - Variables ::::::\n";

#Scalars
#Declare variables in perl using the "my" keyword and use a $ for scalar values. 
my $a = 10;
my $b = 20;
my $sum = a+b; #This would add to become 0 because we did not use $ infront of a and b.
print "sum = $sum\n";
$sum = $a+$b;
print "sum = $sum\n"; #This will print 30 as we properly accessed a and b in the previous step

#Strings
my $name = "Justin";
print "$name\n";

#Arrays
#For arrays we use "@"
my @names = ("Brad","Mike","Harry");
my @ages = (13,21,23);

#We can access the array elements with indexing
#First element
print "Age of $names[0] is $ages[0] years\n";

#Hashes - They are unorderded collection of key value pairs
my %grades = (
    'Brad',22,
    'Mike',25,
    'Harry',41
);

#Hashes can also be created with =>
my %capitals = (
    "USA" => "Washington D.C.",
    "Mexico" => "Mexico City",
    "Norway" => "Oslo"
);
print "Harry's grades = $grades{'Harry'}\n";

print "Capital of USA is $capitals{'USA'}\n";

# :::::::::: String :::::::::::::
#Use substring to index in perl because str[index] doesn't work for string
my $str = "It is a very good day indeeed!";
my $substr = substr($str,0,2);
print "Substring: $substr \n";

#Concatenate two string using the "." operator
my $str1 = "Hello World ";
my $str2 = "Hola Mundo";
my $str3 = $str1.$str2;
print $str3."\n";      #Notice that we can also use the "." operator to add the new line delimeter to print on the new line

#Increment operator on the string - Using the increment operator will work on the last character on the string. 
# If it's a, then it changes to b and if its a digit, it increments by 1
$a = "abc";
$a++;
print $a."\n";  #This becomes abd

$b = "abz";
$b++;
print $b."\n";  #This becomes aba because z wraps back to a

my $c = "1239";
$c++;
print $c."\n"; #Prints 1240

#To multiply a string, we can use "x" operator
my $d = "avc" x 2;
print $d."\n";

my $e = "12" x 2;
print $e."\n";

$a = "z";
$a++;
print $a."\n"; #This prints aa

#List
#You can access list elements by using indexing. 
@names = ("Brad","Mike","Harry","Ole","Julia","Kellie","Moriane");
print "$names[0] is the first name \n$names[-1] is the last name\n";

@new_names = @names[1,3,5];
print "$new_names[0] -- $new_names[1] -- $new_names[2] \n";

#If we want values from n->m, where m could be n+5 or n+10, we can do the following
my @list1 = (1..10); #Now list1 stores 1 to 10 values in the list
print (@list1);
print ("\n");

#Same with strings
my @list2=(aa...az);
print(@list2);
print("\n");

#Cool thing - if you want the list elements to be printed with spaces, then use print("@list1");
print ("@list1");
print ("\n");

print("@list2");
print("\n");

#To print the length of the list, use the # operator
print "Length of the list1 is: ";
print($#list1);
print "\n";


#Sorting - to sort a list in ascending order just use the "sort" keyword
#For descending order sort ue
@sorted_names = sort @names;
@reverse_sorted_names = reverse sort @names;
print("@sorted_names");
print("\n");
print("@reverse_sorted_names");
print "\n";

#To merge elements of array, we can use join(<separator> <name of the array>). This returns a string
my @sentence = ("this","is","perl");
my $sentence_string = join(" ", @sentence);
print $sentence_string."\n";

$sentence_string = join("::","hello","hola","bonjour","ni hao");
print $sentence_string."\n";