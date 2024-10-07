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
    rebuild 12
    sha256 cellar: :any,                 arm64_sequoia: "65846cb350086f8e9ef174376d053cf37ed9dccd845d8ffb2157bd53073a3e49"
    sha256 cellar: :any,                 arm64_sonoma:  "79fc587fe90ee3f4adb09e1f70355aecb1133eec45905bc3488b94a83a6a8243"
    sha256 cellar: :any,                 arm64_ventura: "377ddcd4cfcace3b74d8d5d685ba1119790f0115a8f290207da6bc6a73668723"
    sha256 cellar: :any,                 ventura:       "824d5276bb5cc58b26e477c873dbf4f3d7fb3fffd325e76baa5f17586cbdced8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b789a67c209919d743682e65a998cabfc5b9d9e7633b62f677d88e1e9acede09"
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
