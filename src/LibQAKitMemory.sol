// SPDX-License-Identifier: CAL
pragma solidity ^0.8.16;

import "sol.lib.memory/LibMemory.sol";

library LibQAKitMemory {
    using LibMemory for bytes;

    function memoryIsAligned() internal pure returns (bool isAligned_) {
        assembly ("memory-safe") {
            isAligned_ := iszero(mod(mload(0x40), 0x20))
        }
    }

    function allocatedMemoryPointer() internal pure returns (Pointer pointer_) {
        assembly ("memory-safe") {
            pointer_ := mload(0x40)
        }
    }

    /// https://docs.soliditylang.org/en/v0.8.17/assembly.html#memory-management
    /// > Solidity manages memory in the following way. There is a
    /// > “free memory pointer” at position 0x40 in memory. If you want to
    /// > allocate memory, use the memory starting from where this pointer points
    /// > at and update it.
    /// > **There is no guarantee that the memory has not been used before and
    /// > thus you cannot assume that its contents are zero bytes.**
    function copyPastAllocatedMemory(bytes memory input_) internal pure {
        Pointer outputPointer_;
        // This assembly is NOT memory safe, by design.
        assembly {
            outputPointer_ := mload(0x40)
        }
        LibMemory.unsafeCopyBytesTo(input_.dataPointer(), outputPointer_, input_.length);
    }
}
