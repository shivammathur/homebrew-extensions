# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT86 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "37403ffc1b359c6281f702688055c7757f5d34b97bd9a0acbd8da495c917fa5c"
    sha256 cellar: :any,                 arm64_sequoia: "629cf66593de9b2fb4b8e7190cb6a56e535e70672e5913b199db411557cab89f"
    sha256 cellar: :any,                 arm64_sonoma:  "1951dd9fe19c5c2edcab19c970dccaeb5dc6c261f194b8be34c3bdb59eb5c290"
    sha256 cellar: :any,                 sonoma:        "24f2dba3c94e29e2dcb4e5961435037cc0e0155debaa88b0977e1c6083e97fd2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "43c7036309cc9a3d41ee2cae5f722bac13f587605283b78b5203bf8eebafdc7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2ce8e3a5750e0a152d6a4af6faf0ecc94ccdbea2d304f3955f58cb47d9dc9ef6"
  end

  conflicts_with "imagick@8.6",
because: "both provide PHP image processing extensions and should not be loaded together"

  depends_on "graphicsmagick"

  def install
    args = %W[
      --with-gmagick=#{Formula["graphicsmagick"].opt_prefix}
    ]
    Dir.chdir "gmagick-#{version}"
    safe_phpize
    inreplace "gmagick.c", "zend_exception_get_default()", "zend_ce_exception"
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
