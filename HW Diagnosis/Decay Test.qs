namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;
import Microsoft.Quantum.Random.*; // Required for the decay simulation

@EntryPoint()
operation DecayTest() : Unit {
    let trials = 10;
    mutable passCount = 0;

    Message(" STARTING T1 DECAY TEST ({trials} TRIALS) ");

    for index in 1..trials {
        let result = SimulateQubitRetention();
        if result == One {
            set passCount += 1;
        }
    }

    let yieldPercent = passCount * 10; // Percentage for 10 trials
    Message("TEST COMPLETE: Qubit retained state {passCount} out of {trials} times.");
    Message("ESTIMATED VIRTUAL YIELD: {yieldPercent}%");

    if yieldPercent < 70 {
        Message("DECISION: Wafer batch rejected due to high decoherence.");
    } else {
        Message("DECISION: Wafer batch accepted for production.");
    }
}

operation SimulateQubitRetention() : Result {
    use q = Qubit();
    
    // 1. Preparing the qubit in the 'High Energy' state
    X(q);

    // 2. Simulate a 20% chance of T1 Decay (Environment Noise)
    // In a real wafer, this represents the qubit falling back to 0
    if DrawRandomInt(1, 5) == 1 {
        Reset(q); // The qubit "died" and fell back to |0>
    }

    // 3. Measure to see if it's still |1>
    let finalState = MResetZ(q);
    return finalState;
}
}

