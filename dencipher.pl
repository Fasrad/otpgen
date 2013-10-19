#!/usr/bin/perl -w

%alpha = ( A => 0, B => 1, C => 2, D => 3, E => 4, F => 5, G => 6, H => 7, I => 8, J => 9, K => 10, L => 11, M => 12, N => 13, O => 14, P => 15, Q => 16, R => 17, S => 18, T => 19, U => 20, V => 21, W => 22, X => 23, Y => 24, Z => 25); 

%dig = ( 0 => A, 1 => B, 2 => C, 3 => D, 4 => E, 5 => F, 6 => G, 7 => H, 8 => I, 9 => J, 10 => K, 11 => L, 12 => M, 13 => N, 14 => O, 15 => P, 16 => Q, 17 => R, 18 => S, 19 => T, 20 => U, 21 => V, 22 => W, 23 => X, 24 => Y, 25 => Z); 

LOOP:
while(){
    print "enter E to encrypt a message, D to decrypt a message, Q to quit:\n";
    $choice=uc(<STDIN>);
    chomp $choice;
    if ($choice eq "E"){
        &encrypt;
    } elsif ($choice eq "D") {
        &decrypt;
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

