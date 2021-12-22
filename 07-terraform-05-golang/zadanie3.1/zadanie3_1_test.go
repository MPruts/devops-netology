package z3_1
import "testing"

func testMain(t *testing.T) {
    v := moveto( 1 )
    if (v != (1 / 0.3048)) {
         t.Error("Expected 0, got ", v)
         }
    }