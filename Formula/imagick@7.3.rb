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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "b8d06c6bcc89b5c958041a05973246b51d6b78ba2af23cfabd8d0e5d63ab6961"
    sha256 cellar: :any,                 arm64_big_sur:  "f4f353c51938496ab014525555d73969bc3a4c462764fd43d83e5ccc247ce5a4"
    sha256 cellar: :any,                 monterey:       "d65ebfbe8ffbc348ea6a65b9693464af3749cfe594fbd7150e1eeec9947efa8e"
    sha256 cellar: :any,                 big_sur:        "ed850d7a125f7fe0088309fe3322726cb2d533002800cf770e83e8777b3d074f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6c16294cfd1bde8f5e4cd9d785054f68608e24a4d3804f886f0b58abdb8c07c4"
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
