# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.6.tar.xz"
  sha256 "53c8386b2123af97626d3438b3e4058e0c5914cb74b048a6676c57ac647f5eae"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "3c5c744893e47123ce4c598e13a5fe770ccfb45f8f98cab322f452a4222188d5"
    sha256 cellar: :any,                 arm64_ventura:  "fc6cd12f50dfdef3dd49ada00ccebf7f097940b6fb54ef7fb7b3ed25cb8fd2aa"
    sha256 cellar: :any,                 arm64_monterey: "97fc7e3293c339fd94ca1bf0286145b3cb7857d6daf211870fc309007f396edd"
    sha256 cellar: :any,                 ventura:        "7bc27e22d02302e23021949ff2e963e1c907cb8b9dbfd200e67bd81fdafe1368"
    sha256 cellar: :any,                 monterey:       "1e6bac3099a4aac118c282922958feec74573340dfaa99c113b8939ebecf49ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "44d4066b29433dc194b32c3fdd762312edc369b3860aab93c4d473e6081147e5"
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
