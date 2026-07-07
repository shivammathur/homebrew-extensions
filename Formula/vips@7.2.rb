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
  revision 2
  head "https://github.com/libvips/php-vips-ext.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/vips/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "8eecf1563fdaa1eb0655fb9e36e44805c48e3b919df5ba1a8c411a54cee4e7b5"
    sha256 cellar: :any, arm64_sequoia: "aa095dbe022a0011fbcac29e75eaf8f5096e6956c1e67eeabfab62818d0facf5"
    sha256 cellar: :any, arm64_sonoma:  "0978ca6fa97a7e3db32804bb5c4069f90e403e112ca37d69972da008f8e2266b"
    sha256 cellar: :any, sonoma:        "6b16ff9b8adebae56c27831c82159cd1f5fc20ed2811eb8e02e770f61d385743"
    sha256 cellar: :any, arm64_linux:   "55e6a540e908d6e80d1808e047ed3f5b692e60d6a38c1f83e823417dc7644672"
    sha256 cellar: :any, x86_64_linux:  "a522f2b70512cef099d274f1d2dab2bee28e1e336cc38a45d2e385bb8b5a36cb"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Utils::Path.formula_opt_prefix("vips")}
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
