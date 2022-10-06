package main

import (
	"io/ioutil"
	"log"
	"net/http"
)

func main() {
	indexData, err := ioutil.ReadFile("index.html")
	if err != nil {
		log.Fatalf("Could not read index file: %s\n", err)
	}
	wasmExecData, err := ioutil.ReadFile("wasm_exec.js")
	if err != nil {
		log.Fatalf("Could not read wasm_exec file: %s\n", err)
	}

	wasmData, err := ioutil.ReadFile("bundle.wasm")
	if err != nil {
		log.Fatalf("Could not read wasm file: %s\n", err)
	}

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write(indexData)
	})

	http.HandleFunc("/wasm_exec.js", func(w http.ResponseWriter, r *http.Request) {
		w.Write(wasmExecData)
	})

	http.HandleFunc("/bundle.wasm", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/wasm")
		w.WriteHeader(http.StatusOK)
		w.Write(wasmData)
	})

	log.Fatal(http.ListenAndServe(":8080", nil))
}
