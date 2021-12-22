package z3_3
import "testing"

func testMain(t *testing.T) {
    v := Del3( 3 )
    if v != 0 {
         t.Error("Expected 0, got ", v)
         }
    }