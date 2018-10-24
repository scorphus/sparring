package validate

import (
	"fmt"
	"reflect"
)

type Validator func(v interface{}, i ValidateInfo) error

type ValidateInfo struct {
	Type    string
	MinLen  int
	Options []string
	Tags    []string
}

func Validate(v interface{}) error {
	i := ValidateInfo{Type: "text", MinLen: 2}
	return validate(v, i)
}

func extractFields(v interface{}) {
	vv := reflect.ValueOf(v)
	vt := reflect.ValueOf(v).Type()
	for i := 0; i < vv.NumField(); i++ {
		f := vt.Field(i)
		fmt.Printf("==>%v\n", f.Name)
		// el := reflect.Indirect(f.Elem().FieldByName(f.Name))
		// fmt.Printf("%v\n", el.Kind())
		// switch el.Kind() {
		// case reflect.Slice:
		// 	if el.CanInterface() {
		// 		if slice, ok := el.Interface().([]string); ok {
		// 			for i, input := range slice {
		// 				tags := v.Tag.Get("conform")
		// 				slice[i] = transformString(input, tags)
		// 			}
		// 		} else {
		// 			val := reflect.ValueOf(el.Interface())
		// 			for i := 0; i < val.Len(); i++ {
		// 				Strings(val.Index(i).Addr().Interface())
		// 			}
		// 		}
		// 	}
		// case reflect.Struct:
		// 	if el.CanAddr() && el.Addr().CanInterface() {
		// 		Strings(el.Addr().Interface())
		// 	}
		// case reflect.String:
		// 	if el.CanSet() {
		// 		tags := v.Tag.Get("conform")
		// 		input := el.String()
		// 		el.SetString(transformString(input, tags))
		// 	}
		// }
	}
}

func validate(v interface{}, i ValidateInfo) error {
	extractFields(v)
	return fmt.Errorf("FirstName should contain at least 2 characters")
}
