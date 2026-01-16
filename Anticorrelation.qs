namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;

@EntryPoint()
operation AntiCorreleation() : Unit {
    mutable opposites = 0;
    let totalRuns = 100;

    Message($"Running Anti-correlated two coins {totalRuns} times...");

    for index in 1..totalRuns {
        // 1. Allocate TWO qubits
        use (qA, qB) = (Qubit(), Qubit());


        // 2. Put Qubit A into superposition
        H(qA);

        //e. This makes qB not depend on qA.
        CNOT(qA, qB);
        X(qB);

        // 4. Measure both
        let resA = MResetZ(qA);
        let resB = MResetZ(qB);

        // 5. Check if they are the same
       
        
        if resA == resB {
            // do nothing
        } else {
            set opposites += 1;
        }
    }

    Message($"--- Results ---");
    Message($"Total Runs: {totalRuns}");
    Message($"Number of times both coins opposites: {opposites}");
}
}

