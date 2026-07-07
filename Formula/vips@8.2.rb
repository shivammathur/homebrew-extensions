# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT82 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "ad0182d593ba57e46bd219b3a308c53ace4a90d3e547628ab3d1a69cf58a2b23"
    sha256 cellar: :any, arm64_sequoia: "ff713bb6190fcf4f7cc2edbc973a694d38a40da7ae7642aaf6d11f77c98495b5"
    sha256 cellar: :any, arm64_sonoma:  "9947a236446d1dd8c04e8a27443d99645870335cbbad36e4143b9bf0b4fefc12"
    sha256 cellar: :any, sonoma:        "42d14503ab966fb58b3ec2cf2159c4256cb8f4904d385ddac617e2c6bd674554"
    sha256 cellar: :any, arm64_linux:   "cd393cf3f7efd831554ad89d4592045a7d29c20864cbd5ba839536cf6c323a27"
    sha256 cellar: :any, x86_64_linux:  "8b2249ce1376b8ce450631326c556b23b6324d76528860c4c2f796b3f7d26cad"
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
