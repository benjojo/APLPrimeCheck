T ← 'eimnoprt '
E ← 4 1 4 9 5 6 0 3 1
X ← 2 5 8 2 6 7 2 2 1
T ← T[E⌈X]

∇K
I ← ⎕
l ←(((2=+⌿0=(⍳X)∘.|⍳X)/⍳X←I)∊I)[⍒(((2=+⌿0=(⍳X)∘.|⍳X)/⍳X←I)∊I)][1^(~0)]
(4×l)↓T
∇

K