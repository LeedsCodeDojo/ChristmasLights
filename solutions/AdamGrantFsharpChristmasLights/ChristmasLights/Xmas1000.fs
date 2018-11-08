module Xmas1000

let blankRow = Array.init<char> 11 (fun _ -> '*') |> Array.toSeq;
let blankGrid = Array.init<seq<char>> 7 (fun _ -> blankRow) |> Array.toSeq

let mapij fn grid = 
    grid 
    |> Seq.mapi (fun i row -> row |> Seq.mapi (fun j value -> fn i j value))


let applyCommand command (topLeft) (bottomRight) grid = 
    let applyToCell colIndex rowIndex cell =
        let isInBoundingBox = 
            let (tlc, tlr) = topLeft
            let (brc, brr) = bottomRight
            rowIndex >= tlr && rowIndex <= brr &&
            colIndex >= tlc && colIndex <= brc

        if isInBoundingBox 
        then cell |> command
        else cell
            
    grid 
    |> mapij (fun colIndex rowIndex cell -> 
        cell |> applyToCell colIndex rowIndex)

let off = applyCommand (fun _ -> '.')
let on = applyCommand (fun _ -> '*')

let toggle = applyCommand (fun c -> 
    match c with 
    | '*' -> '.'
    | '.' -> '*'
    | _ -> failwith "NO!")

let printGrid grid = 
    let printRow row = 
        row |> Seq.iter (printf "%c")
        printfn ""

    grid |> Seq.iter printRow

//type Command = 
//    | On of ((int*int)*(int*int))
//    | Off of ((int*int)*(int*int))
//    | Toggle of ((int*int)*(int*int))

// Shhh - For type inference...
let a() =
    blankGrid 
    |> off (0,2) (3,4) 
    |> on (0,3) (0,3) 
    |> toggle (1,4)(6,4)
    |> printGrid
