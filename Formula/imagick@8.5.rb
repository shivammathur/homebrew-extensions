# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "9124e8254f2c302429588ea0d5611042fc59a528475e61c29a78cfbdb166b674"
    sha256 cellar: :any,                 arm64_sonoma:  "8389e4a1728dc5084e97b2ed63df7f6d919d9af91bddd6107ea8585e51f1c7c9"
    sha256 cellar: :any,                 arm64_ventura: "fc54a6f90507c18744a786b430c9ce9e2fe82696ced2f16a0dfbd1acc8bcc8bc"
    sha256 cellar: :any,                 ventura:       "465123b286e430a205b72c28cba03d56f30bba1a268f7946b088298fc62cf6c1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3dba12254f07b00baea7f9a734c29338223966815c9285e7b14ecb98b209fafc"
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
