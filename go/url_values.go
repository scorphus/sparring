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
	fmt.Printf("q(%s):\n%s\n", q, q.Encode())
	fmt.Printf("\nq_(%s):\n%s\n", q_, q_.Encode())
	setSpecialParams(q_)
	fmt.Printf("\nq(%s):\n%s\n", q, q.Encode())
	fmt.Printf("\nq_(%s):\n%s\n", q_, q_.Encode())
	q1 := setDefaultParams(nil)
	fmt.Printf("\nq1(%s):\n%s\n", q1, q1.Encode())
	q2 := setSpecialParams(nil)
	fmt.Printf("\nq2(%s):\n%s\n", q2, q2.Encode())
	fmt.Printf("q2[toto]: %s\n", q2["toto"][0])
	q3 := url.Values{}
	q3, _ = url.ParseQuery("foo=var&foo=1&foo=baz")
	fmt.Printf("\nq3(%s):\n%s\n", q3, q3.Encode())
	foo, ok := q3["foo"]
	if ok {
		fmt.Printf("q3[foo]: %s\n", foo[0])
	}
}
