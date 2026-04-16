# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT71 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "8563ff9e1751d0b5fd71e1078f928b0deb78b7414d698f89ca043ebf1946d682"
    sha256 cellar: :any,                 arm64_sequoia: "0590ca4ed189c4bdc5c78e99aa4b7066575a1c1aff5b8698f406c3fc858b8a9f"
    sha256 cellar: :any,                 arm64_sonoma:  "fb979c8f85e297fc28228b00c682dd680b56f37de0464c62e6538c6cad46e532"
    sha256 cellar: :any,                 sonoma:        "a14b703fc5be8f99e5076a1fe8f9ca8e0aff416f56832182f4ec5656dcd02492"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0bb8b3c1b80b075926690564417a6f30cda6c8e26a44b5b51ba636ed43a7350a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "23f9593e935a67786deaba29e07baf22a59a96c36637fd181d4ccceb557f3470"
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
