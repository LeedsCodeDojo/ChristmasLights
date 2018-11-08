//#r @"C:\Users\adam_\.nuget\packages\fparsec\1.0.3\lib\netstandard1.6\FParsecCS.dll"
//#r @"C:\Users\adam_\.nuget\packages\fparsec\1.0.3\lib\netstandard1.6\FParsec.dll"

#r @"C:\Users\adam_\.nuget\packages\fparsec\1.0.3\lib\net40-client\FParsecCS.dll"
#r @"C:\Users\adam_\.nuget\packages\fparsec\1.0.3\lib\net40-client\FParsec.dll"

open FParsec

let test p str =
    match run p str with
    | Success(result, _, _)   -> printfn "Success: %A" result
    | Failure(errorMsg, _, _) -> printfn "Failure: %s" errorMsg

type Cmd = 
    | Off of int*int
    | On of int*int

//let point = pstring "(" >>. sepBy pint32 (pstring ",") .>> pstring ")"
//let twoPoints = many point 

let pcoord = tuple2 (pint32 .>> pchar ',') pint32

let poff = pstring "OFF " >>. pcoord  |>> Off
let pon = pstring "ON " >>. pcoord |>> On
let pcommand = pon <|> poff
let pmanycommands = many pcommand

test pmanycommands @"OFF 1,99ON 33,66"
