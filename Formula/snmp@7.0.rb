# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT70 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/da64b9b864bf43d9023d6d1d6d5b582800d72c9e.tar.gz"
  version "7.0.33"
  sha256 "c412fdeac66cb816f3f3fa5a7a6755daf3f37521d997fca771ecd40f61b22cc3"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "41eedd10faf38de2f8c95e705f1d93fee3c1e018e322b941e97600475d98f8bc"
    sha256 cellar: :any, arm64_sequoia: "987d8c91613ddfbd6b3d741d11ad2abb8cb917b5bb47c63fce8f382f24b1f757"
    sha256 cellar: :any, arm64_sonoma:  "241d1a79330e830f39fcf386ed0bd972362f187e4ecc1912b4cde70d1c0457c3"
    sha256 cellar: :any, sonoma:        "92897d4f548efb962705c44f4d9d3b30b722351eb4bae65cc664aebfcf3d8f15"
    sha256 cellar: :any, arm64_linux:   "50ed8d81c73a458fdd87994c45dab6c4fbae5ad17acda493e4f49c9f9e3805c3"
    sha256 cellar: :any, x86_64_linux:  "ace1902f226e4ca362e1b7d096a9777a8f916e93984cfe92d16e13d2ca0050cb"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
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
