package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
)

const perPage int = 30

var maxPosts int = 100

func init() {
	if maxPostsEnv, err := strconv.Atoi(os.Getenv("MAXPOSTS")); err == nil {
		maxPosts = maxPostsEnv
	}
}

type createPostFunc func(int) []string

func memoize(f createPostFunc) createPostFunc {
	cache := make(map[int][]string)
	return func(page int) []string {
		if posts, ok := cache[page]; ok {
			return posts
		}
		cache[page] = f(page)
		return cache[page]
	}
}

func calcRealPage(cutRange, page int) int {
	maxPos := cutRange + page + 2
	return int(math.Ceil(float64(maxPos) / float64(perPage)))
}

func calcRange(cutRange, page int) (int, int) {
	start := 0
	end := (cutRange+page+1)%perPage + 1
	if page > 1 {
		start = end - 1
	}
	return start, end
}

func createPosts(page int) []string {
	posts := make([]string, 0)
	for i := 0; i < perPage; i++ {
		n := (page-1)*perPage + i + 1
		if n > maxPosts {
			break
		}
		fuck := fmt.Sprintf("Posts%03d", n)
		posts = append(posts, fuck)
	}
	return posts
}

func genPages(cutRange, pageStart, pageEnd int) {
	createPostsCache := memoize(createPosts)
	for page := pageStart; page <= pageEnd; page++ {
		realPage := calcRealPage(cutRange, page)
		posts := createPostsCache(realPage)
		start, end := calcRange(cutRange, page)
		if end > len(posts) {
			fmt.Printf("Page %02d: []\n", page)
		} else {
			fmt.Printf("Page %02d: %s\n", page, posts[start:end])
		}
	}
}

func main() {
	args := os.Args[1:]
	if len(args) == 0 {
		log.Fatal("Bad arguments!")
	}
	cutRange, _ := strconv.Atoi(args[0])
	pageStart, _ := strconv.Atoi(args[1])
	pageEnd, _ := strconv.Atoi(args[2])
	genPages(cutRange, pageStart, pageEnd)
}
