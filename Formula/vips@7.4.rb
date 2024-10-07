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
    rebuild 10
    sha256 cellar: :any,                 arm64_sequoia:  "d2c840b5ceb29eedfe573917f448008fed36e81c34abfc58001f8cf9888f842e"
    sha256 cellar: :any,                 arm64_sonoma:   "32f57a6175e5483c775f25ff747abe32f8759856934788735baa5c57fae7af79"
    sha256 cellar: :any,                 arm64_ventura:  "7de887f928d2e3b52b1af4609104f7f48be37c4d025b5a67b316a0a178a7eef0"
    sha256 cellar: :any,                 arm64_monterey: "81d5b90cdb59a3842799ebc254643af7fc0f3bb4a7840ce028381eacafe1bd14"
    sha256 cellar: :any,                 ventura:        "22270241fe2c6d6cc9045aaca4dcb4a1dc0ae67b0b0588bd29ebe0d6b303e711"
    sha256 cellar: :any,                 monterey:       "f0d3a12410bb16facaeb5cc2dd6c335969edf45c13efd9a04b4bb8869671511c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1630f1cc8a9b9c408dc424b5173e65f3d0192f752ec6c6cc20da75e53b7cd4f1"
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
