# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "2b6c8a404a99ed7d223ea449bc95e359932e4ed145872068ac258e7b801fa859"
    sha256 cellar: :any,                 arm64_sonoma:   "64f07b25ae6e99b9485da7162dfa7a7a5c96cbceb759718b814e198c3cd59e06"
    sha256 cellar: :any,                 arm64_ventura:  "c9d5da12121c4cf073bc656b5d426ed84bf8865897dff86f87caa02f80a855a5"
    sha256 cellar: :any,                 arm64_monterey: "e8a7268706f843e935c26c7fa43bcc73e74eda4df56ad40c7903aa6d5ac60236"
    sha256 cellar: :any,                 ventura:        "ff1c16a4a6dcacf75efb5fc30f3afd3f8b397532bd22054cffeb7352d349911a"
    sha256 cellar: :any,                 monterey:       "73d9630cf0643f1953d160c5f951857bc40883c00dcbd5d35bdc931829ca457a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dfa61fa97833de752e22611aa21d373279d6f82cb64589cd952fa95db377691c"
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
