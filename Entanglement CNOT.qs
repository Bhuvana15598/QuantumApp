namespace QuantumApp {

   import Std.Intrinsic.*;
import Std.Measurement.*;
// entry point
@EntryPoint()
operation EntangleQubits() : Unit {
    mutable matches = 0;
    let totalRuns = 100;

    Message("Entangling two coins 100 times...");

    for index in 1..totalRuns {
        // 1. Allocate TWO qubits
        use (qA, qB) = (Qubit(), Qubit());

        // 2. Put Qubit A into superposition
        H(qA);

        // 3. Entangle them! 
        // This makes qB depend on qA.
        CNOT(qA, qB);

        // 4. Measure both
        let resA = MResetZ(qA);
        let resB = MResetZ(qB);

        // 5. Check if they are the same
        if resA == resB {
            set matches += 1;
        }
    }

    Message($"--- Results ---");
    Message($"Total Runs: {totalRuns}");
    Message($"Number of times both coins matched: {matches}");
}
}

