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
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "b27c33bb4f219c671e60f1928baa136a19cd2d283f46a5a3c02c4411cebe8a6e"
    sha256 cellar: :any, arm64_sequoia: "3970af65b7ed573c0a282c6b377d0b2e5490caa57665a2ac5a026a042c2fdfe0"
    sha256 cellar: :any, arm64_sonoma:  "2e4503cc6b808558af7c41bf4732f20b5988707a22ab3bcf18fcac51d787a7b9"
    sha256 cellar: :any, sonoma:        "9c3d358934a53c678ae6fd945c7eb8a8bc45a186b3f1411cfe4a43b2c42efcf7"
    sha256 cellar: :any, arm64_linux:   "a690758413a36fac8ae26a2bf199865d9cad657c92287e0bfc0314e00e552ce5"
    sha256 cellar: :any, x86_64_linux:  "6aa890c84cda404f99039493a8f96c3acc1a8e8fe278e9b4b1aa9f32f3588018"
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
