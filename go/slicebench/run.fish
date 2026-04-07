# init module if needed
go mod init slicebench

# run tests
go test ./...

# run benchmarks with memory stats, 6 rounds for benchstat
go test -bench=. -benchmem -count=6 | tee bench.txt

# force a specific GOMAXPROCS
# GOMAXPROCS=1 go test -bench=. -benchmem -count=6

# or via the flag
# go test -bench=. -benchmem -count=6 -cpu=1,2,4,8

# install benchstat and get the pretty report
go install golang.org/x/perf/cmd/benchstat@latest
benchstat bench.txt

# **benchstat** output will look something like:
#
# goos: darwin
# goarch: arm64
# pkg: slicebench
# cpu: Apple M5
#                │  bench.txt  │
#                │   sec/op    │
# WithoutMake-10   224.3n ± 2%
# WithMake-10      85.38n ± 1%
# geomean          138.4n
#
#                │  bench.txt   │
#                │     B/op     │
# WithoutMake-10   1.992Ki ± 0%
# WithMake-10        896.0 ± 0%
# geomean          1.320Ki
#
#                │ bench.txt  │
#                │ allocs/op  │
# WithoutMake-10   8.000 ± 0%
# WithMake-10      1.000 ± 0%
# geomean          2.828
