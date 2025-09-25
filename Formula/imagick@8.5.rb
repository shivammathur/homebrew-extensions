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
  revision 2
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "203988f4d764e7166854d3c130c502166df2c7edb6337a0801c7737e9be63cb0"
    sha256 cellar: :any,                 arm64_sequoia: "166c860d7475bfc8e44b8368ad1fe682acc2255ec1e3eefcb6efc28fc2b903d6"
    sha256 cellar: :any,                 arm64_sonoma:  "7db1d6da5495fe75df223e6af3a7f04c4794d3e093d040a3aaaad8c3cb13d051"
    sha256 cellar: :any,                 sonoma:        "31fc493b4df6db810310295846661521048e4d47c9daab8fdaf897edb8984be2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3e8753976326e04c789345c6cf661de406cadadec5ab029f03f01fd6fa1323c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0eeedd1e7baa85ae08af1d5271e8b1dbe570b671f66f7efcc6116bb848526f4a"
  end

  depends_on "imagemagick"
  depends_on "libomp"

  def install
    args = %W[
      --with-imagick=#{Formula["imagemagick"].opt_prefix}
    ]
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    inreplace "imagick.c", "ext/standard/php_smart_string.h", "Zend/zend_smart_string.h"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
