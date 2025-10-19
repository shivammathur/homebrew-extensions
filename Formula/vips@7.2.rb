# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT72 < AbstractPhpExtension
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
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "6ff02997c2f122603c5051a09ddda3ea75fde0cf8e3a288c2ea1aa21e852779d"
    sha256 cellar: :any,                 arm64_sonoma:  "fc670a9a4481119faffe8bd848cd88142575c70a8d29e9c132361f9081843634"
    sha256 cellar: :any,                 arm64_ventura: "1b7706d7595648f4a2290a6d55e375f3684746286e79cf77b0b7472445b4875d"
    sha256 cellar: :any,                 sonoma:        "699871314706ad355a514e7b876d882c0e5575d28c0d5460fac40da81e4304f4"
    sha256 cellar: :any,                 ventura:       "65779257feb400e0d9ea14c014a48e74ef03202e61fcd88eecacbc4f572aa233"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "981dee6285c661f5b6b54357c65420aabd5635c30c8e72d72762e3b820642354"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "65efb7b172504e4bf490228241c38191be2a1087eef2d35b86249296d2e9b093"
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
