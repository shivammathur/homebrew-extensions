# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT84 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "58cccbde19f49dd20b06882e5db6d9b1dcb8980196c593f990459a5b7728a4ca"
    sha256 cellar: :any,                 arm64_sonoma:  "ec2f0f25b32565a8f0c71b51757e825b0077d3096d42b29d5e714dc17ce44490"
    sha256 cellar: :any,                 arm64_ventura: "b3eb9f8b2ff0eadee5b59f473ce562a303376fda9d98a807c581bfe83709a2ec"
    sha256 cellar: :any,                 ventura:       "2a978545939721c2871312337094b6318c1e64d2dfacf2fb5353bcb946c558a2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ae9f42b885df08a0e51d1b8fbae7caa7f1e7d2554eb4ea8b6a6406ca2a32e053"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b3c83452c4577303485f8d0ee94cef309289591f1c47d1e2208581b7d511bb87"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
