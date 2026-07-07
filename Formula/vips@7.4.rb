# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "313329dece43bb21b638aab297e1db6eece34ad18d20a705b2546d20c7867738"
    sha256 cellar: :any, arm64_sequoia: "594a89ba5ea93758d686a8588fefd7dd46ea959fda704eb6009980a97f8ff23a"
    sha256 cellar: :any, arm64_sonoma:  "d0f8cfb4cb4d86b60f88b7744ed9aed14fe6b195a1fd1ec068ec7a1b26dd1638"
    sha256 cellar: :any, sonoma:        "bc2d10d9887363f87f9e06e965eb5fbd6aaec95d9de05f48a74ecfba46d22e97"
    sha256 cellar: :any, arm64_linux:   "6e1372ac67dbeaccd6bc36ee373fdc10ca258d867302dbae16d463873b388154"
    sha256 cellar: :any, x86_64_linux:  "22e8950e3709b16ffda223daec2b857bb901c88cdd81fb86e3efa1ed19463ac1"
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
