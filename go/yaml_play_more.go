package main

import (
	"menteslibres.net/gosexy/yaml"
)

func main() {
	settings, err := yaml.Open("sample.yaml")
	if err != nil {
		log.Printf("Could not open YAML file: %s", err.Error())
	}
	s := to.String(settings.Get("test_string"))
	fmt.Printf("%s", s)
}
