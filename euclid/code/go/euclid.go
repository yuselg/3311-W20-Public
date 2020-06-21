// go run euclid.go
package main

import (
	"fmt"
)

// greatest common divisor (GCD) via Euclidean algorithm
func gcd(m, n int) int {
	x := m
	y := n
	for x != y {
		if x < y {
			y = y - x
		} else {
			x = x - y
		}
	}
	return x
}

func main() {
	fmt.Println(gcd( 111, 259))
	// fmt.Println(gcd(-111, 259))
}