# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT83 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d802bb6be891c3001c89c8e6823fd5bc76f67bff66942ad13f190a7e183fe366"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "86d266970173b89dcf9c48eecaba8af2a05d156bc4558d46bb37f9422059c839"
    sha256 cellar: :any_skip_relocation, monterey:       "ff15b92270e22f8e4566a28a648976572410e47a48c0b71255808bae41c6b367"
    sha256 cellar: :any_skip_relocation, big_sur:        "acbc7284651c3315394a619fad80a6134bdc1b1b8c0648a45ef61444704415be"
    sha256 cellar: :any_skip_relocation, catalina:       "68e62bb1045bdc099e3fc6233d4c6a262bc1aa0014811d8bc61d61dcc1a5470c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "596cbffdd386ea98ae19edecbeab93c32e2e0d74423ef8e3a76f68d3f48a98af"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
