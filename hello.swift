#!/usr/bin/env swift

print("hello, world!")

var args = 0

for arg in CommandLine.arguments {
    print("\(args) is \(arg)")
    args += 1
}