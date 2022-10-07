# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "41cd8943fcdc6e9b2a910ee3ddd3e30ef4fb035842d73abbc0756ba08368f5b3"
    sha256 cellar: :any,                 arm64_big_sur:  "b585a46bc536d7879c9120a513638a591d1a14c7e8045bfa63be41ee0e49584b"
    sha256 cellar: :any,                 monterey:       "1e10d54d5f9ad9184df351532c9bd409f56e237878451a045da2ea868be457de"
    sha256 cellar: :any,                 big_sur:        "03750ed4a8f425b06e7ee0be85bf21bfa28b786b59316a8dbeb709cc35b40990"
    sha256 cellar: :any,                 catalina:       "77502732fbf51b612f61b49a90cd4de981bddd3ecf80e163deb8bb97eabd7129"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a2d6a248443c633ea4b6418df9316ca5f68c6925fe2c345f87280123e9e9c922"
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
