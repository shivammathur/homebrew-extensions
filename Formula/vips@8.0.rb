# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  revision 1
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9df53e2677e93d7cbbcdaa2931a7f3106ff1756f6c0d6a2047894f7a175cbabb"
    sha256 cellar: :any,                 arm64_sequoia: "a12262877d2b3cee6c4a92b0a7812f171254bf8c958b5eee7d1cc93998e57b15"
    sha256 cellar: :any,                 arm64_sonoma:  "be4536ce0648babfdd1838e55a40c1ef575fbaa739d9352dfd55404bcb91cb66"
    sha256 cellar: :any,                 sonoma:        "1614e24bc4a4ac8a561cef78ab787ce6011605a7e5ecd20ddb891985664222ea"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "db62833d82879c0056fd3f253a1db4400659208ac9d79cb771be70729c5f8560"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bb5d7565ab1974f2d04c0cb9c01e677a50c06cc21d311156ae24afbe7fae1098"
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
