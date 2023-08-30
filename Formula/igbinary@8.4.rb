# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT84 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "afd61ddb5042c7d6f12a2da06423b31b023f7865c8afae211047bb94914aa808"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "5fa07369d40e542fdcf1b071bbb17bddcfb71e8b3150baca3819961418e7c836"
    sha256 cellar: :any_skip_relocation, ventura:        "e800de84da28aea9f86d57613ea1de158056f4077025b6a77dcb6b7d8f2e173e"
    sha256 cellar: :any_skip_relocation, monterey:       "ac24a95eebb90b9018d5d2df49cc251e0e07578d4cbf9d5f81a866cc3e78bd58"
    sha256 cellar: :any_skip_relocation, big_sur:        "27ccbc1db0863e69c0d0e073b24a8fe1e3a332543e696dac0ae5fb3acd9700ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5121271c62c77dc509babf775d440a29e166f2e54f838bcc24fdeb277bfedbe7"
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
