# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "cfef3500cad34886fe459d364b91ce4fd0707bbbb425f209573e770823fb4175"
    sha256 cellar: :any,                 big_sur:       "1a39e26381ee565095caa6cb564225b6cc3b33e22c07e26b84c13a47b08dd1cb"
    sha256 cellar: :any,                 catalina:      "50c635b7a3c360ad8ee87d127b3749bbcfb029efd5a6f1b7c5a24bd9bf69055a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6ba3171dbc8e3f6b7af4414a71ca8cf99182e9c4a48d4457cebf6d82ac7d719e"
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
