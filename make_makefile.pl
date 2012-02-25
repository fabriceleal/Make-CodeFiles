#!/usr/bin/perl -w

# Generates Makefiles

my $finalname = "Makefile";
my $text = "
# .o files to be linked
SRC=
# Final executable name
OUTPUT=

all : \$(SRC)
	\$(CC) -o \$(OUTPUT) \$(SRC)

clean :
	rm -f *.o \$(OUTPUT)
";

# If file exist, throw error ...
(-e "$finalname") and die ("File $finalname already exists!");

open (myfs, ">$finalname") or die ("Could not generate file $finalname, $!"));


print myfs $text ;

# Close files 
close myfs ;

