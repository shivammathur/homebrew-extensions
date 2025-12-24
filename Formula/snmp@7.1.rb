# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT71 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/45db7daedb330abded7576b9c4dadf5ed13e2f0b.tar.gz"
  version "7.1.33"
  sha256 "c83694b44f2c2fedad3617f86d384d05e04c605fa61a005f5d51dfffaba39772"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "c36e0138136f08841f6e4047edd436da7a7b071f5971f16e180c42a0c17534b6"
    sha256 cellar: :any,                 arm64_sequoia: "fc0a716b92276c6803f23b1c97dea33c15475b7c0f57f26adc9b0fb9b6b862be"
    sha256 cellar: :any,                 arm64_sonoma:  "a29d50f0d025cc03eb8cee5df8fd88d9b964d6ecd726214052823dafaac338cd"
    sha256 cellar: :any,                 sonoma:        "e4ea67f887ec1a0dfcefd79cdc1418b11fc33fd6f578f56a07759d6fbdbc9fea"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f63189b476ee0d801cc365b9bd5b1f406a055e451f6ba3d05f9482a7a1ae6d37"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d0f810c3f7e407857dc850e27e23e1af251367a3407f4e8d4abd65cdf858ea44"
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
