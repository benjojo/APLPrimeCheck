APLPrimeCheck
=============

My entry to the Facepunch Obfuscation Challenge ( [Link](http://facepunch.com/showthread.php?t=1392931) )

```
$ echo "777" | apl --noColor -f prime.apl --noCIN --noCONT --silent
⎕:
not prime
```

```
$ echo "7" | apl --noColor -f prime.apl --noCIN --noCONT --silent
⎕:
prime
```

How it works
===

So there are 5 major vars,

I l T E X and K

The first three parts are the fairly simple parts of the code:

###Hiding the strings

```
T ← 'eimnoprt '
E ← 4 1 4 9 5 6 0 3 1
X ← 2 5 8 2 6 7 2 2 1
```

So here we are seeing `T` being set to a string. this string is "not prime" alphabetically sorted.

The `E` and `X` vars are a mask that are used to put `T` in the correct order.

This is done by running `⌈` over it, that goes though E and X and picks the biggest var of each, so `E⌈X` ==
`4 5 8 9 6 7 2 3 1`

In that order when you run `T[E⌈X]` it will equal `not prime`
