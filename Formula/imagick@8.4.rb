# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imagick Extension
class ImagickAT84 < AbstractPhpExtension
  init
  desc "Imagick PHP extension"
  homepage "https://github.com/Imagick/imagick"
  url "https://pecl.php.net/get/imagick-3.7.0.tgz"
  sha256 "5a364354109029d224bcbb2e82e15b248be9b641227f45e63425c06531792d3e"
  head "https://github.com/Imagick/imagick.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "d6a220af472403e4915a25aca281ac01f1b510ee3ea6a98b654914e81e8dfb51"
    sha256 cellar: :any,                 arm64_sonoma:   "de111988b69551a4878bc2b04ed48f47bfb9b96984f23f16d1bcbea3f48a1bc8"
    sha256 cellar: :any,                 arm64_ventura:  "bf698d99a02a00b919ce72a664a9234500cecdd0b6e9d2b236e7592a4ef0608a"
    sha256 cellar: :any,                 arm64_monterey: "7a6852e38025880ef6eae63bb38a35bcf819961175e10cb8b6d42bc90a7cbde6"
    sha256 cellar: :any,                 ventura:        "a8039922f3d576fa4ea7f761206a1fffa12f173d2b3b51c30a3410dd120a04f4"
    sha256 cellar: :any,                 monterey:       "f7a5e5c4258cd489c975b02051d6b6bf8b4d9abefd7ed067ffaca2b4d8b41baa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01dc9f5cc2a746ddc67aa2a8147ef55dab770ba5efb32bc793e42352cadc9abb"
  end

  depends_on "imagemagick"

  def install
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"
    Dir.chdir "imagick-#{version}"
    safe_phpize
    system "./configure"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
