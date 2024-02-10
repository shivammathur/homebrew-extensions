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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_sonoma:   "d772029da8321596ddcaec896cae5c63d9d6bb3aae1276a295df40c95ca53499"
    sha256 cellar: :any,                 arm64_ventura:  "1e57b4f92dc77c17882e88df157654f93bdd739882a4a00e10117e24b05da811"
    sha256 cellar: :any,                 arm64_monterey: "3dc76c9f86c1f9e3b1b4c6affcbdd35489569483b71758a46540f15774efff45"
    sha256 cellar: :any,                 ventura:        "c0fadb7e0dd55f9fd9f9f66e5ef61380204d20f8948afc8df87dc18fbeefa212"
    sha256 cellar: :any,                 monterey:       "17e72dd16e1020d8320c4f27fc0d62a8045181e7c1b8015e6b747d4906d7794f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0f8c8f10e82aecfb3bf1b68337814a73c8a0d15459758685945c8a99de7aa3a7"
  end

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
