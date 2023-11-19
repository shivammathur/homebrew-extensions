# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sonoma:   "8e88b30ed46dc12e8ce5b04fbe0e73a1ac52a9ff3f6ef0af7645cbde956a444a"
    sha256 cellar: :any,                 arm64_ventura:  "46525e104de894e2cb8c3ebfd0c4e2dad89e485aa7160e81b46a8a9379b019f3"
    sha256 cellar: :any,                 arm64_monterey: "b0c2f2b3315b24a05903902611cc8b2499c4fe3a5778c4de0d9d12a04b2ed522"
    sha256 cellar: :any,                 ventura:        "2891a12736f2a9b5e3d0b9c20d414f6e0d9e574ab3e6835494b288a85cb2ffbb"
    sha256 cellar: :any,                 monterey:       "2a70c0f73cc1b642f9adcaf1898e3ad28575ca9b21ca16eddbcbb2f36e0719de"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "60530a19889cbb64f35edf15af0b8631fd63dabde3e39f987cb0e1e914255adf"
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
