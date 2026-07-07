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
  revision 2
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "375ba52a6eb6e05eadce7bcd8b4e5ff733d527172d55477836bf193eaa09047d"
    sha256 cellar: :any, arm64_sequoia: "c059c345203e4c1ef070ccdf744601ec4cab2e55580f229872de00a833a20ce2"
    sha256 cellar: :any, arm64_sonoma:  "ddade3fafd4fdf113b9535cf4a38392a8597a9eb3bdc2d6565f4b0b09a076035"
    sha256 cellar: :any, sonoma:        "0b67a115b6a6388d07e1b9668ff87e4306af8bc477c18ff44f9feae1b32d911b"
    sha256 cellar: :any, arm64_linux:   "c1908e447f727b3b862654dbf9081ff368970b0962f63dceef9a207ecd150823"
    sha256 cellar: :any, x86_64_linux:  "eef29e0a0e5734d80a2dd03fc5b916a2c2b2a798901c5eb132c6f1ff24c13830"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Utils::Path.formula_opt_prefix("vips")}
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
