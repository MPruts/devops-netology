package z3_1

import "fmt"

func moveto (x float64) float64 {
    return (x * (1 / 0.3048))
}

func main() {
    fmt.Print("Enter a number: ")
    var input float64
    fmt.Scanf("%f", &input)
    v := moveto(input)
    fmt.Println(v)
}