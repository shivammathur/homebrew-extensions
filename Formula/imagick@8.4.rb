# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT84 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "249beef6086b3527e346280fdfe2427fdd6320ad53ecb2f6d90740dd4355ee2f"
    sha256 cellar: :any,                 arm64_big_sur:  "53d4e3e64aca3bd0a4672e6d669d3f29ca8c5c9acbf678ba57b7927c94e6b3b4"
    sha256 cellar: :any,                 ventura:        "c3d60c5ed48954f125ae90e2dafd27e723f614edd4666034e80adad89348994e"
    sha256 cellar: :any,                 monterey:       "bb03cdcf2ec744ab897ce1c3952642d59b50dbaed285678afaeb1484bc8eeecb"
    sha256 cellar: :any,                 big_sur:        "f0783fd12ffa0e9562304758a994a10882afdb0875ca9d337b41599c16e927aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8f341959add18960c319e8fc9a1560e4668755e0f97d3efa84a9b6fbbc9eb2bf"
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
