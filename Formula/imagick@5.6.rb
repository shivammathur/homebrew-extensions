# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256 cellar: :any,                 arm64_sequoia:  "e5a34c74070533ae9d317b1ad4a184a6eb79d3d82a3c91949cbd40dc43b1395d"
    sha256 cellar: :any,                 arm64_ventura:  "0802b97cff6ca6fa7ecd0fc55bce6cdcec790210a3f281350996fc623fd19cd9"
    sha256 cellar: :any,                 arm64_monterey: "d8180e8be4c164838ca309435a2a61de23af17d6630c2288c2c4bf1be801341e"
    sha256 cellar: :any,                 arm64_big_sur:  "137c62bdcbff96d74ca2ab616a84ca1086ff5ba6b186fba12f6d69eb4e6bbe2e"
    sha256 cellar: :any,                 ventura:        "1c025c09fa1472f08ad97811c220060b712e50c24c4c02f4facd456e6b50c864"
    sha256 cellar: :any,                 monterey:       "ee09e16d7b7b365809b387e6a4bebf1cfd10fb0d78ca8d465e76a6020b705ae6"
    sha256 cellar: :any,                 big_sur:        "ef0d1e558f3423a6fc545350a483c39695adfd402f759e060bb65c23244888a7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "add0a187bb6f3e7c27247590cb9b6dd21d0f2a9e05d2e5e409732889931a2fcb"
  end

  depends_on "imagemagick"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
