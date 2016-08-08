package main

import (
	"archive/tar"
	"fmt"
	"io"
	"io/ioutil"
	"os"
	"path/filepath"
)

func handleError(err error) {
	if err != nil {
		fmt.Fprintln(os.Stderr, "err:", err.Error())
	}
}

type fileInfo struct {
	fileFullPath string
	info         os.FileInfo
}

func enumDir(p string) <-chan fileInfo {
	c := make(chan fileInfo)
	go func() {
		filepath.Walk(p, func(f string, i os.FileInfo, err error) error {
			if f == p || i.IsDir() {
				return nil
			}
			c <- fileInfo{f, i}
			return nil
		})
		close(c)
	}()
	return c
}

func tarReader(p string) {
	f, err := os.OpenFile(p, os.O_RDONLY, os.ModePerm)
	if err != nil {
		handleError(err)
		return
	}
	defer f.Close()
	tarR := tar.NewReader(f)
	for {
		h, err := tarR.Next()
		if err != nil {
			break
		}
		fmt.Fprintln(os.Stdout, h.Name)
	}
}

func tarAll(p, dest string) (tarFile string, err error) {
	f, err := ioutil.TempFile(dest, "tar")
	if err != nil {
		handleError(err)
		return
	}
	defer f.Close()
	dir := enumDir(p)
	tarW := tar.NewWriter(f)
	defer tarW.Close()
	defer tarW.Flush()
	for v := range dir {
		var name string
		name, err = filepath.Rel(p, v.fileFullPath)
		if err != nil {
			return
		}
		header := &tar.Header{
			Name:     name,
			Mode:     int64(os.ModePerm),
			Size:     v.info.Size(),
			ModTime:  v.info.ModTime(),
			Typeflag: tar.TypeReg,
		}
		tarW.WriteHeader(header)
		var tmpF *os.File
		tmpF, err = os.OpenFile(v.fileFullPath, os.O_RDONLY, os.ModePerm)
		if err != nil {
			return
		}
		_, err = io.Copy(tarW, tmpF)
		if err != nil {
			return
		}
		tmpF.Close()
	}
	tarFile = f.Name()
	err = nil
	return
}

func main() {
	tarFile, err := tarAll(".", "")
	if err != nil {
		handleError(err)
		return
	}
	println(tarFile)
	tarReader(tarFile)
}
