package main

import "fmt"
import "time"

type ResultError struct {
	res Result
	err error
}

type Result struct {
	ErrorName          string
	NumberOfOccurances int64
}

func getError(errorId string) (r ResultError) {
	errors := map[string]Result{
		"1001": {"a is undefined", 245},
		"2001": {"Cannot read property 'data' of undefined", 10352},
	}
	outputChannel := make(chan ResultError)
	go func() {
		time.Sleep(time.Second)
		if r, ok := errors[errorId]; ok {
			outputChannel <- ResultError{res: r, err: nil}
		} else {
			outputChannel <- ResultError{
				res: Result{},
				err: fmt.Errorf("getErrorName: %s errorId not found", errorId),
			}
			return // must return in case of error
		}
		fmt.Println("! This line shouldn't be executed in case of an error !")
	}()

	return <-outputChannel
}

func main() {
	fmt.Println("Using separate channels for error and result")
	errorIds := []string{
		"1001",
		"2001",
		"3001",
	}
	for _, e := range errorIds {
		r := getError(e)
		if r.err != nil {
			fmt.Printf("Failed: %s\n", r.err.Error())
			continue
		}
		fmt.Printf(
			"> Name: \"%s\" has occurred \"%d\" times\n",
			r.res.ErrorName,
			r.res.NumberOfOccurances,
		)
	}
}
