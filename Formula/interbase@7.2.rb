# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    manifest_sha256 "df86c1e66ac2e5ece2fcbf400aed51b0c7250a33decbf25851b2ed8e8c6a442d"
    sha256 cellar: :any, arm64_golden_gate: "6fe8b735560c163af7db4a5d8f67a9b977b79ebe890b8f23b4ba1ef7ce213aa6"
    sha256 cellar: :any, arm64_tahoe:       "825db0c144e822ec67b9455307c8910aba75e366337824064f40982ca2dbd497"
    sha256 cellar: :any, arm64_sequoia:     "ed965e96290a06bd758a48366bb0953329fa365d050b4a5b37b45955a60789a2"
    sha256 cellar: :any, arm64_linux:       "547c411c127428350797934b083628d11d4943eac7dd2c884839f17310419bed"
    sha256 cellar: :any, x86_64_linux:      "a41afb8128ac83896800613ff362eae473b0303dea5cceed7c721f16b01dce14"
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
