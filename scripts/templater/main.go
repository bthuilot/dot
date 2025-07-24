// Copyright (C) 2017-2025 Bryce Thuilot <bryce@thuilot.io>
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the FSF, either version 3 of the License, or (at your option) any later version.
// See the LICENSE file in the root of this repository for full license text or
// visit: <https://www.gnu.org/licenses/gpl-3.0.html>.

// templater.go is a simple templating engine for Go.
// It is used to replace placeholders in a template string with values.
// The placeholders are defined by curly braces prefixed with a # sign.
// For example, the placeholder #{name} will be replaced with the value of the
// environment variable 'name's.
package main

import (
	"flag"
	"io"
	"log"
	"os"
	"strings"
	"text/template"
)

var (
	// inFile is the path to the template file
	// if inFile is empty or "-", it will read from stdin
	inFile string
	// outFile is the path to write template
	// if outFile is empty or "-", it will write to stdout
	outFile string

	// in is the reader for the template file
	in io.ReadCloser
	// out is the writer for the template file
	out io.WriteCloser
	// vars is the map of variables to replace in the template
	// the key is the placeholder and the value is the value to replace it with
	// each is defined as a command line argument in the form key=value
	vars = make(map[string]string)
)

func parseFileName(name string, defaultRW io.ReadWriteCloser) (io.ReadWriteCloser, error) {
	if name == "-" || name == "" {
		return defaultRW, nil
	}
	return os.Open(name)

}

func init() {
	flag.StringVar(&inFile, "in", "-", "The path to the template file")
	flag.StringVar(&outFile, "out", "-", "The path to the template file")
	flag.Parse()

	var err error
	in, err = parseFileName(inFile, os.Stdin)
	if err != nil {
		log.Fatal(err)
	}
	out, err = parseFileName(outFile, os.Stdout)
	if err != nil {
		log.Fatal(err)
	}

	for _, varDef := range flag.Args() {
		parts := strings.SplitN(varDef, "=", 2)
		if len(parts) != 2 {
			log.Fatalf("Invalid variable definition: %s", varDef)
		}
		vars[parts[0]] = parts[1]
	}

}

func main() {
	defer func() {
		in.Close()
		out.Close()
	}()

	text, err := io.ReadAll(in)
	if err != nil {
		log.Fatal(err)
	}
	t, err := template.New("template").Parse(string(text))
	if err != nil {
		log.Fatal(err)
	}

	err = t.Execute(out, vars)
	if err != nil {
		log.Fatal(err)
	}
}
