# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT72 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/269a597ce7d22198bca3745157a45783d86da7ac.tar.gz"
  version "7.2.34"
  sha256 "01e8a6bf83a7b5e77ec6b02d5933e12a39911a4f34bfa572d99ac0020c9513b0"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "b5f1f0834dc410577cb55bfb3e1112a217c7932d7b4a86269132fdc4e6eefe8e"
    sha256 cellar: :any,                 arm64_sonoma:  "fbf32a583a82d2b427c46bc9481f2e295caa6c3368e7667f001a93ffc1b1effc"
    sha256 cellar: :any,                 arm64_ventura: "8227c60d3a2986233b9484a269b3afc2e14aa38665b328c1ff2aa457b53913d4"
    sha256 cellar: :any,                 ventura:       "53b09db5f005cf93aed53f458b6aa243f5b24c9e4f0871ee648d1249f66edacc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2711d6dc1b96a5f3d8375f6f107577006a4bdd5dda5e8c3e7293a12099bc0d50"
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
