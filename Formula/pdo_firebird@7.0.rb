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
    rebuild 3
    sha256 cellar: :any, arm64_golden_gate: "b9c8a60a131439b9e820d300a66338f88159c7527512d038fcfdd01872d1cae6"
    sha256 cellar: :any, arm64_tahoe:       "2a3510c9b77e024ed9c6691a385aad5556a4a8148fc3efcd0eb91bf654faae5f"
    sha256 cellar: :any, arm64_sequoia:     "a1d65c5d2c8a321d76ed889b172cc3089d46fcf449217b5b12f81a783190f80a"
    sha256 cellar: :any, arm64_linux:       "8d4da5aba0d1a77002c60f5dee980edfa8978e78276bda853e85d98f9d2f4890"
    sha256 cellar: :any, x86_64_linux:      "a29744c8ee2b4aed06b9789ae9931332d28ffa7c8198501312c41850dafa6304"
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
