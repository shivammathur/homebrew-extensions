# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT84 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.4.27.tar.xz"
  sha256 "dcf93923b0e38e0d5252b25b796520b5a47761a08b3488b6d0b5d1115764d3f0"
  head "https://github.com/php/php-src.git", branch: "PHP-8.4"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.4(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "ce033fbf02ca530bd99930ea7549734214564e7a9438b37cc4429afb851bfd5d"
    sha256 cellar: :any, arm64_tahoe:       "2cf32c9c0b21b4a1cfb114ace3daaf42bae530a121960444bc9797898b058222"
    sha256 cellar: :any, arm64_sequoia:     "f40e75a6aa7b2fb1cd3fc7d51d16cc4d03baf5b4b47e6ec03f2500d16a0c5938"
    sha256 cellar: :any, arm64_linux:       "a5eb26657bf09cfac0b8c2e84033d32676e3ee3649cbc2c7c40d27185574790e"
    sha256 cellar: :any, x86_64_linux:      "d6e552f4c1ac4aec2f197fa36fc569a03f90d9e78c548e4275098a86ae6aa169"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
