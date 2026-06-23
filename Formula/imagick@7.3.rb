# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT73 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  revision 1
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@7.3",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "875ddb13da970732a5b0ad1d57879f26e1d6dbb4286a551ec66e595adfe7209a"
    sha256 cellar: :any, arm64_sequoia: "0737508bfc4a91e5ed610378e994ea78b177922731ed4a78f89dbcfc6edc6b05"
    sha256 cellar: :any, arm64_sonoma:  "7a35a6cf2cc6994915588c4a364cee27aa9199865866aae2426cb647230e7698"
    sha256 cellar: :any, sonoma:        "e36bef1645c9fdfa4dc3f91bf0567718458ca7c6aacf11d300855d11cd59637b"
    sha256 cellar: :any, arm64_linux:   "a426fc23e48774ee641ab345ff191c1a1fddb26245387c504c7807eaea0e682b"
    sha256 cellar: :any, x86_64_linux:  "e24874ed93037be8cfe580f123926c16d6ca87baf9dd54d436332fe3d3bd7061"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Utils::Path.formula_opt_prefix("imagemagick")}
    ]
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
