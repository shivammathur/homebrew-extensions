# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT84 < AbstractPhpExtension
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
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "6cea467401aca01b1c44d4887a4fdca739d79b7dc7b51858d2e3da62eea06fb6"
    sha256 cellar: :any,                 arm64_sonoma:  "f551d95e17c2b938585394caa998959ed06da6abf0fefec2e4402346a7ac25b9"
    sha256 cellar: :any,                 arm64_ventura: "555823bf114cb3def91611909df98b6a63d6d923a48dc68495479173e0157d08"
    sha256 cellar: :any,                 ventura:       "49dbcda21a2bd60a22d8fb3ab1a14432d6f94ec1090e131081f86c3330b1d206"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "407c1380eb5445f1de86ef931c0f01e4a347bafea27e2a0111510c15b3cf7e00"
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
