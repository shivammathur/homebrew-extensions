# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT70 < AbstractPhpExtension
  init
  desc "Gmagick PHP extension"
  homepage "https://github.com/vitoc/gmagick"
  url "https://pecl.php.net/get/gmagick-2.0.6RC1.tgz"
  sha256 "350cb71a4fbd58e037c7182cafa14e6f6df952126869205918fcc9ec5798e2fa"
  head "https://github.com/vitoc/gmagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gmagick/allreleases.xml"
    regex(/<v>(\d+\.\d+(?:\.\d+)?(?:RC\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "5c6302af90d62b36da8458b6119cb8da31f5522afbfcf93fe05e06d593f951cb"
    sha256 cellar: :any,                 arm64_sequoia: "e59b245620d0ed31d865c367c3db99453dc321963579fb9a7cd94bf3cfe75f12"
    sha256 cellar: :any,                 arm64_sonoma:  "7ae0b2013b583b034d07ca015279f3b4e229959eb7f3dc8fccf969c9366c5ffc"
    sha256 cellar: :any,                 sonoma:        "75c2613c312f8edf1342ff15b8e09f92ed47d5f78e8fcb34a769032461c4e955"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c58677091ce5b035bc15e209d5bec6ca684e67cb3fd4b34ffbd3ada215232956"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "818fe23d40167acb83ed5ba00d845ef9ed9ed88468629f39844b74f98f0d26f9"
  end

  conflicts_with "imagick@7.0",
because: "both provide PHP image processing extensions and should not be loaded together"

  depends_on "graphicsmagick"

  def install
    args = %W[
      --with-gmagick=#{Formula["graphicsmagick"].opt_prefix}
    ]
    Dir.chdir "gmagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
