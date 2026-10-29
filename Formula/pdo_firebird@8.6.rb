# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/17cfa007d5daf760cbcc76916fb52d673c9e530f.tar.gz?commit=17cfa007d5daf760cbcc76916fb52d673c9e530f"
  version "8.6.0"
  sha256 "a8dac945f8cf84d8561e75febe12b583afb753f36a8c66fb665dbe8f49019d2d"
  revision 2
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any, arm64_golden_gate: "21b0a8720b1085001ff7be5862c3a9931cc51ea6eabba778d17f623ce98f8c61"
    sha256 cellar: :any, arm64_tahoe:       "ce00d9da47cee29bd8bac08bb38160e96058dd824b16aa576208adddce7d1a3d"
    sha256 cellar: :any, arm64_sequoia:     "387cad437682bbc438d771680d27cd8ac549bfd87075ae208d15ca9fb6ac8e56"
    sha256 cellar: :any, arm64_linux:       "4523cc451c6e87b0cebab738e69c82405a15a4d1c01c8c9522a96b2e23e4623d"
    sha256 cellar: :any, x86_64_linux:      "b4a5b176bbfe78868ca32fbbe2e216abb2491d13065f0d159f304943560d84de"
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
