# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "f9eade72277e43973548572f1bf86b9dafafbcc31622ac0f2551dc5df93f7023"
    sha256 cellar: :any,                 arm64_sonoma:  "98af0870839cf4d59252ec97b018d22bdd1311ab78fb8d1b5424e340d09bdd51"
    sha256 cellar: :any,                 arm64_ventura: "24de3041e46441f551313f0f26a016cfe416c324618f816b9031dd4137a6c9ba"
    sha256 cellar: :any,                 ventura:       "c0b19ba53da5f0a5090d1aeb11a63b7c87e6489ca9947327991544173e25062e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5dbcaca10f515b3bd4636f543a6c687d8d97f101c609b3e5dee339d1eccbbfb0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6380aabfd228c9a3eea9aa61f179c3facd66d675d7ce0477e240e0808eec09e5"
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
