# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/5ccfb6d3550d977f95b0c8338b2e5f99e05a31b9.tar.gz"
  version "7.3.33"
  sha256 "062d12fab7d94b517a64c89da2dae480a4ffc0af72e80342166fb6e1c105be76"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "edbe6dcbcee763002148e99fea193971f0e5dc67c5a5972f9c2946167043c6d3"
    sha256 cellar: :any,                 arm64_monterey: "a7ee3532df9ba670b3fb95a79be794b101bb42efc73503fbf10c5d13d0219beb"
    sha256 cellar: :any,                 arm64_big_sur:  "3673e3705f80b0bf7937139ac73091558fb06747f35209b9d8b5e3ac30f1906a"
    sha256 cellar: :any,                 ventura:        "c6e603ba606c75809459d1accbd102bcf05f0c1407a1bcfe659d03bd4b499fa0"
    sha256 cellar: :any,                 monterey:       "1132e2ec71dd9aca6c67d1f66e10c5a58647a1f518c9933772466b8ec9ae986b"
    sha256 cellar: :any,                 big_sur:        "7a2eba89c4806c0229fe5a66a29f9baa368ca8cab9feec5249a008808b0f020c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "404e6250b90bc6e8b2fdce1e5025c8d9b607f56892c421f9263e8fa80c0b576e"
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
