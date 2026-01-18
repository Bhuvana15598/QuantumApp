namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;

@EntryPoint()
operation DeutschAlgorithm() : Unit {
    // We need two qubits: a 'query' qubit and a 'target' qubit
    use (query, target) = (Qubit(), Qubit());

    // 1. Setup Phase
    // We put the target in the |1> state first, then both into superposition
    X(target); 
    H(query);
    H(target);

    // 2. The Black Box
    // To test a BALANCED box, leave the CNOT in. 
    // To test a CONSTANT box, comment out the CNOT line below.
    CNOT(query, target); 

    // 3. Interference Phase
    // This turns the 'quantum information' back into something we can read
    H(query);

    // 4. Measure
    let result = MResetZ(query);
    let _ = MResetZ(target); // Clean up the second qubit

    // 5. Logic
    if result == One {
        Message("The Box is BALANCED (Quantum computer found this in 1 try!)");
    } else {
        Message("The Box is CONSTANT (Quantum computer found this in 1 try!)");
    }
}

}

