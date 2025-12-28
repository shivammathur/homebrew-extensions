# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gmagick Extension
class GmagickAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "a474d179cf6838a538ac6bb36b4e8ada9cd153744df8c9d79ea1be2c9cc7731f"
    sha256 cellar: :any,                 arm64_sequoia: "abac91c4718610388727a28eb26c6bd420baa12989dc45983afce6838dd9096e"
    sha256 cellar: :any,                 arm64_sonoma:  "6c6731f8da3375ef8659537e6a46099bcb98cb3d2ff546eac2ed46099b93a730"
    sha256 cellar: :any,                 sonoma:        "222693f2c7a330849ef7f77c28d0084f91ed3d5a87bc2720cd33274d2e22fd6f"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e8eb2c6845a397b2cb5e1722ba476209e210659dcd28c8cc826fc3cfff2dd444"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6f6c01e8a933cb91a4591007856180466ef9bc3e7a72dcea5f5dc92725401a9d"
  end

  conflicts_with "imagick@8.1",
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
