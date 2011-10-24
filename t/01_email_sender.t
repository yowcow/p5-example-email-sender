use strict;
use utf8;
use warnings;

use Email::MIME;
use Email::Sender::Simple qw(sendemail);
use Test::More tests => 2;

our $utf8_subject = '〜〜テスト〜〜';
our $utf8_body = <<BODY;
〜〜テスト〜〜
〜〜テスト〜〜
BODY

{
    diag('Sending UTF-8 email test');

    my $mail = Email::MIME->create(
        header_str => [
            From    => 'you@example.com',
            To      => 'somebody@example.com',
            Subject => $utf8_subject,
        ],
        attributes => {
            content_type    => 'text/plain',
            charset         => 'UTF-8',
            encoding        => 'base64',
        },
        body_str    => $utf8_body,
    );

    isa_ok($mail, 'Email::MIME');

    sendemail($mail);
    pass('sendemail ok');
};

1;
