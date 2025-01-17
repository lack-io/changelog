package main

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"strings"
)

func git(dir string, args ...string) (string, error) {
	cmd := exec.Command("git", args...)
	var stdout bytes.Buffer
	var stderr bytes.Buffer
	cmd.Stdout = &stdout
	cmd.Stderr = &stderr
	cmd.Dir = dir
	cmd.Env = os.Environ()
	if *verbose {
		fmt.Println(cmd.String())
	}
	if err := cmd.Run(); err != nil {
		return "", fmt.Errorf(stderr.String())
	}
	return stdout.String(), nil
}

// fetchGitRepository will fetch latest commits and tags
func fetchGitRepository() error {
	_, err := git(*source, "fetch", "--all")
	if err != nil {
		return err
	}
	return nil
}

// getGitTags will query all git tags with created time and subject
func getGitTags() (string, error) {
	tags, err := git(*source, "tag", "-n", "-l", "--sort=creatordate", "--format", "%(refname:short);%(creatordate:short);%(subject)")
	if err != nil {
		return "", err
	}
	return tags, nil
}

// getGitLogs will query commit records between two tags
func getGitLogs(tag1, tag2 string) (string, error) {
	var notation string
	if len(tag1) > 0 && len(tag2) > 0 {
		notation = fmt.Sprintf("%s..%s", tag1, tag2)
	} else if len(tag1) > 0 {
		notation = tag1
	} else if len(tag2) > 0 {
		notation = tag2
	}
	commits, err := git(*source, "log", "--no-merges", "--format=oneline", notation)
	if err != nil {
		return "", err
	}
	return commits, nil
}

// getGitRemote will query remote url
func getGitRemote() (string, error) {
	items, err := git(*source, "remote", "-v")
	if err != nil {
		return "", err
	}

	remotes := strings.Split(items, "\n")
	var remote string
	for _, item := range remotes {
		if strings.Contains(item, "push") {
			parts := strings.Split(strings.TrimSpace(strings.TrimPrefix(item, "origin")), " ")
			if len(parts) > 0 {
				remote = parts[0]
			}
		}
	}

	return remote, nil
}
