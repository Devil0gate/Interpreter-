This is a simple interpreter designed as a prototype application,

It has four different types of functionalities,

	1, addition and subtraction
	2, let, defines function variables
	3, boolean evaluation
	4, conditional check

in order to run the program with this interpreter, you will need to use test cases, which are grammarly 
validated already.

test file:

int add ( int a , int b ) = a + b 
int letin ( int a ) = let b = 10 in add ( a , b ) 
int equal ( int a , int b ) = if a == b then letin ( a ) else 1 
int main ( int input ) = equal ( input , 2 )

with this test file written in txt file format, the interpreter will be able to run properly.