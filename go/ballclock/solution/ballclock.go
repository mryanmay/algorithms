/*
* Accepts integers (between 27 and 127) from stdin. After input is gathered, the appropriate output is generated.
* Flag of -time can be used to display rough time benchmarking.
*
*/
package main

import (
	"bufio"
	"os"
	"strconv"
	"fmt"
	"strings"
	"clock"
	"time"
	"io"
	"flag"
)

const MIN = 27
const MAX = 127

func main() {
	includeTime := flag.Bool("time", false, "Use to include elapsed time")
	flag.Parse()

	var ballQtys []int
	r := bufio.NewReader(os.Stdin)

	println("Enter Number Of Balls:")

	for {
		line, lineErr := r.ReadString('\n')

		// Allow file to be passed in and accept EOF as a "0"
		if lineErr == io.EOF {
			line = strings.TrimSpace(line)
			ballQty, err := strconv.ParseInt(line,10,0)
			if err != nil {
				fmt.Printf("Cannot Parse Input: %s\n", line)
				break
			}
			if ballQty < MIN || ballQty > MAX {
				println("Invalid Input: Number must be in the range of 27-127")
				break
			}
			ballQtys = append(ballQtys, int(ballQty))
			break
		}

		if lineErr != nil {
			// Handle Error
			fmt.Printf("Error Processing Input: %v\n", lineErr)
			os.Exit(1)
		}

		line = strings.TrimSpace(line)
		ballQty, err := strconv.ParseInt(line,10,0)

		if err != nil {
			// Skip over whitespace, etc.
			fmt.Printf("Cannot Parse Input: %s\n", line)
			continue
		}

		if ballQty == 0 {
			break
		}

		//Check minimum/maximum number of balls
		if ballQty < MIN || ballQty > MAX {
			println("Invalid Input: Number must be in the range of 27-127")
			continue
		}

		ballQtys = append(ballQtys, int(ballQty))
	}

	allStart := time.Now()
	for i := 0; i < len(ballQtys); i++ {
		start := time.Now()
		newOrder := clock.Simulate(ballQtys[i])
		lcm := getLCM(newOrder)
		elapsed := time.Since(start)

		if *includeTime {
			fmt.Printf("%d balls cycle after %d days (%s)\n", ballQtys[i], (lcm/2), elapsed)
		} else {
			fmt.Printf("%d balls cycle after %d days\n", ballQtys[i], (lcm/2))
		}
	}
	allElapsed := time.Since(allStart)
	if *includeTime {
		fmt.Printf("Total Runtime (Including Output): %s", allElapsed)
	}
}

func getLCM(order []int) int {
	usedBalls := make([]int, len(order))
	var patternLengths []int
	var usedOrder []int

	for i:=0; i < len(order); {
		next := findNext(usedBalls)
		counter := 0
		for {
			if usedBalls[next] == 1 {
				break
			}
			usedOrder = append(usedOrder,next)
			i++
			usedBalls[next] = 1
			counter ++
			next = order[next]
		}
		if counter > 1 {
			patternLengths = append(patternLengths, counter)
		}
	}

	// Start with 1 as the first to check with
	lcmX := 1
	for _, length := range patternLengths {
		lcmX = lcm(lcmX, length)
	}
	return lcmX
}

func findNext(balls []int) int {
	for i:=0; i < len(balls); i++ {
		if balls[i] == 0 {
			return i
		}
	}
	return -1
}

func lcm(x, y int) int {
	return x * y / gcd(x, y)
}

func gcd(x, y int) int {
	for y != 0 {
		x, y = y, x%y
	}
	return x
}