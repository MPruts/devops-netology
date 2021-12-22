package z3_2
import "testing"

func testMain(t *testing.T) {
    v := FindMin( 3,9 )
    if v != 3 {
         t.Error("Expected 3, got ", v)
         }
    }