use strict;
use utf8;
use warnings;

use Encode qw(is_utf8);
use Test::More tests => 6;

BEGIN {
    use_ok('Email::MIME');
    use_ok('Email::Sender::Simple', qw(sendmail));
};

our $utf8_subject = '〜〜テスト〜〜';
our $utf8_body = <<BODY;
〜〜テスト〜〜
〜〜テスト〜〜
BODY

{
    diag('Encoding test');

    ok(is_utf8($utf8_subject), '$utf8_subject is utf8');
    ok(is_utf8($utf8_body), '$utf8_body is utf8');
};

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

    sendmail($mail);
    pass('sendmail ok');
};

1;
