# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_monterey: "8fae3bf353b9e40712c4a18ee3469494610d4659485092906a94f97051b5cc60"
    sha256 cellar: :any,                 arm64_big_sur:  "debbe6998ac6f6450171c145dbd41b06dfbba38246a63981340ecd4ba441d477"
    sha256 cellar: :any,                 ventura:        "25b374b8490e39b7d58d91ba1755d7a2af3026651334bf4cf706aa854d33d0de"
    sha256 cellar: :any,                 monterey:       "b69f1d8f6f21c2219c6091176d20a1f49cb0df2f85e4c95ecff09a7417aa78cf"
    sha256 cellar: :any,                 big_sur:        "6005b774549e714ceb7ce4e98c84f45e67a49dd0b787bba7dcfe1319ff01c9c7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "17a4ac86c906e15975671251d7d51c01753247f73a0970e4681b2cb58e4bdf1f"
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
