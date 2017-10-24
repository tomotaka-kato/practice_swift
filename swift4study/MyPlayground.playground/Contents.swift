//: Playground - noun: a place where people can play

// UIKitのライブラリ読み込み
import UIKit

var str = "Hello, Swift!"

print(str)

var a = 5
var b = 2

a + b
a - b
a / b
a * b
a % b

// 定数
let taxRate = 0.08
var productX = 8000.0
var productY = 6000.0
productX * taxRate


// for文（7の段階）
let x = 7
for i in 1 ... 9 {
    print(x * i)
}

print("九九の出力")
for i in 1..<10 {   // n..<m でnからm未満の値のリストになる
    for j in 1...9{
        print(i*j)
    }
}
