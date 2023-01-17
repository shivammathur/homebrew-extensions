# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/igbinary@8.3-3.2.12"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9976a4017fc3eb596395c7957a60187a1f0ad50d0dacc747fe26db126ee66d6e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6be85bc8e4ac4080859e4ae63dde49135d579489347284744aaa5a2a0153e915"
    sha256 cellar: :any_skip_relocation, monterey:       "aae57a887377daf84cd2d44f1557da63a2012949005d32a15101ea67dd6edf7d"
    sha256 cellar: :any_skip_relocation, big_sur:        "24d2f11fe0710462f66b994a86832d21acc3cdac4b5f5e5628c48741b4b5ddf6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ae07a68db89189b1373583b8985bf57299e51f77c5190b66eba091d0e4f643a3"
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
