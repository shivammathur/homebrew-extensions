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
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_ventura:  "51ef0650c9ff9f9cc26a8930638214382204a7d8f120a7e9aa946df4394afb72"
    sha256 cellar: :any,                 arm64_monterey: "6df54ba13792dd72ac83f64fb14d3fbde53aae5e42e6d4f2466ea0c120fe9732"
    sha256 cellar: :any,                 arm64_big_sur:  "f69d77eda03cd6f333079c0c1684c90212ae470481ab79bfdddc07ee9b5f1b44"
    sha256 cellar: :any,                 ventura:        "1077d7516650558c8defe63accfa594b7c15253ee6b123b9059f304929975319"
    sha256 cellar: :any,                 monterey:       "a87732f5340462e9e3cbf8c2b638826aff5962f331246f4c848e308625911b8d"
    sha256 cellar: :any,                 big_sur:        "1ca5b9badeec87a0ed31a6bf617f842cdd34dac01839428ce8774a00837f36fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "57ce0aa47fe7902fe1ed5a90d5bbf6840af76b21aa0767c8801e2223c36e968d"
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
