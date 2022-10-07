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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "971dda6c816e324153478b1b36153e30eb72ea3814839d90f3e10cd410c11741"
    sha256 cellar: :any,                 arm64_big_sur:  "a178fa8aa034745211f1faa76b4ae0172cebc058d05df67528e8d196825e843d"
    sha256 cellar: :any,                 monterey:       "120ec64306e50dd80f96345a1d48146be0a4a13ef4fc0da83bbe78aae227aa59"
    sha256 cellar: :any,                 big_sur:        "54cd4ae005953474819e76cb73e63bb6baaee7f96ab5714033b8d6ab0bf13e1e"
    sha256 cellar: :any,                 catalina:       "b9f86b7dd37f18e305b9e04961cde7d48342a0a7d88805ac013ccc2f7deb73ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6d515d9a91cd0375c781a4e6b6737d30b653c9f8bccffa60ae46df0a7cc7a2c9"
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
