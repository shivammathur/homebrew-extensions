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
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "aa615f3afa6633053c777aa9c2392a501cb2247a2b69c2550d4910ba1e2a9e9b"
    sha256 cellar: :any, arm64_sequoia: "47156e7b1b6920d4bc83615b4f28ee9df526e2a02cccc1cd21e507bb6b7b8c8b"
    sha256 cellar: :any, arm64_sonoma:  "f4f1e80978de24e54b964f724e8d59fc032a214653818dd232034a5442d374c3"
    sha256 cellar: :any, sonoma:        "f8960c817d9b2c49d073fb5101cbc8b5ee46eea03e97eb9c1b8f8be477c34dcd"
    sha256 cellar: :any, arm64_linux:   "98e637d6ef82d679827df33963aa1303dc3f6ce8c991885089293f31775ce350"
    sha256 cellar: :any, x86_64_linux:  "0cad6f888c736f30aa3077f25a9218270b01310fce84cf04080ead1bf904efb0"
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
