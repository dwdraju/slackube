package main

import (
	"fmt"
	"os"
	"github.com/nlopes/slack"
)

func main() {
	SLACK_TOKEN := os.Getenv("SLACK_TOKEN")
	api := slack.New(SLACK_TOKEN)
  user, err := api.GetUserInfo("U045U8KN6")
  if err != nil {
	  fmt.Printf("%s\n", err)
	  return
  }
  fmt.Printf("ID: %s, Fullname: %s, Email: %s\n", user.ID, user.Profile.RealName, user.Profile.Email)
}
