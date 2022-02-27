use strict;
use warnings;


sub selectword()
{
    my $Words='computer|radio|calculator|teacher|bureau|police|geometry|president|subject|country|enviroment|classroom|animals|province|month|politics|puzzle|instrument|kitchen|language|vampire|ghost|solution|service|software|virus25|security|phonenumber|expert|website|agreement|support|compatibility|advanced|search|triathlon|immediately|encyclopedia|endurance|distance|nature|history|organization|international|championship|government|popularity|thousand|feature|wetsuit|fitness|legendary|variation|equal|approximately|segment|priority|physics|branche|science|mathematics|lightning|dispersion|accelerator|detector|terminology|design|operation|foundation|application|prediction|reference|measurement|concept|perspective|overview|position|airplane|symmetry|dimension|toxic|algebra|illustration|classic|verification|citation|unusual|resource|analysis|license|comedy|screenplay|production|release|emphasis|director|trademark|vehicle|aircraft|experiment';
    my @lsitOfWords=split('\|',$Words);
    return $lsitOfWords[rand @lsitOfWords];

}

sub initiateWord($)
{
    my ($length)=@_;
    $length=length($length);
    my @guessArray;
    for (my $count = 1 ; $count <= $length ; $count++)
    {
        push @guessArray,"_";
    }
    return @guessArray;
}

sub askInput()
{
    print "Guess a letter : " ;
    my $guess=<STDIN>;
    chomp($guess);
    return lc $guess;
}


sub checkValidInput($$)
{
    my ($input,$guessedLetters)=@_;
    if($input=~/^\w$/)
    {
        foreach my $char (@$guessedLetters)
        {
            if($char eq $input)
            {
                print "You already Gussed \"$input\"\n";
                return 0;
            }
        }
        return 1;
    }
    print "Please enter only single alphanumeric values\n";
    return 0;
}

sub wordContains($$)
{
    my ($input,$wordChoosen)=@_;
    return index($wordChoosen,$input);
}

sub updateGuess($$$)
{
    my ($in,$wordChoosen,$gussedWord)=@_;
    my $offset = 0,my $cnt=0;
    my $result = index($wordChoosen, $in, $offset);
    while ($result != -1) {
        $cnt++;
        @$gussedWord[($result)]=$in;
        $offset = $result + 1;
        $result = index($wordChoosen, $in, $offset);
    }
    return $cnt;
}

sub displayHangman($$$){
    my ($lifeRemainning,$word,$Guesses)=@_;
    my @head=(' ','O');
    my @body=(' ','|');
    my @leftHand=(' ','\\');
    my @rightHand=(' ','/');
    my @leftLeg=(' ','/');
    my @rightLeg=(' ','\\');
        print "
        ╭-------─╮ 
        |        |
        |        $head[$lifeRemainning<=5]
        |       $leftHand[$lifeRemainning<=3]$body[$lifeRemainning<=4]$rightHand[$lifeRemainning<=2]        All Guesses : @$Guesses 
        |        $body[$lifeRemainning<=1]         Word        : @$word
        |       $leftLeg[$lifeRemainning<=1] $rightLeg[$lifeRemainning<=0] 
        |         
    ____|____";
    print "\n\n\n";
}

sub play() 
{
    my $wordChoosen=selectword(); # selects a word at random
    my $totalTurns=6,my $correctGusses=0,my @allWordsGuessed;
    my @gussedWord=initiateWord($wordChoosen); # store guessed letters by the user

    while($totalTurns>0) 
    {
        displayHangman($totalTurns,\@gussedWord,\@allWordsGuessed);
        my $input=askInput();

        while(!checkValidInput($input,\@allWordsGuessed)) # check if input is valid or already guessed
        {
            $input=askInput();
        }

        push @allWordsGuessed,$input;

        if(wordContains($input,$wordChoosen)!=-1) #check if selected word has the guessed letter
        {
            $correctGusses+=updateGuess($input,$wordChoosen,\@gussedWord);
            print "Correct guess\n\n";
            
            if($correctGusses==length($wordChoosen))
            {
                displayHangman($totalTurns,\@gussedWord,\@allWordsGuessed);
                print "Congrats! You guessed it correct, the word was : $wordChoosen\n";
                return 1;
            }
        }
        else 
        {
            # user guessed wrong letter
            print "Wrong guess\n\n";
            $totalTurns=$totalTurns-1;
        }
    }
    displayHangman($totalTurns,\@gussedWord,\@allWordsGuessed);
    print "You missed it, the correct word was : $wordChoosen\n";
    print "----------------------------------------------------------\n";
    return 0;

}


sub main
{
    my $score=0;
    my $gamesPlayed=1;
    my $exit=0;
    $score+=play();
    while(!$exit)
    {
        print "Your score = $score\n";
        print "Games played = $gamesPlayed\n";
        print "Do you want to play again (Y/N)? : ";
        $exit=<STDIN>;
        chomp($exit);
        $exit=uc $exit;
        if($exit eq 'N')
        {
            $exit=1;
        }
        else
        {
            $exit=0;
            $score+=play();
            $gamesPlayed++;
        }
    }
}

main();
