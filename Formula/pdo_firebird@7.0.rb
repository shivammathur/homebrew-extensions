# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT70 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/76d932fdc0b984a1a8d9bd42bd04fb386e36135f.tar.gz"
  version "7.0.33"
  sha256 "c7363edcfbae285748026db1e4dc70d119fead29f49c13fc42a0067d1b093241"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any, arm64_golden_gate: "0bbf58ab85efc7a6ed7d33d3640a7a1b1d4f53b4b31398ec0e148ac7da55d266"
    sha256 cellar: :any, arm64_tahoe:       "c6281996f25444e452a4ce1c4afe8a5e1bf9d5e983387851ba44c284706698a8"
    sha256 cellar: :any, arm64_sequoia:     "b4205b41f015fe84525f234b9f5bc36c78da2911ea2098f206d3eca975e9e6fc"
    sha256 cellar: :any, arm64_linux:       "a991979899e29465fd078a573e8dfb5faabae3838407410cb93206b4f6352ad2"
    sha256 cellar: :any, x86_64_linux:      "d152afff2169e6474df18d48fe2b648f3afae21ee84bdda8e53ddb088bc05081"
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
