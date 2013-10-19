#!/usr/bin/perl -w

%alpha = ( A => 0, B => 1, C => 2, D => 3, E => 4, F => 5, G => 6, H => 7, I => 8, J => 9, K => 10, L => 11, M => 12, N => 13, O => 14, P => 15, Q => 16, R => 17, S => 18, T => 19, U => 20, V => 21, W => 22, X => 23, Y => 24, Z => 25); 

%dig = ( 0 => A, 1 => B, 2 => C, 3 => D, 4 => E, 5 => F, 6 => G, 7 => H, 8 => I, 9 => J, 10 => K, 11 => L, 12 => M, 13 => N, 14 => O, 15 => P, 16 => Q, 17 => R, 18 => S, 19 => T, 20 => U, 21 => V, 22 => W, 23 => X, 24 => Y, 25 => Z); 

{
local $/;
$help=<DATA>;
}

LOOP:
while(){
    print "enter E to encrypt a message, D to decrypt a message, H for help, Q to quit:\n";
    $choice=uc(<STDIN>);
    chomp $choice;
    if ($choice eq "E"){
        &encrypt;
    } elsif ($choice eq "D") {
        &decrypt;
    } elsif ($choice eq "H") {
        my $pager = $ENV{PAGER} || 'less';
        open(my $less, '|-', $pager, '-e') || die "Cannot pipe to $pager: $!";
        print $less $help;
        close($less);
        next LOOP;
    } elsif ($choice eq "Q") {
        exit;
    } else {
        next LOOP;
    }
}
sub encrypt{

    print "enter your plaintext to encrypt:";
    $mess=<STDIN> ;
    chomp $mess;
    $mess=uc($mess);
    $mess=~s/\s//g;
    if($mess=~/[^A-Z]/){print "Illegal characters in message.\n"; return}

    print "enter your pad text:";
    $pad=<STDIN>;
    chomp $pad;
    $pad=uc($pad);
    $pad=~s/\s//g;
    if($mess=~/[^A-Z]/){print "Illegal characters in pad text.\n"; return}

    print "your ciphertext is as follows:\n";
    @pad=split'',$pad; $pad_length=scalar(@pad);
    @message=split'',$mess; $mess_length=scalar(@message);
    if($mess_length > $pad_length){print "Not enough pad!\n"; return}

    $ind=0;
    while($ind < $mess_length){
        $messd=$alpha{$message[$ind]};
        $padd=$alpha{$pad[$ind]};
        $cypher=($padd+$messd) % 26;
        print $dig{$cypher};
        $ind++;
    }
    print "\n";
    return;
}
sub decrypt{

    print "enter your ciphertext to decrypt:";
    $mess=<STDIN> ;
    chomp $mess;
    $mess=uc($mess);
    $mess=~s/\s//g;
    if($mess=~/[^A-Z]/){print "Illegal characters in ciphertext. Cannot continue.\n"; return}

    print "enter your pad text:";
    $pad=<STDIN>;
    chomp $pad;
    $pad=uc($pad);
    $pad=~s/\s//g;
    if($mess=~/[^A-Z]/){print "Illegal characters in pad text. Cannot continue.\n"; return}

    print "your decrypted message is as follows:\n";
    @pad=split'',$pad; $pad_length=scalar(@pad);
    @message=split'',$mess; $mess_length=scalar(@message);
    if($mess_length > $pad_length){print "Not enough pad!\n"; return}

    $ind=0;
    while($ind < $mess_length){
        $messd=$alpha{$message[$ind]};
        $padd=$alpha{$pad[$ind]};
        $cypher=($messd-$padd) % 26;
        print $dig{$cypher};
        $ind++;
    }
    print "\n";
    return;
}
__DATA__

HOW TO USE A ONE-TIME PAD, BY HAND

Private communication over computer networks is hard. 

For the ultimate in privacy, we must assume that all computer systems 
are compromised. Data encryption is no protection if the computer system itself
is compromised either through the OS, malware, keyloggers, powerline 
noise analysis, Van Eyck phreaking, backdoors hidden in CPU microcode, embedded 
3G modems hidden in silicon phoning home (google: Sandy bridge kill switch)
The only way to be REALLY sure that a computer message is private 
is to encrypt your message manually before even typing it into a computer.  

One way to do that is using a one-time pad. One-time pad encryption is 
absolutely unbreakable, provided:

--the pad is random
--the pad is never reused, even in part
--the pad remains secret

In addition to the above points, both parties (Alice and Bob) must have copies
of the pad ahead of time, and ideally, they must agree ahead of time what
pad data will be used to transmit future messages. 

---ENCRYPTING A MESSAGE BY HAND---
0. Decide what section of pad to use. Since the pad must never be reused, and 
is ideally destroyed after being used, a convention must be established ahead 
of time to prevent you and your counterpart from using the same section of 
pad. The most straightforward is to use different pads for A->B messages and 
for B->A messages. You can communicate instructions regarding the 
pad to be used "in the open" along with your message, but you cannot rely on 
that as a system because Bob might have have already used that same section of pad 
before he receives your message, and he may have already destroyed it.  

1. Write down your plaintext message. Remove all spaces. Remove all 
punctuation; spell out STOP or PARAGRAPH if you really need punctuation. 
Use all-caps, A-Z. Spell out all numbers either in English or your 
favorite spelling alphabet.

2. For each digit of your message, add the numerical value (A=0, B=1, etc.)
of your plaintext digit to the numerical value of the one-time-pad digit. If the 
result of the addition goes bigger than 25, then "wrap around" back to A and keep going 
(e.g. 24=Y, 25=Z, 26=A, 27=B, etc.)

3. Send the message 

4. According to your level of confidence and paranoia, destroy the pad used to send the message. 

---DECRYPTING A MESSAGE BY HAND---
0. Determine what pad data the message was encrypted with, either through established
convention or by following the instructions sent with the message

1. For each digit of the ciphertext, subtract the numerical value (A=0, B=1, etc.) 
of the one-time-pad digit from the numerical value of the the ciphertext digit. If 
the result of the subtraction is a negative number, then "wrap around" and keep going 
(e.g. 1=B, 0=A, -1=Z, -2=Y, etc.) The result is the recovered plain text message.

3. According to your level of confidence and paranoia, destroy the pad used to decrypt the message. 

HELPFUL RESOURCES

A   -26     0    26
B   -25     1    27
C   -24     2    28
D   -23     3    29
E   -22     4    30
F   -21     5    31
G   -20     6    32
H   -19     7    33
I   -18     8    34
J   -17     9    35
K   -16    10    36
L   -15    11    37
M   -14    12    38
N   -13    13    39
O   -12    14    40
P   -11    15    41
Q   -10    16    42
R    -9    17    43
S    -8    18    44
T    -7    19    45
U    -6    20    46
V    -5    21    47
W    -4    22    48
X    -3    23    49
Y    -2    24    50
Z    -1    25    51

-----EXAMPLE OTP 6D9TH3----
IMOJVZHSNE  1
PPEGWMXXVP  2
DHSOMIEYUG  3
XTSHPLDISA  4
-----END OTP 6D9TH35 ----

-----BEGIN OTP MESSAGE, PAD 6D9TH3, LINE 2----
WPQSAD
-----END OTP MESSAGE-----

The message above should decrypt to "HAMMER" when line 2 of pad 6D9TH3 is used for 
encryption and decryption. 

