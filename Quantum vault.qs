namespace QuantumApp {

    import Std.Intrinsic.*;
    import Std.Measurement.*;

    @EntryPoint()
    operation Vault () : Unit {
        // 1. Allocate the qubits.
        use (qA, qB)= (Qubit(), Qubit());
        // 2. Qubit A as superposition.
        H(qA);
        //H(qA);
        CNOT(qA, qB);
        // 3. The security glitch
        X(qB);
    
    //4. Measure both 
    let resA = MResetZ(qA);
    let resB = MResetZ(qB);

    if resA == resB {
        Message ("The vault is LOCKED");
       } else {
            Message ("The vault is OPENED");
        }
    
    

}
}

