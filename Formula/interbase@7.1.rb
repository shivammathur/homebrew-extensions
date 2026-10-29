# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT71 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256 cellar: :any, arm64_golden_gate: "192d34e2f4bd192ef9f31b73ea0ae6acefb6cf8ba017d5c326fdf328b42d19db"
    sha256 cellar: :any, arm64_tahoe:       "7af265bb8c936c8058354b47b821dbf88071531628e85cacd7bb1bd765f808a6"
    sha256 cellar: :any, arm64_sequoia:     "1278ad1fc50f79617df08b26a4d9044ed3e98e53a74f050ad0e62af267d3861a"
    sha256 cellar: :any, arm64_linux:       "b6255245dd9fccca6a2c6f3595f1b2f2f5d841c7b4372f9ab1fc15c8973cec8b"
    sha256 cellar: :any, x86_64_linux:      "4cbe1e71a44f6d48afcb03a7a862452db9494e4d3cecedc01d531a394cb686bb"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/b170cdd5baaf5c6b1efd4e78f9a668f10acebc28.tar.gz"
  version "7.1.33"
  sha256 "0120b9ba5bd74c7fb2787142973da29dc6868941e63c34fdf3fd5ea954acb2cd"
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
