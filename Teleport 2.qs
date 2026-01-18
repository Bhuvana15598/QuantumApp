namespace QuantumApp {

  import Std.Intrinsic.*;
import Std.Measurement.*;

@EntryPoint()
operation TeleportationTest() : Unit {
    
    // CHANGE THIS: Set this to 'One' or 'Zero' and click Run
    let aliceSecret = Zero; 
    
    Message($"--- STARTING TELEPORTATION ---");
    Message($"Alice's chosen input: {aliceSecret}");

    // Run the teleportation logic
    let received = TeleportScenario(aliceSecret);
    
    Message($"BOB'S TERMINAL: Received {received}");
    
    if aliceSecret == received {
        Message("SUCCESS: The message survived the quantum bridge!");
    } else {
        Message("ERROR: Something went wrong.");
    }
}

operation TeleportScenario(input : Result) : Result {
    use (msg, aliceBridge, bobBridge) = (Qubit(), Qubit(), Qubit());

    // 1. Alice prepares the message
    if input == One { X(msg); }

    // 2. Create the Entangled Bridge (The Link)
    H(aliceBridge);
    CNOT(aliceBridge, bobBridge);

    // 3. Alice's "Scan" (Entangling message with bridge)
    CNOT(msg, aliceBridge);
    H(msg);

    // 4. Alice measures (Original is destroyed)
    let resMsg = MResetZ(msg);
    let resAlice = MResetZ(aliceBridge);

    // 5. Bob's "Repair" 
    // He uses Alice's measurement results to fix his qubit
    if resAlice == One { X(bobBridge); }
    if resMsg == One { Z(bobBridge); }

    // 6. Return the final result found at the destination
    return MResetZ(bobBridge);
}

}

