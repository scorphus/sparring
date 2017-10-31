package main

import (
	"fmt"
	"log"
	"math"
	"os"
	"strconv"
)

const PerPageDefault int = 10
const PerPageSSIDefault int = 30

var maxPosts int = 100

func init() {
	if maxPostsEnv, err := strconv.Atoi(os.Getenv("MAXPOSTS")); err == nil {
		maxPosts = maxPostsEnv
	}
}

type createPostFunc func(int, bool) []string

func memoize(f createPostFunc) createPostFunc {
	cache := make(map[int][]string)
	return func(page int, isAutomatic bool) []string {
		if posts, ok := cache[page]; ok {
			return posts
		}
		cache[page] = f(page, isAutomatic)
		return cache[page]
	}
}

func calcPerPage(page int, isAutomatic bool) int {
	if page > 1 || isAutomatic {
		return PerPageDefault
	}
	return PerPageSSIDefault
}

func calcRealPage(cutRange, page int, isAutomatic bool) int {
	perPage := calcPerPage(page, isAutomatic)
	maxPos := cutRange + page
	return int(math.Ceil(float64(maxPos) / float64(perPage)))
}

func calcRange(cutRange, page int, isAutomatic bool) (int, int) {
	perPage := calcPerPage(page, isAutomatic)
	additionalPosts := perPage/PerPageDefault - 1
	start := 0
	end := (cutRange+page-1)%perPage + 1 + additionalPosts
	if page > 1 {
		start = end - 1
	}
	return start, end
}

func createPosts(page int, isAutomatic bool) []string {
	perPage := calcPerPage(page, isAutomatic)
	posts := make([]string, 0)
	for i := 0; i < perPage; i++ {
		n := (page-1)*perPage + i + 1
		if n > maxPosts {
			break
		}
		fuck := fmt.Sprintf("Post %03d", n)
		posts = append(posts, fuck)
	}
	return posts
}

func genPages(cutRange, pageStart, pageEnd int, isAutomatic bool) {
	createPostsCache := memoize(createPosts)
	for page := pageStart; page <= pageEnd; page++ {
		realPage := calcRealPage(cutRange, page, isAutomatic)
		posts := createPostsCache(realPage, isAutomatic)
		start, end := calcRange(cutRange, page, isAutomatic)
		fmt.Printf("[%02d:%02d:%02d] - ", cutRange, start, end)
		if start > len(posts) {
			fmt.Printf("Page %02d: []\n", page)
		} else if end > len(posts) {
			fmt.Printf("Page %02d: %s\n", page, posts[start:])
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
	isAutomatic, _ := strconv.Atoi(args[3])
	genPages(cutRange, pageStart, pageEnd, isAutomatic == 1)
}
