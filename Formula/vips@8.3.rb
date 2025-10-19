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
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 14
    sha256 cellar: :any,                 arm64_sequoia: "3c98cc6451e0255457dc0ec4b20fc12d78214a0ecf56bcd3a9c13fa1c17d7665"
    sha256 cellar: :any,                 arm64_sonoma:  "72e9d4be9a5c64b328de73bf7eca62d1b022d246a952aa17d714ddf404357930"
    sha256 cellar: :any,                 arm64_ventura: "d94b002f9e4ab1f03686ee7f5ec08a79ebd670ecc8ece646d880904e03d52d89"
    sha256 cellar: :any,                 sonoma:        "5c1863c67ea306b3e25b4f01345c2adb7a7fe664c07c4199441bce46867246f9"
    sha256 cellar: :any,                 ventura:       "33928feb382e6fab6a34b5aa0e8583ca9af593509da34d2e8d814d967ee79e17"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "52c78cd510a386213e7fcc8722444be91b96ba9dd8a5198af1b51f9bac005ac8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "73896b7b457c035d4c8aae86ce50404a4eeaca6c61fae13df97d9284c7835c92"
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
