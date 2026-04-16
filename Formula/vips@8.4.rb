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
  revision 1
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "9df55e0109ed63d23ba269a8f5699b7360896359e87cd7fb94387df0bcbe406f"
    sha256 cellar: :any,                 arm64_sequoia: "d04050a850bf18811056c41be524c47867e175463367161f945246cfb5efa041"
    sha256 cellar: :any,                 arm64_sonoma:  "295068fad1c4aceae5a952f635973a650c974b2feeb967d59f03221c98edd3d4"
    sha256 cellar: :any,                 sonoma:        "9e37eeb7629ac205b1b8a1e43f950b61ab891cdb61f0000530d1f04421d4b4b2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "1d955c08f21d93357102a4184901920c8b267af32db9a815cb5a75d6d107d1ac"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d509ad6976c4e817b9c066f02b34fac2c3b18ca6120418003409497e3830247e"
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
