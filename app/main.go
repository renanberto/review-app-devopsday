package main

import (
	"gopkg.in/macaron.v1"
)

func main(){
	m := macaron.Classic()
	m.Use(macaron.Renderer())
	m.Get("/", index)

	m.Run()
}

// index Function
func index(ctx *macaron.Context) {
	ctx.HTML(200, "index")
}