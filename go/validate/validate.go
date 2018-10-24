package validate

type Validator func(v interface{}, i ValidateInfo) error

type ValidateInfo struct {
	Type    string
	MinLen  int
	Options []string
	Tags    []string
}

func Validate(v interface{}) error {
	return nil
}
