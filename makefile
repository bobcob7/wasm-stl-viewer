all: wasm-stl-viewer

wasm-stl-viewer: bundle.wasm main.go
	go build -o wasm-stl-viewer main.go

bundle.wasm: bundle.go
	GOOS=js GOARCH=wasm go build -o bundle.wasm bundle.go

run: bundle.wasm wasm-stl-viewer wasm_exec.js
	./wasm-stl-viewer

wasm_exec.js:
	cp $(GOROOT)/misc/wasm/wasm_exec.js .

clean:
	rm -f wasm-stl-viewer *.wasm
