package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"net/http"
	"net/http/httputil"
	"net/url"
	"os"
)

type transport struct {
	http.RoundTripper
}

func (t *transport) RoundTrip(req *http.Request) (*http.Response, error) {
	req.Host = os.Getenv("HOST")
	resp, err := t.RoundTripper.RoundTrip(req)
	if err != nil {
		msg := fmt.Sprintf("ERROR: %q", err)
		log.Print(msg)
		operr, _ := err.(*net.OpError)
		msg = fmt.Sprintf("ERROR: %q", operr)
		log.Print(msg)
		body := ioutil.NopCloser(bytes.NewReader([]byte(msg)))
		return &http.Response{
			Body:       body,
			StatusCode: 500,
		}, nil
	}
	log.Printf(
		"%s %s %d %d",
		req.Method,
		req.RequestURI,
		resp.StatusCode,
		resp.ContentLength,
	)
	resp.Header.Del("x-xss-protection")
	resp.Header.Del("x-content-type-options")
	resp.Header.Del("x-frame-options")
	return resp, nil
}

func main() {
	host := os.Getenv("HOST")
	port := os.Getenv("PORT")
	log.Printf("Proxying %s on port %s...", host, port)
	target := &url.URL{Scheme: "http", Host: host}
	reverseProxy := httputil.NewSingleHostReverseProxy(target)
	reverseProxy.Transport = &transport{http.DefaultTransport}
	http.Handle("/", reverseProxy)
	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}
