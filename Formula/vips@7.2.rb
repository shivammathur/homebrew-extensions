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
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any,                 arm64_sonoma:   "f2d93fd5afae3b627f4cb6d26ee2b8b8fa85865bde14e129ac02b5b16f1a4f75"
    sha256 cellar: :any,                 arm64_ventura:  "222d990915e57d3a2cdc62f80860b5a32bf17dddf39f374e254869dc545d0792"
    sha256 cellar: :any,                 arm64_monterey: "37895125a32c9ae7f693ba9a5f271b071818000c9a41712fb8f3f94cca115cd9"
    sha256 cellar: :any,                 ventura:        "b6c9dcdf45da083cfc62e854da30e099abc3a67b2b68beb2ae5cc1b468c8f06c"
    sha256 cellar: :any,                 monterey:       "d741e2f9a8093fd2f181b8070d4a5ede495ea617fa18a81744e533e325838728"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4a623d230defe205d43ef57d3f75c8b2616636ebf79128315cccfd7078951792"
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
