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
    rebuild 4
    sha256 cellar: :any,                 arm64_monterey: "c6a58663508f11377a880dd3899bd9b5edb84586df1669ff7382bec79c210965"
    sha256 cellar: :any,                 arm64_big_sur:  "026e7af371197466fb1c3e1328edb88cb5e8a7943094bc202732a1c234dc2fcc"
    sha256 cellar: :any,                 monterey:       "f53ec4a03e395f76bc4b7c454b5ebe8261c1791bb2e2b44be6e812b2e00133f0"
    sha256 cellar: :any,                 big_sur:        "d35ccaf92844f7105b242fc49b19b9ce971ff1279c4ed0c26f9e2241e6116409"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "796ce4e42e51c974060a826c97742802755f15dffb44120facdb87f37771eb66"
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
