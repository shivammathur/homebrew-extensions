# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT73 < AbstractPhpExtension
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
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "48701bf4993378dc65989fb5fcd8b3d27ff3c048f90acc366e502b982122d9dc"
    sha256 cellar: :any,                 arm64_sonoma:  "0f9b21fc341f879e30f7cdc19755a7df141c85b8b199396825a9b0dae5a85413"
    sha256 cellar: :any,                 arm64_ventura: "8a869c02c299b7b2420947e5b952409983531b3da2e3af1b06230d9e4a8f7088"
    sha256 cellar: :any,                 ventura:       "f67463507f5b3e5928c4a88bd89f9808e0328251ff38faed2b84bcf23b83e18c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ec5d9ccda1ab8f9ca62aa67eae2c0b67631050b5304bdf7888fd655862a508f7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "eefe9fec27f6753dc19318220dda650574abfd224899b623be7b70698a789dc1"
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
