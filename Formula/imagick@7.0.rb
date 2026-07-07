# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT70 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.1.tgz"
  sha256 "3a3587c0a524c17d0dad9673a160b90cd776e836838474e173b549ed864352ee"
  revision 2
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  conflicts_with "gmagick@7.0",
because: "both provide PHP image processing extensions and should not be loaded together"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "8c587d0d4efa732f1c656493ec68ed3068f8af8e341226412652a5359bbfc721"
    sha256 cellar: :any, arm64_sequoia: "8355018f466b5a385a8a8b2543157ff23ed37b846aaccfa3ba44e31ae0930eea"
    sha256 cellar: :any, arm64_sonoma:  "0ff93adf0887ae84e5ab524d1895deee15b983603c59314f2dd9a3cc3e4e7fe7"
    sha256 cellar: :any, sonoma:        "fa3f2e461c5251560bc6e288c668c2888276a7c21179e5ce73f59dd166d6ce9f"
    sha256 cellar: :any, arm64_linux:   "a5d7722cbe780445132ef0aa21344777c29fad72c4d72c7de9fd847705b67bec"
    sha256 cellar: :any, x86_64_linux:  "d8964b3f53fd0f536de32edb4604bcc6bd8747e0cb3a022154753441ef932f3d"
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
