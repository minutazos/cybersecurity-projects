package handler

import "os"

type config struct {
	randomName string
}

func NewConfigFromEnv() *config {

	return &config{
		randomName: os.Getenv("RANDOM_NAME"),
	}
}
