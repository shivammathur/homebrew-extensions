# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any, arm64_golden_gate: "058e86674ba1eb635a8632f5d346dcfac999dfa1006a9eb773db317cfe373918"
    sha256 cellar: :any, arm64_tahoe:       "2df165816e2c4b4cfb66b7a43320f34cccd0ebd17eff561d46a9f85e4ef2846e"
    sha256 cellar: :any, arm64_sequoia:     "612c42d6c4ab59ae7e669e8d15db7d866b607256c20853e2d6283cdd8ff27110"
    sha256 cellar: :any, arm64_linux:       "bf553760a4517b40b21765d922d255d8aa05c98874aa6bd93c9e6da4c9384e3a"
    sha256 cellar: :any, x86_64_linux:      "b8f602e3aba066d249fcee134d8a99b80ce857226b89c212cb3f1838e861032a"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b9324026a97a5255ffa24107c48c6e2a9c0a8b.tar.gz"
  version "7.2.34"
  sha256 "c68605c387149e04a20b193fcb93c8b65a859b7ab3f4b77b12339f83d6583319"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
