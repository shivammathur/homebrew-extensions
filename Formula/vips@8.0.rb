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
  revision 2
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "a1a7f499258c3dcc152491a7ffa27f2300efeae5bec09d6f1bb5f32f35986359"
    sha256 cellar: :any, arm64_sequoia: "6497c9c5dff80cdaa901cac5a31d945775ca9d453260d34434c38965220c9a18"
    sha256 cellar: :any, arm64_sonoma:  "e570caf269a2b7b30d55c76c2fd119a24191eb3c54f5847a44664f9ade0dd97e"
    sha256 cellar: :any, sonoma:        "a31c33807fc8a97ebb87678d3721387071a84ff97bc8959eb711f6050df03eb9"
    sha256 cellar: :any, arm64_linux:   "037cfabbf20863886761e73e8b4384f33c92c1ff1bcf99e5564dbcc560f71514"
    sha256 cellar: :any, x86_64_linux:  "cab3ce3728d64c29a47434be09956e1ff02fae810dca0da11a574dff3c353c3d"
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
