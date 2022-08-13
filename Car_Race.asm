[org 0x0100]
jmp Start
;Prints Lose on Screan then Moves Forward to Outro which is End Sceen
LOSE:
mov di,dx
mov word[es:di],0x8711
add di,2
mov word[es:di],0x870F
add di,2
mov word[es:di],0x8710
;Printing Lose
mov di,1990
mov word[es:di],0x8259
add di,2
mov word[es:di],0x824f
add di,2
mov word[es:di],0x8255
add di,2
mov word[es:di],0x8000
add di,2
mov word[es:di],0x8000
add di,2
mov word[es:di],0x854c
add di,2
mov word[es:di],0x854f
add di,2
mov word[es:di],0x8553
add di,2
mov word[es:di],0x8545
;Delay before Outro
push cx
mov cx,0xffff
;IT Generates a single beep sound when a car its hurdle or footpath
B:
push ax
call Sound
pop ax
sub cx,1
cmp cx,0
jne B
mov cx,20
A:

call delay
sub cx,1
cmp cx,0
jne A
 pop cx
jmp Outro
;Prints Victory on Screan then Moves Forward to Outro which is End Sceen
Victory:
;Printing Win
mov di,1990
mov word[es:di],0x8259
add di,2
mov word[es:di],0x824f
add di,2
mov word[es:di],0x8255
add di,2
mov word[es:di],0x8000
add di,2
mov word[es:di],0x8000
add di,2
mov word[es:di],0x8557
add di,2
mov word[es:di],0x8549
add di,2
mov word[es:di],0x854e
push cx
mov cx,20
jmp A
;Clears the Screen
clrscr: push es
push ax
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov di, 0 ; point di to top left column
nextloc: mov word [es:di], 0x7020 ; clear next char on screen
add di, 2 ; move to next screen location
cmp di, 4000 ; has the whole screen cleared
jne nextloc ; if no clear next position
pop di
pop ax
pop es
ret
;Intro Page Prints Contoras and PLay button P on Intro Screen Taking input in main Functoin
Intro:
mov ax,0xb800
mov es,ax
mov ds,ax
mov di,0
mov cx,560
US: ;uper Border
mov word[es:di],0x01B1
add di,2
sub cx,1
cmp cx,0
jne US
mov cx,880
PS:  ;Play Section
mov word[es:di],0x0020
add di,2
sub cx,1
cmp cx,0
jne PS
mov cx,560 
DPS: ;Down Section
mov word[es:di],0x01B1
add di,2
sub cx,1
cmp cx,0
jne DPS
;Printing Play
mov di,1990
mov word[es:di],0x8750
add di,4
mov word[es:di],0x8210
add di,6
mov word[es:di],0x8550
add di,2
mov word[es:di],0x854C
add di,2
mov word[es:di],0x8541
add di,2
mov word[es:di],0x8559
add di,144
add di,320
;Print LEft
mov word[es:di],0x0711
add di,4
mov word[es:di],0x023A
add di,6
mov word[es:di],0x054C
add di,2
mov word[es:di],0x0545
add di,2
mov word[es:di],0x0546
add di,2
mov word[es:di],0x0554
add di,144
;Print Right
mov word[es:di],0x0710
add di,4
mov word[es:di],0x023A
add di,6
mov word[es:di],0x0552 
add di,2
mov word[es:di],0x0549
add di,2
mov word[es:di],0x0547
add di,2
mov word[es:di],0x0548
add di,2
mov word[es:di],0x0554

ret
;Outro Page a End Screen Funtion Priting Options For play Again and Exit and takes input from user in this function
Outro:
mov ax,0xb800
mov es,ax
mov ds,ax
mov di,0
mov cx,560
UO: ;uper Border
mov word[es:di],0x74B0
add di,2
sub cx,1
cmp cx,0
jne UO
mov cx,880
PO: ;Middle Portion
mov word[es:di],0x7020
add di,2
sub cx,1
cmp cx,0
jne PO
mov cx,560 
DPO: ;down Border
mov word[es:di],0x74B0
add di,2
sub cx,1
cmp cx,0
jne DPO
mov di,1990
;Play Again
mov word[es:di],0x7050
add di,4
mov word[es:di],0x7210
add di,6
mov word[es:di],0x7550
add di,2
mov word[es:di],0x754C
add di,2
mov word[es:di],0x7541
add di,2
mov word[es:di],0x7559
add di,4
mov word[es:di],0x7541
add di,2
mov word[es:di],0x7547
add di,2
mov word[es:di],0x7541
add di,2
mov word[es:di],0x7549
add di,2
mov word[es:di],0x754e
;Exit
mov di,2150
mov word[es:di],0x7145
add di,2
mov word[es:di],0x7153
add di,2
mov word[es:di],0x7143
add di,4
mov word[es:di],0x7210
add di,6
mov word[es:di],0x7445
add di,2
mov word[es:di],0x7458
add di,2
mov word[es:di],0x7449
add di,2
mov word[es:di],0x7454
;Takes input
TakOt:
int 0x16
in al ,0x60
cmp al,0x1
jne Nxt
jmp Terminate
Nxt:
cmp al,0x19
jne TakOt
jmp Start
;Printing Score Digits copied From Book Takes a number and Print it digits on Screen
printnum:
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov ax, [bp+4] ; load number in ax
mov bx, 10 ; use base 10 for division
mov cx, 0 ; initialize count of digits
nextdigit: 
mov dx, 0 ; zero upper half of dividend
div bx ; divide by 10
add dl, 0x30 ; convert digit into ascii value
push dx ; save ascii value on stack
inc cx ; increment count of values
cmp ax, 0 ; is the quotient zero
jnz nextdigit ; if no divide it again
mov ax,[bp+6]
mov di,ax ; point di to top Right column
nextpos:
pop dx ; remove a digit from the stack
mov dh, 0x70 ; use normal attribute
mov [es:di], dx ; print char on screen
add di, 2 ; move to next screen location
loop nextpos ; repeat for all digits on stack
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 4
;Printing car with respect to location checks for Intrup right/left key
PRINT_CAR:
 mov di,dx
