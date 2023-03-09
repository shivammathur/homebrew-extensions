# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Sqlsrv Extension
class SqlsrvAT81 < AbstractPhpExtension
  init
  desc "Sqlsrv PHP extension"
  homepage "https://github.com/Microsoft/msphpsql"
  url "https://pecl.php.net/get/sqlsrv-5.11.0.tgz"
  sha256 "6e437af4db730ab995c597f960e98bac060fc220a8d51ee24877eb7f39090a09"
  head "https://github.com/Microsoft/msphpsql.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "093391aa5d806848831856ab6afabb2409e06165b199ffa81bb0a99993145614"
    sha256 cellar: :any,                 arm64_big_sur:  "a8da75779a97526a27da620d4bc16ec788e76f9453c6827db34a2ba9ce2a66d5"
    sha256 cellar: :any,                 monterey:       "f213237c21c3a0f4924c94e9bf7cce6dffb62ab5849b21f6e65c379a6e8aefba"
    sha256 cellar: :any,                 big_sur:        "6e172d5bd0aa6958b9b7ce050b6bac46e3333f10d6a64bdacc0f39d6c5c7598b"
    sha256 cellar: :any,                 catalina:       "6d6879542e745d78a7a7a66d3ad6dfa742b11ffeacc4dee373fbdd693851db15"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "38266c42843bf9237a54dfc2ea55ad83e5f6f09a3324fedb71a0f7b90da930b5"
  end

  depends_on "unixodbc"

  def install
    Dir.chdir "sqlsrv-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
