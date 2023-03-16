// SPDX-License-Identifier: CAL
pragma solidity ^0.8.15;

import "sol.lib.bytes/LibBytes.sol";

contract QAKitMemory is Test {
    using LibBytes for bytes;

    function assertMemoryAlignment() internal {
        // Check alignment of memory after allocation.
        uint256 memPtr_;
        assembly ("memory-safe") {
            memPtr_ := mload(0x40)
        }
        assertEq(memPtr_ % 0x20, 0);
    }

    /// https://docs.soliditylang.org/en/v0.8.17/assembly.html#memory-management
    /// > Solidity manages memory in the following way. There is a
    /// > “free memory pointer” at position 0x40 in memory. If you want to
    /// > allocate memory, use the memory starting from where this pointer points
    /// > at and update it.
    /// > **There is no guarantee that the memory has not been used before and
    /// > thus you cannot assume that its contents are zero bytes.**
    function copyPastAllocatedMemory(bytes memory input_) internal pure {
        Cursor outputCursor_;
        assembly {
            outputCursor_ := mload(0x40)
        }
        LibBytes.unsafeCopyBytesTo(input_.cursor(), outputCursor_, input_.length);
    }
}
