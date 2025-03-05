# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "ad503149efba880770744b1addc08ea54f33d2df27158cee2cc149ce24a41484"
    sha256 cellar: :any,                 arm64_sonoma:  "d823b5a2f3c0a66e929e9d837a28fbeaee69e7a947fbab349460edbf0b8fed51"
    sha256 cellar: :any,                 arm64_ventura: "450862e15c49b433267810a7f27ab4e1eb670c935afadd1dbde90fdd9bbbea12"
    sha256 cellar: :any,                 ventura:       "973dead68ed85268b69891cba4aa9555592a0245e77e535892293877a1839d63"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5766107b1c3f9114da5a7fd8586b9cac8c44a9d6f7fd870b720ddeafbd7cabcf"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
