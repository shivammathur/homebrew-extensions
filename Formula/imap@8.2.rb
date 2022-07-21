# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/804c3fc821c8a70eeeed4305f2dd3eb367f22301.tar.gz?commit=804c3fc821c8a70eeeed4305f2dd3eb367f22301"
  version "8.2.0"
  sha256 "a7f3b7b43a02284f58a7acb36462eaed77a341948e4c8a03dc60c293a0145692"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 64
    sha256 cellar: :any,                 arm64_monterey: "646625cc0609e3c41f49143c76ba8d36c5f590178436fb683565ed1a8683a14b"
    sha256 cellar: :any,                 arm64_big_sur:  "49a65fc762ce24940bc0fe53cbe49f62e2fba8fbfc0642e35667af741594581d"
    sha256 cellar: :any,                 monterey:       "ef59eedef213cb81c7b8bb922359cf2099020422b0df12e641686110a6d83c56"
    sha256 cellar: :any,                 big_sur:        "22ccd17a2a5d4cc1b7054f91a0d0b8126fe85738c4b8321620c894b9063b0f6c"
    sha256 cellar: :any,                 catalina:       "a16b56beb6208f36c8c3b5c0e9fc6882e5e33a5f9212d35a890c0c7cef205c46"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9c9c5efafb50d07bf6a62cfdd842976e6ff00e78be8ecf6f6d844d22c3e6d1c9"
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
