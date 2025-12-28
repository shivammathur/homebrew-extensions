# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT82 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@8.2",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "187a0aa83523dcb416c308f83c2376e13484d5598d6837dab1870a88ed56dccc"
    sha256 cellar: :any,                 arm64_sequoia: "527914c6a660489a8e6b8bb82fa35b026d8884424524e2177f8f1ed0884fc9df"
    sha256 cellar: :any,                 arm64_sonoma:  "733d35089af615e475e4c36c8c770bf370cc118909f952ad9119d8deb0049247"
    sha256 cellar: :any,                 sonoma:        "8688c6f477398ed752f4a15df4ef387ba3ab474779fbb9f54938e78bbdcaad73"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fa277bb4dd023780b6d7bc9ba9f45b41b9a4e719b007b2e597b1b6fe2e220293"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4c9ae08daeda104377a9abc15791852851ff6297bddb18267c78c1858586ba9f"
  end

  depends_on "imagemagick"
  depends_on "libomp"

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
