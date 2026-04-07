package main

import (
	"flag"
	"os"
	"testing"
)

func TestMain(m *testing.M) {
	flag.Parse()
	os.Exit(m.Run())
}

// --- correctness tests ---

func TestWithoutMake(t *testing.T) {
	s := withoutMake(*N)
	if len(s) != *N {
		t.Errorf("expected len %d, got %d", *N, len(s))
	}
	for i, v := range s {
		if v != i {
			t.Errorf("expected s[%d]=%d, got %d", i, i, v)
			break
		}
	}
}

func TestWithMake(t *testing.T) {
	s := withMake(*N)
	if len(s) != *N {
		t.Errorf("expected len %d, got %d", *N, len(s))
	}
	if cap(s) != *N {
		t.Errorf("expected cap %d, got %d", *N, cap(s))
	}
	for i, v := range s {
		if v != i {
			t.Errorf("expected s[%d]=%d, got %d", i, i, v)
			break
		}
	}
}

// --- benchmarks ---
// run with:
//   go test -bench=. -benchmem -count=6 | tee bench.txt
//   go install golang.org/x/perf/cmd/benchstat@latest
//   benchstat bench.txt

func BenchmarkWithoutMake(b *testing.B) {
	var s []int
	for b.Loop() {
		s = withoutMake(*N)
	}
	_ = s
}

func BenchmarkWithMake(b *testing.B) {
	var s []int
	for b.Loop() {
		s = withMake(*N)
	}
	_ = s
}