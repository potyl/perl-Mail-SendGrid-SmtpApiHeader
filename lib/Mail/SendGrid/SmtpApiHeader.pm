package Mail::SendGrid::SmtpApiHeader;

use strict;
use warnings;
use JSON;

our $VERSION = '0.01';

sub new 
{
  my $class = shift;
  return bless { 'data' => { } },  ref $class || $class;
}

sub addTo 
{
  my $self = shift;
  push @{ $self->{data}{to} }, @_;
}

sub addSubVal 
{
  my $self = shift;
  my $var = shift;
  push @{ $self->{data}{sub}{$var} }, @_;
}

sub setUniqueArgs
{
  my $self = shift;
  my $val = shift;
  $self->{data}{unique_args} = $val if ref $val eq 'HASH';
}

sub setCategory 
{
  my $self = shift;
  my $cat = shift;
  $self->{data}{category} = $cat;
}

sub addFilterSetting 
{
  my $self = shift;
  my $filter = shift;

  my ($settings) = ( $self->{data}{filters}{$filter}{settings} ||= {} );

  while (@_) {
    my $setting = shift;
    my $value = shift;
    $settings->{$setting} = $value;
  }
}

sub addUniqueArgs
{
  my $self = shift;

  my ($unique_args) = ( $self->{data}{unique_args} ||= {} );

  while (@_) {
    my $name = shift;
    my $value = shift;
    $unique_args->{$name} = $value;
  }
}

my $JSON;
sub asJSON 
{
  my $self = shift;
  $JSON ||= _build_json();
  return $JSON->encode($self->{data});
}

my $JSON_PRETTY;
sub asJSONPretty
{
  my $self = shift;
  $JSON_PRETTY ||=  _build_json()->pretty(1);
  return $JSON_PRETTY->encode($self->{data});
}

sub as_string 
{
  my $self = shift;
  my $json = $self->asJSON;
  $json =~ s/(.{1,72})(\s)/$1\n   /g; 
  my $str = "X-SMTPAPI: $json";
  return $str;
}

sub _build_json {
    my $json = JSON->new;
    $json->space_before(1);
    $json->space_after(1);
    $json->ascii(1);
    return $json;
}

1;
