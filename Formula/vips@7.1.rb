# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT71 < AbstractPhpExtension
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
    sha256 cellar: :any, arm64_tahoe:   "4d24fd0f30c17feddb9e1ab9b2a4b09f9fa1489112d0b306598346a75c75331a"
    sha256 cellar: :any, arm64_sequoia: "6b420b538f2c6c405b1d05c1fa0332d6726d834554d3fff16018705a20ea2652"
    sha256 cellar: :any, arm64_sonoma:  "61434dc053a9093d4968f9c557482cbc26ef55cbea514553ac67004de59eba68"
    sha256 cellar: :any, sonoma:        "6b55c0b6cb176cb27699b99485a85a86ef461a7465bf35c9790bf1368358d11f"
    sha256 cellar: :any, arm64_linux:   "2370da74f4b43910fcb91afdc974be26ed850da37c0a6f266c629ea84a818863"
    sha256 cellar: :any, x86_64_linux:  "26aaf615c3025a9fe956efda527254ebd577efeeb7c1ede79c7f1fba270c7f62"
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
