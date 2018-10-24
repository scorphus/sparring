package validate_test

import (
	"testing"
	"validate"
)

type User struct {
	Firstname      string `json:"first_name" validateType:"text" validateMinLen:"2"`
	Lastname       string `json:"last_name" validateType:"text" validateMinLen:"2"`
	Email          string `json:"email" validateType:"email"`
	CountryCode    string `json:"country_code" validateType:"item" validateOptions:"BR,DE,MX,UK,USA"`
	SocialSecurity string `json:"ssn" validateType:"specific" validateTags:"ssn"`
}

func TestValidateName(t *testing.T) {
	u := User{Firstname: "J"}
	err := validate.Validate(u)
	if err == nil {
		t.Fatal("Validate should err!")
	}
}
