! Copyright (c) 2007, 2008 Aaron Schaefer, Alexander Solovyov, Vishal Talwar.
! See http://factorcode.org/license.txt for BSD license.
USING: kernel math sequences project-euler.common ;
IN: project-euler.002

! http://projecteuler.net/index.php?section=problems&id=2

! DESCRIPTION
! -----------

! Each new term in the Fibonacci sequence is generated by adding the previous
! two terms. By starting with 1 and 2, the first 10 terms will be:

!     1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...

! Find the sum of all the even-valued terms in the sequence which do not exceed
! four million.


! SOLUTION
! --------

PRIVATE<

: (fib-upto) ( seq n limit -- seq )
    2dup <= [ [ suffix! dup 2 tail* sum ] dip (fib-upto) ] [ 2drop ] if ;

PRIVATE>

: fib-upto ( n -- seq )
    V{ 0 } clone 1 rot (fib-upto) ;

: euler002 ( -- answer )
    4,000,000 fib-upto [ even? ] filter sum ;

! [ euler002 ] 100 ave-time
! 0 ms ave run time - 0.22 SD (100 trials)


! ALTERNATE SOLUTIONS
! -------------------

: fib-upto* ( n -- seq )
    0 1 [ pick over >= ] [ [ nip ] 2keep + dup ] produce [ 3drop ] dip
    but-last-slice { 0 1 } prepend ;

: euler002a ( -- answer )
    4,000,000 fib-upto* [ even? ] filter sum ;

! [ euler002a ] 100 ave-time
! 0 ms ave run time - 0.2 SD (100 trials)


PRIVATE<

: next-fibs ( x y -- y x+y )
    [ nip ] [ + ] 2bi ;

: ?retotal ( total fib- fib+ -- retotal fib- fib+ )
    dup even? [ [ nip + ] 2keep ] when ;

: (sum-even-fibs-below) ( partial fib- fib+ max -- total )
    2dup > [
        3drop
    ] [
        [ ?retotal next-fibs ] dip (sum-even-fibs-below)
    ] if ;

PRIVATE>

: sum-even-fibs-below ( max -- sum )
    [ 0 0 1 ] dip (sum-even-fibs-below) ;

: euler002b ( -- answer )
    4000000 sum-even-fibs-below ;

! [ euler002b ] 100 ave-time
! 0 ms ave run time - 0.0 SD (100 trials)

SOLUTION: euler002b
