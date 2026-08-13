# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT86 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/c127a96fd77c6429c269009c39c7e4c34b15dfe4.tar.gz?commit=c127a96fd77c6429c269009c39c7e4c34b15dfe4"
  version "8.6.0"
  sha256 "97755ddf8e90e2add3f412b928d1d23d7e7f9310f3cfd5e19967c6a723a2b788"
  revision 1
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any, arm64_tahoe:   "b9fe5f09e85f62be625e34b71d3aeef6e2a9212aa8e27d9df8673de23bc81166"
    sha256 cellar: :any, arm64_sequoia: "12603ed92183e69b701f84526eb4b4a50450ad8cb014b16c994d034d5232dde5"
    sha256 cellar: :any, arm64_sonoma:  "da354cbe891466193b4ce68b2a66feb5c3c1daec76002a7a1be529c77515bda2"
    sha256 cellar: :any, sonoma:        "18291ec37fbf21f2586be605ee98cfe62a73b55ce479b9bdd6b89e97149578d7"
    sha256 cellar: :any, arm64_linux:   "a63b407f9530c497c008efdcbaec438a59e1d825de473c3d4dac73a7ab0756c7"
    sha256 cellar: :any, x86_64_linux:  "87a13370f1e70d58e9d62e46a0ce2770f0caacae6ada11ae53a2500e1cd2cbc3"
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
