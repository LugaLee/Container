package main

import (
        "database/sql"
        "fmt"
        "net/http"
        "log"
        _ "github.com/lib/pq"
)

type Book struct {
        Id int
        Name string
        Phone string
        Email string
        Stars int
        Category string
}

var db *sql.DB

func init() {
        var err error
        db, err = sql.Open("postgres", "postgres://luga:password@127.0.0.1:26257/books?sslmode=disable")
        if err != nil {
            log.Fatal(err)
        }

        if err = db.Ping(); err != nil {
            log.Fatal(err)
        }       
}

func main() {
    http.HandleFunc("/books", booksIndex)
    http.ListenAndServe(":9090", nil)
}

func booksIndex(w http.ResponseWriter, r *http.Request) {

        if r.Method != "GET" {
                http.Error(w, http.StatusText(405), http.StatusMethodNotAllowed)
                return
        }

        rows, err := db.Query("SELECT * FROM tblbook")

        if err != nil {
                http.Error(w, http.StatusText(500), 500)
                return
        }
        defer rows.Close()

        bks := make([]*Book, 0)

        for rows.Next() {
                bk := new(Book)
                err := rows.Scan(&bk.Id, &bk.Name, &bk.Phone, &bk.Email, &bk.Stars, &bk.Category)
                if err != nil {
                    http.Error(w, http.StatusText(500), 500)
                    return
                }
                bks = append(bks, bk)
        }

        if err = rows.Err(); err != nil {
                http.Error(w, http.StatusText(500), 500)
                return
        }

        for _, bk := range bks {
                fmt.Fprintf(w, "%d %s %s %s %d %s\n", bk.Id, bk.Name, bk.Phone, bk.Email, bk.Stars, bk.Category)
        }
}
