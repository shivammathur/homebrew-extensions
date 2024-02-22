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
    rebuild 6
    sha256 cellar: :any,                 arm64_sonoma:   "adfccecb1d5a88c971e40be43e2ad30a1f1cbf690bb3aa4ac732ef33f3e1da2f"
    sha256 cellar: :any,                 arm64_ventura:  "444c1b93822669f285f20d6baa532dcef7da2f46829f23f730756d6103e490fd"
    sha256 cellar: :any,                 arm64_monterey: "07c09b47126d1a060084838dc38a51de48861a68b82b5bb2e0bdbf7ec229bb29"
    sha256 cellar: :any,                 ventura:        "a11c95c89d675090526ba3b0f073bd289c2054453da78d657cab7a20dca8b270"
    sha256 cellar: :any,                 monterey:       "7d596c3164da1f122e33a26a78fe07497e5f4c5f9691fdb268acf9e879ab235b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7911ada95138bacccefdc02b36841fe48eb8acabbd425bad4d0be40373f2802d"
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
