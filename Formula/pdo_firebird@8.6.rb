# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/f4a17fdefd18ab40807a82c4526c52fdcb4a875a.tar.gz?commit=f4a17fdefd18ab40807a82c4526c52fdcb4a875a"
  version "8.6.0"
  sha256 "84d869a8fe3e5d3baf17b60718f19dd687178b36d7827050ed962a93cce79c52"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 16
    sha256 cellar: :any, arm64_tahoe:   "9a7d703135dc7d8adbc7a035fa485c762fc07d56a0131c6194ccca1fb2f00699"
    sha256 cellar: :any, arm64_sequoia: "7fb6395a877436f6c87838cafb83af367c612e10c7243e73b19cb742bcd6506b"
    sha256 cellar: :any, arm64_sonoma:  "72baf7d9909c4837007de139d4a6904023a9caa22de64247c9d50ff630ae24df"
    sha256 cellar: :any, sonoma:        "d8f8681c944c87694281885d9b60d42f567cd654e996ab3e07ff7c26345bf6c4"
    sha256 cellar: :any, arm64_linux:   "6329b91f8366f29cec32d136be9e0e792bb7aeddad0547b8cae129ba0030ece9"
    sha256 cellar: :any, x86_64_linux:  "90ffe23c220f9d8e80e5e8d3f4267b0583587a0bd6caaa26f2a0a6aade7fa32c"
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
