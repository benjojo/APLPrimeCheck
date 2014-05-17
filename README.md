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


###Moving on

First we start off a new function by asking `∇K` This makes a var that will be turned into a function until `∇` is inputted again.

`I ← ⎕` takes a number in from stdin and puts it in I.

`l ←(((X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I)∊I)[⍒(((X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I)∊I)][1^(~E[7])]` is a complex one but can be simplified a great deal by notcing the repitition.

`(X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I` is a function that will get a list of all primes leading up to the number in `I`.

When `I` is 7 we can get the following vars from it.

```
   I ← 7

   (X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I
2 3 5 7
```

2,3,5,7 is prime.

Expanding this more we can notice `(((X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I)∊I)`

Or in a more easy to read fasion: `(@WhatWeSaw@)∊I).

This does a check to see if any of them match what put in I.

```
   I ← 7
   test ← ((X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I)
   test
2 3 5 7
   test ∊ I
0 0 0 1
```

As can see all of the older vars have been turned into 0's *apart* from the 7 that we put in, that was turned into 1.

Next we take the output as an array and try and get a element from it.

`l ←(((@WhatWeHaveSeen@)[⍒(((X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I)∊I)][1^(~E[7])]`

As you can note. We have used the same function twice. So I will remove that to make it clear.

`l ←(((@WhatWeHaveSeen@)[⍒(@WhatWeSaw@)][1^(~E[7])]`

The `⍒` function will sort everything to make sure that the highest value element is at the front.

```
   l ←(((X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I)∊I)[⍒(((X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I)∊I)]
   l
1 0 0 0
```

The last part is `[1^(~E[7])]` at the end. You can proabbly guess at this point what this does.

`E[7]` is part of the jumble array, the 7th element is 0.

The `~` function inverts. so 0 becomes 1.

We can now simply put this as `[1^1]`, Unsuprisingly this is 1.

### To print Prime or not to.

To pick if we sould print `prime` or `not prime` is handled by `(E[1]×l)↓T[E⌈X]`

We have already gone though what T[E⌈X] does.

```
   T[E⌈X]
not prime
```

the `↓` function will take one off the front, for example.

```
   1↓T[E⌈X]
ot prime
```

In this, the amount to chop off the front is dependant on what `(E[1]×l)` returnes.

We can simpily this to `4×l`. We can already look at see that `l` is the output (1 or 0).

If it is 1 then that is multiplied by 4 and thus becomes 4.

```
   4↓T[E⌈X]
prime
```

or if it isnt because it is a multiplication by 1 it becomes:

```
   0↓T[E⌈X]
not prime
```

Then we end the function using `∇`.

All of that function was stored in `K`.
So then we just call K. Then all of the code we have written above runs.

It's worth noting that there isnt a exit issue, this is because `)OFF` (the command to exit) as not working in my tests, So I left it out since the rules didnt say it has to exit.

### But wait you didnt explain the huge long function. Well now that you have asked...

Before in this we simplyed the long line into a basic compenent:

`((X[1]=+⌿E[7]=(⍳J)∘.|⍳J)/⍳J←I)`

First we are going to remove the number fill ins, Like the ones I did last time.

`((2=+⌿0=(⍳J)∘.|⍳J)/⍳J←I)`

Now we have a zero and two in the mix.

We know that `I` at the end means the number that the user had inputed.

This function works by assuming that is number A is multipul of another number (B) then the remainder of A divided by B is zero.

The function `|` gives us remainders.

```
   7|10
3
```

We can do this on a array/vector of numbers. So a better way to explain this function is:

```
   3|1 2 3 4 5 6 7 8 9 10
1 2 0 1 2 0 1 2 0 1
```

=== To be finished ===

