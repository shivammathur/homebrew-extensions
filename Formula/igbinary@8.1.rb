# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.12.tar.gz"
  sha256 "de41f25b7d3cf707332c0069ad2a7541f0265b6689de5e99da3c2cab4bf5465e"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4186de7ff2425f6d37dd0f592e85ecb91e870bf3b1c932439231cd95c6747ce4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "33abca88eb8f611129c9936c7ee394fde047a0d94079ef54bb0ceaedf5e1c0ef"
    sha256 cellar: :any_skip_relocation, monterey:       "b02362e3551750bcd3e3660b3b0e42b0677820366cc1e9f3e33db618d57c9cf5"
    sha256 cellar: :any_skip_relocation, big_sur:        "6a8c793a07cdbd8230575bfc937bf7ab7f9329f1ad9d5e668a891d8578bb6dd9"
    sha256 cellar: :any_skip_relocation, catalina:       "213a00f6b097cce5a64ac637b092508d6cba9ddec00c4207e15d218b71a21c02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ee50fcdf4ca14d261c4f702ccc44e98a63b37181725a5146a6bfea93e7fca03d"
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
