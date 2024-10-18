# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT70 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "64ef87d7fd96a2861ce873b2b368a52f2e8d75721707cc53c25b836d0132ffd0"
    sha256 cellar: :any,                 arm64_sonoma:  "8446edb19a37d17796fd5822aac8574dbf0cf70710c6e2902e4ef6d06feceb4d"
    sha256 cellar: :any,                 arm64_ventura: "e0d1f02b3aec59459820c4e2dfdee0368cb7598b7bf06b731535a1f8ad3ee6b6"
    sha256 cellar: :any,                 ventura:       "6febcb3fc3f6c5a42937a544467400a5994ece2868b188114620e8c4a60bbd0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9da5f99c17ee3be114720addb7f0d09663e76ec7dd65b414ebc0ac130d44e6ad"
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
