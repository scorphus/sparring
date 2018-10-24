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

func TestValidateFirstName(t *testing.T) {
	u := User{FirstName: "J"}
	err := validate.Validate(u)
	if err == nil {
		t.Fatal("Validate should err!")
	}
	expectedError := "FirstName should contain at least 2 characters"
	if err.Error() != expectedError {
		t.Fatalf("Unexpected error!\n\tWant: %s\n\tHave: %s", expectedError, err)
	}
}

func TestValidateLastName(t *testing.T) {
	u := User{LastName: "D"}
	err := validate.Validate(u)
	if err == nil {
		t.Fatal("Validate should err!")
	}
	expectedError := "LastName should contain at least 2 characters"
	if err.Error() != expectedError {
		t.Fatalf("Unexpected error!\n\tWant: %s\n\tHave: %s", expectedError, err)
	}
}
