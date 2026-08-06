# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT80 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/1bb9988fd6c151c783653e3a2257c1a0897e6633.tar.gz"
  version "8.0.30"
  sha256 "1969f16cab5dbf112b0f1115279d061f29f63d8910cc56c497cff59c853f9f6c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any, arm64_tahoe:   "cca3e39be7fc3522c55d9a10f3b594b662415f7fbe2a3106a54324601a80f453"
    sha256 cellar: :any, arm64_sequoia: "ad928be6963d217e01d9bb36120793ad0d50adc11b6e2c6f09f96210143740c6"
    sha256 cellar: :any, arm64_sonoma:  "fae862eae2f3b2bfa212920e9458db60b39e6c6d94aa95deb76fbc0c7510c33d"
    sha256 cellar: :any, sonoma:        "349b0b7d513e5bc93f2b9cf78576e4fe8250a4b4504f8ed1f95fc234b3249d07"
    sha256 cellar: :any, arm64_linux:   "a61fb976c48988b1f6b6286250c32d71e47a46e64f82091dee1cd88a51a320d4"
    sha256 cellar: :any, x86_64_linux:  "0539f9118da1999688fd09e23f3f4277847b3c12f0cfca0ada7aaab44232f829"
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
