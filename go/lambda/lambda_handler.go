package main

import (
	"fmt"
	"io"
	"log"
	"net"
	"os"
	"strings"
	"time"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/pressly/sup"
	"golang.org/x/crypto/ssh"
)

func privateKeyDialer(network, addr string, config *ssh.ClientConfig) (*ssh.Client, error) {
	privKey := os.Getenv("PRIVATE_KEY")
	if privKey == "" {
		return nil, fmt.Errorf("failed to read key: PRIVATE_KEY is empty")
	}
	privKey = strings.Replace(privKey, "::", "\n", -1)
	signer, err := ssh.ParsePrivateKey([]byte(privKey))
	if err != nil {
		return nil, fmt.Errorf("failed to parse key: %s", err)
	}
	config.Auth = []ssh.AuthMethod{ssh.PublicKeys(signer)}
	config.HostKeyCallback = func(h string, r net.Addr, k ssh.PublicKey) error { return nil }
	config.Timeout = 750 * time.Millisecond
	return ssh.Dial("tcp", addr, config)
}

func runTask(cli sup.SSHClient, cmd string, verbose ...bool) error {
	if len(verbose) > 0 && verbose[0] {
		cmd = "set -x; " + cmd
	}
	t := sup.Task{
		Run: cmd,
		TTY: true,
	}
	err := cli.Run(&t)
	if err != nil {
		return fmt.Errorf("failed to run: %s", err)
	}
	_, err = io.Copy(os.Stdout, cli.Stdout())
	if err != nil {
		return fmt.Errorf("failed to read stdout: %s", err)
	}
	_, err = io.Copy(os.Stderr, cli.Stderr())
	if err != nil {
		return fmt.Errorf("failed to read stderr: %s", err)
	}
	return err
}

func HandleRequest() {
	log.Println("[HandleRequest] Hello!")
	sshClient := sup.SSHClient{}
	if err := sshClient.ConnectWith("pablo@54.171.202.105:22", privateKeyDialer); err != nil {
		log.Fatalf("[HandleRequest] Failed to connect: %s\n", err)
	}
	cmds := []string{
		"pwd",
		"ls -lha",
		"rm -f get-pip.*",
		"wget https://bootstrap.pypa.io/get-pip.py",
		"ls -lha",
	}
	for _, cmd := range cmds {
		err := runTask(sshClient, cmd)
		if err != nil {
			log.Fatalf("[HandleRequest] Failed to run %q: %s\n", cmd, err)
		}
	}
}

func main() {
	log.Print("[main] Hello!\n")
	lambda.Start(HandleRequest)
}
