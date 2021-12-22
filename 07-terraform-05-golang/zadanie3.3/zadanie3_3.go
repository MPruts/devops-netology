package z3_3

import "fmt"

func Del3 (k int) int {
    return k % 3
}

func main() {
    for i := 1; i<101; i++ {
        if ( Del3( i ) == 0 ) {
            fmt.Println(i)
        }
    }
}