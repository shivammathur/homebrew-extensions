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
    rebuild 9
    sha256 cellar: :any,                 arm64_sequoia:  "623b4d95a6cfde4d8206abe1792c0f0a5d773a50ee6190beed1ac0971b0467fc"
    sha256 cellar: :any,                 arm64_sonoma:   "1b355760f3afa1e293d4ba783706a9eb3729ce997f7e7036be93cf6b1312b3f9"
    sha256 cellar: :any,                 arm64_ventura:  "a848bd85b4c93bdb384d33cb5cf2847e853d9307dc146f216917c68ec2126652"
    sha256 cellar: :any,                 arm64_monterey: "8b2aedc196d56dc4d34b8767aa3f7c7500157a7ea0dbb9ce3e94ad16db137769"
    sha256 cellar: :any,                 ventura:        "3bb10669fe2520864784ebd6fa4e3468ae7bfab466336a349538c1e05b1b8e13"
    sha256 cellar: :any,                 monterey:       "855436d6734c9ce04da87aad65809dbf9b2b99deb83a13b77a8df3e888cd022c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aa9d343f87496f8320e308de004a3075d3d042b4210d527701a1d7de3573262a"
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
