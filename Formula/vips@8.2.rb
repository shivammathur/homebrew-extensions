# typed: false
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
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/vips@8.2-1.0.13"
    rebuild 5
    sha256 cellar: :any,                 arm64_monterey: "02ac9510521d56e2483f3e99848fc67b24e42ff362fc80386c2562a4551f2ce9"
    sha256 cellar: :any,                 arm64_big_sur:  "2540f9d8317175500fb2b3ae6ce3675bce94afb2e3a2599f20c6134edcbac791"
    sha256 cellar: :any,                 monterey:       "fd7fa7ed06a37bb90c625c50793f602cdcbf29217fae00bc195687a7149fc378"
    sha256 cellar: :any,                 big_sur:        "90126b842bb07b7750f24358f40e3e91028ce807d29b70a655e4059fb8e99729"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "27078974a714183d09acbf7e35ff993f042057f27019d1d761e4d21a4d3dbf8e"
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
