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
    sha256 cellar: :any,                 arm64_sonoma:   "900b2ed3753fc36ee27565a731aaeb779964acd3df52b6b3a35ff81aef6dded7"
    sha256 cellar: :any,                 arm64_ventura:  "2899f044201e3be08024f13d0d627be723654d526a729e6f9dd189795270598a"
    sha256 cellar: :any,                 arm64_monterey: "cd2a9e724181cfc3ee9d6836deabb9d3edfea19cf9d7b71407490af0b7bc8702"
    sha256 cellar: :any,                 ventura:        "474fd30b66a22a164f6435ce96d68e388bc7cde7015fb5733652c9b6cd19fbe2"
    sha256 cellar: :any,                 monterey:       "4dab11141f8c0e9c181faa2720abbfa0f6e5c02d51088d6ff7d477c48fee9421"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "25f8847bfdccc8a079fd88781c578606e1b30f5939570ed1fc185e9887f7abe5"
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
