# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/d600a45b658e5e99e5c7bc6b997154eb6127d1c4.tar.gz"
  version "7.3.33"
  sha256 "ec1986574a674214f4106d87778f0aac7f4458e4586fdea599fe8da1990b3c29"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "a4ab490a03b5468bd00913d51b24ebfc5583a96860308696268a0a501f6d3e31"
    sha256 cellar: :any,                 arm64_big_sur:  "4dfece3b6bb13d636a8738614b435ae7c38186e3b93fa4b0ee0e94a4409acc38"
    sha256 cellar: :any,                 ventura:        "b12c489a3426ccc9222834796116ea3316de1b22bb7f64727f0eef7cc96a68ea"
    sha256 cellar: :any,                 monterey:       "a082b0dbb35fdf10957c8cb4977a94d974689ce02617520ef5f1ccdfc52f62ef"
    sha256 cellar: :any,                 big_sur:        "21dfec6801fe5e771e1f057ed5435a7d366b90cebea84741494611ddd4c0b45b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "03441c19e61582700a6d1037104cb06e618e8212bf49ad1a4b06169f6f0a760b"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
