package validate

import (
	"fmt"
)

type Validator func(v interface{}, i ValidateInfo) error

type ValidateInfo struct {
	Type    string
	MinLen  int
	Options []string
	Tags    []string
}

func Validate(v interface{}) error {
	return fmt.Errorf("FirstName should contain at least 2 characters")
}
