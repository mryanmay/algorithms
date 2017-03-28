/*
* This contains a clock simulation that takes a number of balls and simulates a single 12 hour cycle
*/
package clock

import (
//	"fmt"
)

func Simulate(ballQty int) []int {
	var one_hour []int
	var five_minute []int
	var one_minute []int
	var currentBall int
	currentOrder := make([]int, ballQty)

	for i := range currentOrder {
		currentOrder[i] = i
	}

	// Do this for every min in 12 hour period
 	for i := 0; i < 720; i++ {
		currentBall = currentOrder[0]

		currentOrder = currentOrder[1:]

		// Add up to 4 balls to the minute rack
		if len(one_minute) < 4 {
			one_minute = append(one_minute, currentBall)
		} else {
			// Reverse one_minute[] and return to those balls to the queue (popping might be better)
			
			for j, k := 0, len(one_minute)-1; j < k; j, k = j+1, k-1 {
				one_minute[j], one_minute[k] = one_minute[k], one_minute[j]
			}

			currentOrder = append(currentOrder,one_minute...)
			one_minute = one_minute[:0]
			if len(five_minute) < 11 {
				five_minute = append(five_minute, currentBall)
			} else {
				for j, k := 0, len(five_minute)-1; j < k; j, k = j+1, k-1 {
					five_minute[j], five_minute[k] = five_minute[k], five_minute[j]
				}
				currentOrder = append(currentOrder,five_minute...)
				five_minute = five_minute[:0]
				if len(one_hour) < 11 {
					one_hour = append(one_hour, currentBall)
				} else {
					for j, k := 0, len(one_hour)-1; j < k; j, k = j+1, k-1 {
						one_hour[j], one_hour[k] = one_hour[k], one_hour[j]
					}
					currentOrder = append(currentOrder,one_hour...)
					one_hour = one_hour[:0]
					currentOrder = append(currentOrder,currentBall)
				}
			}
		}
	}

	return currentOrder
}