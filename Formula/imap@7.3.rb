# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT73 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580fe100065f1cd83ac2ad5a6254a1f95dde93ee.tar.gz"
  version "7.3.33"
  sha256 "c3bb3db324daed97e2c50f2755462df5b0cb4b912ab5b38c96dc6cfaca92475e"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia: "ef8a8cc5a7ae9c9535d3b391411934e19a55bf75fabaceb5dffbcca946f7f943"
    sha256 cellar: :any,                 arm64_sonoma:  "a056037bd9029825b7f94134d7e7cddfe805ffc14775c2c8eda1e7ec3c836638"
    sha256 cellar: :any,                 arm64_ventura: "d3550771332ecad1754d77ef8e693f61c267e01f238655634fd43dedf8770184"
    sha256 cellar: :any,                 ventura:       "b339a6d94d18cf95a9504d81fa7d3b8a874bb741e23456e6052345c785e98c39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37131bd2382f7bccfca21fd6ff7f3cc88c2a32c4169ee6a63f7ac0fe25b059b8"
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
