// SPDX-License-Identifier: CAL
pragma solidity ^0.8.16;

import "forge-std/Test.sol";
import "sol.lib.memory/LibMemory.sol";
import "../src/LibQAKitMemory.sol";

contract QAKitMemoryTest is Test {
    using LibMemory for bytes;

    // Just fuzz to get some things in memory.
    function testMemoryIsAlignedFuzz(bytes memory, uint256 offset_) public {
        vm.assume(offset_ % 0x20 != 0);
        assertTrue(LibQAKitMemory.memoryIsAligned());
        assembly {
            mstore(0x40, add(mload(0x40), offset_))
        }
        assertTrue(!LibQAKitMemory.memoryIsAligned());
    }

    function testCopyPastAllocatedMemory(bytes memory input_) public {
        bytes memory output_ = new bytes(input_.length);

        Pointer a_ = LibQAKitMemory.allocatedMemoryPointer();
        LibQAKitMemory.copyPastAllocatedMemory(input_);
        Pointer b_ = LibQAKitMemory.allocatedMemoryPointer();

        assertEq(Pointer.unwrap(a_), Pointer.unwrap(b_));

        LibMemory.unsafeCopyBytesTo(b_, output_.dataPointer(), input_.length);

        assertEq(input_, output_);
    }

    function testAllocatedMemoryPointer(uint8 length_) public {
        vm.assume(length_ > 0);
        Pointer a_ = LibQAKitMemory.allocatedMemoryPointer();
        new uint256[](length_);
        Pointer b_ = LibQAKitMemory.allocatedMemoryPointer();
        assertEq(uint256(length_) * 0x20 + 0x20, Pointer.unwrap(b_) - Pointer.unwrap(a_));
    }
}
