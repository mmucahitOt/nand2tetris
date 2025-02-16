// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

// Initialize variables
    @SCREEN     // Set base address of screen memory map
    D=A
    @addr
    M=D        // addr = SCREEN (16384)
    
    @8192      // Total number of 16-bit words to fill (256 rows * 32 words per row)
    D=A
    @n
    M=D        // n = 8192

(LOOP)
    @KBD       // Check keyboard input
    D=M
    
    @BLACK     // If key pressed (D > 0), jump to BLACK
    D;JGT
    
    @WHITE     // Else jump to WHITE
    0;JMP

(BLACK)
    @color
    M=-1       // color = -1 (1111111111111111 in binary)
    @DRAW
    0;JMP

(WHITE)
    @color
    M=0        // color = 0 (0000000000000000 in binary)
    @DRAW
    0;JMP

(DRAW)
    @n         // if n <= 0, reset and restart
    D=M
    @RESET
    D;JLE

    @color     // Get current color
    D=M
    @addr      // Get current address
    A=M        // Select address to modify
    M=D        // Set pixels at current address

    @addr      // Increment address
    M=M+1
    @n         // Decrement counter
    M=M-1
    
    @DRAW      // Continue drawing
    0;JMP

(RESET)
    @SCREEN    // Reset address to start of screen
    D=A
    @addr
    M=D
    
    @8192      // Reset counter
    D=A
    @n
    M=D
    
    @LOOP      // Return to main loop
    0;JMP
