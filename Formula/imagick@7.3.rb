# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "b6efd794354ed8c213a4708eb8886fd925e2460109e0b944c3c91135d887ffc8"
    sha256 cellar: :any,                 arm64_big_sur:  "361a275665b22314a7b45aee4d9e2f0abbf41ef3ee1e8c2416b100c407485b68"
    sha256 cellar: :any,                 monterey:       "d9a5672398b2c846964a0dff1006d68b72e7a36414c06342394b0dd041892875"
    sha256 cellar: :any,                 big_sur:        "0c7ac3bbf4218ede1b4f25607bdc1be914cd08116737b3f4680611ab44161288"
    sha256 cellar: :any,                 catalina:       "12adee6731661055b4ae984045dd403c451a2c4cca173b02e65bb1de9e79d45c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b98ea9db65ce09b0d4eb28c7bd9d2e8216b30765e3aaee91fc389bec87b0d2b4"
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
