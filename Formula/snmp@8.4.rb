# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.7.tar.xz"
  sha256 "e29f4c23be2816ed005aa3f06bbb8eae0f22cc133863862e893515fc841e65e3"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.4.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "79b8b7a4091a2aabb335d0df4b1df0ed39b34da36f17a62df7a2dbbab6554d99"
    sha256 cellar: :any,                 arm64_sonoma:  "995b717760d39acb47097aa974ca3e3142a16b84eb9f825eeac685d2d50b4188"
    sha256 cellar: :any,                 arm64_ventura: "ee6ec8f72480f009c591aac495f8bc71bbcda925d5d495d4c8a1ab3f133a7259"
    sha256 cellar: :any,                 ventura:       "a8dd3179b627fc0240511187790c44a505c82091cfc6fb919e0cf9fe569d7fc3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e685d8fe2bdeb039d87a07dbb22666ab576fc29736aa03b63cce2253e1cafc67"
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
