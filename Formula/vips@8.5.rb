# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "88b01e516498db707378d5d2057fa7e3b66947580b19f42093c79a2c35690d97"
    sha256 cellar: :any,                 arm64_sequoia: "72a5a4201ce1d94fdd32f8159f0df9fbcc48c7026fa27b85e509abba8e074683"
    sha256 cellar: :any,                 arm64_sonoma:  "979bd74c7dd0115e1ef4dbe16dbf91c8f937480c9cfba032c85b35dfa5bdadd4"
    sha256 cellar: :any,                 sonoma:        "1c2038089305f73677fd4024abbbed94c03cd7bc6233f94e993644e3eead3404"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1b8a3104626ac8be7a5f3c257c76b6d4337851faeb0a6b1f6332c080923eab98"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fabf44f9c6db20e6db34c5146607cc49bcfc545ca5cf44b9a5d9eee6b1acaeb5"
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
