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
    sha256 cellar: :any,                 arm64_big_sur: "fc85418806918430dbd1ea1f4a6474ce475f78a3b784d44e74d89403334f3df2"
    sha256 cellar: :any,                 big_sur:       "43e6280ee39ec6d0bf3022876cf3a33ba348cdade6c99142832a5b5456307390"
    sha256 cellar: :any,                 catalina:      "f5159f9148a2cdf7e0701dcc91c453a6f2e7ca1026b439a3d92a1cf4593be75f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa55a1b7fd16c89de4a87f099a873fd9f76e809e1bcbc15cc9c307e69851be3b"
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
