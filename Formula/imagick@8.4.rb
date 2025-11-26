# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT84 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "89b0985ec14337ae396d035a424db20582553610bbd9b7099be1aab794b57166"
    sha256 cellar: :any,                 arm64_sequoia: "2a26419b587704de96b4936481ff99eeb37ab64674e62cb8de97aca9fb0306c8"
    sha256 cellar: :any,                 arm64_sonoma:  "d493a0e7a68b14992720ccd1009f7aa9955b2347afbd5a2c98822dc6b6927937"
    sha256 cellar: :any,                 sonoma:        "6b566f4ab26deba2fd8430d284e8c24ed65fc0d75a2068eeb5012863d3f815b0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9823bd802c8faccc86c646d3e78c08ee32d7a53c458179421bd867400ba7cd5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3e3345704812e87e3fc1e8a5dc0d0b6444f34bf4c25285cc875115640441cb19"
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
