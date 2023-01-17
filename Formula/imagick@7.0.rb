# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "24b8d96edf0c660fbb347d335fe0b9cd47f6c73cf22e4ff5e1f0bfc59ce56acb"
    sha256 cellar: :any,                 arm64_big_sur:  "df2088e1c088d8b5e0a760f7c2a8d3f919f97a2035cf74d81e2e168220a7f485"
    sha256 cellar: :any,                 monterey:       "e3728ff617d010b3b787d680b1e43a0eed4dfceb00a81ddd69626b8c060cc6d2"
    sha256 cellar: :any,                 big_sur:        "5c4d3814273488613d9a5576a0695bda746a5da51c700df1cfe86cdc89f807a3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "97c3067ea62a7f5ec162844020153d2eb0492c27faef5b55d078e324065b1afc"
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
