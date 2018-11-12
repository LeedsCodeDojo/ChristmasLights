package com.code

fun main(args: Array<String>) {
    val input = arrayOf(
        arrayOf("*", "*", "*", "*", "*", "*", "*", "*", "*"),
        arrayOf("*", " ", " ", " ", "*", " ", " ", " ", "*"),
        arrayOf("*", " ", " ", "*", "*", "*", " ", " ", "*"),
        arrayOf("*", " ", "*", "*", "*", "*", "*", " ", "*"),
        arrayOf("*", "*", "*", "*", "*", "*", "*", "*", "*"),
        arrayOf("*", " ", " ", " ", "*", " ", " ", " ", "*"),
        arrayOf("*", "*", "*", "*", "*", "*", "*", "*", "*")
    )

    val tree = arrayOf(
        arrayOf("*", "*", "*", "*", "*", "*", "*", "*", "*"),
        arrayOf("*", " ", " ", " ", "*", " ", " ", " ", "*"),
        arrayOf("*", " ", " ", "*", "*", "*", " ", " ", "*"),
        arrayOf("*", " ", "*", "*", "*", "*", "*", " ", "*"),
        arrayOf("*", "*", "*", "*", "*", "*", "*", "*", "*"),
        arrayOf("*", " ", " ", " ", "*", " ", " ", " ", "*"),
        arrayOf("*", "*", "*", "*", "*", "*", "*", "*", "*")
    )

    while (true) {
        print("\u001b[H\u001b[2J")
        printer(tree)
        Thread.sleep(500)

        print("\u001b[H\u001b[2J")
        printer(squareNavigator(Pair(1, 1), Pair(7, 5), input, ::off))
        Thread.sleep(500)
    }
}

fun printer(input: Array<Array<String>>) {
    input.forEach {
        it.forEach { x -> print(x) }
        println("")
    }
}

fun on(x: Int, y: Int, array: Array<Array<String>>): Array<Array<String>> {
    array[x][y] = "*"

    return array
}

fun off(x: Int, y: Int, array: Array<Array<String>>): Array<Array<String>> {
    array[x][y] = " "

    return array
}

fun toggle(x: Int, y: Int, array: Array<Array<String>>): Array<Array<String>> {
    when (array[x][y]) {
        "*" -> return off(x, y, array)
        " " -> return on(x, y, array)
        else -> {
            println("Something went wrong!"); return array
        }
    }
}

fun squareNavigator(topLeft: Pair<Int, Int>, bottomRight: Pair<Int, Int>, array: Array<Array<String>>, action: (Int, Int, Array<Array<String>>) -> Array<Array<String>>): Array<Array<String>> {
    var array = array

    var x = topLeft.first
    var y = topLeft.second
    while (x <= bottomRight.second ) {
        y = topLeft.second
        while (y <= bottomRight.first) {
            array = action(x, y, array)
            y++
        }
        x++
    }

    return array
}
