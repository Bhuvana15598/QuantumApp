namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;


@EntryPoint()
operation CrossTalkTest() : Result {
    use (source, neighbour) = (Qubit(), Qubit());
    
    // I want to flip the source
    X(source);

    // SIMULATED HARDWARE DEFECT: 
    // Manually flipping the neighbour to simulate cross-talk leakage
    //X(neighbour);
    
    // In a 'perfect' wafer, neighbor should still be Zero.
    // If neighbor is One, the yield for this pair is 0%.
    let leakage = MResetZ(neighbour);
    Reset (source);
    
    return leakage; 
}
}

