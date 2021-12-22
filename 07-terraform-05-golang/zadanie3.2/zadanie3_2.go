package z3_2

import "fmt"

func FindMin (a, b int) int {
    if a > b {
        return b
        }else{
        return a
        }
}

func main() {
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    min := x[0]
    for i := range x {
        min =FindMin(min,x[i])
    }

    fmt.Println(x)
    fmt.Println(min)
}