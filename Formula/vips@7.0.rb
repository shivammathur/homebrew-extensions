# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT70 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "4faec0c40009c84cfbb2c288154a5b9b9c912e86e75163086320f64b9b2c3be9"
    sha256 cellar: :any, arm64_sequoia: "dfc1aeaeb72511c9649717aa80f91b65b288f29a8b46bea265224a0e9c00f742"
    sha256 cellar: :any, arm64_sonoma:  "381319cf1f0390175c5105270a7ca64ea468e16294bfa913716e5cecc22de952"
    sha256 cellar: :any, sonoma:        "84c8f845d5ac9158479f1e31774dbce8b61c8fd051c9a99bffad1566e3727d5c"
    sha256 cellar: :any, arm64_linux:   "ea54ee4948515d2d9f74af8e77c1b9327f72b184db32864186c6295ac5808180"
    sha256 cellar: :any, x86_64_linux:  "ed5797dda7065a0be669889f9a32ccbd3b7329a6c66a6c8a052504e4c1276871"
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
