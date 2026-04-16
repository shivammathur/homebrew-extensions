# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT83 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "fa11824ffe8a3ead93160c4055b570884b45848576902f769e052dc271c27f7e"
    sha256 cellar: :any,                 arm64_sequoia: "4f5908699fc1db6a3d45de7e67b5de84d64e8f963e6c3b1779e0caef230ff67a"
    sha256 cellar: :any,                 arm64_sonoma:  "27d3637351109b419c4ad28a652e9579d43b077491012edd3efe02cb0ce43bf6"
    sha256 cellar: :any,                 sonoma:        "86d6901d5b1a234b940b15cb6521314a8ad9b3cc9c3532882a7121e155ad186e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3bd1a86a36b02d6651c1d4bff37c116b85854032c83797cf362f463972e34467"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7c943ff117457133802108546da978e553530bb708487d9e0d5ff21cf0770d8f"
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
