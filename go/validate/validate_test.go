package validate_test

import (
	"testing"
	"validate"
)

type User struct {
	FirstName      string `json:"first_name" validateType:"text" validateMinLen:"2"`
	LastName       string `json:"last_name" validateType:"text" validateMinLen:"2"`
	Email          string `json:"email" validateType:"email"`
	CountryCode    string `json:"country_code" validateType:"item" validateOptions:"BR,DE,MX,UK,USA"`
	SocialSecurity string `json:"ssn" validateType:"specific" validateTags:"ssn"`
}

func TestValidateName(t *testing.T) {
	u := User{FirstName: "J"}
	err := validate.Validate(u)
	if err == nil {
		t.Fatal("Validate should err!")
	}
	if err.Error() != "FirstName should contain at least 2 characters" {
		t.Fatalf("Unexpected error: %s", err)
	}
}
