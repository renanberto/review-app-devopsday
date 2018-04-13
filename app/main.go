package main

import (
	"gopkg.in/macaron.v1"
	"gopkg.in/mgo.v2"
	"time"
	"log"
	"os"
)

var mongoServer = os.Getenv("MONGO_SERVER")

func main(){
	session := mongoConnect()
	
	m := macaron.Classic()
	m.Map(session)
	m.Use(macaron.Renderer())
	
	m.Get("/", index)
	
	m.Run()
}

// index Function
func index(ctx *macaron.Context) {
	ctx.HTML(200, "index")
	ctx.SetTemplatePath("", "templates")
}

func mongoConnect() *mgo.Session {
	dialInfo := &mgo.DialInfo{
		Addrs:    []string{mongoServer},
		Timeout:  1 * time.Second,
		Database: "hands_on_docker",
		Username: "",
		Password: "",
	}
	
	session, err := mgo.DialWithInfo(dialInfo)
	if err != nil {
		log.Fatal("Couldn't connect to mongodb :( ", err)
	}
	return session
}
