# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT81 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.24.tar.xz"
  sha256 "ee61f6232bb29bd2e785daf325d2177f2272bf80d086c295a724594e710bce3d"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sonoma:   "ed5fe528e23ac523ee9e49b2cf80b6f837cff849bc798c936c3e4bad0a907026"
    sha256 cellar: :any,                 arm64_ventura:  "2340161767a25b1f164e2ad2d8de7e312b0fe327a957c250efe690ed83bba066"
    sha256 cellar: :any,                 arm64_monterey: "6b6a577d37a764cd1f9dc06f124a341f2a04e7d1ab6b204d7a9539b62042a888"
    sha256 cellar: :any,                 ventura:        "d986d63455ec16cac0386472a007c5882f2b197ed289233bcde507c707782c9f"
    sha256 cellar: :any,                 monterey:       "6490c22d19c800425984be9af2814c0b5a9212e8b87c2d0d5be4749de8bc38d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "eb94f4b5c3e3691e80596d9acb225460545675af1135e36cb695076ef82ebbe3"
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
