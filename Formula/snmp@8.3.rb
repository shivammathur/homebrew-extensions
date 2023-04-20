# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/360e6f842c885f9e6018f603ba00ceb5cd78ef31.tar.gz?commit=360e6f842c885f9e6018f603ba00ceb5cd78ef31"
  version "8.3.0"
  sha256 "6ee93d0f0c4bb23a1f68a2a4e01da16f9c95fa8ab84ab6cba3e0b0cde25da371"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_monterey: "45d56a88b7320ef7cb791822429cc8345c8232388d09216a9360c5453906ac27"
    sha256 cellar: :any,                 arm64_big_sur:  "038f15c47cea7d250602419c4e69454c60e47030f4b79ec9af374949fed540a6"
    sha256 cellar: :any,                 monterey:       "b083a5a2006f8ce80a88b837dcf0dfa86e62e062e51b5c534560be8d5cbeab63"
    sha256 cellar: :any,                 big_sur:        "2aaa073167b58d53c0c0b668d5c59c61d7341dc830a3f203ff2dea84aaab53ea"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "efe74e632572f55696849f2ac3c469d84c61568609034db1014641cc857961e7"
  end

  depends_on "net-snmp"
  depends_on "openssl@1.1"

  def install
    args = %W[
      --with-snmp=#{Formula["net-snmp"].opt_prefix}
      --with-openssl-dir=#{Formula["openssl@1.1"].opt_prefix}
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
