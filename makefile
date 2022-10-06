GOROOT := $(shell go env GOROOT)

all: wasm-stl-viewer

wasm-stl-viewer: bundle.wasm main.go
	go build -o wasm-stl-viewer main.go

bundle.wasm: bundle.go color/color.go color/gradient.go color/interpolation.go gltypes/gltypes.go models/model.go models/stl.go renderer/renderer.go
	tinygo build -o bundle.wasm -target wasm -no-debug ./bundle.go

run: bundle.wasm wasm-stl-viewer wasm_exec.js
	./wasm-stl-viewer

wasm_exec.js:
	cp $(GOROOT)/misc/wasm/wasm_exec.js .

clean:
	rm -f wasm-stl-viewer *.wasm
