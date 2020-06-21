#!/usr/bin/env python

# n = input ("Enter a number to calculate integer sqrt: ")
# print(n)

n = 35

a = 0
while (a + 1)**2 <= n:
	print(a*a , n, (a + 1)**2, a)
	a = a + 1

print(a*a , n, (a + 1)**2, a)
print(n, a)