cmp word[es:di], 0x7020
je NC
cmp word[es:di],0x70B1
je NC
jmp LOSE
NC: ;Next check
add di,2
cmp word[es:di], 0x7020
je NNC
cmp word[es:di],0x70B1
je NNC
jmp LOSE
NNC: ;Next Next check
add di,2
cmp word[es:di], 0x7020
je MC
cmp word[es:di],0x70B1
je MC
jmp LOSE
MC: ;Final Check
mov di,dx
mov word[es:di],0x0711
add di,2
mov word[es:di],0x070F
add di,2
mov word[es:di],0x0710
;mov di,3840
;call Display

ret
;Getting Random numbers
RANDNUM:
push bp
mov bp,sp
push ax
push cx
push dx
push bx 
MOV AH, 00h  ; interrupts to get system time        
INT 1AH      ; CX:DX now hold number of clock ticks since midnight      
mov  ax, dx
mov bx, 25173          
mul bx
add ax, 13849                    
xor  dx, dx
mov  cx, [bp+4]
shr  ax,5 
inc cx   
div  cx
mov [bp+6], dx
pop bx
pop dx
pop cx
pop ax
pop bp   
ret 2
;Generating Hurdels in very First Line
Hurdle1:
push di
add di,80
mov word[es:di],0x81B1
add di,2
mov word[es:di],0x81B1
add di,2
mov word[es:di],0x81B1
pop di
jmp En
Hurdle2:
push di
add di,60
mov word[es:di],0x82B3
add di,2
mov word[es:di],0x82B3
add di,2
mov word[es:di],0x82B3
pop di
jmp En
Hurdle3:
push di
add di,68
mov word[es:di],0x84B2
add di,2
mov word[es:di],0x84B2
add di,2
mov word[es:di],0x84B2
pop di
jmp En
Hurdle4:
push di
add di,66
mov word[es:di],0x7111
add di,2
mov word[es:di],0x71EA
add di,2
mov word[es:di],0x7110
pop di
jmp En
Hurdle5:
push di
add di,84
mov word[es:di],0x7411
add di,2
mov word[es:di],0x74EA
add di,2
mov word[es:di],0x7410
pop di
jmp En
Hurdle6:
push di
add di,48
mov word[es:di],0x7811
add di,2
mov word[es:di],0x78EA
add di,2
mov word[es:di],0x7810
pop di
jmp En
;Delay Function copied from CLassRoom 
delay:
push cx
mov cx, 5 ; change the values  to increase delay time
delay_loop1:
push cx
mov cx, 0xFFFF
delay_loop2:
loop delay_loop2
pop cx
loop delay_loop1
pop cx
ret
;Function from Generating a tilt in Road and then Making it Normal 
;Copies every above Line and Paste it on very next Line Starting From 2nd Last line to Top Line
TiltMov:
push dx
mov ax,0xb800
mov es,ax
mov ds,ax
std
mov si,3656
mov di,3816
mov dx,23
Print2:
mov cx,68
rep movsw
sub si,24
sub di,24
dec dx
cmp dx,0
jne Print2

pop dx
ret
;ROAD Tilt function
Tilt1:
mov di ,0
mov word[es:di],0x2020;Green color
add di,2
call Display
sub di,26
mov word[es:di],0x7020;Green color
add di, 24
ret
Tilt2:
mov di ,0
mov word[es:di],0x2020;Green color
add di,2
mov word[es:di],0x2020;Green color
add di,2
call Display
sub di,28
mov word[es:di],0x7020;Green color
add di,2
mov word[es:di],0x7020;Green color
add di,24
ret


