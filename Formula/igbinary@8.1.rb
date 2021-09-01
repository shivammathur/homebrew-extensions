# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.6.tar.gz"
  sha256 "87cf65d8a003a3f972c0da08f9aec65b2bf3cb0dc8ac8b8cbd9524d581661250"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "51816557258dc5d85c2066ffa7c7f5ea6264e3735a4fdc0a3e56289984111449"
    sha256 cellar: :any_skip_relocation, big_sur:       "f86ae54439093d1b5870f1c192d072bac23af63061294d8fee113810663091da"
    sha256 cellar: :any_skip_relocation, catalina:      "1a51fdbf88f43c6e3f8c9b38530327d23fdd285d11661aab809ae2581401868f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d9168414545e1dab3d59d2846badb9b896d7b5789dcf5554444c706851c98ea0"
  end

  def install
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
