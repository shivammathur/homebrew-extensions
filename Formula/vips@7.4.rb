# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT74 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "1acdc98a11a251090e291396d408803adbd30b3f54116ebbb905b5b900c68be4"
    sha256 cellar: :any,                 arm64_big_sur:  "397604872d1e2db6c53ee9bb07df0698b49e517d45c77b6105ec3aa0c71b08e8"
    sha256 cellar: :any,                 monterey:       "b7d9b927816964ee9cae5386fa4a531bba08ae137f2c19ed2b54639e78888b76"
    sha256 cellar: :any,                 big_sur:        "d8a61893b5a2b44a24bf694a3b86074ea4605f4ee5c0f9f6311fc73cbf09c1d2"
    sha256 cellar: :any,                 catalina:       "ed403dabc0ef64da4d658cbb8745fb59dca130dbee6b19bf2eb3d085a003794a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0111f654ada1bbb08da60bc786436b3b2b5ff500545a35917ad460259ab13486"
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
