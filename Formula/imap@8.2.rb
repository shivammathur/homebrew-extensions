# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/9c6b843ff0f4b7af926a69ef89d7f9ec1db31866.tar.gz?commit=9c6b843ff0f4b7af926a69ef89d7f9ec1db31866"
  version "8.2.0"
  sha256 "4a13f0555a092c1cf883670c9898041a1deb3daebc33877a7e083487fd93a7fc"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 20
    sha256 cellar: :any,                 arm64_big_sur: "8f3e87ccbc5f7b282c78b9d52c934b9000cb378477f8a521b15355442abd0932"
    sha256 cellar: :any,                 big_sur:       "6f3e96690b7017c6c82d1ac207192eef4fc562d547fb946a0695d23258da4b55"
    sha256 cellar: :any,                 catalina:      "5b4d62858ff8f395b472fe17a20c78455464c460d3cf8ab8bbd26a415bfe581e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "14c27ce0c3bb39b581f9676aa7051e23dbceebe95c7bf0473a591b72c758512a"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
