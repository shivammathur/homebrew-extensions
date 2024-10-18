# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "67e59dfb337288fb6e32f2ab65502e7605873a775a7385a1645b3331efec5b2e"
    sha256 cellar: :any,                 arm64_sonoma:  "cf961dd5e03e8a9e0f23bf8ab249075cb074a83a1af3a44031a034980f86dc4e"
    sha256 cellar: :any,                 arm64_ventura: "39dd050521459587fd3674fb43360cdddee36fabdf342246cc3255f147bca53a"
    sha256 cellar: :any,                 ventura:       "685f65684452f716b440d1b337393a23bb453921fedbd4102b695bfe3f2761ba"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d16bd4d28ec8ee18f64cdcffb55d920b589109823be167596b88ad546feee012"
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
