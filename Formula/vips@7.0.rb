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
  revision 1
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "2d7491aecd8b7a9228ef2511e6e6b531723eae8115687a142687cb9d32417381"
    sha256 cellar: :any,                 arm64_sequoia: "6d993984e00943e0d0d22744d51ef38094b1e03ff97ff75ca09b1c7b4d10c0da"
    sha256 cellar: :any,                 arm64_sonoma:  "c2a7692d3511d0ddbfa185a92d016d9f52d008b63efec9e82716cc7f0895f622"
    sha256 cellar: :any,                 sonoma:        "ebcf54e7f3643218f611cd24bcb2f1786bb62b425abd57f739bf7c16c845abd6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bb9f0dd853aa460359b23a79fc34642410222f9c2b119fff9f619d16be8ca8aa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca69e74949b716d58f8ba258dc69598f3906a738eb06dc301bf0b50ccec37274"
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
