# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_monterey: "89bf90a35fa429d4e0b87624207d4491b8f139408039f7e97205d0914783dc69"
    sha256 cellar: :any,                 arm64_big_sur:  "214a009c6dbca377c27fefb90b1eb413520c9b0df1b3a36e66286c89b5259495"
    sha256 cellar: :any,                 monterey:       "d2e562a8df7708620ad6f7b993b5ffb9b243674a64f47d0768c19ae6d4875723"
    sha256 cellar: :any,                 big_sur:        "c8e00eb20c86ec43dfc3adf23d2454f17d4c8098d9c773bfcbaee3b73c6e6e42"
    sha256 cellar: :any,                 catalina:       "c63cdf39b1f04b4511c0e0df62337dfea9de67b70a8faf9b57a92c5d03c7933b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d3c636300d228c57bb78b511a6729d86895d379e9bdc8779c599ac383289b688"
  end

  depends_on "imagemagick"

  def install
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
