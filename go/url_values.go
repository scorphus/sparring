package main

import (
	"fmt"
	"net/url"
)

func setDefaultParams(q url.Values) url.Values {
	if q == nil {
		q = url.Values{}
	}
	q.Set("xzz", "XZZ")
	q.Set("foo[bar]", "1")
	q.Set("spam[eggs]", "baz")
	return q
}

func setSpecialParams(q url.Values) url.Values {
	if q == nil {
		q = url.Values{}
	}
	q.Set("toto", "titi")
	q.Set("bidule[truc]", "machin")
	return q
}

func main() {
	q := url.Values{}
	q_ := setDefaultParams(q)
	fmt.Printf("q(%s):\n%s\n\n", q, q.Encode())
	fmt.Printf("q_(%s):\n%s\n\n", q_, q_.Encode())
	setSpecialParams(q_)
	fmt.Printf("q(%s):\n%s\n\n", q, q.Encode())
	fmt.Printf("q_(%s):\n%s\n\n", q_, q_.Encode())
	q1 := setDefaultParams(nil)
	fmt.Printf("q1(%s):\n%s\n\n", q1, q1.Encode())
	q2 := setSpecialParams(nil)
	fmt.Printf("q2(%s):\n%s\n\n", q2, q2.Encode())
}
