# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT84 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/1e7c64bd4dc65e3361e3b86d90aac1b116d25f69.tar.gz?commit=1e7c64bd4dc65e3361e3b86d90aac1b116d25f69"
  version "8.4.0"
  sha256 "80067f8a333ae63d5104d76f8a328e994c851e639d17619b9322eb9ac0790afe"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 17
    sha256 cellar: :any,                 arm64_sonoma:   "fdf81ff1f8b6d7f0159fc7f90dc2d95df1ed4c4e7226fc3af08efeda230651fc"
    sha256 cellar: :any,                 arm64_ventura:  "22b590c022caa3420731efb6febd79f225fc4f938c6875236d543a4df19fbcab"
    sha256 cellar: :any,                 arm64_monterey: "a6c7386449b5928d75c7b74fee93c4daccb1812911c393e59a75df122909e98d"
    sha256 cellar: :any,                 ventura:        "17740053a4d6f92774198568ab2b33a248f7cef77e9fac5eb5ce754745c5dca6"
    sha256 cellar: :any,                 monterey:       "c10b36d434c8267ab7ccb16a98c63f358d262c626e8c28d56b8d2475c83e05aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "330f4d5712cb4b07f98025c6f0feb11feec6ac5ae2a69086b7b8c2a16176b49c"
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
