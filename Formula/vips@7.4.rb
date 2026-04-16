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
  revision 1
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "5845ef4159e582c26003a0cbbd5f046a0afdfa7f8fc6b7221b74231e9a2819ed"
    sha256 cellar: :any,                 arm64_sequoia: "02423c3d2f1be629dd888886d39677a03af063d496bb4930b375c629f60acf1e"
    sha256 cellar: :any,                 arm64_sonoma:  "eb104ededbeaf4b0a9b57dbd1b11911db845a8b5d5d92086ce830e0b7ea06e3a"
    sha256 cellar: :any,                 sonoma:        "5b70325b8ccb8c6f72c810e70005bdd2106764ca6040ab3111723ae3d82b8922"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5dbf9d76c8b0ab14bfe7c41cb3cb3a841f266e9bca8f27fb37fd235fc2607683"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4e9e44075f013d914fef84470d684762934a90060974cdf0c1f77dbf9c4dc5d"
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
