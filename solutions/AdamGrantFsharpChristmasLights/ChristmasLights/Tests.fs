module Tests

open System
open Xunit

let blankRow = Array.init<string> (20);

[<Fact>]
let ``My test`` () =
    Assert.True(true)
