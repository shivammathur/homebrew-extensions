# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT87 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/3d857e6158c0922510ca26c642ed15b2998fae8a.tar.gz?commit=3d857e6158c0922510ca26c642ed15b2998fae8a"
  version "8.7.0"
  sha256 "1cb4aae7a6c640b637bf0e8ebf01ff45ad7931a442ad69cbab39086c3d04e5ed"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "3bf6f62c304e63cc012ae45a3f940fdc30d00b76b90edea07b4445af799d6b2a"
    sha256 cellar: :any, arm64_tahoe:       "8a2c02f7169111b7772926a516b19c8e7651b320e01a99cfd47c4b6efb6a3706"
    sha256 cellar: :any, arm64_sequoia:     "12e26d950e2de8ce8a44015f6baba036724f8d2f3ef7d202266f0ae69f8461f4"
    sha256 cellar: :any, arm64_linux:       "595e0cb72dc5d9615af6a469eba0c863c4f92ee417255e0f9719ddff1aa421ec"
    sha256 cellar: :any, x86_64_linux:      "7cb999845d322297f73c88c34003ec017c48bb29b27092c3e273e845f5e702ac"
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
