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
    rebuild 6
    sha256 cellar: :any, arm64_golden_gate: "97aff6be0930ce5bee8c357e57eb8c4c10653ccbbc60bcdd29e168551354a1ac"
    sha256 cellar: :any, arm64_tahoe:       "7918e612ff3e96efdfa03a2df7a6e1f4ea167a8cffd0c89a1c5826bbe92a6b9b"
    sha256 cellar: :any, arm64_sequoia:     "9922b09db5275eece4b737a716af464b9eb863245647992fdae740d6d07eea84"
    sha256 cellar: :any, arm64_linux:       "e96c40a7dd1688578934284d7ee6dfb8d44e40dafaace274c815e53bc76c06d1"
    sha256 cellar: :any, x86_64_linux:      "bc292eaeea6b8b63866b63877e5bb431104bb14480efab86a51d0fd0cb9eca63"
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
