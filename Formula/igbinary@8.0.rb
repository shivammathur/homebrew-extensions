# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT80 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5a646ffdc1aba5d3a7bb0cadc113d8d9c986c3f53fda74ba99b485fccdc73c9f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "14c83a91de0c2e19f733701671d4aa8dbed5f1af5273ac10e0257ae0f1bdc3b1"
    sha256 cellar: :any_skip_relocation, monterey:       "ae9e6dc28a00199ffc9e3e70c78531bc57a96b2f8b1439aea4d01c2333d47bce"
    sha256 cellar: :any_skip_relocation, big_sur:        "c004c7f60e9296b0e455c120edb2a5456d0a41568e870e24ac96ac0cc01df507"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2a33fd40e88f2cfaf5800923b8d0683d03e4f2e1eea9e632fa9cf86d62439b42"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
