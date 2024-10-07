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
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "be388861b97a9031c74f3a65047e71004c4d7bae0aaafde470e718936a1211d6"
    sha256 cellar: :any,                 arm64_sonoma:  "2c302b41cd3d23c137ff02a624ff77890bbe88e1f8abe38f5a3439303c9c6a57"
    sha256 cellar: :any,                 arm64_ventura: "9f05ec2c229cc4f6fe0ee46c34fa897e5b65f181c6d827fc4d81838eba515624"
    sha256 cellar: :any,                 ventura:       "552fb1e46c37d0ff970cbf7798e4a0c54ae16249cd6c9a00e1a1a9211d70279a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03a7e99e2f5398bf366c791380ba6de4e34a356c2316f846c0830715393b7b11"
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
