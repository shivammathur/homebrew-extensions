# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/940ff2098ea4cbc1ce711a07df958f7d531e51fa.tar.gz?commit=940ff2098ea4cbc1ce711a07df958f7d531e51fa"
  version "8.6.0"
  sha256 "52a0c3c3c924c3b1ced852e1306690dfdac516bf4c7c9077b80b4d65b44105f5"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_golden_gate: "7a71824455597daa82f61f945d1be2fe2fb7f6a30503b9b8aee65b2e9baf7776"
    sha256 cellar: :any, arm64_tahoe:       "46607278108058af4dc1883fb4627353e48244a4216e048b10a0077efb9733c3"
    sha256 cellar: :any, arm64_sequoia:     "16dd3e6f1e681c898a4074ee768b0f8619e7e8b6fedf7db6f69b5685e33a1be9"
    sha256 cellar: :any, arm64_linux:       "3dbbb4aecbefdfab9b770a2176992870f45d214f5b4fc7cf7fab91dd8b7eb9b4"
    sha256 cellar: :any, x86_64_linux:      "6f1b0d97b3ec42b6b73912f7e5e87b282a0e5153f3e1de453ecc455d250e4f23"
  end

  depends_on "shivammathur/extensions/firebird-client"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client")
    args = %W[
      --with-pdo-firebird=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/pdo_firebird" do
      safe_phpize
      ENV.append "CFLAGS", "-Wno-incompatible-function-pointer-types" if OS.mac?
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
