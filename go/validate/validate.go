package validate

import (
	"fmt"
	"reflect"
	"strconv"
)

type Validator func(v interface{}, i ValidateInfo) error

type ValidateInfo struct {
	Type    string
	MinLen  int
	Options []string
	Tags    []string
}

func Validate(v interface{}) error {
	i := extractValidateInfo(v)
	return validate(v, i)
}

func extractValidateInfo(v interface{}) map[string]ValidateInfo {
	vv := reflect.ValueOf(v)
	vt := reflect.ValueOf(v).Type()
	vis := make(map[string]ValidateInfo, vv.NumField())
	for i := 0; i < vv.NumField(); i++ {
		vtf := vt.Field(i)
		tag := vtf.Tag
		validateType, ok := tag.Lookup("validateType")
		if !ok {
			continue
		}
		vi := ValidateInfo{Type: validateType}
		if minLen, ok := tag.Lookup("validateMinLen"); ok {
			vi.MinLen, _ = strconv.Atoi(minLen)
		}
		vis[vtf.Name] = vi
	}
	return vis
}

func validate(v interface{}, vi map[string]ValidateInfo) error {
	vv := reflect.ValueOf(v)
	vt := reflect.ValueOf(v).Type()
	for i := 0; i < vv.NumField(); i++ {
		vvf := vv.Field(i)
		vtf := vt.Field(i)

	}
	return fmt.Errorf("FirstName should contain at least 2 characters")
}
