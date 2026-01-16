namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;

@EntryPoint()
operation TeleportSecretMessage() : Unit {
    // We need 3 qubits:
    // 1. The message we want to send
    // 2. Alice's half of the bridge
    // 3. Bob's half of the bridge
    use (msg, aliceBridge, bobBridge) = (Qubit(), Qubit(), Qubit());

    // STEP 1: Prepare the secret message.
    // Let's make the message "1" by flipping it with X.
    X(msg); 
    Message("Alice has a secret message: 1");

    // STEP 2: Create the Entangled Bridge (The link between Alice and Bob)
    H(aliceBridge);
    CNOT(aliceBridge, bobBridge);

    // STEP 3: Alice "scans" her message onto her half of the bridge
    CNOT(msg, aliceBridge);
    H(msg);

    // STEP 4: Alice measures her qubits (this destroys the original message)
    let resMsg = MResetZ(msg);
    let resAlice = MResetZ(aliceBridge);
    Message($"Alice measured: {resMsg} and {resAlice}. Sending these to Bob...");

    // STEP 5: Bob "repairs" his qubit based on Alice's measurements
    // This is the part where the state actually "arrives" at the destination
    if resAlice == One { 
        X(bobBridge); 
    }
    if resMsg == One { 
        Z(bobBridge); // This is a phase flip gate
    }

    // STEP 6: Check if the message arrived at Bob's end
    let finalResult = MResetZ(bobBridge);
    
    if finalResult == One {
        Message("SUCCESS: The message '1' was teleported to Bob!");
    } else {
        Message("FAILED: The message did not arrive.");
    }
}
}

