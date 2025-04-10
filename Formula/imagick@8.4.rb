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
    rebuild 4
    sha256 cellar: :any,                 arm64_sequoia: "42d909f3249a9a8f502bac42209b0efbced95059cf1a2828f2957e679bb4e837"
    sha256 cellar: :any,                 arm64_sonoma:  "b7c44f3fe26d62928809b217280cb09d4043073ec783b40d13cf8fa54abc6b06"
    sha256 cellar: :any,                 arm64_ventura: "4be2cb6cac744c77b607224bda1edc3ed4c2d25ae2308b2e381e307c33225801"
    sha256 cellar: :any,                 ventura:       "9209c4017c2b7b7a14dd650c6417b0dbdf5862df0bdc6e6b42724e0967d4808a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ee8c7a4fbea7d106d9ef3c4c0746673e10c004f2e61e47650d247298acfb34d"
  end

  depends_on "imagemagick"

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
