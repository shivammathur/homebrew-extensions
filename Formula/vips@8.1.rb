# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia:  "6b8882e168c5772a6da1356d646fb88b566b26bfe9039a174ec319b52564e82b"
    sha256 cellar: :any,                 arm64_sonoma:   "c487ac2e073a45822a78b09d48daa3e8c0355ad1b0e2cd8177d994a99c684aef"
    sha256 cellar: :any,                 arm64_ventura:  "8150a6824b88de6dfca7322186ef2006c16a88ca0f1a52cbbc6e0a4b084ea0a3"
    sha256 cellar: :any,                 arm64_monterey: "c309c322e1dca6b15396ee6aa596bba04d917ca9f8974f04c1b8ae061be6a127"
    sha256 cellar: :any,                 ventura:        "b7270cf26a27f5f3fdbc24a973ffd7f568518c0e6c2605e29e1584e7599c3f74"
    sha256 cellar: :any,                 monterey:       "6632b0114a6a578499d25b05a3b7a4bf425903cdd70eff9642665532cddfd57e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7ae6bb6ea4bcbcade7c7402af6c3152f39b205bd06345e42fb1228be158e82b7"
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
