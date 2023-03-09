# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT83 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.14.tar.gz"
  sha256 "3dd62637667bee9328b3861c7dddc754a08ba95775d7b57573eadc5e39f95ac6"
  head "https://github.com/igbinary/igbinary.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "81654385d37cd74f9a462fd7836ba4bc7d7bbcd36812b878125eac1425f12d54"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "fb7b68e4de8ed3b19d5d28404cc9be6eccb096b63517e47b6fc63ebe63a41f5d"
    sha256 cellar: :any_skip_relocation, monterey:       "7acfcddaba2e218c52866376db3b94f5cfd52867ad29685a81d5a320fc8aac9c"
    sha256 cellar: :any_skip_relocation, big_sur:        "7c3c65f37bf0ef2032fb5e0d0a0fe5c7817ae8f0dfa5342de3d55625667ad34f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "64a458d6da041f4c95d77dc91406eddba0ff4648c3c42872b23847cee89b79a7"
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
