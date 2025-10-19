# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT56 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.8.0.tgz"
  sha256 "bda67461c854f20d6105782b769c524fc37388b75d4481d951644d2167ffeec6"
  revision 1
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/imagick/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "e645bff539627ca42fd022532bdcfd057c653fe2b5fd1f292c4e726321e7184e"
    sha256 cellar: :any,                 arm64_sonoma:  "e9f8235b70e5809b4ba6647ecac8acf9d28bf8444c348307a4e0e63126649768"
    sha256 cellar: :any,                 arm64_ventura: "158079c84eff2d94eec7cb9f73d0a0f8b5d5d01dc1ce2ba4cebb9e60fbede9c1"
    sha256 cellar: :any,                 sonoma:        "535e2a004502bec758c2f24791dd4868e92d1fadd816711c1a3c922fe41ed65d"
    sha256 cellar: :any,                 ventura:       "de3d1e6c2000dbf2215bc69e0a72ca7684530b675e219e4693c94170064eae28"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c3207d3df8fb52aad6a7ca7bb4e4445c2a71937db1ed97f17a44b64d65f9b752"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21edea78304c4c677bdbc6c451c46c876e29b9d9d836fa25ca9e57b49ff5dbc4"
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
