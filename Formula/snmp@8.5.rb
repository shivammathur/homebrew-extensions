# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT85 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c31c697a856a2e0defa0f97517fda3fd043e5a79.tar.gz?commit=c31c697a856a2e0defa0f97517fda3fd043e5a79"
  version "8.5.0"
  sha256 "038694004d757c723a2c747e8c796b72bcff8b715ab4609d8c31148fd6273566"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_tahoe:   "61b9fd1f0a34c957c6647146a16ca4dddbc9becf95bcd7e279f98266ae1fb7bb"
    sha256 cellar: :any,                 arm64_sequoia: "294d9f984f24050568e3598fcc7a4bd8ee9161258716fb03e3dca30481a89a44"
    sha256 cellar: :any,                 arm64_sonoma:  "6f40ede027c153bca73b6f57ca8722a987c2b818a028cffb06af8bc4144d7b18"
    sha256 cellar: :any,                 sonoma:        "8da2ab47025a51f2c718bda31714214c1dec71b1850523e7ec694c33480665dc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5a5fc625fa819c55fcc0601277f22de9131576c6dc39c1956f84814a57f3a9f8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "dfed425c3fec30bf571c37ee546475b6c58563a061e53246bd36639c435eee9c"
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
