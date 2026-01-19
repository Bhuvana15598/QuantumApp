namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;
import Std.Math.*;



@EntryPoint()
operation RunTest() : Unit {
    let outcome = CrossTalkTest();
    
    // We check if the result is exactly the 'Zero' constant
    if outcome == Zero {
        Message("Success: The result is Zero (No Leakage).");
    } else {
        Message("Warning: The result is One (Leakage detected).");
    }
}

operation CrossTalkTest() : Result {
    use (source, neighbour) = (Qubit(), Qubit());
    X(source);
    // Manually flipping the neighbour to simulate cross-talk leakage
   // X(neighbour);
    
    // MResetZ performs the measurement and returns a Result (Zero or One)
    let leakage = MResetZ(neighbour);
    
    
    Reset(source);
    return leakage;
}

}



