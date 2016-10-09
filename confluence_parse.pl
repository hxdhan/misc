use strict;
use warnings;
use Data::Dumper;
use feature qw(say);
use XML::Parser;

my $user = 0;
my $text = '';
my $parser = XML::Parser->new(Handlers=>{Start=>\&handle_start,End=>\&handle_end,Char=>0});
my $file = $parser->parsefile("entities.xml");
sub handle_start {
  my ($p, $elt, %atts) = @_;
  if ($elt eq 'object' && $atts{'class'} eq 'InternalUser') {
	$user = 1;
  }
  if($user) {
   	print "<".$elt;
	while (my ($id, $val) = each %atts)
	{
	    $val = $p->xml_escape($val, "'");
	    print " $id='$val'";
	}
	print ">";
   $p->setHandlers(Char=>\&char_handler,CdataStart=>\&cdata_start,CdataEnd=>\&cdata_end);
  }
  else {
   $p->setHandlers(Char=>0,CdataStart=>0,CdataEnd=>0);
  }

}
sub handle_end {
  my $p = shift;
  my $elt = shift;
  if ($user){
      print "</$elt>";
      if ($elt eq 'object') {
        $user = !$user;
	print "\n";
      }

    }
}

sub handle_char {
  my ($p, $elt) = @_;
}

sub char_handler
{
    my ($xp, $text) = @_;
    if (length($text) && $user) {
      $text = $xp->xml_escape($text, '>');
      print $text;
    }
}
sub cdata_start {
  my $xp = shift;
  print '<![CDATA[' if $user;
}

sub cdata_end {
  my $xp = shift;
  print ']]>' if $user;
}
