# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "8c4dfcf5b36529e67036b1bf76e19cb5114af51a01522e88d8a35f98e98d4638"
    sha256 cellar: :any,                 arm64_sonoma:  "cc2ff05eaa82548b4b88a90c91a78b958c3fe307f788609204a6f08740e1eda1"
    sha256 cellar: :any,                 arm64_ventura: "62ea2b7655a8542daf0c4476036031fd35d85a1940bd5b161ab9cb255d7c564d"
    sha256 cellar: :any,                 ventura:       "59507c32bf3f65b68406be64b11e1cdc50892a79376e3860e380a026b52ead05"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7831d2774f444fd04abd3040fe09b871173dd82a702f464bbf2ee636712b9018"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ed7b298b4e7441950c8902d662d9da08ad51700fac2f693406bfa765aa857468"
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
