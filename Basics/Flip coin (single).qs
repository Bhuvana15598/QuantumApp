namespace QuantumApp {

   import Std.Intrinsic.*;
   import Std.Measurement.*;

   // adding comments
   
    @EntryPoint()
    operation FlipQuantumCoin() : Result {
        //1. Allocate a qubit
        //In Q#, 'use' ensures the qubit starts in the |0⟩ state
        use q= Qubit();

        // 2. Put the qubit into superposition.
    // The H (Hadamard) gate creates a 50/50 chance of 0 or 1(Superposition).
    H(q);

    // 3. Measure the qubit.
    // MResetZ measures the qubit and resets it to |0⟩ (required for release).
    let result = MResetZ(q);

    // 4. Report the result back to the console.
    if result == One {
        Message("The coin landed on: TAILS (1)");
    } else {
        Message("The coin landed on: HEADS (0)");
    }

    return result;
    }
}

