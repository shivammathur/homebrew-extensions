# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/fd8dfc4248d5270417e3c986a50382377153f4ff.tar.gz?commit=fd8dfc4248d5270417e3c986a50382377153f4ff"
  version "8.1.0"
  sha256 "a4340fa3e6a920245c843290393fe3d1c4c16661e670ef48e5264a68816e67fb"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 27
    sha256 cellar: :any, arm64_big_sur: "bbc6f96d62fbe7297d25327e91a38891901198b4e687d747b741751afdb855be"
    sha256 cellar: :any, big_sur:       "e3c238fb5b4d44f8ef1cf22792db374d6847dab76a066f3295db6e1972b45504"
    sha256 cellar: :any, catalina:      "a5abfd0766da5bbb5bd0863be15ce776dd8caa176374a03886466408cf7729ca"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

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
