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
    sha256 cellar: :any,                 arm64_tahoe:   "89d59921fa6616da374f7e668e011b994d912e1cbb39658ece179c12222d15a2"
    sha256 cellar: :any,                 arm64_sequoia: "bdf243eb33c39a3599a01dbc03519f15895aee75cce9fb0b7a624c3d7c3ada08"
    sha256 cellar: :any,                 arm64_sonoma:  "1da3b85f7bf11db1508204c5245e1b2947ea8759ec0bcab2eb410a9b2042366a"
    sha256 cellar: :any,                 sonoma:        "2a98cf3401dbe7a12c33ac913ef8e4d540494f55dd09469f750e4edae40d1458"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1a1283a4eb5375703272344daf4ccd968e10d5ae3fda46467994f1c84611abe0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "071ece686023a22f98b972a6f64ddae8c4d7292dd46fd2a47192f3356fd5eb89"
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
