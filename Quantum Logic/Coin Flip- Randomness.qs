namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;

@EntryPoint()
operation QuantumCoinFlip() : Unit {
    use q = Qubit();
    
    // Put the coin in a "spinning" state (Superposition)
    H(q);
    
    // Measure the result
    let result = MResetZ(q);
    
    if result == One {
        Message("Heads!");
    } else {
        Message("Tails!");
    }
}
}

