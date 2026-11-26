# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT73 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/2013f21a26a5d3d3adefc2a6f903ff28ad2334e6.tar.gz"
  version "7.3.33"
  sha256 "69bf22cebb9cb2c381ca68be7088fdff5751c37d667286f9f11ff984e8fe5889"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    manifest_sha256 "9d20d96e7f5abff64a4a73ea4e8d7b796692d4dcc9c30a1bcabe72969c60a752"
    sha256 cellar: :any, arm64_golden_gate: "f2a903835c68b46aa3322109647083346383a45daee8f694669a60a3f92b8ec8"
    sha256 cellar: :any, arm64_tahoe:       "3504cd908b002c16f2609c85d1cb6fc50127a83dc81d8ffff15fa4c1a75a08c1"
    sha256 cellar: :any, arm64_sequoia:     "fd217d347723c38bf4122b55e5a97e4b28e33f5114104f44cad5f5f27218304c"
    sha256 cellar: :any, arm64_linux:       "ad58debc8442fe750fe7de1e94a5a69a76c210e758d6647ec129cfa6d6a64148"
    sha256 cellar: :any, x86_64_linux:      "24cbdf88d5b12316154be028ca7268b08db002f18c6e8b0cd942d821731675b0"
  end

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types"
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
