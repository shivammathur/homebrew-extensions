# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT80 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 9
    sha256 cellar: :any,                 arm64_sonoma:   "d139cb04354ef41cf5b265fce5c9197bd3cfde5aedf9215720b6799f7b0956f9"
    sha256 cellar: :any,                 arm64_ventura:  "8ce4c6e28dd7381046581e1e18b7a88dce518c6d9aef42e7948091cda857953f"
    sha256 cellar: :any,                 arm64_monterey: "d14c563e0d91c586dd80d8150e5e4824c62e9906611e118affeb46c6468463a7"
    sha256 cellar: :any,                 ventura:        "099a9320a80a283908be5e3dd0253e1517494c043e3420e1126842ed8ddb2b77"
    sha256 cellar: :any,                 monterey:       "46817ad89b0f582e47a2c7da949947e89206a6c39be47956725c104aee30584d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bc71e3a8a996a49749c1662f31848ef522f8971075d20a7aed366146ca7921f5"
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
