# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT73 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/34456d7558a6a1741fab48074c0c42d89b4834ac.tar.gz"
  version "7.3.33"
  sha256 "14d7086d3098273da345e1917ca44b6aee8f2f12db230ed09e03e5bfeaf5fab4"
  revision 3
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "8362e370867c67b5435ccbfcc4e5d89631d940ef62de0db4f92d8e3c4cda6e97"
    sha256 cellar: :any, arm64_tahoe:       "de79e87b59cde753a25078b30e8c7ecba0d3a2cad13b20ddd021baf45577048c"
    sha256 cellar: :any, arm64_sequoia:     "10955513ae842801d636c617c93a2e6441bbdd21b010813f622c7648d5f185b1"
    sha256 cellar: :any, arm64_linux:       "ca5335ce640bde90f7ded38418e2f787268992d1dc6a912a9739740803836847"
    sha256 cellar: :any, x86_64_linux:      "ab01c50fbef776681665d2e02993c12ffd030730095e2bb6dd65a83faad0661f"
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
