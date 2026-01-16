namespace QuantumApp {

    import Std.Intrinsic.*;
import Std.Measurement.*;
import Std.Diagnostics.*; // Added for better messaging

@EntryPoint()
operation MultiCoinFlip() : Unit {
    // Variables to keep track of our score
    mutable headsCount = 0;
    mutable tailsCount = 0;

    Message("Flipping the quantum coin 1000 times...");

    // The 'for' loop replaces the single execution
    for index in 1..1000 {
        use q = Qubit();
        
        H(q); // Put in superposition
        
        let result = MResetZ(q); // Measure and reset

        // Instead of a simple 'if' message, we increment our counters
        if result == One {
            set tailsCount += 1;
        } else {
            set headsCount += 1;
        }
    }

    // Report the final tally
    Message($"Results after 1000 flips:");
    Message($"Heads: {headsCount}");
    Message($"Tails: {tailsCount}");
}
}

