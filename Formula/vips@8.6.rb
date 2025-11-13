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
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "593057f199d56e0027a30fdbd4f021f89cf52f262b38902ef9a517aae9514773"
    sha256 cellar: :any,                 arm64_sequoia: "9a8975e2170e8d07f8c021a3fd8a3723b7583720e3977ffdfdc7060f1a20c4d4"
    sha256 cellar: :any,                 arm64_sonoma:  "36fd6bf68d595e7dc62404a3ef49c07d3fde6f14d00cb9f58e2856b020647b46"
    sha256 cellar: :any,                 sonoma:        "56a058eb43baba7deb7b188a317fa154eff92d5bcbc50ae365eddde243d63d69"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a2565862cbc84e09e1739de0456f825bccd9781deae6a2a3dbcc62560b7f6b58"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7752bae95d8935e308339ba8522f5caa86eb0751498030bf925e5f00481eb51f"
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
