# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT80 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/190a0202b4601d3066088ba913c2f1bda921ad8c.tar.gz"
  version "8.0.30"
  sha256 "3b70dac41c775c41913ff3a13c77beeaee375b995f41940e62ace648119c4622"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any, arm64_golden_gate: "b11684608817709ffa2fc3ff9d0c589917c6c51047becd871662fcaa168557ef"
    sha256 cellar: :any, arm64_tahoe:       "9f72a08c3fc28cbe8ab1338996c18e1818f6410c2c1db2ad223c1eb118ea688a"
    sha256 cellar: :any, arm64_sequoia:     "ae42fbc6dd7d56db21ad71944f01935d7b71224b2d24022519cefd45ae905946"
    sha256 cellar: :any, arm64_linux:       "f7bb9b71657fe3f25a69702a3b7649dd6237f1a544905f797f14a53e6dfbe8af"
    sha256 cellar: :any, x86_64_linux:      "427f3650559036c5d3b4b6ea8097efec2e58e5e5155dc7212d6fa93222e1c3ae"
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
