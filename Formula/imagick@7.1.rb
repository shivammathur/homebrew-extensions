# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT71 < AbstractPhpExtension
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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "92980b3ed01948d5518b65fb9d44f4f26c8f66fa4258939a0aa781c002fc5d64"
    sha256 cellar: :any,                 arm64_sequoia: "487dabb49a9fbfd99bd39cb56d7bd25cc43703c809697990954702bf9a4f035b"
    sha256 cellar: :any,                 arm64_sonoma:  "1b6332645d52003fd9a9d84505d92dc51ccbecdf922129528cef05ab65b50d7c"
    sha256 cellar: :any,                 sonoma:        "7240cbac39cd36ad668e20f34981ff457f1270261cdbbe38982b03337febf63a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4d8007b008768fbfc056166c94f454673cd6140fb1c843fe924a981c7245c460"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "acc6dab331eb4e976a89cd05c5068fd05a6c44cec97d3205de34203431de46b2"
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
