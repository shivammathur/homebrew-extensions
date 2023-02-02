# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT74 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7328f3a0344806b846bd05657bdce96e47810bf0.tar.gz"
  version "7.4.33"
  sha256 "97b817fb1d8ace67512da447496c115e998397084c741e5bef4385f5fab3fb4c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "5d75cf9fecea0fb5efa33d5a0637685387ffdf145ca0c9cf57ec8b4ea0f965cf"
    sha256 cellar: :any,                 arm64_big_sur:  "02743b1c28a873be43fc5363e7daabf35cd0aa1c25795ccb0d998ce9433e9621"
    sha256 cellar: :any,                 monterey:       "24893c89275395adb61d3d6c45899acc3143b19bccae2e14c2f4bdea5f257029"
    sha256 cellar: :any,                 big_sur:        "b0390e415a163ab83ed5c16cec42eaf41e9fa252059b1a1362d65baaa92898f5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b722cdc472f9c6fc2d370f479306ad3adf20bd71b5eb88ee88a75b71d3f8e075"
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
