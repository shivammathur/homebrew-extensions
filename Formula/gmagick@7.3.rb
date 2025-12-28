# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "6861f49b87fdaf1291cfb5fd03e868582cdb61edb248b739d06f2a8ec1565895"
    sha256 cellar: :any,                 arm64_sequoia: "03545378a3d0a7cd4d0e48546e7b3bc75c1fef5b3a826b19ebe454c21f2fbefe"
    sha256 cellar: :any,                 arm64_sonoma:  "90334e070c24c004c8d7f5705d2de17b43ffce0d44ece2ba163ce4a7aec37c05"
    sha256 cellar: :any,                 sonoma:        "34d4b42c78624ba9cf3cf629377b2be9e7bcd4bede7f99a5266687a1efad741e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dda6919674d42f566e426c9e328dc0d41dcf7f0e687d19ee21333e99c5f1a7c9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "32389874fce3dfd44768a30f136a746ea0749fccc3e94cdbcd87b814e358ce2b"
  end

  conflicts_with "imagick@7.3",
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
