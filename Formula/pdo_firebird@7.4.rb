# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Pdo Firebird Extension
class PdoFirebirdAT74 < AbstractPhpExtension
  init
  desc "PDO Firebird PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/9608f3152844986efc1ce94e9a4a603e252f58de.tar.gz"
  version "7.4.33"
  sha256 "f2c7d3c82fdf553f8f3c5f0dcaf6334b22a4e0d02f36bce64433cd835ec30978"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    manifest_sha256 "9a825ec7e56a88a6a42f1ade50c64df4a9f4d17cf1388acb348bc7f3ccf14ba6"
    sha256 cellar: :any, arm64_golden_gate: "cb92536456441237f3392b8aacd00fa30c6fb5cd6d0b870b816e35ff1779a024"
    sha256 cellar: :any, arm64_tahoe:       "0b09230b4f965ec060d3bb7f7275485d7e73718d36f25a001f43f569ac3cc6e9"
    sha256 cellar: :any, arm64_sequoia:     "2cdd7b1cb1aff790e2b1e8b74086c41c1924cc9b593656c091ee6122793f0ff9"
    sha256 cellar: :any, arm64_linux:       "9d90dee6b884df2a069f43c685ee8e7f07d50a17d7568b5265c6daf443b5574a"
    sha256 cellar: :any, x86_64_linux:      "799d2c48ddbc185596f518c66b6d9d805d28b3ff39e651faf9ddbe152a9bfed1"
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
