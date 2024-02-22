# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT82 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.16.tar.xz"
  sha256 "28cdc995b7d5421711c7044294885fcde4390c9f67504a994b4cf9bc1b5cc593"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "7bb7000760c10dbcd8542d7d2d638b803dbeac90f301337937d3f27ec49a09aa"
    sha256 cellar: :any,                 arm64_ventura:  "889473598798ad7b11ec9c75985acc8a56a088db9efe7865bf85e2adafd7347e"
    sha256 cellar: :any,                 arm64_monterey: "d6e1dd78990aa3735f23516d92d4516328dcf147f6a690b5d8b1ddd2861182f1"
    sha256 cellar: :any,                 ventura:        "a2739c4b34717eb95e1d8463acf4e6b450eccfbb0dce00751c54cf6af040a1b8"
    sha256 cellar: :any,                 monterey:       "4d3649a0ff3dda3aca53c2f79ce48e1a7458e6b99e773ea4127ef4d1ae0ea474"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "af4a835ba81e04bbed1367d2fbc328749baf87231067bb0cc2310551c4b29cab"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
