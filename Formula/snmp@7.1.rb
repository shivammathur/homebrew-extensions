# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/dca4c0c085063632757e8f8d296e06aaff2159e9.tar.gz"
  version "7.1.33"
  sha256 "c16d623df64f5f4823b15880350923498ec0003af815a8c121a53b8755e14914"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "c1741423db912d78a59f511fca16ce6d91121a74d4f759bb4649b93718df6c92"
    sha256 cellar: :any, arm64_sequoia: "b9e82ea415c2239c779a2c3f564b536c7fa8acc0fa67a4a29af2a97830fdfae2"
    sha256 cellar: :any, arm64_sonoma:  "e596d91efcb2041be9e4a35f3e0b8908dbe62c190672fd8231e023c8e50ec25e"
    sha256 cellar: :any, sonoma:        "65a8c6cfc1391854ffb32fa2165fff1a79a71796882bc1701a1c5eb904f24689"
    sha256 cellar: :any, arm64_linux:   "b93c29c0d6466fc1f293aa38ccf786387391b2045b0047b32e6d2117a7c1bfcc"
    sha256 cellar: :any, x86_64_linux:  "be997a7b3a31389cfd93d8a81cd0a26d33d42f552967757ead2d2a650324dab5"
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
