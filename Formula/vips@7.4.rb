# typed: true
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
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "99de123f0b8c7d6f8176fa0abb095f37733763ff26cc837402b880979cc4c82a"
    sha256 cellar: :any,                 arm64_sonoma:  "0b2b2c12d233d70498dd3d6a37f0df0491f882e33c25327fd47d2c5c4a3c4fa4"
    sha256 cellar: :any,                 arm64_ventura: "15196d52cebfd12a454fad8e17214b53d0ad4408557dc546fc503d35d4dbff2d"
    sha256 cellar: :any,                 ventura:       "fc118dbde7412a3c8cc86d74e568e7f0f2a2e41f50e70125476e58b9eed23090"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a2c5ce75e7470296ceefa341e4fc962418377a21aaf3f0d2ea13e10a765e1b1"
  end

  depends_on "gettext"
  depends_on "glib"
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
