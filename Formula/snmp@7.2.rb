# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/580ff94139aa2f0383dae4da1d40fcf726b27a31.tar.gz"
  version "7.2.34"
  sha256 "cbf4d0b35b53b32b303b7e7ec171acc097094534b1e068b2c66abfce6008c4c0"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "61448529c7d48fb7ef3cae6b5b9a6b5e391c1718dcb352c5e67433cd7b7b8d18"
    sha256 cellar: :any,                 arm64_sequoia: "ee72c922ef081acd5d603e6a4ad63901ad739078bf63cd5a5f28b9793870c629"
    sha256 cellar: :any,                 arm64_sonoma:  "22972ab88f2ca73fab34f7f4a3766d70cecdcf84992c531f1d75da716f7b4ce0"
    sha256 cellar: :any,                 sonoma:        "ff668cb347cd9db727b848e204b009be6a3624ae73825a73e5b7c4bafd2f3f08"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c7136a57ab78ed55b5a9b094f993e02ca48c999e9dd6315e5567ff7dba5904e0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1d49686748955b4b6a9c6dcc3947c5595f56623e2da2be5bef82ae8e55d8952"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    # Work around configure issues with Xcode 12
    ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"

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
