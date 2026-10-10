# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/64ca21fc4a956b8d2c151943dc22dbedb889f01d.tar.gz"
  version "7.3.33"
  sha256 "ffe700b4ddaf86b580bd5176bdbd2bfae785b9eb6786dde06afe6ce77e665ca7"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "60e7572c38a003b1267b5809e9933b329e8f0eb82c4bafdb8bef863b3f979709"
    sha256 cellar: :any, arm64_tahoe:       "9d530f947d0a49dc88d4cc06ad8d02127634e378052e745c49b3e712e4d7e483"
    sha256 cellar: :any, arm64_sequoia:     "d0d600c8cb2242c1c9fbcabc5dbd006c2c3ef8c5697043f8ecb06502be5c7641"
    sha256 cellar: :any, arm64_linux:       "fa0543cc22664cfe6052e0a9d470e99f91c0669c58ebb3508bcd3f0777ba8631"
    sha256 cellar: :any, x86_64_linux:      "757c5d30bcaa935bfbe521bcd63bca68d739f1312846255582a6d85fde376633"
  end

  depends_on "net-snmp"
  depends_on "openssl@4"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@4")}
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
