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
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sonoma:   "fee2c4d32efc5f37709a94e7df66dd8d60c8c164c3350fe15bd8ee8971fef002"
    sha256 cellar: :any,                 arm64_ventura:  "2a8f251ef696eee581ea14a6231c79c284023f7bf1c7fa0413c03716b900ac49"
    sha256 cellar: :any,                 arm64_monterey: "a613334a83ca23f1afa6cdae85f79809b546a4c6e7f50b69bc7b1e02eba303f2"
    sha256 cellar: :any,                 ventura:        "790f1fdcaec81e042e2b33d13cde68f12066726e3988bbbc43ffd437a2d85351"
    sha256 cellar: :any,                 monterey:       "e2e5a3d319ee51ba94dcd3c9519afb07c17d865f36da87bf5af49a5adaca4b69"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e3d084554986923301aaa2323493b7d0603ac43a3e98c5f09411d999f91d35bc"
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
