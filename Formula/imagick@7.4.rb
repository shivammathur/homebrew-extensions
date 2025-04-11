# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  head "https://github.com/Imagick/imagick.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "ea4307f85765fe4484309b02bc9ae01ea9f87d2e1ce7b94d68f674d6004e4061"
    sha256 cellar: :any,                 arm64_sonoma:  "76fd628e350af961a3a82a3c9dc27c95b4a41f51c3b68f261c42fdaef8c50e70"
    sha256 cellar: :any,                 arm64_ventura: "366533c3762e2d48c0035338948cd4d4c247a40b266c2fd81bb68363765423bc"
    sha256 cellar: :any,                 ventura:       "9ca418a260314adabc5c458f9db599a8d23cd202ba901ffa16389128fee125b8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ec67fb56c88976ecf9060b04b6eb79a5a0258ba01ffd14f5c8e6f0b168af2d86"
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
