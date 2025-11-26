# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "38ffd8960b36a4d48016db3e800fa79ab3002ef2d956068824b4604fe98874d2"
    sha256 cellar: :any,                 arm64_sequoia: "4b17b2e9b6762e131843f53e9ddf7cacbb6f216ab2dbf9dce0a2beac3cf4ccbc"
    sha256 cellar: :any,                 arm64_sonoma:  "b417bc383e50bbf814106cc0924244f7cd02d14c90a93cfafc5c4c0ce9dbe0d1"
    sha256 cellar: :any,                 sonoma:        "6bf2d9dd7da79f98e95d5ad72e49ab62f8695be308c041015f6adaae30fedb44"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0f354aaad80dd3e81a1dcba56ce7bb6a9e67049adad7ebdc8af258c19ccee9bc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c1efb35070ee692dbdfca2e6c6d8e303403928d68107612f52eeb139672af463"
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
