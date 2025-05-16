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
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "84935519dcb48b50a8aa710f9008cf9467f769dc8dee23eb28add62ca78cbe46"
    sha256 cellar: :any,                 arm64_sonoma:  "cafbbb748a1b94349ea65fc89b8ee9003649c8ba2577af2726bc7563e6c69886"
    sha256 cellar: :any,                 arm64_ventura: "b464806000fd0e95bc8627da49d6319075b0e76cbc3ecd089442b40447d143e5"
    sha256 cellar: :any,                 ventura:       "c9bfa78b3d7a4e52217250b869f09e7b9aa75391501e6bc4127377c1af5c9325"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f604b319b003615d9e274ee7160cb68b0764fa6d417717138fe389552bcdce60"
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
