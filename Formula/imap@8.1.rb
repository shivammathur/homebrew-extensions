# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/4ef6280b9aa907378eeac7d3fde0ddd479603957.tar.gz?commit=4ef6280b9aa907378eeac7d3fde0ddd479603957"
  version "8.1.0"
  sha256 "8667de9bc4105bc54b30b92e41b6a58c1be03927df34b14f478455557dc5866c"
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