;Screen Movement Function
;Copies every above Line and Paste it on very next Line Starting From 2nd Last line to Top Line
;And calls the display Function to Generate a new Line at 0 Di index
;Calls the Function OF hurdels to generate it on new line using Random Function
;takes Intrupt and change the Location of Car which is Stored in DX

;
MovScreen:
push bx
push ds
push dx
mov ax,0xb800
mov es,ax
mov ds,ax
std
mov si,3656
mov di,3816
mov dx,23
Print:
mov cx,68
rep movsw
sub si,24
sub di,24
dec dx
cmp dx,0
jne Print
push 0
push 100
call RANDNUM
pop bx
cmp bx,7
je Tilt
mov di ,0
call Display
jmp nex
Tilt:
call Tilt1
call TiltMov
call delay
call Tilt2
call TiltMov
call Tilt1
call TiltMov
call delay
mov di,0
call Display
nex:
push 0
push 30
call RANDNUM
pop bx
cmp bx,1
je Hurdle5
cmp bx,4
je Hurdle4
cmp bx,21
je Hurdle6
cmp bx,14
je Hurdle1
cmp bx,27
je Hurdle3
cmp bx, 20
je Hurdle2
En:
pop dx
in al ,0x60
cmp al,0x4b
jne Check2
sub dx,2
Check2:
cmp al ,0x4D
jne L
add dx,2
L:
push di
call PRINT_CAR
pop di
pop ds
pop bx
push 470
push bx
call printnum
add bx,1
push cx
mov cx,1000
sub cx,bx
push 310
push cx
call printnum
cmp bx,501
je Victory
pop cx
Ret
;Main Home Screen
;Prints a Complete Line including Left and Right Decors with Road and footpath
Display:
mov cx ,20
LGrass:
mov word[es:di],0x2020;Green color
add di,2
dec cx
cmp cx,0
jne LGrass
mov word[es:di],0x89B0
add di,2
mov cx ,26
Road:
mov word[es:di],0x7020;White Grey color
add di,2
dec cx
cmp cx,0
jne Road
mov word[es:di],0x89B0
add di,2
mov cx, 20
RGrass:
mov word[es:di],0x2020;Green color
add di,2
dec cx
cmp cx,0
jne RGrass
mov cx, 4
push di
sub di,130
mov cx ,5
LDeco: ;Left Decore
mov word[es:di],0x72B0
add di,2
mov word[es:di],0x2706
add di,2
mov word[es:di],0x72B0
add di,2
dec cx
cmp cx,0
jne LDeco
add di,64
mov cx ,5
RDeco: ;Right Decore
mov word[es:di],0x72B0
add di,2
mov word[es:di],0x2706
add di,2
mov word[es:di],0x72B0
add di,2
dec cx
cmp cx,0
jne RDeco
pop di
;Code for Side Decors
push di
sub di,60
mov word[es:di],0x70B1
sub di,18
mov word[es:di],0x70B1
pop di
add di,24
Ret
PrintSF:
;Writing Score USing Asci Codes
mov di,458
mov word[es:di],0x7053
add di,2
mov word[es:di],0x7043
add di,2
mov word[es:di],0x704F
add di,2
mov word[es:di],0x7052
add di,2
mov word[es:di],0x7045
add di,2
mov word[es:di],0x703A
;Writing Fule USing Asci Codes
mov di,298
mov word[es:di],0x7046
add di,2
mov word[es:di],0x7075
add di,2
mov word[es:di],0x706c
add di,2
mov word[es:di],0x7065
add di,2
mov word[es:di],0x703A
jmp D2
;Code For Generating Sound
Sound:
IN AL, 61h  ;Save state
PUSH AX  
mov     al, 182         ; meaning that we're about to load
out     43h, al         ; a new countdown value
mov     ax, 2153        ; countdown value is stored in ax. It is calculated by 
                            ; dividing 1193180 by the desired frequency (with the
                            ; number being the frequency at which the main system
                            ; oscillator runs
out     42h, al         ; Output low byte.
mov     al, ah          ; Output high byte.
out     42h, al               
in      al, 61h                                     ; to connect the speaker to timer 2
or      al, 00000011b  
out     61h, al   
INT 15h        
POP AX;restore Speaker state
OUT 61h, AL
RET
;Main Function()
Start:
;Calls the intro Screen and then takes input IF P then Moves to the PLAY function
;calling Display() 25 times to Print the Whole Display Screen
mov ax,0xb800
mov es,ax
mov ds,ax
push ax
push es
push ds
call Intro
pop ds
pop es
pop ax
mov di,0
mov bx,0 ;Score
mov cx,25
TakIn:
push ax
call Sound
pop ax
int 0x16
in al ,0x60
cmp al,0x19
jne TakIn
call clrscr
D:
push cx
call Display ;Display the Backgroud 
pop cx
sub cx,1
cmp cx,0
jne D 
jmp PrintSF
D2:
mov dx,3746   ;Position Of CAR
L1:
call delay
call MovScreen
jmp L1
Terminate
mov ax, 0x4c00
int 21h