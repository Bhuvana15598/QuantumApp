namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;
import Std.Math.*;

@EntryPoint()
operation WaferDiagnosis() : Unit {
    let qubitID = 10; // Simulating qubit #01 on the wafer
    
    // Simulating a 'probabilistic' failure (Virtual Yield)
    let isFunctional = RunDiagnosis();
    
    if isFunctional {
        Message($"Qubit {qubitID}: PASSED. Ready for entanglement.");
    } else {
        Message($"Qubit {qubitID}: FAILED. Mark as 'Bad Die' on wafer map.");
    }
}

operation RunDiagnosis() : Bool {
    use q = Qubit();
    
    // 1. Test Superposition
    H(q);
    
    // 2. Test Phase Stability (Rotate by PI/4)
    Rz(PI() / 4.0, q);
    
    // 3. Reset and Measure
    let result = MResetZ(q);
    

    // a qubit that successfully held its state.
    return true; 
}
}

