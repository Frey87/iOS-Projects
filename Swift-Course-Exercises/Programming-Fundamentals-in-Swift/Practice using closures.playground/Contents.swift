var goldBars = 0
//let unlockTreasureChest = {(inventory:Int) -> Int in return inventory + 100}

let unlockTreasureChest = {(inventory:inout Int) -> Void in inventory += 100}
unlockTreasureChest(&goldBars)
print(goldBars)
