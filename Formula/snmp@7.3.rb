# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b9413f1c99872b744c15f807e811fd280842ed28.tar.gz"
  version "7.3.33"
  sha256 "d46f032f9253f219cafdf5d52c274bc52cca2b6af9c799fa71cdcdd7c077b298"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "1b839efe3d949f0dc62bcf989b0d67019bad45efe5445e4b12220d47b312292f"
    sha256 cellar: :any,                 arm64_big_sur:  "e757fb93fd19ebf2013128623180eca8f55e473bcf2fbbc93be7b26ccea88c9f"
    sha256 cellar: :any,                 monterey:       "a654e7c160528712236d3c9659f19f8d718b2bdd5315ff9807a43c12562c84c8"
    sha256 cellar: :any,                 big_sur:        "d41310d5036bd35a04d304d0beccd943d93625d77f23a9e83f644379cf339fdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "251b40d04acc1d7a9cbb99700fdb0fe557da8adc03cd022e10f5239fc16c62ce"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
