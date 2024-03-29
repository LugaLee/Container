FROM golang:1.18 as builder

WORKDIR /

COPY <<EOF server.go

package main

import (
    "fmt"
    "log"
    "net/http"
)

func main() {
    
    log.Println("Starting HTTP server...")

    http.HandleFunc("/", func(w http.ResponseWriter, req *http.Request) {
        log.Println("Incoming request")
        fmt.Fprintf(w, "hello\n")
    })
    http.ListenAndServe(":9090", nil)
}

EOF

COPY <<EOF sleep.go

package main

import (
    "log"
    "time"
)

func main() {
    for {
        log.Println("What a fucking day !...")
        time.Sleep(1 * time.Second)
    }
}

EOF

RUN CGO_ENABLED=0 go build -o server server.go

RUN CGO_ENABLED=0 go build -o sleep sleep.go


FROM scratch

COPY --from=builder /server /server

COPY --from=builder /sleep /sleep

CMD ["/server"]
