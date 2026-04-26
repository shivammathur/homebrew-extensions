# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT86 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  revision 2
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "c71c4a502213f7326e7ca9c56f6bbe1957c7f982bc21967d8b3eae8df9866785"
    sha256 cellar: :any,                 arm64_sequoia: "edef94a30d7596fd7e1c40a2d66ea336552d519cf3566feb3082c17f34a4617c"
    sha256 cellar: :any,                 arm64_sonoma:  "4ae2a14d61a08d99e0cd5987d2348f86e5aba7415efcb97fcf23899597170d40"
    sha256 cellar: :any,                 sonoma:        "45c9ae0cb4c05c6d2d39ce208c460898553ac2dac92dbb4625b05d9b32da4448"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f0ea526fa77e4b008a1cb5bea23211cd5d8ab27579095819ccb86b12fcfe3e0e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a86fea75583fa64356ee4095650313c913332321fda6c25621f19b1a8c66813"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    inreplace "vips.c", "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "vips.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
