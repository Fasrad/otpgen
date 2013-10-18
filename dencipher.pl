#!/usr/bin/perl -w

%alpha = ( A => 0, B => 1, C => 2, D => 3, E => 4, F => 5, G => 6, H => 7, I => 8, J => 9, K => 10, L => 11, M => 12, N => 13, O => 14, P => 15, Q => 16, R => 17, S => 18, T => 19, U => 20, V => 21, W => 22, X => 23, Y => 24, Z => 25); 

%dig = ( 0 => A, 1 => B, 2 => C, 3 => D, 4 => E, 5 => F, 6 => G, 7 => H, 8 => I, 9 => J, 10 => K, 11 => L, 12 => M, 13 => N, 14 => O, 15 => P, 16 => Q, 17 => R, 18 => S, 19 => T, 20 => U, 21 => V, 22 => W, 23 => X, 24 => Y, 25 => Z
 ); 

LOOP:
while(){
    print "enter E to encrypt a message, D to decrypt a message:\n";
    $choice=uc(<STDIN>);
    chomp $choice;
    if ($choice eq "E"){
        &encrypt;
    } elsif ($choice eq "D") {
        &decrypt;
    } else {
        print "enter E to encrypt a message, D to decrypt a message:\n";
        next LOOP;
    }
}
sub encrypt{

    print "enter your plaintext to encrypt:";
    $mess=<STDIN> ;
    chomp $mess;
    $mess=uc($mess);
    $mess=~s/\s//g;

    print "enter your pad text:";
    $pad=<STDIN>;
    chomp $pad;
    $pad=uc($pad);
    $pad=~s/\s//g;

    print "your ciphertext is as follows:\n";
    @pad=split'',$pad;
    @message=split'',$mess;
    $ind=0;
    while(@message){
        print "ind:$ind,";
        $messd=$alpha{$message[$ind]};
        print "messd:$messd,";
        $padd=$alpha{$pad[$ind]};
        print "padd:$padd,";
        $cypher=($padd+$messd) % 25;
        print "cypher:$cypher,";
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

    print "enter your pad text:";
    $pad=<STDIN>;
    chomp $pad;
    $pad=uc($pad);
    $pad=~s/\s//g;

    print "your plaintext is as follows:\n";
    foreach(split '', $mess){
        $messd=$alpha{$mess};
        $padd=$alpha{$pad};
        $cypher=($messd-$padd) % 25;
        print $cypher;
        print $dig{$cypher};
    }
    print "\n";
    return;
}

